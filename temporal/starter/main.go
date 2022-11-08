package main

import (
	"context"
	"log"

	"go.temporal.io/sdk/client"

	"gopherpizza/app"
	gopherpizza "gopherpizza/app/api/gopherpizza.api"
)

const workflows = 100

func main() {
	c, err := client.NewLazyClient(client.Options{})
	if err != nil {
		log.Fatalln("Unable to create client", err)
	}
	defer c.Close()

	a := &app.Activities{
		Order: &gopherpizza.PizzaOrderInfo{
			Id:       "1234",
			Crust:    gopherpizza.Crust_CRUST_GARLIC,
			Cheese:   gopherpizza.Cheese_CHEESE_ALL,
			Toppings: []string{"mushroom"},
		},
	}
	workflowOptions := client.StartWorkflowOptions{
		ID:        "testing-" + a.Order.Id,
		TaskQueue: "gopherpizza",
	}

	we, err := c.ExecuteWorkflow(context.Background(), workflowOptions, app.PizzaWorkflow, a.Order)
	if err != nil {
		log.Fatalln("Unable to execute workflow", err)
	}

	log.Println("Started workflow", "WorkflowID", we.GetID(), "RunID", we.GetRunID())
}
