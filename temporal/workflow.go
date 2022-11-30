package app

import (
	"time"

	gopherpizza "gopherpizza/app/api/gopherpizza.api"

	"go.temporal.io/sdk/temporal"
	"go.temporal.io/sdk/workflow"
)

var buildStatus gopherpizza.OrderStatus = gopherpizza.OrderStatus_ORDER_RECEIVED

const ACTIVITY_MOCK_DURATION_SEC int = 10

func PizzaWorkflow(ctx workflow.Context, o *gopherpizza.PizzaOrderInfo) error {
	retryPolicy := &temporal.RetryPolicy{
		InitialInterval:    time.Second,
		BackoffCoefficient: 2,
		MaximumInterval:    time.Duration(ACTIVITY_MOCK_DURATION_SEC) * time.Second,
	}
	ao := workflow.ActivityOptions{
		StartToCloseTimeout: time.Duration(ACTIVITY_MOCK_DURATION_SEC) * time.Second,
		RetryPolicy:         retryPolicy,
	}
	ctx = workflow.WithActivityOptions(ctx, ao)

	log := workflow.GetLogger(ctx)

	a := &Activities{}

	err := workflow.SetQueryHandler(ctx, "getOrderStatus",
		func() (*gopherpizza.PizzaOrderStatus, error) {
			log.Debug("Query for order status received.")
			runId := workflow.GetInfo(ctx).WorkflowExecution.RunID
			status := &gopherpizza.PizzaOrderStatus{
				Status: buildStatus,
				RunId:  runId,
				Order:  o,
			}

			return status, nil
		})
	if err != nil {
		log.Error("SetQueryHandler failed.", "Error", err)
		return err
	}

	err = workflow.ExecuteActivity(ctx, a.ValidateOrder, o).Get(ctx, nil)
	if err != nil {
		log.Error("Step failed", "Err", err)
		return err
	}

	buildStatus = gopherpizza.OrderStatus_ORDER_PREPARING
	err = workflow.ExecuteActivity(ctx, a.PreparePizza, o).Get(ctx, nil)
	if err != nil {
		log.Error("Step failed", "Err", err)
		return err
	}

	buildStatus = gopherpizza.OrderStatus_ORDER_BAKING
	err = workflow.ExecuteActivity(ctx, a.BakePizza, o).Get(ctx, nil)
	if err != nil {
		log.Error("Step failed", "Err", err)
		return err
	}
	buildStatus = gopherpizza.OrderStatus_ORDER_PENDING_PICKUP

	// TODO: between these two, something could go wrong. Driver quits. Order is canceled. Any number of edge cases. How do we simulation this?

	buildStatus = gopherpizza.OrderStatus_ORDER_OUT_FOR_DELIVERY
	err = workflow.ExecuteActivity(ctx, a.Deliver, o).Get(ctx, nil)
	if err != nil {
		log.Error("Step failed", "Err", err)
		return err
	}
	buildStatus = gopherpizza.OrderStatus_ORDER_DELIVERED

	return nil
}
