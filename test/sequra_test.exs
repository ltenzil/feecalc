defmodule SequraTest do
  use ExUnit.Case
  doctest Sequra

  # test "greets the world" do
  #   assert Sequra.hello() == :world
  # end

  test "should return sequra fee" do
    assert Sequra.fees("49") == 0.01
    assert Sequra.fees(49) == 0.01
    assert Sequra.fees(55) == 0.0095
    assert Sequra.fees(325) == 0.0085
  end

  test "should return order fee" do
    assert Sequra.order_fee(100) == (0.0095 * 100)
  end

  test "should return amount after fee" do
    assert Sequra.order_amount(100) == 100 - (0.0095 * 100)
    assert Sequra.order_amount("325") == Float.round(325 - (0.0085 * 325), 2)
  end
end
