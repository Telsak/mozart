#NOP == autohunts a specified monster

#VAR {autoatk} {look}
#VAR {target} {}
#VAR {autotrack} {off}
#VAR {autoscan} {off}
#VAR {autosneak} {off}

#VAR {track_retry} {3}

#MACRO {\eOp} {$autoatk $hunt_target} 

#ALIAS {atk} {#VAR autoatk %1}
#ALIAS {tar} {#VAR target %1}

#ALIAS {autosneak}
{
  #IF {"$autosneak" == "on"} {#VAR autosneak off} {#VAR autosneak on}
}

#ALIAS {autotrack}
{
  #IF {"$autotrack" == "on"} {#VAR autotrack off} {#VAR autotrack on}
}

#ALIAS {autoscan}
{
  #IF {"$autoscan" == "on"} {#VAR autoscan off} {#VAR autoscan on}
}

#ALIAS {track} 
{
  #IF {"%0" == "" && "$hunt_target" != ""} {scan;trac $hunt_target};
  #ELSEIF {"%0" == ""} {#SHOW ==Empty track target!==};
  #ELSE {#VAR {hunt_target} {%0};scan;trac {%0}}
}

#ACTION {^You see a faint trail to the %1.} 
{
  #IF {"$autotrack" == "on"}
  {
    #VAR track_retry 3;
    %1
  }
}

#ACTION {^You have lost the trail}
{
  #IF {"$autotrack" == "on"}
  {
    #VAR track_retry 3;
    track $hunt_target
  }
}

#ACTION {You are unable to find traces of one}
{
  #IF {"$autotrack" == "on"}
  {
    #IF {$track_retry > 0} {#math {track_retry} {$track_retry - 1};track};
    #ELSE {#SHOWME {== Out of track retries! ==}}
  }
}
