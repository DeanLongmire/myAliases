co() {
    git checkout "$1"
}

gogit() {
  cd
  cd ../../git
}

gcom() {
  git add .
  git commit -m "$1"
}

gp() {
  git push origin
}

gnew() {
  git checkout -b "$1"
  git push --set-upstream origin "$1"
}

_co_completion() {
    local branches
    branches=$(git branch -a | awk '{print $NF}' | sed 's|remotes/origin/||' | sort -u)
    COMPREPLY=($(compgen -W "$branches" -- "${COMP_WORDS[1]}"))
}
complete -F _co_completion co

gup() {
  git fetch --prune && git branch -r | awk -F/ '$2 == "origin" && !seen[$3]++ && !system("git rev-parse --quiet --verify " $3) {print $3}' | xargs -I {} git branch -d {}
}

rb() {
  current_dir="$(basename "$PWD")"

  if [ -d "$current_dir" ]; then
    cd "$current_dir"
    cargo run
  else
    echo "No project folder was found: $current_dir"
  fi
}


