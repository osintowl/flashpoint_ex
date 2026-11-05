defmodule FlashpointEx.Communities do
  @moduledoc """
  Communities endpoint for Flashpoint Sources API v2.

  Provides access to forums, chat services, paste sites, and other
  threat actor gathering places monitored by Flashpoint.
  """

  alias FlashpointEx.{Client, HTTP}

  @doc """
  List communities.

  ## Parameters

    - `client` - FlashpointEx.Client struct (optional, will be created if not provided)
    - `opts` - Query options:
      - `:query` - Search query string
      - `:limit` - Maximum results to return (default: 50, max: 1000)
      - `:skip` - Number of results to skip for pagination
      - `:sort` - Sort field and order (e.g., "created_at.date-time:desc")

  ## Examples

      client = FlashpointEx.Client.new()
      {:ok, communities} = FlashpointEx.Communities.list(client, query: "hacking", limit: 100)

      # Or without explicit client
      {:ok, communities} = FlashpointEx.Communities.list(query: "hacking")
  """
  @spec list(Client.t() | Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def list(client_or_opts \\ [], opts \\ [])

  def list(%Client{} = client, opts) do
    params = Keyword.take(opts, [:query, :limit, :skip, :sort])
    HTTP.get(client, "/sources/v2/communities", params)
  end

  def list(opts, []) when is_list(opts) do
    client = Client.new()
    list(client, opts)
  end

  @doc """
  Get a specific community by ID.

  ## Parameters

    - `client` - FlashpointEx.Client struct (optional)
    - `id` - Community ID

  ## Examples

      client = FlashpointEx.Client.new()
      {:ok, community} = FlashpointEx.Communities.get(client, "abc123")

      # Or without explicit client
      {:ok, community} = FlashpointEx.Communities.get("abc123")
  """
  @spec get(Client.t() | String.t(), String.t() | nil) :: {:ok, map()} | {:error, String.t()}
  def get(client_or_id, id \\ nil)

  def get(%Client{} = client, id) when is_binary(id) do
    HTTP.get(client, "/sources/v2/communities/#{id}")
  end

  def get(id, nil) when is_binary(id) do
    client = Client.new()
    get(client, id)
  end
end
