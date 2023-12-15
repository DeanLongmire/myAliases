co() {
    git checkout "$1"
}

gogit() {
  cd
  cd ../../git
}

gocs() {
  cd
  cd ../../git/cs$1
}

gop() {
  cd
  cd ../../git/Projects/$1
  if [ $1 ]; then 
    code .
  fi
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
  current_directory=$(pwd)
  current_directory_name=$(basename "$current_directory")

  # Set the directory path
  directory="$current_directory_name/src"

  # Use find to recursively search for files and print their names
  find "$directory" -type f | while read -r file; do
    # Store the file name in a variable
    filename=$file
    rustfmt $filename
  done
}
