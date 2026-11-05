defmodule FlashpointEx.Client do
  @moduledoc """
  Client configuration for FlashpointEx.

  Holds API key and other configuration options.
  """

  defstruct [:api_key, base_url: "https://api.flashpoint.io", user_agent: "curl/8.7.1"]

  @type t :: %__MODULE__{
          api_key: String.t(),
          base_url: String.t(),
          user_agent: String.t()
        }

  @doc """
  Create a new client with the given options.

  ## Options

    - `:api_key` - Flashpoint API key (required if not set via env or config)
    - `:base_url` - Base URL for the API (default: "https://api.flashpoint.io")
    - `:user_agent` - User-Agent header (default: "curl/8.7.1")

  ## Examples

      # From environment variable FLASHPOINT_API_KEY
      client = FlashpointEx.Client.new()

      # From application config
      client = FlashpointEx.Client.new()

      # Explicit API key
      client = FlashpointEx.Client.new(api_key: "your-key")
  """
  @spec new(Keyword.t()) :: t()
  def new(opts \\ []) do
    api_key =
      opts[:api_key] ||
        System.get_env("FLASHPOINT_API_KEY") ||
        Application.get_env(:flashpoint_ex, :api_key) ||
        raise "FLASHPOINT_API_KEY not configured. Set it via environment variable, application config, or pass :api_key option."

    %__MODULE__{
      api_key: api_key,
      base_url: opts[:base_url] || "https://api.flashpoint.io",
      user_agent: opts[:user_agent] || "curl/8.7.1"
    }
  end

  @doc """
  Get the API key from the client.
  """
  @spec api_key(t()) :: String.t()
  def api_key(%__MODULE__{api_key: key}), do: key

  @doc """
  Get the base URL from the client.
  """
  @spec base_url(t()) :: String.t()
  def base_url(%__MODULE__{base_url: url}), do: url

  @doc """
  Get the user agent from the client.
  """
  @spec user_agent(t()) :: String.t()
  def user_agent(%__MODULE__{user_agent: ua}), do: ua
end
