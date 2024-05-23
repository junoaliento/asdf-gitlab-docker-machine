#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://gitlab.com/gitlab-org/ci-cd/docker-machine"
TOOL_NAME="docker-machine"
TOOL_TEST="docker-machine -v"
ASDF_PLUGIN_NAME="gitlab-$TOOL_NAME"

fail() {
	echo -e "$ASDF_PLUGIN_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_gitlab_tags() {
	git ls-remote --tags --refs "$REPO_URL" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_gitlab_tags
}

download_release() {
	local version url platform architecture
	version="$1"
	platform=$(uname)
	architecture=$(uname -m)

	if [ "$platform" = 'Linux' ]; then
		if ! { [ "$architecture" = 'aarch64' ] || [ "$architecture" = 'armhf' ] || [ "$architecture" = 'x86_64' ]; }; then
			fail "Unsupported architecture"
		fi
	elif [ "$platform" = 'OpenBSD' ] && [ "$architecture" != 'x86_64' ]; then
		fail "Unsupported architecture"
	elif [ "$platform" = 'Darwin' ] && [ "$architecture" != 'x86_64' ]; then
		fail "Unsupported architecture"
	else
		fail "Unsupported platform"
	fi

	mkdir -p "$ASDF_DOWNLOAD_PATH"

	url="$REPO_URL/-/releases/v${version}/downloads/docker-machine-$platform-$architecture"

	echo "* Downloading $TOOL_NAME release $version to $ASDF_DOWNLOAD_PATH..."
	curl "${curl_opts[@]}" -o "$ASDF_DOWNLOAD_PATH/$TOOL_NAME" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "$ASDF_PLUGIN_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

		chmod +x "$install_path/$tool_cmd"

		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
