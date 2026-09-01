(( $+commands[secret-tool] )) || return 0

__load_secrets() {
  export GITHUB_PACKAGES_TOKEN="$(secret-tool lookup service github-packages-token 2>/dev/null)"
  unfunction npm npx bun bunx __load_secrets 2>/dev/null
}

for __cmd in npm npx bun bunx; do
  eval "${__cmd}() { __load_secrets; command ${__cmd} \"\$@\"; }"
done
unset __cmd
