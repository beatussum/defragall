TRANSLATIONS_SRC := $(wildcard i18n/*.po)
TRANSLATIONS := $(TRANSLATIONS_SRC:.po=.mo)
LANGUAGES := $(foreach i, $(TRANSLATIONS), $(shell echo $(i) | cut -d / -f 2 | cut -d . -f 1))


all: $(TRANSLATIONS)
.PHONY: all

%.mo: %.po
	@echo 'Compiling the Portable Object files...'
	@msgfmt -o $@ $*.po

%.po: defragall.pot
	@echo 'Updating the Portable Object files...'
	@if [ -e $@ ]; then \
		msgmerge -q -U --backup=existing $@ defragall.pot; \
	else \
		echo "$@ : This language is not translated!"; \
		cp defragall.pot $@; \
	fi

defragall.pot: defragall
	@echo 'Creating the Portable Object Template file...'
	@xgettext -LShell --from-code=UTF-8 --no-wrap -o $@ defragall

install: all
	@echo 'Installing the Machine Object files...'
	@for i in $(LANGUAGES); do \
		if [ ! -e $(INSTALL_ROOT)/usr/share/locale/$$i/LC_MESSAGES/defragall.mo ]; then \
			install -Dm644 i18n/$$i.mo $(INSTALL_ROOT)/usr/share/locale/$$i/LC_MESSAGES/defragall.mo; \
		fi \
	done
	@echo 'Installing the executable file...'
	@if [ ! -e $(INSTALL_ROOT)/usr/bin/defragall ]; then \
		install -Dm755 defragall $(INSTALL_ROOT)/usr/bin/defragall; \
	fi
	@echo 'Installing the completion files...'
	@if [ ! -e $(INSTALL_ROOT)/usr/share/zsh/site-functions/_defragall ]; then \
		install -Dm644 completions/zsh $(INSTALL_ROOT)/usr/share/zsh/site-functions/_defragall; \
	fi
.PHONY: install

uninstall:
	@echo 'Uninstalling the Machine Object files...'
	@for i in $(LANGUAGES); do \
		if [ -e $(INSTALL_ROOT)/usr/share/locale/$$i/LC_MESSAGES/defragall.mo ]; then \
			rm $(INSTALL_ROOT)/usr/share/locale/$$i/LC_MESSAGES/defragall.mo; \
		fi \
	done
	@echo 'Uninstalling the executable file...'
	@if [ -e $(INSTALL_ROOT)/usr/bin/defragall ]; then \
		rm $(INSTALL_ROOT)/usr/bin/defragall; \
	fi
	@echo 'Uninstalling the completion files...'
	@if [ -e $(INSTALL_ROOT)/usr/share/zsh/site-functions/_defragall ]; then \
		rm $(INSTALL_ROOT)/usr/share/zsh/site-functions/_defragall; \
	fi
.PHONY: uninstall

reinstall: uninstall install
.PHONY: reinstall

update: clean all
.PHONY: update

clean:
	@echo 'Deleting of the Machine Object files...'
	@if [ -e $(TRANSLATIONS) ]; then \
		rm $(TRANSLATIONS); \
	fi
	@echo 'Deleting of the Portable Object Template file...'
	@if [ -e defragall.pot ]; then \
		rm defragall.pot; \
	fi
.PHONY: clean
