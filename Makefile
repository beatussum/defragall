ifneq ($(ALL_TS), yes)
	LOCALE := $(shell echo $$LANGUAGE)
	TRANSLATIONS = i18n/$(LOCALE).mo
else
	TRANSLATIONS_SRC := $(wildcard i18n/*.po)
	TRANSLATIONS := $(TRANSLATIONS_SRC:.po=.mo)
endif
LANGUAGES := $(foreach i, $(TRANSLATIONS), $(shell echo $(i) | cut -d / -f 2 | cut -d . -f 1))


all: $(TRANSLATIONS)
.PHONY: all

%.mo: %.po
	@echo "Compiling of the Portable Object files..."
	@msgfmt -o $@ $*.po

%.po: defragall.pot
	@echo "Updating of the Portable Object files..."
	@if [ -e $@ ]; then \
		msgmerge -q -U --backup=existing $@ defragall.pot; \
	else \
		echo "$@ : This language is not translate!"; \
		cp defragall.pot $@; \
	fi

defragall.pot: defragall
	@echo "Creating of the Portable Object Template file..."
	@xgettext -LShell --from-code=UTF-8 --no-wrap -o $@ defragall

install: all
	@echo "Installing of the Machine Object files..."
	@$(foreach i, $(LANGUAGES), $(shell install -Dm644 i18n/$(i).mo $(INSTALL_ROOT)/usr/share/locale/$(i)/LC_MESSAGES/defragall.mo))
	@echo "Installing of the executable file..."
	@install -Dm755 defragall $(INSTALL_ROOT)/usr/bin/defragall
.PHONY: install

uninstall:
	@echo "Uninstalling of the Machine Object files..."
	@$(foreach i, $(LANGUAGES), $(shell rm $(INSTALL_ROOT)/usr/share/locale/$(i)/LC_MESSAGES/defragall.mo))
	@echo "Uninstalling of the executable file..."
	@rm $(INSTALL_ROOT)/usr/bin/defragall
.PHONY: uninstall

update: clean all
.PHONY: update

clean:
	@echo "Deleting of the Machine Object files..."
	@rm $(TRANSLATIONS)
	@echo "Deleting of the Portable Object Template file..."
	@rm defragall.pot
.PHONY: clean
