INSTALL_PROGRAM = install -Dm755
DEL_FILE = rm -f


install: defragall
	$(INSTALL_PROGRAM) defragall $(INSTALL_ROOT)/usr/bin/defragall

uninstall:
	$(DEL_FILE) $(INSTALL_ROOT)/usr/bin/defragall
