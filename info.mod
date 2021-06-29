#EVENT {VARIABLE UPDATED autotrack} {printinfo}
#EVENT {VARIABLE UPDATED autoscan} {printinfo}
#EVENT {VARIABLE UPDATED autoatk} {printinfo}
#EVENT {VARIABLE UPDATED target} {printinfo}
#EVENT {VARIABLE UPDATED curX} {printinfo}


#ACTION {^  Experience: %1  To Level: %2  Gold:} {#math totX {%1+%2}}
#ACTION {^Your armor class is %1.} {#var armor %1}
#ACTION {^Your hitroll and damroll are %1 and %2 respectively.} {#VAR hitV %1;#VAR damV %2}
#ACTION {^Quest Shards: %1 Quest Crystals: %2} {printinfo}

#ALIAS {recoords}
{
  #SCREEN get cols screenWidth;
  #VAR {infoX1} {116+$lrnLen-1};
  #VAR {infoY1} {$screenHeight-20};
  #VAR {infoX2} {116+$lrnLen-1+34};
  #VAR {infoY2} {$screenHeight-11}
}

#ALIAS {printinfo}
{
  recoords;
  #DRAW tile $infoY1 $infoX1 $infoY2 $screenWidth-2;
  #DRAW jeweled box $infoY1 $infoX1 $infoY2 $infoX2;
  #SHOW {track:[$autotrack]} {$infoY1+1} {$infoX1+2};
  #SHOW {scan:[$autoscan]} {$infoY1+1} {$infoX1+2+13};
  #IF {"$autosneak" == "on"}
  {
    #SHOW {[<beb>sneak<099>]} {$infoY1+1} {$infoX1+2+24}
  }
  {
    #SHOW {[<bbb>sneak<099>]} {$infoY1+1} {$infoX1+2+24}
  };
  #SHOW {attack: <fba>$autoatk<099>} {$infoY1+2} {$infoX1+2};
  #SHOW {target: <cff>$target<099>} {$infoY1+3} {$infoX1+2};
  #SHOW {───────────────────────────────} {$infoY1+4} {$infoX1+2};
  #DRAW <BBB> bar $infoY1+5 $infoX1+2 $infoY1+5 $infoX1+32 {$totX-$tnlX;$totX;<cdc><afd>};
  #SHOW {───────────────────────────────} {$infoY1+6} {$infoX1+2};
  #SHOW {AC: $armor    H/D: $hitV/$damV} {$infoY1+7} {$infoX1+2};
  #SHOW {bandage: $bandage hp} {$infoY1+8} {$infoX1+2}
}

