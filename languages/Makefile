EXECUTABLE=wahacc

.PHONY: all build clean

all: build

build: $(patsubst %.po,%.mo,$(wildcard *.po))

clean:
	@rm -rf locale

%.mo: %.po
	@mkdir -p locale/$(subst $(EXECUTABLE).,,$(subst .po,,$<))/LC_MESSAGES
	@msgfmt $< -o locale/$(subst $(EXECUTABLE).,,$(subst .po,,$<))/LC_MESSAGES/$(EXECUTABLE).mo
	@cp $< locale/$(subst $(EXECUTABLE).,,$(subst .po,,$<))/LC_MESSAGES/$(EXECUTABLE).po
