__load_secrets() {
  export GITHUB_PACKAGES_TOKEN="$(security find-generic-password -a "$USER" -s github-packages-token -w 2>/dev/null)"
  unfunction npm npx bun bunx __load_secrets 2>/dev/null
}

for __cmd in npm npx bun bunx; do
  eval "${__cmd}() { __load_secrets; command ${__cmd} \"\$@\"; }"
done
unset __cmd
