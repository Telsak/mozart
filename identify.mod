#ACTION {It may be referred to as "%1"} {#VAR {itemwords} {%1}}

#NOP : Grab the keywords for the item and begin logging output to temp item file
#ACTION {You give %1 to parth the appraiser} 
{
  #VAR {itemlong} {%1};
  #LOG overwrite .itemlog
}

#NOP : Stop logging, call cleanup alias and most importantly reset the variables
#ACTION {Parth the appraiser gives you %1.} 
{
  #DELAY 0.3 {#LOG {off}}; 
  cleanup; 
  #DELAY 1 {resetvar}
}

#NOP : Append the keywords to the item textfile, then append the item data afterward
#ALIAS {cleanup}
{
  #SYS {echo ITEM $itemwords >> mozart.db}; 
  #SYS {sed -ne '/Object "$itemlong/,$ p' .itemlog >> mozart.db}
}

#NOP : Force itemvariables to reset after each cycle
#ALIAS {resetvar}
{
  #var itemwords {NULL}; 
  #var itemlong {NULL}
}

#NOP : Look at item to grab keywords, then force a delay so $itemwords gets a real
#NOP   value, then give the item to identify NPC
#ALIAS {identify} 
{
  look %1; 
  #DELAY 0.75 {give %1 parth}
}

#NOP: Crude search by $itemwords, then forces a carriage return for formatting
#ALIAS {find}
{
  look %1;
  #DELAY 1 {finditem %1}
}

#NOP: Lets us pick an item ourselves without looking
#ALIAS {finditem}
{
  #SYS {awk '/ITEM $itemwords/{flag=1;next}/ITEM/{flag=0}flag' mozart.db};
  #SHOWME \ ;
  #CR
}

#NOP : Shows A complete list of identified items
#ALIAS {listitems} {#SYS grep ITEM mozart.db | sed 's/ITEM\ //g'}
