defmodule FlashpointEx.HTTP do
  @moduledoc false

  @timeout 15_000

  @doc """
  Make a GET request to the Flashpoint API.
  """
  def get(client, path, params \\ []) do
    url = FlashpointEx.Client.base_url(client) <> path

    headers = [
      {"Authorization", "Bearer #{FlashpointEx.Client.api_key(client)}"},
      {"User-Agent", FlashpointEx.Client.user_agent(client)}
    ]

    opts = [
      headers: headers,
      params: build_params(params),
      receive_timeout: @timeout,
      connect_options: [timeout: 8_000],
      retry: false
    ]

    case Req.get(url, opts) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %Req.Response{status: 404, body: body}} ->
        {:ok, %{"data" => [], "message" => parse_error_message(body)}}

      {:ok, %Req.Response{status: status, body: body}} ->
        {:error, "Flashpoint API error (HTTP #{status}): #{parse_error_message(body)}"}

      {:error, exception} ->
        {:error, "Request failed: #{format_exception(exception)}"}
    end
  end

  defp build_params(opts) do
    opts
    |> Enum.filter(fn {_k, v} -> v != nil end)
    |> Enum.into(%{})
  end

  defp parse_error_message(body) when is_map(body) do
    cond do
      Map.has_key?(body, "message") -> body["message"]
      Map.has_key?(body, "error") -> body["error"]
      true -> inspect(body)
    end
  end

  defp parse_error_message(body), do: inspect(body)

  defp format_exception(exception) do
    case exception do
      %Req.TransportError{reason: reason} ->
        "Network connection failed: #{format_reason(reason)}"

      %Mint.TransportError{reason: reason} ->
        "Transport layer error: #{format_reason(reason)}"

      %Jason.DecodeError{} ->
        "Unable to parse JSON response from Flashpoint API"

      %{__struct__: _module, message: message} when is_binary(message) ->
        message

      %{__exception__: true} = ex ->
        Exception.message(ex)

      error ->
        "An unexpected error occurred: #{inspect(error)}"
    end
  end

  defp format_reason(reason) do
    case reason do
      :timeout -> "Request timed out"
      :econnrefused -> "Connection refused by Flashpoint API"
      :nxdomain -> "DNS resolution failed for Flashpoint API"
      :closed -> "Connection closed unexpectedly"
      {:tls_alert, {:handshake_failure, _}} -> "TLS handshake failed"
      _ -> inspect(reason)
    end
  end
end
