package app

import (
	"context"
	"math/rand"
	"time"

	gopherpizza "gopherpizza/app/api/gopherpizza.api"
)

type Activities struct{}

func (a *Activities) ValidateOrder(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	return nil
}

func (a *Activities) PreparePizza(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	return nil
}

func (a *Activities) BakePizza(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	return nil
}

func (a *Activities) Deliver(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))
	return nil
}
