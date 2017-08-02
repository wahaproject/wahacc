# Lazarus project file.
TARGET=wahacc.lpi
EXECUTABLE=wahacc
# Primary config directory, where Lazarus stores its config files.
PCP=/etc/lazarus
# override the project widgetset. e.g. gtk,  gtk2,  qt,  win32  or carbon.
WIDGETSET=gtk2

.PHONY: all build install uninstall clean

all: build

build:
	@echo Start compiling ...
	lazbuild -B --pcp=$(PCP) --ws=$(WIDGETSET) $(TARGET)
	@echo Strip symbols and debug info ...
	@strip $(EXECUTABLE)

	@echo generating locales files ...
	@if [ -f languages/$(EXECUTABLE).po ] ; then mv languages/$(EXECUTABLE).po languages/$(EXECUTABLE).en.po; fi;
	@(cd languages && $(MAKE) build)
	@echo done.
install:
	@echo Creating destination directories ...
	@mkdir -p $(DESTDIR)/usr/bin
	@mkdir -p $(DESTDIR)/usr/share/applications
	@mkdir -p $(DESTDIR)/usr/share/wahacc
	@echo Installing ...
	@cp ./$(EXECUTABLE) $(DESTDIR)/usr/bin/
	@cp -r ./icons $(DESTDIR)/usr/share/
	@cp -r ./scripts $(DESTDIR)/usr/share/wahacc
	@cp ./$(EXECUTABLE).desktop $(DESTDIR)/usr/share/applications
	@cp -r ./languages/locale $(DESTDIR)/usr/share/
	@echo done.

uninstall:
	@echo Uninstalling ...
	@rm -f $(DESTDIR)/usr/bin/$(EXECUTABLE)
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/16x16/apps/$(EXECUTABLE).png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/22x22/apps/$(EXECUTABLE).png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/24x24/apps/$(EXECUTABLE).png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/32x32/apps/$(EXECUTABLE).png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/64x64/apps/$(EXECUTABLE).png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/48x48/apps/$(EXECUTABLE).png
	@rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/$(EXECUTABLE).svg
	@rm -f $(DESTDIR)/usr/share/locale/en/LC_MESSAGES/$(EXECUTABLE).mo
	@rm -f $(DESTDIR)/usr/share/locale/ar/LC_MESSAGES/$(EXECUTABLE).mo
	@rm -f $(DESTDIR)/usr/share/locale/en/LC_MESSAGES/$(EXECUTABLE).po
	@rm -f $(DESTDIR)/usr/share/locale/ar/LC_MESSAGES/$(EXECUTABLE).po
	@rm -f $(DESTDIR)/usr/share/applications/$(EXECUTABLE).desktop
	@rm -Rf $(DESTDIR)/usr/share/wahacc/scripts
	@echo Removing empty directories ...
	@if [ -n "${DESTDIR}" ] && [ -d "${DESTDIR}" ]; then \
  	find $(DESTDIR) -type d -empty -delete; \
	fi
	@echo done.
clean:
	@echo Cleaning ...
	@rm -f $(EXECUTABLE)
	@rm -rf lib backup
	@rm -f *.bak
	@rm -f *.lps
	@rm -f *.res
	(cd languages && $(MAKE) clean)
	@if [ -f languages/$(EXECUTABLE).en.po ] ; then mv languages/$(EXECUTABLE).en.po languages/$(EXECUTABLE).po; fi;
	@echo done.
