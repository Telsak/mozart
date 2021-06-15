#NOP ==== CHAT WINDOW & STUFF ====

#nop #SCREEN GET SCROLL_BOT_ROW screenHeight

#NOP == Read in the chat.box art from a file and draw it
#SCAN {file} {chat_g.box} {#VAR chat_gossip &0}
#SCAN {file} {chat_t.box} {#VAR chat_tell &0}
#SCAN {file} {chat_gt.box} {#VAR chat_group &0}



#NOP ==== Find which tab is currently 'active' and draw that text-box =========

#VAR {active_tab} {gossip}
#ALIAS {check_chat}
{
  #SWITCH {"$active_tab"}
  {
    #CASE {"gossip"} {drawgossip_text;#VAR {note_gossip} {0}};
    #CASE {"tell"} {drawtell_text;#VAR {note_tell} {0}};
    #CASE {"group"} {drawgroup_text;#VAR {note_group} {0}}
  }
  ;
  show_notifications
}

#ALIAS {show_notifications}
{
  #IF {$note_gossip} {#show {!} {$screenHeight-9} {99}};
  #IF {$note_tell} {#show {!} {$screenHeight-9} {115}};
  #IF {$note_group} {#show {!} {$screenHeight-9} {131}}
}


#NOP ==== ALT+1, ALT+2, ALT+3 for switching active tab ========================
#MACRO {\e1} 
{
  #VAR active_tab gossip;
  draw_gossip;
  #VAR {note_gossip} {0};
  show_notifications
}

#MACRO {\e2} 
{
  #VAR active_tab tell;
  draw_tell;
  #VAR {note_tell} {0};
  show_notifications
}

#MACRO {\e3}
{
  #VAR active_tab group;
  draw_group;
  #VAR {note_group} {0};
  show_notifications
}

#NOP ==== Draw the contents of the chat-windows ===============================
#ALIAS {drawgossip_text}
{
  #DRAW tile $screenHeight-7 89 $screenHeight-1 180 $goss_win[-10..-1]
}

#ALIAS {drawtell_text}
{
  #DRAW tile $screenHeight-7 89 $screenHeight-1 180 $tell_win[-10..-1]
}

#ALIAS {drawgroup_text}
{
  #DRAW tile $screenHeight-7 89 $screenHeight-1 180 $group_win[-10..-1]
}

#nop #DRAW tile $screenHeight-10 85 $screenHeight+1 200 $chat_gossip\e

#NOP ==== Draw the chat-windows themselves ====================================
#ALIAS {draw_gossip} 
{
  #DRAW tile $screenHeight-10 85 $screenHeight+1 200 $chat_gossip;
  #DRAW line $screenHeight+1 1 $screenHeight+1 200;
  drawgossip_text
}

#ALIAS {draw_tell} 
{
  #DRAW tile $screenHeight-10 85 $screenHeight+1 200 $chat_tell;
  #DRAW line $screenHeight+1 1 $screenHeight+1 200;
  drawtell_text
}

#ALIAS {draw_group} 
{
  #DRAW tile $screenHeight-10 85 $screenHeight+1 200 $chat_group;
  #DRAW line $screenHeight+1 1 $screenHeight+1 200;
  drawgroup_text
}

#ACTION {~%1 tells you, "%2} {tell_to_win %1 tells you, "%2}
#ACTION {~%1 gossips, "%2} {gossip_to_win %1 gossips, "%2}
#ACTION {*%1*: %2} {group_to_win *%1*: %2}

#ALIAS {gossip_to_win} 
{
  #LIST goss_win del 1; 
  #LIST goss_win ins -1 {%0}; 
  #VAR {note_gossip} {1};
  check_chat;
}

#ALIAS {tell_to_win} 
{
  #LIST tell_win del 1; 
  #LIST tell_win ins -1 {%0}; 
  #VAR {note_tell} {1};
  check_chat
}

#ALIAS {group_to_win} 
{
  #LIST group_win del 1; 
  #LIST group_win ins -1 {%0}; 
  #VAR {note_group} {1};
  check_chat
}


