/// Connection information for the API server
const String apiPort =
    String.fromEnvironment('NODE_PORT', defaultValue: '8000');
const String apiPrefix = 'http://127.0.0.1:$apiPort';

/// Number of orders to emit before closing. Set to -1 for infinite.
const int maxOrders = -1;

/// Number of milliseconds randomly in interval [min, max) between generated orders
const int newOrderIntervalMin = 2000;
const int newOrderIntervalMax = 4000;

/// For auto-generated pizzas, how many toppings will they have?
const int numRandomToppings = 4;
