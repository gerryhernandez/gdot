#!/usr/bin/env bash
git clone --bare https://github.com/gerryhernandez/gdot $HOME/.gdot
function gdot {
   git --git-dir=$HOME/.gdot/ --work-tree=$HOME $@
}
mkdir -p .gdot-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out gdot dotfiles...";
  else
    echo "Backing up pre-existing dotfiles.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .gdot-backup/{}
fi;
gdot checkout
gdot config status.showUntrackedFiles no
