# Phalcon Build

Docker images to build Phalcon in supported platforms.

## Supported Operating Systems

### Ubuntu

| Codename  | OS Release | Phalcon Releases  | PHP version  | Docker image                                                |
| --------- | ---------- | ----------------- | ------------ | ----------------------------------------------------------- |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.2.1` | `5.5.x`      | [`phalconphp/build:ubuntu-trusty`][:ubuntu-trusty:]         |
| `trusty`  | 14.04 LTS  | `3.0.0` - `3.2.1` | `7.0.x`      | [`phalconphp/build:ubuntu-trusty-7.0`][:ubuntu-trusty-7.0:] |
| `trusty`  | 14.04 LTS  | `3.2.1`           | `7.1.x`      | [`phalconphp/build:ubuntu-trusty-7.1`][:ubuntu-trusty-7.1:] |
| `wily`    | 15.10      | `3.0.0` - `3.2.1` | `5.6.x`      | [`phalconphp/build:ubuntu-wily`][:ubuntu-wily:]             |
| `xenial`  | 16.04 LTS  | `3.0.0` - `3.2.1` | `7.0.x`      | [`phalconphp/build:ubuntu-xenial`][:ubuntu-xenial:]         |
| `xenial`  | 16.04 LTS  | `3.2.1`           | `7.1.x`      | [`phalconphp/build:ubuntu-xenial-7.1`][:ubuntu-xenial-7.1:] |

### Debian

| Codename  | OS Release | Phalcon Releases  | PHP version  | Docker image                                                  |
| --------- | ---------- | ----------------- | ------------ | ------------------------------------------------------------- |
| `jessie`  | 8.5 LTS    | `3.0.0` - `3.2.1` | `5.6.x`      | [`phalconphp/build:debian-jessie`][:debian-jessie:]           |
| `jessie`  | 8.5 LTS    | `3.0.1` - `3.2.1` | `7.0.x`      | [`phalconphp/build:debian-jessie-7.0`][:jessie-7.0:]          |
| `jessie`  | 8.5 LTS    | `3.2.1`           | `7.1.x`      | [`phalconphp/build:debian-jessie-7.1`][:jessie-7.1:]          |
| `stretch` | 9          | `3.0.0` - `3.2.1` | `7.0.x`      | [`phalconphp/build:debian-stretch`][:debian-stretch:]         |
| `stretch` | 9          | `3.2.1`           | `7.1.x`      | [`phalconphp/build:debian-stretch-7.1`][:debian-stretch-7.1:] |

### CentOS (RHEL)

| Codename  | OS Release | Phalcon Releases  | PHP version  | RPM repo | Docker image                                         |
| --------- | ---------- | ----------------- | ------------ | -------- | ---------------------------------------------------- |
| `Core`    | 7.2 LTS    | -                 | `5.4.x`      | -        | [`phalconphp/build:centos7`][:centos7:]              |
| `Core`    | 7.2 LTS    | `3.0.1` - `3.2.1` | `php55u`     | `IUS`    | [`phalconphp/build:centos7-ius55`][:centos7-ius55:]  |
| `Core`    | 7.2 LTS    | `3.0.1` - `3.2.1` | `php56u`     | `IUS`    | [`phalconphp/build:centos7-ius56`][:centos7-ius56:]  |
| `Core`    | 7.2 LTS    | `3.0.1` - `3.2.1` | `php70u`     | `IUS`    | [`phalconphp/build:centos7-ius70`][:centos7-ius70:]  |
| `Core`    | 7.2 LTS    | `3.2.1`           | `php71u`     | `IUS`    | [`phalconphp/build:centos7-ius71`][:centos7-ius71:]  |

[:ubuntu-trusty-7.0:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-trusty-7.0/Dockerfile
[:ubuntu-trusty-7.1:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-trusty-7.1/Dockerfile
[:ubuntu-trusty:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-trusty/Dockerfile
[:ubuntu-wily:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-wily/Dockerfile
[:ubuntu-xenial:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-xenial/Dockerfile
[:ubuntu-xenial-7.1:]: https://github.com/phalcon/dockerfiles/blob/master/build/ubuntu-xenial-7.1/Dockerfile
[:debian-jessie:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-jessie/Dockerfile
[:jessie-7.0:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-jessie-7.0/Dockerfile
[:jessie-7.1:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-jessie-7.1/Dockerfile
[:debian-stretch:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-stretch/Dockerfile
[:debian-stretch-7.1:]: https://github.com/phalcon/dockerfiles/blob/master/build/debian-stretch-7.1/Dockerfile
[:centos7:]: https://github.com/phalcon/dockerfiles/blob/master/build/centos7/Dockerfile
[:centos7-ius55:]: https://github.com/phalcon/dockerfiles/blob/master/build/centos7-ius55/Dockerfile
[:centos7-ius56:]: https://github.com/phalcon/dockerfiles/blob/master/build/centos7-ius56/Dockerfile
[:centos7-ius70:]: https://github.com/phalcon/dockerfiles/blob/master/build/centos7-ius70/Dockerfile
[:centos7-ius71:]: https://github.com/phalcon/dockerfiles/blob/master/build/centos7-ius71/Dockerfile
