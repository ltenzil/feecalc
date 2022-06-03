defmodule Sequra.ShopperTest do
  use ExUnit.Case
  doctest Sequra.Shopper

  setup_all do
    shoppers = Sequra.Shopper.list()
    {:ok, shoppers: shoppers}
  end

  test "should load and validate shopper struct", %{shoppers: shoppers} do    
    record  = List.first(shoppers)
    %type{} = record
    assert type == Sequra.Shopper
  end

  test "validate shopper data", %{shoppers: shoppers} do    
    record  = List.first(shoppers)
    assert record.name == "Vickey Nikolaus"
  end

  
end
