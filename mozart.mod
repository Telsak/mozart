#NOP ==== Teleport triggers for map ====
#ACTION {^Headfirst!} {#MAP GOTO 2398}
#ACTION {^Where Now?} {#MAP GOTO 2411}
#ACTION {^Sliding Down Mt. Belknap} {#MAP GOTO 1389}
#ACTION {^The Beginning of the Path to Mount Belknap} {#MAP GOTO 1393}
#ACTION {^Under the Outcropping} {#MAP GOTO 5013}
#ACTION {^Bottom of the Trap} {#MAP GOTO 4649}
#ACTION {^steps leads to the Temple Basement, a passageway leading to the board rooms.$} {#MAP GOTO 185}

#ACTION {^You are too exhausted.} {#MAP undo}
#ACTION {^Alas, you cannot go that way.} {#IF {$mapedit > 0} {#MAP undo}}

#HIGHLIGHT {footsteps echo off in all directions except to the west, where death echos} {cyan}
#HIGHLIGHT {There's more here than meets the eye.} {cyan}
#ACTION {^Blue Lift} {exit}
#ACTION {^North - Too dark to tell} {#IF {$playerpos == 4947} {#MAP GOTO 4976}}
#ACTION {^North - Outside the Lift} {#MAP GOTO 4947}
#ACTION {^North - Smoke Filled Hallway} {#MAP GOTO 4976}
#ACTION {^tower.  To the north can be see a luxurious hallway, much the same as the} {#MAP GOTO 4972}
#ACTION {^Penthouse Blue Lift} {#MAP GOTO 4965}
#ACTION {conflict.  You can just make out some kind of entrance at the base of this} {#MAP GOTO 1592}
#ACTION {^Sandy Basin} {#MAP GOTO 2889}

 
#NOP ==== Retreat triggers and alias ====
#ALIAS {f} {#VAR retreat 0;flee}
#ALIAS {rn} {#VAR retreat 12;retreat n}
#ALIAS {rs} {#VAR retreat 6;retreat s}
#ALIAS {rw} {#VAR retreat 9;retreat w}
#ALIAS {re} {#VAR retreat 3;retreat e}
#ACTION {^You flee head over heels.} {
  #IF {$retreat == 3} {#MAP MOVE e};
  #ELSEIF {$retreat == 6} {#MAP MOVE s};
  #ELSEIF {$retreat == 9} {#MAP MOVE w};
  #ELSEIF {$retreat == 12} {#MAP MOVE n};
  #ELSE {#MAP LEAVE;#SHOWME ! CAREFUL - MAP UNSYNCED !}
}

#NOP ====== General ======
#ALIAS {repair} {remove %1;give %1 blacksmith;wear %1;wield %1}
#ALIAS {recall} {c succor;recite recall}
#MACRO {\e[24~} {#MAP set roomcolor;symbol}
#ALIAS {ter} {#MAP goto %1;#MAP set roomterrain %2}
#ALIAS {scry} {remove flame;get scry bag;hold scry;use scry;remove scry;put scry bag;hold flame}

#ALIAS {qr} {#VAR runtarget %1;#DELAY 1 {#VAR runtarget NULL};
  #SWITCH {"$runtarget"} {
    #CASE {"nev"} {findroom 206};
    #CASE {"rb"} {findroom 842};
    #CASE {"nt"} {findroom 1431};
    #CASE {"fg"} {findroom 1739};
    #CASE {"order"} {findroom 1592};
    #CASE {"gaul"} {findroom 2643}
    #DEFAULT {
      #SHOWME nev - City of Nevrast;
      #SHOWME rb - Raven's Bluff;
      #SHOWME nt - New Thalos;
      #SHOWME fg - Fire Giant Keep;
      #SHOWME gaul - Gaullish Village;
      #SHOWME order - Eternal Stalemate
    }
  }
}


#NOP ===== Food/Thirst (assumes create food/water) =====
#ACTION {^You are getting hungry} {#VAR hunger 1} 
#ACTION {^You are getting thirsty} {#VAR thirst 1}
#ACTION {^Your thirst is satiated} {#VAR thirst 0}
#ACTION {^You are full} {#VAR hunger 0}
#ACTION {^You are still hungry} {mushroom}
#ACTION {^You are still thirsty} {water}
#ALIAS {food} {
  #IF {$hunger == 1} {mushroom} {#SHOWME Not hungry!};
  #IF {$thirst == 1} {water} {#SHOWME Not thirsty!}
}

#ALIAS {mushroom} {ccf;get mush;eat mush}
#ALIAS {water} {ccw ale;drink ale;drink ale}

#NOP ====== Prompt ======
#ACTION {^H:%1/%2 M:%3/%4 V:%5/%6 XP:%7 C:%8>} {
  #VAR curH %1;
  #VAR maxH %2;
  #VAR curM %3;
  #VAR maxM %4;
  #VAR curV %5;
  #VAR maxV %6;
  #VAR tnlX %7;
  #VAR targH %8;
  check_combat
}

#ALIAS {check_combat} {
  #SWITCH {"$targH"} {
    #CASE {"*"} {#VAR combat 0};
    #DEFAULT {#VAR combat 1}
  }
}

#NOP ====== Combat ======
#ALIAS {sanc} {get purp bag;qua pur}
#ALIAS {invis} {get roll bag;eat roll}

#HIGHLIGHT {%1 stands up.} {<bdf>}
#HIGHLIGHT {%1 feet very slowly.} {<bdf>}


#ACTION {A purple potion: You can't carry that many items.} {put all.pur bag;get all.pur corpse}
#ACTION {%*{is dead!$|is destroyed!$}%*} {
  #IF {$combat == 1} {
    #SWITCH {"$playerarea"} {
      #CASE {"Mac Mordain Cadal"} {get all.pur corps};
      #CASE {"The Gaullish Village"} {get all.mag corps}
    }
  }{#SHOWME Not your kill - not looting}
}

#MACRO {\eOp} {hitall}
#ACTION {sends you sprawling with a powerful bash!} {stand} {5}
#ACTION {you topple over and fall to the ground} {stand} {5}
#ACTION {leg beneath yours, sending you flying to the ground.$} {stand}
#ACTION {picks you up and throws you %1.} {#MAP move %1}
#HIGHLIGHT {throws you %1.$} {cyan}
#ACTION {^You hit the ground with a thud.} {stand}
#ACTION {^You miss %1 with your stun attempt!} {stand}

#NOP ====== Grouping ======
#ACTION {You are now a member of %1's group.} {#VAR Group 1;#VAR GroupLeader %1}
#ACTION {You follow %1} {#VAR Follow 1; #VAR FollowTarget %1}
#ACTION {You stop following $GroupLeader} {#VAR Group 0; #VAR GroupLeader NULL}

#ACTION {$FollowTarget %1 east.} {e}
#ACTION {$FollowTarget %1 south.} {s}
#ACTION {$FollowTarget %1 west.} {w}
#ACTION {$FollowTarget %1 north.} {n}
#ACTION {$FollowTarget %1 up.} {u}
#ACTION {$FollowTarget %1 down.} {d}

#ALIAS {north} {n}
#ALIAS {east} {e}
#ALIAS {south} {s}
#ALIAS {west} {w}
#ALIAS {up} {u}
#ALIAS {down} {d}

#NOP ====== Statusbar at top split ======
#EVENT {MAP UPDATED VTMAP} {statusbar}
#EVENT {SCREEN RESIZE} {findsplit;#SCREEN get cols col}

#ALIAS {setmap} {
  #MATH mapwidth {$col - 30};
  #DRAW white tube unicode box 1 1 {$rawSplit} {$mapwidth + 1} \ ;
  #MAP offset 2 2 {$rawSplit} $mapwidth
}

#ALIAS {statusbar} {default;mapstate;arealine;roomline;mapzone}

#ALIAS {default} {
  #FORMAT statusbg %+${col}s;
  #REPLACE statusbg { } {=};
  #SHOWME {<eee>$statusbg} {$rawSplit};
  #math offset {$col / 5}
}

#ALIAS {mapstate} {
  #IF {$mapedit > 0} {#VAR mapline {|<dfa>MAP rw<eee>|}};
  #ELSE {#VAR mapline {|<ccc>MAP r-<eee>|}};
  #SHOWME {$mapline} {$rawSplit} {$offset}
}

#ALIAS {roomline} {
  #MAP get roomname maproom;
  #FORMAT areaLength %L $maparea;
  #MATH {roomoffset} {$areaLength + $areaoffset + 8};
  #SHOWME {|R: <bdf>$maproom<eee>|} {$rawSplit} {$roomoffset}
}

#ALIAS {arealine} {
  #MAP GET roomarea maparea;
  #MATH areaoffset {$offset + 11};
  #SHOWME {|A: <fdb>$maparea<eee>|} {$rawSplit} {$areaoffset}
}

#ALIAS {mapzone} {
  #FORMAT zLength %L $roomarea;
  #MATH editoffset {$offset - ($zLength+4)};
  #IF {$mapedit > 0} {#SHOWME {|<bff>$roomarea >><eee>} {$rawSplit} {$editoffset}} {#SHOWME {<ccc>($roomarea)<eee>} {$rawSplit} {$editoffset}}
}

#ALIAS {findsplit} {
  #SCREEN get rows termHeight;
  #MATH rawSplit {(($termHeight / 5) * 2)};
  #SPLIT $rawSplit 1
}

#NOP ====== Rebuffing ======
#ALIAS {resetbuffs}
{
  #VAR spell[DetectEvil] 0;
  #VAR spell[DetectGood] 0;
  #VAR spell[DetectInvis] 0;
  #VAR spell[Bless] 0;
  #VAR spell[Armor] 0;
  #VAR spell[AlignmentWard] 0;
  #VAR spell[Shield] 0;
  #VAR spell[Courage] 0;
  #VAR spell[ResistPoison] 0;
  #VAR spell[DetectMagic] 0;
  #VAR spell[SenseLife] 0;
  #VAR spell[Freedom] 0;
  #VAR spell[Waterwalking] 0;
  #VAR spell[ResistFire] 0;
  #VAR spell[ResistCold] 0;
  #VAR spell[Strength] 0;
  #VAR spell[Alkar] 0;
  #VAR hunger 0;
  #VAR thirst 0;
  #DELAY {0.3} {affe}
}


#ACTION {^You lie down and rest your tired bones.$} {#VAR standing 0}
#ACTION {^You go to sleep.$} {#VAR standing 0}
#ACTION {^You stop resting, and stand up.$} {#VAR standing 1}
#ACTION {^You awaken and clamber to your feet.$} {#VAR standing 1}

#NOP == Active Spells ==
#ACTION {^Affecting Spells:$} {#VAR affects 1; #DELAY 2 {#VAR affects 0}}
#ACTION {^You feel slightly healthier.} {#VAR spell[ResistPoison] 1}
#ACTION {^You feel someone protecting you.} {#VAR spell[Armor] 1}
#ACTION {^You are briefly surrounded by a holy aura.} {#VAR spell[AlignmentWard] 1}
#ACTION {^You are surrounded by a strong force shield.} {#VAR spell[Shield] 1}
#ACTION {^Your eyes tingle.} {affe}
#ACTION {^You feel righteous.} {#VAR spell[Bless] 1}
#ACTION {^You feel courageous.$} {#Var spell[Courage] 1}
#ACTION {^You feel your awareness improve.$} {#VAR spell[SenseLife] 1}
#ACTION {^You feel buoyant.} {#VAR spell[Waterwalking] 1}
#ACTION {^Your skin turns a little reddish.} {#VAR spell[ResistFire] 1}
#ACTION {^Your skin turns a little bluish.} {#VAR spell[ResistCold] 1}
#ACTION {^You feel stronger.} {#VAR spell[Strength] 1}
#ACTION {^Your skin turns slightly slippery.} {#VAR spell[Freedom] 1}
#ACTION {^You are surrounded in an aura of soft gold.} {#VAR spell[Alkar] 1}

#ACTION {%*{Detect Evil|Detect Good|Bless|Armor|Detect Invisibility|Alignment Ward|Courage|Resist Poison|Detect Magic|Waterwalking|Strength|Freedom|Alkar}%*}
{
  #IF {"%0"=="%*Detect Evil%*" && $affects > 0} {#VAR spell[DetectEvil] 1};
  #IF {"%0"=="%*Detect Good%*" && $affects > 0} {#VAR spell[DetectGood] 1};
  #IF {"%0"=="%*Bless%*" && $affects > 0} {#VAR spell[Bless] 1};
  #IF {"%0"=="%*Armor%*" && $affects > 0} {#VAR spell[Armor] 1};
  #IF {"%0"=="%*Detect Invisibility%*" && $affects > 0} {#VAR spell[DetectInvis] 1};
  #IF {"%0"=="%*Alignment Ward%*" && $affects > 0} {#VAR spell[AlignmentWard] 1};
  #IF {"%0"=="%*Shield%*" && $affects > 0} {#VAR spell[Shield] 1};
  #IF {"%0"=="%*Courage%*" && $affects > 0} {#VAR spell[Courage] 1};
  #IF {"%0"=="%*Resist Poison%*" && $affects > 0} {#VAR spell[ResistPoison] 1};
  #IF {"%0"=="%*Detect Magic%*" && $affects > 0} {#VAR spell[DetectMagic] 1};
  #IF {"%0"=="%*Resist Fire%*" && $affects > 0} {#VAR spell[ResistFire] 1};
  #IF {"%0"=="%*Resist Cold%*" && $affects > 0} {#VAR spell[ResistCold] 1};
  #IF {"%0"=="%*Strength%*" && $affects > 0} {#VAR spell[Strength] 1};
  #IF {"%0"=="%*Freedom%*" && $affects > 0} {#VAR spell[Freedom] 1};
  #IF {"%0"=="%*Alkar%*" && $affects > 0} {#VAR spell[Alkar] 1};
  #IF {"%0"=="%*Waterwalking%*" && $affects > 0} {#VAR spell[Waterwalking] 1};
  #IF {"%0"=="%*Sense Life%*" && $affects > 0} {#VAR spell[SenseLife] 1}
}

#NOP == Fading Spells ==
#ACTION {^You feel less protected} {#VAR spell[Armor] 0}
#ACTION {^The white in your vision fades away} {#VAR spell[DetectGood] 0}
#ACTION {^Your divine assistance fades} {#VAR spell[Bless] 0}
#ACTION {^The yellow in your vision fades away} {#VAR spell[DetectInvis] 0}
#ACTION {^The red in your vision fades away} {#VAR spell[DetectEvil] 0}
#ACTION {^The blue in your vision fades away} {#VAR spell[DetectMagic] 0}
#ACTION {^You feel less morally protected} {#VAR spell[AlignmentWard] 0}
#ACTION {^Your shield of force dissipates} {#VAR spell[Shield] 0}
#ACTION {^You feel more timid} {#VAR spell[Courage] 0}
#ACTION {^You feel less resistant to poison} {#VAR spell[ResistPoison] 0}
#ACTION {^You feel less aware of your surroundings} {#VAR spell[SenseLife] 0}
#ACTION {^You feel less buoyant} {#VAR spell[Waterwalking] 0}
#ACTION {^It seems a bit warmer} {#VAR spell[ResistFire] 0}
#ACTION {^It seems a bit colder} {#VAR spell[ResistCold] 0}
#ACTION {^You feel much weaker} {#VAR spell[Strength] 0}
#ACTION {^Your slippery coat melts off of you} {#VAR spell[Freedom] 0}
#ACTION {^Your golden aura is snuffed out} {#VAR spell[Alkar] 0}
#ACTION {^Your golden aura fades away} {#VAR spell[Alkar] 0}

#TICKER {mana} {#MATH manapercent $curM*10/$maxM} {10}
#TICKER {rebuff} {#IF {$manapercent > 5 && $combat == 0 && $standing == 1} {recast}} {10}

#ALIAS {recast}
{
  #IF {$spell[Armor] == 0} {cast 'armor'};
  #ELSEIF {$spell[AlignmentWard] == 0} {cast 'alignment ward'};
  #ELSEIF {$spell[Bless] == 0} {cast 'bless'};
  #ELSEIF {$spell[Shield] == 0} {cast 'shield'};
  #ELSEIF {$spell[DetectInvis] == 0} {cast 'detect invisibility'};
  #ELSEIF {$spell[DetectGood] == 0} {cast 'detect good'};
  #ELSEIF {$spell[DetectEvil] == 0} {cast 'detect evil'};
  #ELSEIF {$spell[Courage] == 0} {cast 'courage'};
  #ELSEIF {$spell[DetectMagic] == 0} {cast 'detect magic'};
  #ELSEIF {$spell[ResistPoison] == 0} {cast 'resist poison'};
  #ELSEIF {$spell[Waterwalking] == 0} {cast 'waterwalking'};
  #ELSEIF {$spell[ResistFire] == 0} {cast 'resist fire'};
  #ELSEIF {$spell[Strength] == 0} {cast 'strength'};
  #ELSEIF {$spell[Freedom] == 0} {cast 'freedom'};
  #ELSEIF {$spell[ResistCold] == 0} {cast 'resist cold'};
  #ELSEIF {$spell[Alkar] == 0} {cast 'alkar'};
  #ELSEIF {$spell[SenseLife] == 0} {cast 'sense life'}
}

#NOP ==== Data gathering ==== 
#ALIAS {sc} {#LOG overwrite .score; score; #DELAY 0.4 {#LOG {off}}}
#ALIAS {at} {#LOG overwrite .attributes; attr; #DELAY 0.4 {#LOG {off}}}
#ALIAS {le} {#LOG overwrite .learned; spells; skills; weapon; special; #DELAY 0.4 {#LOG {off}}}

#ALIAS {login} {#session mozart ymca.cnap.hv.se 4500} {5}
#ALIAS {logout} {save; rent} {5}

#AC {^You have become more adept at %1!} {learn %1}

#NOP ==== Flymode ====
#MACRO {\e[15~} {#IF {$flymode < 1} {mapoff;#VAR flymode 1;#VAR return_position $playerpos} {#VAR flymode 0;#MAP goto $return_position}}

#MACRO {\eOr} {#IF {$mapedit < 1 && $flymode > 0} {#MAP move s} {s}} 
#MACRO {\eOs} {#IF {$mapedit < 1 && $flymode > 0} {#MAP move d} {d}}
#MACRO {\eOt} {#IF {$mapedit < 1 && $flymode > 0} {#MAP move w} {w}} 
#MACRO {\eOv} {#IF {$mapedit < 1 && $flymode > 0} {#MAP move e} {e}} 
#MACRO {\eOx} {#IF {$mapedit < 1 && $flymode > 0} {#MAP move n} {n}} 
#MACRO {\eOy} {#IF {$mapedit < 1 && $flymode > 0} {#MAP move u} {u}} 
#MACRO {\eOu} {#IF {$mapedit < 1 && $flymode > 0} {rinfo} {look}}

#MACRO {\e[11~} {#MAP flag asciivnum}
#MACRO {\e[12~} {#IF {$mapedit > 0} {mapoff} {mapon}}
#MACRO {\eOl} {#VAR flymode 0;walk}

#CONFIG           {256 COLORS}  {ON}
#CONFIG           {AUTO TAB}  {5000}
#CONFIG           {BUFFER SIZE}  {20000}
#CONFIG           {CHARSET}  {ASCII}
#CONFIG           {COLOR PATCH}  {OFF}
#CONFIG           {COMMAND COLOR}  {<078>}
#CONFIG           {COMMAND ECHO}  {ON}
#CONFIG           {CONNECT RETRY}  {15}
#CONFIG           {HISTORY SIZE}  {1000}
#CONFIG           {LOG}  {PLAIN}
#CONFIG           {PACKET PATCH}  {0.00}
#CONFIG           {REPEAT CHAR}  {!}
#CONFIG           {REPEAT ENTER}  {OFF}
#CONFIG           {SCROLL LOCK}  {ON}
#CONFIG           {SPEEDWALK}  {OFF}
#CONFIG           {TINTIN CHAR}  {#}
#CONFIG           {VERBATIM}  {OFF}
#CONFIG           {VERBATIM CHAR}  {\}
#CONFIG           {VERBOSE}  {OFF}
#CONFIG           {WORDWRAP}  {ON}

#PATHDIR          {d}  {u}  {32}
#PATHDIR          {e}  {w}  {2}
#PATHDIR          {n}  {s}  {1}
#PATHDIR          {ne}  {sw}  {3}
#PATHDIR          {nw}  {se}  {9}
#PATHDIR          {s}  {n}  {4}
#PATHDIR          {se}  {nw}  {6}
#PATHDIR          {sw}  {ne}  {12}
#PATHDIR          {u}  {d}  {16}
#PATHDIR          {w}  {e}  {8}
