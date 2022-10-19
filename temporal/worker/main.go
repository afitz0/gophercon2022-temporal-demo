package main

import (
	"log"

	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"

	"gopherpizza/app"
)

func main() {
	c, err := client.NewLazyClient(client.Options{
		HostPort: "host.docker.internal:7233",
	})
	if err != nil {
		log.Fatalln("unable to create Temporal client", err)
	}
	defer c.Close()

	w := worker.New(c, "gopherpizza", worker.Options{})

	w.RegisterWorkflow(app.PizzaWorkflow)
	w.RegisterActivity(app.ValidateOrder)
	w.RegisterActivity(app.PreparePizza)
	w.RegisterActivity(app.BakePizza)
	w.RegisterActivity(app.Deliver)

	err = w.Run(worker.InterruptCh())
	if err != nil {
		log.Fatalln("Unable to start worker", err)
	}
}
