

if [ -s "${HOME}/.rbenv/bin" ]; then
  rbenv_root="${HOME}/.rbenv"
fi

if [ -n "$rbenv_root" ]; then
  export PATH="${rbenv_root}/bin:$PATH"
  eval "$(rbenv init -)"
fi