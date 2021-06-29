#ACTION {^Terrain: %1.} {#var tempTerrain %1} {5}
#ACTION {^Terrain: %1 Exits:} {#var tempTerrain %1;#replace {tempTerrain} { } {}} {4}

#ALIAS {mst} {#MAP set roomterrain $tempTerrain;#CR}
#MACRO {\e[13~} {set_terrain} 
#MACRO {\e[14~} {mst}

#ALIAS {mm} {#MAP move}
#ALIAS {md} {#MAP del}
#ALIAS {findnote} {#map find {} {} {} {} {%0}; #path show} {5}
#ALIAS {findroom} {#map find {%0} {} {} {} {}; #path show} {5}
#ALIAS {goto} {#map goto %0} {5}
#ALIAS {listarea} {#map list {} {} {} {%0} {} {}} {5}
#ALIAS {listnote} {#map list {} {} {} {} {%0} {}} {5}
#ALIAS {listroom} {#map list {%0} {} {} {} {} {}} {5}
#ALIAS {gz} {#MAP get roomarea roomarea}

#ACTION {There is no room to get in there.} {#MAP undo}
#ACTION {As you try to leave, you slip.} {#MAP undo;stand}


#ALIAS {mapoff}
{
	#MAP {flag} {static} {on};
    #VAR mapedit 0;
	#ECHO {Room writes disabled!};
	#EVENT {MAP ENTER ROOM} {
      #MAP get ROOMVNUM playerpos;
      #MAP get ROOMAREA playerarea
    }
}

#ALIAS {mapon}
{
	#EVENT {MAP ENTER ROOM} {#log {overwrite} .tinlog;
	#MAP set roomarea ${roomarea};
    #DELAY {0.3} {#SCRIPT {sed '/You realize/,+1d' -i .tinlog}};
    #DELAY {0.3} {#SCRIPT {sed '/You open/,+1d' -i .tinlog}};
    #DELAY {0.3} {#SCRIPT {sed '/no wall there/,+1d' -i .tinlog}};
    #DELAY {0.3} {#SCRIPT {sed '/As you try to leave/,+1d' -i .tinlog}};
	#DELAY {0.3} {#SCRIPT {head -n1 ~/mud/.tinlog | sed 's/.*> //' | cat ~/mud/.roomnameheader -}};
	#DELAY {0.3} {#SCRIPT {grep Terrain ~/mud/.tinlog | cut -f2 -d ' ' | cat ~/mud/.roomterrainheader -}};
	#DELAY {0.3} {#SCRIPT {awk 'NR==2,/Exits:/' ~/mud/.tinlog | head -n-1 | tr '\n' ' ' | sed 's/\;/\\\;/g' | cat ~/mud/.roomdescheader -}};
	#DELAY {0.3} {#LOG {off}};
	#DELAY {0.33} {#MAP name ${roomname}};
	#DELAY {0.33} {#MAP set roomdesc ${roomdesc}};
	#DELAY {0.33} {#MAP set roomterrain ${roomterrain}};
	#MAP get ROOMVNUM playerpos};
	#ECHO {Mapping enabled! Room Area = <229>${roomarea}<099>. Update with 'zone' command.};
	#MAP {flag} {static} {off};
    #VAR mapedit 1
}

#ALIAS {msr} {#MAP set roomname} {5}
#ALIAS {note} {#MAP set roomnote %0; #echo {RoomNote = <229>%0}} {5}
#ALIAS {rinfo} {#MAP info} {5}
#ALIAS {save} 
{
	#SHOWME "Map saved.";
	#MAP write mozart.map;
	#SHOWME "Player saved.";
	saveplayer
}

#ALIAS {checkme} {#var whoami 1;look self;#delay {1} {#var whoami 0}}
#ACTION {^%1 may be referred to as "%2".}
{
  #IF {$whoami == 1}
  {
    #FORMAT playername %l %2;
    #VAR playerfile $playername.db;
    #READ $playerfile
  }
}


#ALIAS {saveplayer}{#LINE LOG {$playerfile} {#VAR playerpos {$playerpos}}}
#ALIAS {setup}
{
    #var zcol <fff>;
	#map read mozart.map;
    findsplit;
    checkme;
    attr;score;
	#map flag vtmap on;
    #map goto 1;
    #CONFIG charset utf-8;
    zone Unset;
    resetbuffs;
    sleep;
    stand;
    #screen RAISE {screen resize};
    #DELAY {1} {#map goto $playerpos};
    mapoff;
    draw_gossip
}

#ALIAS {symbol} {#map set roomsymbol %0; #echo {RoomSymbol = <229>%0}} {5}
#ALIAS {undo} {#if {$mapedit == 1} {#map undo};#else {#showme Nothing to undo!}} {5}
#ALIAS {walk} {#path walk} {5}
#ALIAS {zone} {#variable {roomarea} {%0}; #echo {Zone set to:<229> ${roomarea}};statusbar} {5}
#ALIAS {nozone} {#variable {roomarea} {NotYetSet}; #echo {Zone un-set}}
#ALIAS {setcol} {#variable {zcol} {%1}}

#EVENT {SESSION CREATED}
{
	#script {touch ~/mud/.roomnameheader && echo -n '#VARIABLE {roomname} ' > ~/mud/.roomnameheader};
	#script {touch ~/mud/.roomdescheader && echo -n '#VARIABLE {roomdesc} ' > ~/mud/.roomdescheader};
	#script {touch ~/mud/.roomterrainheader && echo -n '#VARIABLE {roomterrain} ' > ~/mud/.roomterrainheader}
}
