#MATH {n_x} {$col / 2 - 3}
#MATH {n_y} {$rawSplit / 2}

#ALIAS {setlegend} {#VAR l_y %1; #MATH {l_x} {1 * $l_y}}

#ALIAS {getnotes} {#MAP list {roomnote}{{\w+}}{distance}{$rawSplit}{variable}{note}}

#ALIAS {loopnotes} 
{
  #LIST {notes_l} clear;
  #LIST {notes_l} add {-== Map legend ==-};
  #FOREACH {*note[%*]} attr #IF 
  {
    $note[$attr][z] == 0 && 
    $note[$attr][x] > -$l_x && 
    $note[$attr][x] < $l_x && 
    $note[$attr][y] > -$l_y && 
    $note[$attr][y] < $l_y
  } 
  {
    #MAP GET {roomnote} {notetext} {$attr};
    #MAP GET {roomsymbol} {notesymbol} {$attr};
    #CAT {notesymbol} {<fff> : $notetext};
    #LIST {notes_l} add $notesymbol;
  };
  show_legend_info
}

#ALIAS {show_legend_info} 
{
  #IF {&notes_l[] > 1}
  {
    #DRAW White BOX 3 4 4+&notes_l[] 25 $notes_l[];
  }
}

