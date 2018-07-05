## About defragall
**defragall** is a simple utility which allows you to defragment all _btrfs_ subvolumes mounted in a single command.

## To install it
Type `make install`, then the file will be installed in _/usr/bin_. But if you want to choose another root, type `make INSTALL_ROOT='my_root' install`.

## To use it
Type `defragall -h` for help. The commands are based on `btrfs filesystem defragment`. The program creates a log file in the path _/var/log/defragall.log_.
