defmodule Sequra.OrderTest do
  use ExUnit.Case
  doctest Sequra.Order
  alias Sequra.{DataLoader, Order}

  setup_all do
    orders = DataLoader.load("./test/data/orders_test.json", %Sequra.Order{})
    {:ok, orders: orders}
  end

  test "should load and validate order struct", %{orders: orders} do
    record  = List.first(orders)
    %type{} = record
    assert type == Order
  end

  test "should check merchant data", %{orders: orders} do
    record = List.first(orders)
    assert record.merchant_id == "7"
    assert record.shopper_id == "125"
  end

  describe "Query Helpers" do
  
    test "should check - completed_orders", %{orders: orders} do
      completed_orders = Order.completed_orders(orders)
      record = List.first(completed_orders)
      assert length(completed_orders) == 3
      assert length(orders) == 5
      assert record.completed_at != ""
    end

    test "should fetch orders by merchant_id", %{orders: orders} do
      merchant_orders = Order.orders_by(orders, merchant_id: "2")
      assert length(merchant_orders) == 2
    end

    test "should fetch orders by shopper_id", %{orders: orders} do
      user_orders = Order.orders_by(orders, shopper_id: "325")
      assert length(user_orders) == 1
    end

    test "should not fetch orders without keys", %{orders: orders} do
      merchant_orders = Order.orders_by(orders, "2")
      assert length(merchant_orders) == 0
    end

    test "should fetch weekly_orders ", %{orders: orders} do
      date = "30/05/2022"
      date_range  = Order.get_range(date)
      weekly_orders = Order.weekly_orders(orders, date_range, :completed)
      assert length(weekly_orders) == 2

      record = List.first(weekly_orders)
      assert Enum.member?(date_range, Order.format_date(record.completed_at, Order.time_format))
    end

    test "should check date time formats" do
      assert Order.time_format() == "{0D}/{0M}/{YYYY} {h24}:{m}:{s}"
      assert Order.date_format() == "{0D}/{0M}/{YYYY}"
    end

  end

end
