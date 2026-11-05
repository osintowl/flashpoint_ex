defmodule FlashpointExTest do
  use ExUnit.Case, async: true

  doctest FlashpointEx

  test "returns version" do
    assert FlashpointEx.version() == "0.1.0"
  end
end
