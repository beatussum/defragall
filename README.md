## About defragall
**defragall** is a simple utility which allows you to defragment all [_Btrfs subvolumes_](https://en.wikipedia.org/wiki/Btrfs#Subvolumes_and_snapshots) mounted on your system, in a single command.

## To update the Archlinux submodule
Type `git submodule update --init` to download the [_AUR_ repository][aur-repo].

## To build it
Just type `make`.

## To install it
Type `sudo make install`. But if you want to choose another root, so type `sudo make INSTALL_ROOT='my_root' install`. If you are on a system based on _Archlinux_, the package is available on [_AUR_][aur-repo].

## To use it
Type `defragall -h` to get help. The commands are based on `btrfs filesystem defragment`. The program creates a log file whose absolute path is _/var/log/defragall.log_.


[aur-repo]:https://aur.archlinux.org/packages/defragall-git
