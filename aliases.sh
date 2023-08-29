co() {
    git checkout "$1"
}

gogit() {
  'cd /git'
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
