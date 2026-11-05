defmodule FlashpointEx.ClientTest do
  use ExUnit.Case, async: true

  alias FlashpointEx.Client

  describe "new/1" do
    test "creates client with explicit API key" do
      client = Client.new(api_key: "test-key")
      assert client.api_key == "test-key"
      assert client.base_url == "https://api.flashpoint.io"
      assert client.user_agent == "curl/8.7.1"
    end

    test "creates client with custom base URL" do
      client = Client.new(api_key: "test-key", base_url: "https://custom.url")
      assert client.base_url == "https://custom.url"
    end

    test "creates client with custom user agent" do
      client = Client.new(api_key: "test-key", user_agent: "custom-agent")
      assert client.user_agent == "custom-agent"
    end

    test "raises when API key is not provided or configured" do
      # Clear env and config for this test
      original_env = System.get_env("FLASHPOINT_API_KEY")
      System.delete_env("FLASHPOINT_API_KEY")

      assert_raise RuntimeError, ~r/FLASHPOINT_API_KEY not configured/, fn ->
        Client.new()
      end

      # Restore env if it existed
      if original_env, do: System.put_env("FLASHPOINT_API_KEY", original_env)
    end
  end

  describe "accessors" do
    setup do
      client = Client.new(api_key: "test-key")
      {:ok, client: client}
    end

    test "api_key/1 returns API key", %{client: client} do
      assert Client.api_key(client) == "test-key"
    end

    test "base_url/1 returns base URL", %{client: client} do
      assert Client.base_url(client) == "https://api.flashpoint.io"
    end

    test "user_agent/1 returns user agent", %{client: client} do
      assert Client.user_agent(client) == "curl/8.7.1"
    end
  end
end
