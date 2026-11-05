defmodule FlashpointEx.CommunitiesTest do
  use ExUnit.Case, async: true

  alias FlashpointEx.{Client, Communities}

  setup_all do
    Code.ensure_loaded(Communities)
    :ok
  end

  setup do
    client = Client.new(api_key: "test-key")
    {:ok, client: client}
  end

  describe "module structure" do
    test "defines list/2" do
      assert function_exported?(Communities, :list, 2)
    end

    test "defines get/2" do
      assert function_exported?(Communities, :get, 2)
    end
  end
end
