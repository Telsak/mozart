#MATH {n_x} {$col / 2 - 3}
#MATH {n_y} {$rawSplit / 2}

#ALIAS {getnotes} {#MAP list {roomnote}{{\w+}}{distance}{$n_y}{variable}{note}}

#ALIAS {loopnotes} 
{
  #LIST {notes_l} clear;
  #LIST {notes_l} add {-== Map legend ==-};
  #FOREACH {*note[%*]} attr #IF 
  {
    $note[$attr][z] == 0 && 
    $note[$attr][x] > -$num && 
    $note[$attr][x] < $num && 
    $note[$attr][y] > -$num && 
    $note[$attr][y] < $num
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
  #IF {&notes_l[] > 0}
  {
    #DRAW White BOX 3 4 4+&notes_l[] 25 $notes_l[];
  }
}

#EVENT {MAP UPDATED VTMAP} 
{
  getnotes;
  loopnotes;
}
