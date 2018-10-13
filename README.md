## About defragall
**defragall** is a simple utility which allows you to defragment all _btrfs_ subvolumes mounted on your system, in a single command.

## To build it
Just type `make`.

## To install it
Type `sudo make install`. But if you want to choose another root, so type `sudo make INSTALL_ROOT='my_root' install`.

## To use it
Type `defragall -h` to get help. The commands are based on `btrfs filesystem defragment`. The program creates a log file whose absolute path is _/var/log/defragall.log_.
