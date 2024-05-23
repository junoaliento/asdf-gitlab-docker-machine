# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test gitlab-docker-machine https://github.com/junoaliento/asdf-gitlab-docker-machine.git "docker-machine -v"
```

Tests are automatically run in GitHub Actions on push and PR.
