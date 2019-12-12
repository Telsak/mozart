#NOP ==== Teleport triggers for map ====
#ACTION {^Headfirst!$} {#MAP GOTO 2398}
#NOP #ACTION {^Where now?$} {#MAP GOTO } <- fix me!
 
#NOP ==== Retreat triggers and alias ====
#ALIAS {f} {#VAR retreat 0;flee}
#ALIAS {rn} {#VAR retreat 12;retreat n}
#ALIAS {rs} {#VAR retreat 6;retreat s}
#ALIAS {rw} {#VAR retreat 9;retreat w}
#ALIAS {re} {#VAR retreat 3;retreat e}
#ACTION {You flee head over heels.}
{
  #IF {$retreat == 3} {#MAP MOVE east};
  #ELSEIF {$retreat == 6} {#MAP MOVE south};
  #ELSEIF {$retreat == 9} {#MAP MOVE west};
  #ELSEIF {$retreat == 12} {#MAP MOVE north}
  #ELSE {#MAP LEAVE;#SHOWME ! CAREFUL - MAP UNSYNCED !}
}

#NOP ====== Combat ======
#ACTION {%*{C:few|C:critical|C:excellent|C:awful|C:pretty|C:big|C:quite|C:small}%*} {#VAR combat 1}


#NOP ====== Rebuffing ======
#ACTION {M:%1/%2 V:%3C:*>} {#VAR curM %1; #VAR maxM %2; #VAR combat 0}

#ACTION {^You lie down and rest your tired bones.$} {#VAR standing 0}
#ACTION {^You go to sleep.$} {#VAR standing 0}
#ACTION {^You stop resting, and stand up.$} {#VAR standing 1}
#ACTION {^You awaken and clamber to your feet.$} {#VAR standing 1}

#NOP == Active Spells ==
#ACTION {^Affecting Spells:$} {#VAR affects 1; #DELAY 1 {#VAR affects 0}}
#ACTION {^You feel someone protecting you.} {#VAR Armor 1}
#ACTION {^Your eyes tingle.} {#VAR DetectInvis 1}
#ACTION {^You are briefly surrounded by a holy aura.} {#VAR AlignmentWard 1}
#ACTION {^You are surrounded by a strong force shield.} {#VAR Shield 1}
#ACTION {^You feel righteous.} {#VAR Bless 1}
#ACTION {^You have become more adept at courage!$} {#Var Courage 1}

#ACTION {%*{Detect Evil|Detect Good|Bless|Armor|Detect Invisibility|Alignment Ward|Courage}%*}
{
  #IF {"%0"=="%*Detect Evil%*" && $affects > 0} {#VAR DetectEvil 1};
  #IF {"%0"=="%*Detect Good%*" && $affects > 0} {#VAR DetectGood 1};
  #IF {"%0"=="%*Bless%*" && $affects > 0} {#VAR Bless 1};
  #IF {"%0"=="%*Armor%*" && $affects > 0} {#VAR Armor 1};
  #IF {"%0"=="%*Detect Invisibility%*" && $affects > 0} {#VAR DetectInvis 1};
  #IF {"%0"=="%*Alignment Ward%*" && $affects > 0} {#VAR AlignmentWard 1};
  #IF {"%0"=="%*Shield%*" && $affects > 0} {#VAR Shield 1};
  #IF {"%0"=="%*Courage%*" && $affects > 0} {#VAR Courage 1}
}

#NOP == Fading Spells ==
#ACTION {^You feel less protected.} {#VAR Armor 0}
#ACTION {^The white in your vision fades away.} {#VAR DetectInvis 0}
#ACTION {^Your divine assistance fades.} {#VAR Bless 0}
#ACTION {^The yellow in your vision fades away.$} {#VAR DetectGood 0}
#ACTION {^The red in your vision fades away.$} {#VAR DetectEvil 0}
#ACTION {^You feel less morally protected.$} {#VAR AlignmentWard 0}
#ACTION {^Your shield of force dissipates.$} {#VAR Shield 0}

#TICKER {mana} {#MATH manapercent $curM*10/$maxM} {10}
#TICKER {rebuff} {#IF {$manapercent > 5 && $combat == 0 && $standing == 1} {recast}} {10}

#ALIAS {recast}
{
  #IF {$Armor == 0} {cast 'armor'};
  #ELSEIF {$AlignmentWard == 0} {cast 'alignment ward'};
  #ELSEIF {$Bless == 0} {cast 'bless'};
  #ELSEIF {$Shield == 0} {cast 'shield'};
  #ELSEIF {$DetectInvis == 0} {cast 'detect invisibility'};
  #ELSEIF {$DetectGood == 0} {cast 'detect good';affe};
  #ELSEIF {$DetectEvil == 0} {cast 'detect evil';affe};
  #ELSEIF {$Courage == 0} {cast 'courage'}
}

#NOP ==== Data gathering ====
#ALIAS {sc} {#LOG overwrite .score; score; #DELAY 0.4 {#LOG {off}}}
#ALIAS {at} {#LOG overwrite .attributes; attr; #DELAY 0.4 {#LOG {off}}}
#ALIAS {le} {#LOG overwrite .learned; spells; skills; weapon; special; #DELAY 0.4 {#LOG {off}}}

#ACTION {sends you sprawling with a powerful bash!} {stand} {5}
#ACTION {you topple over and fall to the ground} {stand} {5}
#ACTION {leg beneath yours, sending you flying to the ground.$} {stand}

#ACTION {^steps leads to the Temple Basement, a passageway leading to the board rooms.$} {#MAP GOTO 185}
#ACTION {^Alas, you cannot go that way.} {#MAP UNDO}

#ALIAS {login} {#session mozart ymca.cnap.hv.se 4500} {5}
#ALIAS {logout} {save; rent} {5}

#ALIAS {flyon} {remove mocc;wear carpet}
#ALIAS {flyoff} {remove carpet;wear mocc}


#ALIAS {food} {ccf;get mush;eat mush}
#ALIAS {water} {ccw water;dri water}

#AC {You have become more adept at %1!} {learn %1}

#MACRO {\eOr} {s}
#MACRO {\eOs} {d}
#MACRO {\eOt} {w}
#MACRO {\eOu} {look}
#MACRO {\eOv} {e}
#MACRO {\eOx} {n}
#MACRO {\eOy} {u}
#MACRO {\e[11~} {#MAP flag asciivnum}
#MACRO {\eOl} {walk}

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
