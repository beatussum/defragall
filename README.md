## About defragall
**defragall** is a simple utility which allows you to defragment all _btrfs_ subvolumes mounted in a single command.

## To build it
Just type `make`. By default, only the translation corresponding to the system locale is installed. If you want to install all translations, type `make ALL_TS=yes`.

## To install it
Type `sudo make install`, then the file will be installed in _/usr/bin_. But if you want to choose another root, type `sudo make INSTALL_ROOT='my_root' install`.

## To use it
Type `defragall -h` for help. The commands are based on `btrfs filesystem defragment`. The program creates a log file in the path _/var/log/defragall.log_.
