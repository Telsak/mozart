#ACTION {^Terrain: %1.} {#var tempTerrain %1} {5}
#ACTION {^Terrain: %1 Exits:} {#var tempTerrain %1;#replace {tempTerrain} { } {}} {4}
#ALIAS {mst} {#MAP set roomterrain $tempTerrain;#CR}
#MACRO {\e[13~} {set_terrain} 
#MACRO {\e[14~} {mst}

#ALIAS {mm} {#MAP move}
#ALIAS {md} {#MAP del}
#ALIAS {findnote} {#map find {} {} {} {} {%0}; #path show} {5}
#ALIAS {findroom} {#map find {%0} {} {} {} {}; #path show} {5}
#ALIAS {getplayer} {#script playerpos {cat .mozart.plr}} {5}
#ALIAS {goto} {#map goto %0} {5}
#ALIAS {listarea} {#map list {} {} {} {%0} {} {}} {5}
#ALIAS {listnote} {#map list {} {} {} {} {%0} {}} {5}
#ALIAS {listroom} {#map list {%0} {} {} {} {} {}} {5}

#ALIAS {mapoff}
{
	#MAP {flag} {static} {on};
    #VAR mapedit 0;
	#ECHO {Room writes disabled!};
	#EVENT {MAP ENTER ROOM} {#MAP get ROOMVNUM playerpos}
}
#nop	#SUB {^H:} {[MAPOFF] H:}

#ALIAS {mapon}
{
	#EVENT {MAP ENTER ROOM} {#log {overwrite} .tinlog;
	#MAP set roomarea ${roomarea};
    #DELAY {0.3} {#SCRIPT {sed '/You realize/,+1d' -i .tinlog}};
    #DELAY {0.3} {#SCRIPT {sed '/You open/,+1d' -i .tinlog}};
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

#nop	#SUB {^H:} {[MAPON] H:}

#ALIAS {msr} {#map set roomname} {5}
#ALIAS {note} {#map set roomnote %0; #echo {RoomNote = <229>%0}} {5}
#ALIAS {rinfo} {#map info} {5}
#ALIAS {save} 
{
	#showme "Map saved.";
	#map write mozart.map;
	#showme "Player saved.";
	saveplayer
}

#ALIAS {saveplayer}{#system echo $playerpos > .mozart.plr} {5}
#ALIAS {setup} 
{
    #VAR zcol {<fff>};
	#map read mozart.map;
	#split 30 1;
	#map flag vtmap on;
	getplayer;
	#map goto $playerpos[1];
    mapoff;
    resetbuffs;
    sleep;
    stand
}

#ALIAS {symbol} {#map set roomsymbol %0; #echo {RoomSymbol = <229>%0}} {5}
#ALIAS {undo} {#if {$varedit == 1} {#map undo};#else {#showme Nothing to undo!}} {5}
#ALIAS {walk} {#path walk} {5}
#ALIAS {zone} {#variable {roomarea} {%0}; #echo {Zone set to:<229> ${roomarea}}} {5}
#ALIAS {nozone} {#variable {roomarea} {NotYetSet}; #echo {Zone un-set}; #VAR zcol {<fff>}}
#ALIAS {setcol} {#variable {zcol} {%1}}

#EVENT {SESSION CREATED}
{
	#script {touch ~/mud/.roomnameheader && echo -n '#VARIABLE {roomname} ' > ~/mud/.roomnameheader};
	#script {touch ~/mud/.roomdescheader && echo -n '#VARIABLE {roomdesc} ' > ~/mud/.roomdescheader};
	#script {touch ~/mud/.roomterrainheader && echo -n '#VARIABLE {roomterrain} ' > ~/mud/.roomterrainheader}
}
