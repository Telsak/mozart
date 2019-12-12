#NOP ==== Teleport triggers for map ====
#ACTION {^Headfirst!$} {#MAP GOTO 2398}
#NOP #ACTION {^Where now?$} {#MAP GOTO } <- fix me!
 
#NOP ==== Retreat triggers and alias ====
#ALIAS {f} {#VAR retreat 0;flee}
#ALIAS {rn} {#VAR retreat 3;retreat n}
#ALIAS {rs} {#VAR retreat 6;retreat s}
#ALIAS {rw} {#VAR retreat 9;retreat w}
#ALIAS {re} {#VAR retreat 12;retreat e}
#ACTION {You flee head over heels.}
{
  #IF {$retreat == 3} {#MAP MOVE east};
  #ELSEIF {$retreat == 6} {#MAP MOVE south};
  #ELSEIF {$retreat == 9} {#MAP MOVE west};
  #ELSEIF {$retreat == 12} {#MAP MOVE north}
  #ELSE {#MAP LEAVE;#SHOWME ! CAREFUL - MAP UNSYNCED !}
}

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
#ALIAS {water} {ccw beer;dri beer}

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
