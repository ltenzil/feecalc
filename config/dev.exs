use Mix.Config

config :sequra, Sequra.Order, data_source: "./data/orders.json"
config :sequra, Sequra.Merchant, data_source: "./data/merchants.json"
config :sequra, Sequra.Shopper, data_source: "./data/shoppers.json"
