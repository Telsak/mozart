#NOP == autohunts a specified monster
#VAR {track_retry} {3}
#VAR {hunt_attack} {hit}
#MACRO {\eOp} {$hunt_attack $hunt_target} 

#ALIAS {track} 
{
  #IF {"%0" == "" && "$hunt_target" != ""} {scan;trac $hunt_target};
  #ELSEIF {"%0" == ""} {#SHOW ==Empty track target!==};
  #ELSE {#VAR {hunt_target} {%0};scan;trac {%0}}
}

#ACTION {^You see a faint trail to the %1.} {#VAR track_retry 3;%1}
#ACTION {^You have lost the trail} {#VAR track_retry 3;track $hunt_target}
#ACTION {You are unable to find traces of one}
{
  #IF {$track_retry > 0} {#math {track_retry} {$track_retry - 1};track};
  #ELSE {#SHOWME {== Out of track retries! ==}}
}
