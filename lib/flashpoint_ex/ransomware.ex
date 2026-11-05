defmodule FlashpointEx.Ransomware do
  @moduledoc """
  Ransomware endpoint for Flashpoint Sources API v2.

  Provides access to ransomware groups, their activities, and victim organizations
  from leak sites and other sources.
  """

  alias FlashpointEx.{Client, HTTP}

  @doc """
  List ransomware groups and victims.

  ## Parameters

    - `client` - FlashpointEx.Client struct (optional, will be created if not provided)
    - `opts` - Query options:
      - `:query` - Search query string
      - `:limit` - Maximum results to return (default: 50, max: 1000)
      - `:skip` - Number of results to skip for pagination
      - `:sort` - Sort field and order (e.g., "posted_at.date-time:desc")

  ## Examples

      client = FlashpointEx.Client.new()
      {:ok, groups} = FlashpointEx.Ransomware.list(client, query: "LockBit", limit: 100)

      # Or without explicit client
      {:ok, groups} = FlashpointEx.Ransomware.list(query: "LockBit")
  """
  @spec list(Client.t() | Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def list(client_or_opts \\ [], opts \\ [])

  def list(%Client{} = client, opts) do
    params = Keyword.take(opts, [:query, :limit, :skip, :sort])
    HTTP.get(client, "/sources/v2/ransomware-groups", params)
  end

  def list(opts, []) when is_list(opts) do
    client = Client.new()
    list(client, opts)
  end

  @doc """
  Get a specific ransomware group by ID.

  ## Parameters

    - `client` - FlashpointEx.Client struct (optional)
    - `id` - Ransomware group ID

  ## Examples

      client = FlashpointEx.Client.new()
      {:ok, group} = FlashpointEx.Ransomware.get(client, "def456")

      # Or without explicit client
      {:ok, group} = FlashpointEx.Ransomware.get("def456")
  """
  @spec get(Client.t() | String.t(), String.t() | nil) :: {:ok, map()} | {:error, String.t()}
  def get(client_or_id, id \\ nil)

  def get(%Client{} = client, id) when is_binary(id) do
    HTTP.get(client, "/sources/v2/ransomware-groups/#{id}")
  end

  def get(id, nil) when is_binary(id) do
    client = Client.new()
    get(client, id)
  end
end
