
help:
	@echo ""
	@echo "Usage:"
	@echo ""
	@echo "  make init                       ;# init mindmap repo"
	@echo ""
	@echo "  ./bin/mmclean.tcl < test.mm     ;# clean mindmap file"
	@echo ""

init:
	echo "*.mm filter=freemind" >> .gitattributes
	git config filter.freemind.required true
	git config filter.freemind.clean bin/mmclean.tcl
	git config filter.freemind.smudge cat
