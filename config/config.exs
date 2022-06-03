use Mix.Config

config :sequra, Sequra.Endpoint, port: 4040

import_config "#{Mix.env()}.exs"
