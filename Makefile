
help:
	@echo "make init       ;# init mindmap repo"

init:
	echo "*.mm filter=freemind" >> .gitattributes
	git config filter.freemind.required true
	git config filter.freemind.clean bin/mmclean.tcl
	git config filter.freemind.smudge cat
