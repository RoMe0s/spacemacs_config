get_bash_w() {
  # Returns the same working directory that the \W bash prompt command
  echo $(pwd | sed 's@'"$HOME"'@~@')
}

split_pwd() {
  # Split pwd into the first element, elipsis (...) and the last subfolder
  # /usr/local/share/doc --> /usr/.../doc
  # ~/project/folder/subfolder --> ~/project/../subfolder
  split=2
  W=$(get_bash_w)
  if [ $(echo $W | grep -o '/' | wc -l) -gt $split ]; then
    echo $W | cut -d'/' -f1-$split | xargs -I{} echo {}"/../${W##*/}"
  else
    echo $W
  fi
}

# Slightly modified from: https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt

# Show current git branch in command line
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\$(split_pwd)\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
