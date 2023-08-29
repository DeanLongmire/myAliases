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
