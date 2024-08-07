co() {
    git checkout "$1"
}

gogit() {
  cd
  cd ../../git
}

open() {
  cd /git/$1
  code .
  cd
}

_open_completion() {
  local directories
  directories=$(find /git -maxdepth 1 -type d -printf "%P\n")
  COMPREPLY=($(compgen -W "$directories" -- "${COMP_WORDS[1]}"))
}
complete -F _open_completion open

st() {
  sudo hwclock -s
}

gocs() {
  cd
  if [ $1 ]; then
    cd ../../git/cs$1
  else
    cd ../../git
  fi
}

gop() {
  cd
  cd ../../git/Projects/$1
  if [ $1 ]; then 
    code .
  fi
}

gri() {
  git rebase -i HEAD~$1
}

grm() {
  git rebase main
}

gcom() {
  git add .
  git commit -m "$1"
}

gp() {
  git push origin
}

gpf() {
  git push origin -f
}

gst() {
  git stash
}

gsp() {
  git stash pop
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
  git pull --rebase && git remote update origin --prune && git fetch -p -t && for branch in $(git for-each-ref --format "%(refname) %(upstream:track)" refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}

gopen() {
  url=$(git config --get remote.origin.url)
  wslview $url
}

# Cargo Run
cr() {
  current_dir="$(basename "$PWD")"

  if [ -d "$current_dir" ]; then
    cd "$current_dir"
    cargo run
    cd ../
  else
    echo "No project folder was found: $current_dir"
  fi
}

# Cargo Test
ct() {
  current_dir="$(basename "$PWD")"

  if [ -d "$current_dir" ]; then
    cd "$current_dir"
    cargo test
    cd ../
  else
    echo "No project folder was found: $current_dir"
  fi
}

# Cargo Format
cf() {
  current_dir="$(basename "$PWD")"

  if [ -d "$current_dir" ]; then
    cd "$current_dir"
    cargo fmt
    cd ../
  else
    echo "No project folder was found: $current_dir"
  fi
}
