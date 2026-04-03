# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-04-03
### Added
- Initial release of `aun_notifications_logger` mimicking `aun_api_logger`.
- Support for capturing push notifications parameters: `title`, `body`, `payload`, `type`, `action`, `route`.
- Adaptive UI blocks for viewing notification logs.
- SQLite local database storage for persistence.

### Dependencies
```yaml
dependencies:
  aun_notifications_logger:
    git:
      url: https://github.com/maulik1626/aun_notifications_logger.git
      ref: 1.0.0
```
