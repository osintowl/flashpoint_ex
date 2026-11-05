# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-11-05

### Added

- Initial release
- Communities endpoint support
  - List communities with query, limit, skip, and sort parameters
  - Get specific community by ID
- Ransomware endpoint support
  - List ransomware groups with query, limit, skip, and sort parameters
  - Get specific ransomware group by ID
- Markets endpoint support
  - List dark web markets with query, limit, skip, and sort parameters
  - Get specific market by ID
- Client configuration with multiple authentication methods
  - Environment variable (FLASHPOINT_API_KEY)
  - Application config
  - Explicit API key parameter
- User-Agent curl/8.7.1 for Cloudflare bypass
- Comprehensive error handling
- Full type specs

[0.1.0]: https://github.com/osintowl/flashpoint_ex/releases/tag/v0.1.0
