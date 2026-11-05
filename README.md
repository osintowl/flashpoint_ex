# FlashpointEx

Elixir client for [Flashpoint](https://flashpoint.io) Sources API v2.

Provides access to Flashpoint's threat intelligence data including:
- Communities (forums, chat services, paste sites)
- Ransomware groups and victims
- Dark web markets

## Installation

Add `flashpoint_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:flashpoint_ex, "~> 0.1.0"}
  ]
end
```

## Configuration

Configure your API key in one of the following ways:

### 1. Environment Variable

```bash
export FLASHPOINT_API_KEY="your-api-key"
```

### 2. Application Config

```elixir
config :flashpoint_ex, api_key: "your-api-key"
```

### 3. Explicit Client

```elixir
client = FlashpointEx.Client.new(api_key: "your-api-key")
```

## Usage

### Communities

```elixir
# List communities
{:ok, communities} = FlashpointEx.Communities.list(query: "hacking", limit: 10)

# Get specific community
{:ok, community} = FlashpointEx.Communities.get("community-id")

# With explicit client
client = FlashpointEx.Client.new()
{:ok, communities} = FlashpointEx.Communities.list(client, query: "hacking")
```

### Ransomware

```elixir
# List ransomware groups
{:ok, groups} = FlashpointEx.Ransomware.list(query: "LockBit", limit: 50)

# Get specific group
{:ok, group} = FlashpointEx.Ransomware.get("group-id")

# With sorting
{:ok, groups} = FlashpointEx.Ransomware.list(
  sort: "posted_at.date-time:desc",
  limit: 100
)
```

### Markets

```elixir
# List markets
{:ok, markets} = FlashpointEx.Markets.list()

# Search markets
{:ok, markets} = FlashpointEx.Markets.list(query: "drugs")

# Get specific market
{:ok, market} = FlashpointEx.Markets.get("market-id")
```

### Pagination

All list endpoints support pagination:

```elixir
# First page
{:ok, page1} = FlashpointEx.Communities.list(limit: 50, skip: 0)

# Second page
{:ok, page2} = FlashpointEx.Communities.list(limit: 50, skip: 50)
```

## Features

- User-Agent set to `curl/8.7.1` to bypass Cloudflare protection
- Comprehensive error handling with detailed error messages
- Support for all query parameters (query, limit, skip, sort)
- Optional client configuration for flexible authentication
- Type specs for all public functions

## API Documentation

For detailed API documentation, see the [Flashpoint API documentation](https://flashpoint.io/api-docs).

## License

BSD 3-Clause

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
