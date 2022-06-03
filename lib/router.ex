defmodule Sequra.Router do
  import Plug.Conn
  use Plug.Router
  alias Sequra.{Order, Disburse}

  plug(:match)
  plug(:dispatch)

  get "/disburse/merchants" do
    orders = Order.list()
      |> Disburse.generate_report(conn.params["date"])
    handle_reponse(conn, orders)
  end

  get "/disburse/merchants/:id" do
    orders = Order.list()
      |> Order.orders_by(merchant_id: conn.params["id"])
      |> Disburse.generate_report(conn.params["date"])
    handle_reponse(conn, orders)
  end

  get "/orders" do
    orders = Order.list()
    handle_reponse(conn, orders)
  end

  # additional apis

  get "/orders/completed" do
    data = Order.list() |> Order.completed_orders()
    handle_reponse(conn, data)
  end

  get "/merchant/:id/orders" do
    merchant_orders =  Order.list()
      |> Order.orders_by(merchant_id: conn.params["id"])
    handle_reponse(conn, merchant_orders)
  end

  get "/merchant/:id/orders/completed" do
    merchant_orders = Order.list()
      |> Order.orders_by(merchant_id: conn.params["id"])
      |> Order.completed_orders()
    handle_reponse(conn, merchant_orders)
  end

  get "/user/:id/orders" do
    user_orders = Order.list()
      |> Order.orders_by(shopper_id: conn.params["id"])
    handle_reponse(conn, user_orders)
  end

  get "/user/:id/orders/completed" do
    user_orders = Order.list()
      |> Order.orders_by(shopper_id: conn.params["id"])
      |> Order.completed_orders()
    handle_reponse(conn, user_orders)
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  def handle_reponse(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, to_json(data))
  end

  defp to_json(data) when is_list(data) do
    %{
      title: "Orders",
      count: length(data),
      data: data
    }
    |> Poison.encode!()
  end

  defp to_json(resp) when is_map(resp) do
    %{
      title: "Weekly Disbursal Report",
      count: length(resp[:orders]),
      data: resp[:orders],
      date_range: [resp[:date_range].first, resp[:date_range].last]
    }
    |> Poison.encode!()
  end
end
