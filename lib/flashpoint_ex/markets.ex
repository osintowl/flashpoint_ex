defmodule FlashpointEx.Markets do
  @moduledoc """
  Markets endpoint for Flashpoint Sources API v2.

  Provides access to dark web marketplaces where illicit goods and
  services are traded.
  """

  alias FlashpointEx.{Client, HTTP}

  @doc """
  List dark web markets.

  ## Parameters

    - `client` - FlashpointEx.Client struct (optional, will be created if not provided)
    - `opts` - Query options:
      - `:query` - Search query string
      - `:limit` - Maximum results to return (default: 50, max: 1000)
      - `:skip` - Number of results to skip for pagination
      - `:sort` - Sort field and order (e.g., "created_at.date-time:desc")

  ## Examples

      client = FlashpointEx.Client.new()
      {:ok, markets} = FlashpointEx.Markets.list(client, query: "drugs", limit: 100)

      # Or without explicit client
      {:ok, markets} = FlashpointEx.Markets.list(query: "drugs")
  """
  @spec list(Client.t() | Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def list(client_or_opts \\ [], opts \\ [])

  def list(%Client{} = client, opts) do
    params = Keyword.take(opts, [:query, :limit, :skip, :sort])
    HTTP.get(client, "/sources/v2/markets", params)
  end

  def list(opts, []) when is_list(opts) do
    client = Client.new()
    list(client, opts)
  end

  @doc """
  Get a specific market by ID.

  ## Parameters

    - `client` - FlashpointEx.Client struct (optional)
    - `id` - Market ID

  ## Examples

      client = FlashpointEx.Client.new()
      {:ok, market} = FlashpointEx.Markets.get(client, "ghi789")

      # Or without explicit client
      {:ok, market} = FlashpointEx.Markets.get("ghi789")
  """
  @spec get(Client.t() | String.t(), String.t() | nil) :: {:ok, map()} | {:error, String.t()}
  def get(client_or_id, id \\ nil)

  def get(%Client{} = client, id) when is_binary(id) do
    HTTP.get(client, "/sources/v2/markets/#{id}")
  end

  def get(id, nil) when is_binary(id) do
    client = Client.new()
    get(client, id)
  end
end
