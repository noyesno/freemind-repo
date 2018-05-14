# freemind-repo

Freemind mindmaps are saved as XML files. So it's possible to manage a collection of Freemind mindmaps with a version control system. Here we choose popular Git.

But Freemind mindmap xml file contains attributes like `CREATED`, `MODIFIED` which are timestampes. Such timestampes does not make too much sense for a knowledge mindmap, and bring noise to version control.

[freemind-mmx](https://github.com/jiangxin/freemind-mmx) solve this issue with a hacked version Freemind.

This project solves the issue through git `clean` filter. A program is used to apply filters on the mindmap xml file.

* Remove `CREATED` and `MODIFIED` node attributes.
  * Attribute `ID` is also removed. It's not needed when there is no node link in the mindmap.
* Decode unicode characters which are encoded like `&#x627e;`.
  * This improves the readiblity of mindmap XML file.

It has been verified that Freemind can open the filterred mindmap file well.

## Quick Usage

```
echo "*.mm filter=freemind" >> .gitattributes

git config filter.freemind.required true

git config filter.freemind.clean bin/mmclean.tcl
git config filter.freemind.smudge cat
```

Default filter program is implemented with [Tcl](http://www.tcl.tk/) - my favourite script language.

## See Also

My another Freemind related project [freefind-plus](https://github.com/noyesno/freemind-plus) which focus on Freemind mindmap conversion.
