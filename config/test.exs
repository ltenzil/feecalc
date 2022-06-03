use Mix.Config

config :sequra, Sequra.Order, data_source: "./test/data/orders_test.json"
config :sequra, Sequra.Merchant, data_source: "./test/data/merchants_test.json"
config :sequra, Sequra.Shopper, data_source: "./test/data/shoppers_test.json"
