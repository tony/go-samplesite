WATCH_FILES= find . -type f -not -path '*/\.*' | grep -i '.*[.]go$$' 2> /dev/null


test:
	go test $(test)

run:
	go run main.go

build:
	go build ./...

runbuild:
	go build ./...; ./go-samplesite

entr_warn:
	@echo "----------------------------------------------------------"
	@echo "     ! File watching functionality non-operational !      "
	@echo ""
	@echo "Install entr(1) to automatically run tasks on file change."
	@echo "See http://entrproject.org/"
	@echo "----------------------------------------------------------"


watch_test:
	if command -v entr > /dev/null; then ${WATCH_FILES} | entr -c $(MAKE) test; else $(MAKE) test entr_warn; fi

watch_run:
	if command -v entr > /dev/null; then ${WATCH_FILES} | entr -c $(MAKE) run; else $(MAKE) run entr_warn; fi

watch_build:
	if command -v entr > /dev/null; then ${WATCH_FILES} | entr -c $(MAKE) build; else $(MAKE) build entr_warn; fi

watch_runbuild:
	if command -v entr > /dev/null; then ${WATCH_FILES} | entr -c $(MAKE) runbuild; else $(MAKE) runbuild entr_warn; fi
