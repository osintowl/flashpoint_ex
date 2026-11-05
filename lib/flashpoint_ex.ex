defmodule FlashpointEx do
  @moduledoc """
  Elixir client for Flashpoint Sources API v2.

  Provides access to Flashpoint's threat intelligence data including:
  - Communities (forums, chat services, paste sites)
  - Ransomware groups and victims
  - Dark web markets

  ## Configuration

  Configure your API key in one of the following ways:

  1. Environment variable:
     ```bash
     export FLASHPOINT_API_KEY="your-api-key"
     ```

  2. Application config:
     ```elixir
     config :flashpoint_ex, api_key: "your-api-key"
     ```

  3. Pass directly to functions using a client struct:
     ```elixir
     client = FlashpointEx.Client.new(api_key: "your-api-key")
     FlashpointEx.Communities.list(client)
     ```

  ## Usage

  ```elixir
  # List communities
  {:ok, communities} = FlashpointEx.Communities.list(query: "hacking", limit: 10)

  # Get specific community
  {:ok, community} = FlashpointEx.Communities.get("community-id")

  # List ransomware groups
  {:ok, ransomware} = FlashpointEx.Ransomware.list(query: "LockBit")

  # List markets
  {:ok, markets} = FlashpointEx.Markets.list()
  ```

  Uses User-Agent `curl/8.7.1` to bypass Cloudflare protection.
  """

  @doc """
  Returns the library version.
  """
  def version, do: "0.1.0"
end
