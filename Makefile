main_dir ?= main_dir
malicious_dir ?= quarantine_dir
interval ?= 5

.PHONY: all prepare daemon restore clean

all: prepare daemon

prepare:
	@mkdir -p $(malicious_dir)
	@mkdir -p $(main_dir)
	
daemon: prepare
	bash antivirus.sh $(main_dir) $(malicious_dir) $(interval)
	
restore: prepare
	bash restore.sh $(main_dir) $(malicious_dir)

clean:
	rm -f directory-info.last directory-info.new	
