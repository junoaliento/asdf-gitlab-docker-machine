<div align="center">

# asdf-gitlab-docker-machine [![Build](https://github.com/junoaliento/asdf-gitlab-docker-machine/actions/workflows/build.yml/badge.svg)](https://github.com/junoaliento/asdf-gitlab-docker-machine/actions/workflows/build.yml) [![Lint](https://github.com/junoaliento/asdf-gitlab-docker-machine/actions/workflows/lint.yml/badge.svg)](https://github.com/junoaliento/asdf-gitlab-docker-machine/actions/workflows/lint.yml)

[docker-machine](https://gitlab.com/gitlab-org/ci-cd/docker-machine) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl` and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add gitlab-docker-machine https://github.com/junoaliento/asdf-gitlab-docker-machine.git
```

gitlab-docker-machine:

```shell
# Show all installable versions
asdf list-all gitlab-docker-machine

# Install specific version
asdf install gitlab-docker-machine latest

# Set a version globally (on your ~/.tool-versions file)
asdf global gitlab-docker-machine latest

# Now gitlab-docker-machine commands are available
docker-machine -v
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/junoaliento/asdf-gitlab-docker-machine/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Juno Aliento](https://github.com/junoaliento/)
