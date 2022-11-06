# Gdot - Gerry's Dot Files
I'm giving [this](https://www.atlassian.com/git/tutorials/dotfiles) method a
shot.

## TLDR:
```
curl https://raw.githubusercontent.com/gerryhernandez/gdot/main/.gscripts/unix/init_repo.sh | /bin/bash
```

This will copy all existing dotfiles that would otherwise be overwritten into
`~/.gdot-backup/`, then copy all dotfiles from the repo into place. This is
done via the magic of abusing Git's ability to have a repo in another
directory. Pretty nifty.

Then just use the `gdot` command as if it's Git. It really is just an aliased
Git, but with command line arguments automagically baked in. The above script
already ignores untracked files, and since the actual Git repo is in `~/.gdot`,
the home directory doesn't show as a Git repo at the command line prompt in
any way. No noise. Yay!

Careful when adding files. It's best to add one small folder or even
individual files at a time. Just use `gdot add foobar`.
