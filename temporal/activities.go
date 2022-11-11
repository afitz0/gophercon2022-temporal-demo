package app

import (
	"context"
	"math/rand"
	"time"

	gopherpizza "gopherpizza/app/api/gopherpizza.api"
)

type Activities struct{}

func (a *Activities) ValidateOrder(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	// TODO: Replace with actual logic
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))

	// check that the request has everything needed for a "valid" order
	// check inventory for the requested ingredients
	return nil
}

func (a *Activities) PreparePizza(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	// TODO: Replace with actual logic
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))

	// Random duration (short).
	// Chance to fail with:
	//  - Missing ingredients (non-retryable)
	//      - Trying to get ingredients *should* succeed, given ValidateOrder above. Fail if it doesn't.
	//  - Threw dough too high; it's stuck on the ceiling (infinitely retryable)
	//  - Dropped dough; it's been stepped on (infinitely retryable)

	return nil
}

func (a *Activities) BakePizza(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	// TODO: Replace with actual logic
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))

	// Activity: Random duration (long)
	// Chance to fail with:
	//  - Undercooked (retryable once)
	//  - Overcooked (non-retryable)
	//     - compensate by backtracking to `prepare`
	return nil
}

func (a *Activities) Deliver(ctx context.Context, o *gopherpizza.PizzaOrderInfo) error {
	// TODO: Replace with actual logic
	time.Sleep(time.Second * time.Duration(rand.Intn(ACTIVITY_MOCK_DURATION_SEC)))

	// Random duration (medium)
	// Chance to fail with:
	//  - Driver forgot address (infinitely retryable)
	//  - Driver is lost ("soft" fail; activity takes longer than expected but is still heartbeating)
	//  - Driver quit during delivery (worker process fails heartbeat; non-retryable)
	//     - compensate by backtracking to `prepareRaw`
	//  - Customer got wrong order (non-retryable)
	//     - compensate by backtracking to `prepareRaw`
	return nil
}
