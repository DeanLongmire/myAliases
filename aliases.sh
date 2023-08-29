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
