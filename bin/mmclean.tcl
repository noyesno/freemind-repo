#!/usr/bin/env tclsh


proc decode_entities {text} {
  set matches [regexp -all -inline -indices {&#x[a-fA-F0-9]+;} $text]
  if {[llength $matches]>0} {
    set head 0
    set buf ""
    foreach pair $matches {
      lassign $pair a b
      set hex [string range $text $a+3 $b-1]
      append buf [string range $text $head $a-1]
      append buf [format "%c" "0x$hex"]
      set head [expr {$b+1}]
    }
    append buf [string range $text $b+1 end]
    set text $buf
  }
  return $text
}

proc decode_entities {text} {
  set text [subst -nocommand -novariable [regsub -all {&#x([a-fA-F0-9]+);} [string map {"\\" "\\\\"} $text] {\u\1}]]

  return $text
}

proc remove_freemind_dummy {text} {
  # set text [regsub -all {ID="\w+"|CREATED="\d+"|MODIFIED="\d+"|FOLDED="(true|false)"} $text ""]
  set text [regsub -all {ID="\w+"|CREATED="\d+"|MODIFIED="\d+"} $text ""]
  #set text [regsub -all {CREATED="\d+"|MODIFIED="\d+"} $text ""]
  set text [regsub -all {<node\s{2,}} $text "<node "]
  return $text
}


set xml_head {<?xml version="1.0" encoding="utf-8"?>}

set nline 0
while {[gets stdin line]>=0} {
  incr nline

  if {$nline==1} {
    puts $xml_head

    # compare with "<?xml "
    if [string equal -length 6 $line $xml_head] {
      continue
    }
  }

  set line [decode_entities $line]
  set line [remove_freemind_dummy $line]
  puts $line
}
