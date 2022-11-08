package main

import (
	"log"

	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"

	"gopherpizza/app"
)

func main() {
	tryLocal := false

	c, err := client.Dial(client.Options{
		HostPort: "host.docker.internal:7233",
	})
	if err != nil {
		log.Println("Unable to create Temporal client on Docker network. Falling back to localhost", err)
		tryLocal = true
	}

	if tryLocal {
		c, err = client.Dial(client.Options{
			HostPort: "127.0.0.1:7233",
		})
		if err != nil {
			log.Fatalln("Unable to create Temporal client", err)
		}
	}

	defer c.Close()

	w := worker.New(c, "gopherpizza", worker.Options{})

	a := &app.Activities{}
	w.RegisterWorkflow(app.PizzaWorkflow)
	w.RegisterActivity(a)

	err = w.Run(worker.InterruptCh())
	if err != nil {
		log.Fatalln("Unable to start worker", err)
	}
}
