alias gogit='cd /git'

gcom() {
  git add .
  git commit -m "$1"
}
