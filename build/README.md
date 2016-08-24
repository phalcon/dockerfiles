# Phalcon Build

Docker images to build Phalcon in supported platforms.

## Supported Operating Systems

### Ubuntu

| Codename  | OS Release | Phalcon Releases  | PHP version  | Docker image                                        |
| --------- | ---------- | ----------------- | ------------ | --------------------------------------------------- |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.0.2` | `5.5.x`      | [`phalconphp/build:ubuntu-trusty`][:ubuntu-trusty:] |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.0.2` | `7.0.x`      | [`phalconphp/build:ubuntu-trusty-7.0`][:trusty-7:]  |
| `wily`    | 15.10      | `3.0.0` - `3.0.2` | `5.6.x`      | [`phalconphp/build:ubuntu-wily`][:ubuntu-wily:]     |
| `xenial`  | 16.04 LTS  | `3.0.0` - `3.0.2` | `7.0.x`      | [`phalconphp/build:ubuntu-xenial`][:ubuntu-xenial:] |

### Debian

| Codename  | OS Release | Phalcon Releases  | PHP version  | Docker image                                          |
| --------- | ---------- | ----------------- | ------------ | ----------------------------------------------------- |
| `jessie`  | 8.5 LTS    | `3.0.0` - `3.0.2` | `5.6.x`      | [`phalconphp/build:debian-jessie`][:debian-jessie:]   |
| `stretch` | 9          | `3.0.0` - `3.0.2` | `7.0.x`      | [`phalconphp/build:debian-stretch`][:debian-stretch:] |

[:trusty-7:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-trusty-7.0/Dockerfile
[:ubuntu-trusty:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-trusty/Dockerfile
[:ubuntu-wily:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-wily/Dockerfile
[:ubuntu-xenial:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-xenial/Dockerfile
[:debian-jessie:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-jessie/Dockerfile
[:debian-stretch:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-stretch/Dockerfile
