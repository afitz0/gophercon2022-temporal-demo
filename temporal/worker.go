package main

import (
	"log"

	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"
)

func main() {
	c, err := client.NewLazyClient(client.Options{})
	if err != nil {
		log.Fatalln("unable to create Temporal client", err)
	}
	defer c.Close()

	w := worker.New(c, "gopherpizza", worker.Options{})

	w.RegisterWorkflow(PizzaWorkflow)
	w.RegisterActivity(ValidateOrder)
	w.RegisterActivity(PreparePizza)
	w.RegisterActivity(BakePizza)
	w.RegisterActivity(Deliver)

	err = w.Run(worker.InterruptCh())
	if err != nil {
		log.Fatalln("Unable to start worker", err)
	}
}
