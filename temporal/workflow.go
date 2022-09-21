package app

import (
	"context"
	"math/rand"
	"time"

	gopherpizza "gopherpizza/app/api/gopherpizza.api"

	"go.temporal.io/sdk/temporal"
	"go.temporal.io/sdk/workflow"
)

/* Pseudocode:

PizzaWorkflow(order):
  // in-workflow: does the order request have all the requisite info?
  // Fail the workflow if it doesn't. Continue otherwise.
  validateOrder()

  // Activity: Random duration (short).
  // Chance to fail with:
  //  - Missing ingredients (non-retryable)
  //  - Threw dough too high; it's stuck on the ceiling (infinitely retryable)
  //  - Dropped dough; it's been stepped on (infinitely retryable)
	prepareRaw()

  // Activity: Random duration (long)
  // Chance to fail with:
  //  - Undercooked (retryable once)
  //  - Overcooked (non-retryable)
  //     - compensate by backtracking to `prepareRaw`
	bake()

  // Activity: Random duration (medium)
  // Chance to fail with:
  //  - Driver forgot address (infinitely retryable)
  //  - Driver is lost ("soft" fail; activity takes longer than expected but is still heartbeating)
  //  - Driver quit during delivery (worker process fails heartbeat; non-retryable)
  //     - compensate by backtracking to `prepareRaw`
  //  - Customer got wrong order (non-retryable)
  //     - compensate by backtracking to `prepareRaw`
  deliver()
*/

var buildStatus gopherpizza.OrderStatus = gopherpizza.OrderStatus_ORDER_RECEIVED

const ACTIVITY_MOCK_DURATION_SEC int = 60

func PizzaWorkflow(ctx workflow.Context, o *gopherpizza.PizzaOrderInfo) error {
	retryPolicy := &temporal.RetryPolicy{
		InitialInterval:        time.Second,
		BackoffCoefficient:     2,
		MaximumInterval:        time.Duration(ACTIVITY_MOCK_DURATION_SEC) * time.Second,
		MaximumAttempts:        100,
		NonRetryableErrorTypes: []string{},
	}
	ao := workflow.ActivityOptions{
		StartToCloseTimeout: 60 * time.Second,
		RetryPolicy:         retryPolicy,
	}
	ctx = workflow.WithActivityOptions(ctx, ao)

	log := workflow.GetLogger(ctx)

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

	activities := []interface{}{ValidateOrder, PreparePizza, BakePizza, Deliver}

	for _, act := range activities {
		err := workflow.ExecuteActivity(ctx, act, o).Get(ctx, &o)
		if err != nil {
			log.Error("Step failed", "Err", err)
			return err
		}
	}

	return nil
}

func ValidateOrder(ctx context.Context, o *gopherpizza.PizzaOrderInfo) (*gopherpizza.PizzaOrderInfo, error) {
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	return o, nil
}

func PreparePizza(ctx context.Context, o *gopherpizza.PizzaOrderInfo) (*gopherpizza.PizzaOrderInfo, error) {
	buildStatus = gopherpizza.OrderStatus_ORDER_PREPARING
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	return o, nil
}

func BakePizza(ctx context.Context, o *gopherpizza.PizzaOrderInfo) (*gopherpizza.PizzaOrderInfo, error) {
	buildStatus = gopherpizza.OrderStatus_ORDER_BAKING
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	buildStatus = gopherpizza.OrderStatus_ORDER_PENDING_PICKUP
	return o, nil
}

func Deliver(ctx context.Context, o *gopherpizza.PizzaOrderInfo) (*gopherpizza.PizzaOrderInfo, error) {
	buildStatus = gopherpizza.OrderStatus_ORDER_OUT_FOR_DELIVERY
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	buildStatus = gopherpizza.OrderStatus_ORDER_DELIVERED
	return o, nil
}
