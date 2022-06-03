defmodule Sequra.RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias Sequra.{Router, Order}

  @opts Router.init([])

  test "returns all orders" do
    conn =
      :get
      |> conn("/orders", "")
      |> Router.call(@opts)
    response = Poison.decode!(conn.resp_body)
    assert conn.state == :sent
    assert response["title"] == "Orders"
    assert length(response["data"]) ==  response["count"]
  end

  test "returns disburse report for merchant" do
    conn =
      :get
      |> conn("/disburse/merchants/2?date=01/06/2022")
      |> Router.call(@opts)

    response = Poison.decode!(conn.resp_body)
    assert conn.state == :sent
    assert conn.status == 200
    assert response["title"] == "Weekly Disbursal Report"
    assert length(response["data"]) == response["count"]
  end

  test "returns disburse report for merchant, record dates" do
    date = "01/06/2022"
    conn =
      :get
      |> conn("/disburse/merchants/2?date=#{date}")
      |> Router.call(@opts)

    week = Order.get_range(date)
    response = Poison.decode!(conn.resp_body)
    record   =  List.first(response["data"])
    record_completed_at = Order.format_date(record["completed_at"], Order.time_format())
    assert conn.state == :sent
    assert conn.status == 200
    assert Enum.member?(week, record_completed_at)
  end

  test "returns disburse report for merchants" do
    conn =
      :get
      |> conn("/disburse/merchants?date=01/06/2022")
      |> Router.call(@opts)

    response = Poison.decode!(conn.resp_body)
    merchants = Enum.map(response["data"], fn(resp) -> resp["merchant_id"] end)
    assert conn.state == :sent
    assert conn.status == 200
    assert response["title"] == "Weekly Disbursal Report"
    assert length(response["data"]) == 2
    assert merchants == ["7", "2"]
  end

  test "returns completed orders" do
    conn =
      :get
      |> conn("/orders/completed", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end


  test "returns merchant orders" do
    conn =
      :get
      |> conn("/merchant/2/orders", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "returns completed merchant orders" do
    conn =
      :get
      |> conn("/merchant/2/orders/completed", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end


  test "returns completed user orders" do
    conn =
      :get
      |> conn("/user/325/orders/completed", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "returns 404" do
    conn =
      :get
      |> conn("/missing", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end
