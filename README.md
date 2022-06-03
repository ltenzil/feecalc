# Fee Calculator

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sequra` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sequra, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/sequra](https://hexdocs.pm/sequra).

## Instructions:

  * Install dependencies with `mix deps.get`
  * Run the server with `mix run --no-halt`
  * Run the console with `iex -S mix`

## Endpoints:
  * http://localhost:4040/disburse/merchants/14?date=10/01/2018
  * http://localhost:4040/disburse/merchants
  * http://localhost:4040/disburse/merchants?date=01/01/2018
  * http://localhost:4040/orders
  * http://localhost:4040/orders/completed
  * http://localhost:4040/merchant/2/orders
  * http://localhost:4040/merchant/2/orders/completed
  * http://localhost:4040/user/7/orders/completed
