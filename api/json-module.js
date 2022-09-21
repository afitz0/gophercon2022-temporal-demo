/*eslint-disable block-scoped-var, id-length, no-control-regex, no-magic-numbers, no-prototype-builtins, no-redeclare, no-shadow, no-var, sort-vars*/
"use strict";

var $protobuf = require("protobufjs/light");

var $root = ($protobuf.roots["default"] || ($protobuf.roots["default"] = new $protobuf.Root()))
.addJSON({
  gopherpizza: {
    nested: {
      pizza: {
        nested: {
          api: {
            nested: {
              v1: {
                options: {
                  go_package: "gopherpizza.api"
                },
                nested: {
                  Crust: {
                    values: {
                      CRUST_NORMAL: 0,
                      CRUST_THIN: 1,
                      CRUST_GARLIC: 2,
                      CRUST_STUFFED: 3,
                      CRUST_GLUTEN_FREE: 4,
                      CRUST_PRETZEL: 5
                    }
                  },
                  Cheese: {
                    values: {
                      CHEESE_MOZZARELLA: 0,
                      CHEESE_CHEDDAR: 1,
                      CHEESE_NONE: 2,
                      CHEESE_ALL: 3
                    }
                  },
                  OrderStatus: {
                    values: {
                      ORDER_RECEIVED: 0,
                      ORDER_PREPARING: 1,
                      ORDER_BAKING: 2,
                      ORDER_PENDING_PICKUP: 3,
                      ORDER_OUT_FOR_DELIVERY: 4,
                      ORDER_DELIVERED: 5
                    }
                  },
                  PizzaOrderInfo: {
                    fields: {
                      id: {
                        type: "string",
                        id: 1
                      },
                      crust: {
                        type: "Crust",
                        id: 2
                      },
                      cheese: {
                        type: "Cheese",
                        id: 3
                      },
                      toppings: {
                        rule: "repeated",
                        type: "string",
                        id: 4
                      }
                    }
                  },
                  PizzaOrderStatus: {
                    fields: {
                      status: {
                        type: "OrderStatus",
                        id: 1
                      },
                      order: {
                        type: "PizzaOrderInfo",
                        id: 2
                      },
                      runId: {
                        type: "string",
                        id: 3
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
});

module.exports = $root;
