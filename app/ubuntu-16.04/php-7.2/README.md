# `phalconphp/base:ubuntu-16.04`

Application image to use for production with PHP and Nginx.

## Usage

### Xdebug

Xdebug is disabled by default. To enable it you'll need pass
`XDEBUG_REMOTE_ENABLE` and/or `XDEBUG_REMOTE_HOST` environment variables.

| Variable                         | Description                               |
| -------------------------------- | ----------------------------------------- |
| `XDEBUG_REMOTE_ENABLE=1`         | This will enable Xdebug.                  |
| `XDEBUG_REMOTE_AUTO_START=1`     | Enable autostart will catch all requests. |
| `XDEBUG_REMOTE_HOST=192.168.0.1` | Xdebug remote host.                       |
| `XDEBUG_REMOTE_PORT=9000`        | Will setup remote host.                   |

If you want to start debug session manually pass variable `XDEBUG_SESSION_START`
via `GET`, `POST` or `COOKIE`. Note: To use this feature you'll need set
`XDEBUG_REMOTE_HOST`.
