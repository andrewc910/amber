PREFIX=/usr/local
INSTALL_DIR=$(PREFIX)/bin
OPAL_SYSTEM=$(INSTALL_DIR)/opal

OUT_DIR=$(CURDIR)/bin
OPAL=$(OUT_DIR)/opal
OPAL_SOURCES=$(shell find src/ -type f -name '*.cr')

all: build

build: lib $(OPAL)

lib:
	@shards install --production

$(OPAL): $(OPAL_SOURCES) | $(OUT_DIR)
	@echo "Building opal in $@"
	@crystal build -o $@ src/amber/cli.cr -p --no-debug

$(OUT_DIR) $(INSTALL_DIR):
	 @mkdir -p $@

run:
	$(OPAL)

install: build | $(INSTALL_DIR)
	@rm -f $(OPAL_SYSTEM)
	@cp $(OPAL) $(OPAL_SYSTEM)

link: build | $(INSTALL_DIR)
	@echo "Symlinking $(OPAL) to $(OPAL_SYSTEM)"
	@ln -s $(OPAL) $(OPAL_SYSTEM)

force_link: build | $(INSTALL_DIR)
	@echo "Symlinking $(OPAL) to $(OPAL_SYSTEM)"
	@ln -sf $(OPAL) $(OPAL_SYSTEM)

clean:
	rm -rf $(OPAL)

distclean:
	rm -rf $(OPAL) .crystal .shards libs lib
