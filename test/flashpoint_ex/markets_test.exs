defmodule FlashpointEx.MarketsTest do
  use ExUnit.Case, async: true

  alias FlashpointEx.{Client, Markets}

  setup_all do
    Code.ensure_loaded(Markets)
    :ok
  end

  setup do
    client = Client.new(api_key: "test-key")
    {:ok, client: client}
  end

  describe "module structure" do
    test "defines list/2" do
      assert function_exported?(Markets, :list, 2)
    end

    test "defines get/2" do
      assert function_exported?(Markets, :get, 2)
    end
  end
end
