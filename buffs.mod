#NOP ==== Buffs, Spells and skills! ====

#TICKER {mana} {#MATH manapercent $curM*100/$maxM} {10}
#TICKER {rebuff} {#IF {$manapercent > 15 && $combat == 0 && $standing == 1} {recast}} {20}

#ACTION {^You lie down and rest your tired bones.$} {#VAR standing 0}
#ACTION {^You go to sleep.$} {#VAR standing 0}
#ACTION {^You stop resting, and stand up.$} {#VAR standing 1}
#ACTION {^You awaken and clamber to your feet.$} {#VAR standing 1}

#SUB {[--        ]} {[LEVEL ME!!]}
#HIG { [ %1] %2 [LEVEL ME!!]} {cyan}
#HIG {[ %1] %2 [LEVEL ME!!] } {cyan}

#NOP ==== Active Spells ====
#ACTION {^Affecting Spells:$} {#VAR affects 1; #DELAY 1 {#VAR affects 0}}
#ACTION {^You feel slightly healthier.} {#VAR spell[resist poison] 1}
#ACTION {^You feel someone protecting you.} {#VAR spell[armor] 1}
#ACTION {^Your skin takes on a rough, bark-like texture.} {#VAR spell[barkskin] 1}
#ACTION {^You feel a mystical force protecting you.} {#VAR spell[armor] 1}
#ACTION {^You are briefly surrounded by a holy aura.} {#VAR spell[alignment ward] 1}
#ACTION {^You are surrounded by a strong force shield.} {#VAR spell[shield] 1}
#ACTION {^Your eyes tingle.} {affe}
#ACTION {^Your eyes glow red.} {#VAR spell[darksight] 1}
#ACTION {^You feel righteous.} {#VAR spell[bless] 1}
#ACTION {^You feel courageous.$} {#Var spell[courage] 1}
#ACTION {^You feel your awareness improve.$} {#VAR spell[sense life] 1}
#ACTION {^You feel buoyant.} {#VAR spell[waterwalking] 1}
#ACTION {^Your skin turns a little reddish.} {#VAR spell[resist fire] 1}
#ACTION {^Your skin turns a little bluish.} {#VAR spell[resist cold] 1}
#ACTION {^You feel much stronger.} {#VAR spell[strength] 1}
#ACTION {^Your skin turns slightly slippery.} {#VAR spell[freedom] 1}
#ACTION {^You are surrounded in an aura of soft gold.} {#VAR spell[alkar] 1}
#ACTION {^You start to float!} {#VAR spell[float] 1}
#ACTION {^You are encased in a grey, storm-like sphere.} {#VAR spell[stormguard] 1}
#ACTION {^You start glowing.} {#VAR spell[sanctuary] 1}
#ACTION {^You feel inspired.} {#VAR spell[inspiration] 1}
#ACTION {^You no longer feel hunger or thirst.}{#VAR spell[sustenance] 1}

#NOP ==== Fading Spells ====
#ACTION {^You feel less protected} {#VAR spell[armor] 0}
#ACTION {^Your barklike skin returns to normal.} {#VAR spell[barkskin] 0}
#ACTION {^The white in your vision fades away} {#VAR spell[detect good] 0}
#ACTION {^Your divine assistance fades} {#VAR spell[bless] 0}
#ACTION {^The yellow in your vision fades away} {#VAR spell[detect invisibility] 0}
#ACTION {^The red in your vision fades away} {#VAR spell[detect evil] 0}
#ACTION {^The blue in your vision fades away} {#VAR spell[detect magic] 0}
#ACTION {^You feel less morally protected} {#VAR spell[alignment ward] 0}
#ACTION {^Your shield of force dissipates} {#VAR spell[shield] 0}
#ACTION {^You feel more timid} {#VAR spell[courage] 0}
#ACTION {^You feel less resistant to poison} {#VAR spell[resist poison] 0}
#ACTION {^You feel less aware of your surroundings} {#VAR spell[sense life] 0}
#ACTION {^You feel less buoyant} {#VAR spell[waterwalking] 0}
#ACTION {^It seems a bit warmer} {#VAR spell[resist fire] 0}
#ACTION {^It seems a bit colder} {#VAR spell[resist cold] 0}
#ACTION {^You feel much weaker} {#VAR spell[strength] 0}
#ACTION {^Your slippery coat melts off of you} {#VAR spell[freedom] 0}
#ACTION {^Your golden aura is snuffed out} {#VAR spell[alkar] 0}
#ACTION {^Your golden aura fades away} {#VAR spell[alkar] 0}
#ACTION {^You feel disoriented as you lose your darksight.} {#VAR spell[darksight] 0}
#ACTION {^You fall abruptly to the ground.} {#VAR spell[float] 0}
#ACTION {^You feel dangerously more exposed to the elements} {#VAR spell[stormguard] 0}
#ACTION {^The white aura around your body vanishes!} {#VAR spell[sanctuary] 0}
#ACTION {^The white aura around your body fades.} {#VAR spell[sanctuary] 0}
#ACTION {^You feel much more foolish!} {#VAR spell[inspiration] 0}
#ACTION {^Your stomach rumbles.} {#VAR spell[sustenance] 0}

#NOP ==== Affected spells ====
#ACTION {%*{Detect Evil|Detect Good|Bless|Armor|Detect Invisibility|Alignment Ward|Courage|Resist Poison|Detect Magic|Waterwalking|Strength|Freedom|Alkar|Darksight|Float|Stormguard|Sanctuary|Inspiration|Sustenance|Barkskin}%*}
{
  #IF {"%0"=="%*Detect Evil%*" && $affects > 0} {#VAR spell[detect evil] 1};
  #IF {"%0"=="%*Detect Good%*" && $affects > 0} {#VAR spell[detect good] 1};
  #IF {"%0"=="%*Bless%*" && $affects > 0} {#VAR spell[bless] 1};
  #IF {"%0"=="%*Barkskin%*" && $affects > 0} {#VAR spell[barkskin] 1};
  #IF {"%0"=="%*Armor%*" && $affects > 0} {#VAR spell[armor] 1};
  #IF {"%0"=="%*Detect Invisibility%*" && $affects > 0} {#VAR spell[detect invisibility] 1};
  #IF {"%0"=="%*Alignment Ward%*" && $affects > 0} {#VAR spell[alignment ward] 1};
  #IF {"%0"=="%*Shield%*" && $affects > 0} {#VAR spell[shield] 1};
  #IF {"%0"=="%*Courage%*" && $affects > 0} {#VAR spell[courage] 1};
  #IF {"%0"=="%*Resist Poison%*" && $affects > 0} {#VAR spell[resist poison] 1};
  #IF {"%0"=="%*Detect Magic%*" && $affects > 0} {#VAR spell[detect magic] 1};
  #IF {"%0"=="%*Resist Fire%*" && $affects > 0} {#VAR spell[resist fire] 1};
  #IF {"%0"=="%*Resist Cold%*" && $affects > 0} {#VAR spell[resist cold] 1};
  #IF {"%0"=="%*Strength%*" && $affects > 0} {#VAR spell[strength] 1};
  #IF {"%0"=="%*Freedom%*" && $affects > 0} {#VAR spell[freedom] 1};
  #IF {"%0"=="%*Alkar%*" && $affects > 0} {#VAR spell[alkar] 1};
  #IF {"%0"=="%*Waterwalking%*" && $affects > 0} {#VAR spell[waterwalking] 1};
  #IF {"%0"=="%*Darksight%*" && $affects > 0} {#VAR spell[darksight] 1};
  #IF {"%0"=="%*Float%*" && $affects > 0} {#VAR spell[float] 1};
  #IF {"%0"=="%*Stormguard%*" && $affects > 0} {#VAR spell[stormguard] 1};
  #IF {"%0"=="%*Sanctuary%*" && $affects > 0} {#VAR spell[sanctuary] 1};
  #IF {"%0"=="%*Inspiration%*" && $affects > 0} {#VAR spell[inspiration] 1};
  #IF {"%0"=="%*Sustenance%*" && $affects > 0} {#VAR spell[sustenance] 1};
  #IF {"%0"=="%*Sense Life%*" && $affects > 0} {#VAR spell[sense life] 1}
}

#NOP ==== Rebuffing ====
#ALIAS {resetbuffs}
{
  #VAR spell[alignment ward] 0;
  #VAR spell[alkar] 0;
  #VAR spell[armor] 0;
  #VAR spell[barkskin] 0;
  #VAR spell[bless] 0;
  #VAR spell[courage] 0;
  #VAR spell[darksight] 0;
  #VAR spell[detect evil] 0;
  #VAR spell[detect good] 0;
  #VAR spell[detect invisibility] 0;
  #VAR spell[detect magic] 0;
  #VAR spell[float] 0;
  #VAR spell[freedom] 0;
  #VAR spell[inspiration] 0;
  #VAR spell[resist cold] 0;
  #VAR spell[resist fire] 0;
  #VAR spell[resist poison] 0;
  #VAR spell[sanctuary] 0;
  #VAR spell[sense life] 0;
  #VAR spell[shield] 0;
  #VAR spell[stormguard] 0;
  #VAR spell[strength] 0;
  #VAR spell[waterwalking] 0;
  #VAR spell[sustenance] 0;
  #VAR hunger 0;
  #VAR thirst 0;
  #DELAY {0.3} {affe}
}

#ALIAS {recast}
{
  #FOREACH {*spell[]} {rSpell}
  {
    #IF {$spell[$rSpell] == 0 && $buff[$rSpell] == 1} {cast '$rSpell';#break}
  }
}

#NOP ==== Set, display and save buffs ====
#EVENT {VARIABLE UPDATED spell} {#DELAY {1.5} {printbuffs}}

#NOP Will toggle all buffs on/off for auto recast.
#ALIAS {togglebuff}
{
  #FOREACH *buff[] buffitem
  {
    #IF {$buff[$buffitem] == 1}
    {
      #VAR togB 0;
      #break  
    };
    #ELSE
    {
      #VAR togB 1
    }
  };
  #FOREACH *buff[] buffitem {#VAR buff[$buffitem] $togB};
  printbuffs
}


#ALIAS {setbuff}
{
  #IF {"%0" == ""} {#SHOW $buff};
  #ELSE
  {
    #IF {$buff[%0] == 1} {#VAR buff[%0] 0};
    #ELSE {#VAR buff[%0] 1}
  };
  printbuffs
}

#VAR {txtClr}
{
  {0}{fbb}
  {1}{bfb}
  {2}{ }
  {3}{ᐅ}
}

#NOP Maybe limit myself to 10 spells for display in right window?
#ALIAS {printbuffs}
{
  #IF {&{buff} > 0}
  {
    #DRAW tile $screenHeight-12-&buff[] 85 $screenHeight-11 110;
    #DRAW jeweled box $screenHeight-12-&buff[] 85 $screenHeight-11 109;
    #LOOP {0} {&buff[]-1} {i}
    {
      #VAR {colIx} {$spell[*buff[+$i]]};
      #VAR {colJx} {$buff[+$i]};
      #MATH colKx $colJx+2;
      #SHOW {$txtClr[$colKx] <$txtClr[$colIx]>*buff[+$i]<099>} {$screenHeight-11+$i-&buff[]} {87}
    }
  }
}

#ALIAS {savebuff}
{
  #LOG OVERWRITE {$playerfile};#LOG OFF;
  #FOREACH {*buff[]} {test}
  {
    #LINE LOG {$playerfile} {#VAR {buff[$test]} {$buff[$test]}}
  }
}

#NOP ==== Tracker of skillups /w learned ====

#ACTION {^You have become more adept at %1!} {#var learninfo 1;learn %1;#DELAY {1}{#var learninfo 0}}
#ACTION {^You are now a master of %1!} {#var learninfo 1;learn %1;#DELAY {1}{#var learninfo 0}}

#VAR lrnLen 0

#ACTION {[%1] %2 [%3]}
{
  #IF {$learninfo == 1}
  {
    #VAR learnN %2;
    #FORMAT learnN %p $learnN;
    #LIST outlearn ins -1 { [%3] $learnN};
    #IF {&outlearn[] > 5}
    {
      #LIST outlearn del 1;
      #DRAW tile $screenHeight-17 111 $screenHeight-11 116+$lrnLen;
      #VAR lrnLen 0
    };
    check_learn_len;
    #DRAW tile $screenHeight-17 111 $screenHeight-11 116+$lrnLen;
    #DRAW jeweled box $screenHeight-17 111 $screenHeight-11 116+$lrnLen-3 $outlearn[%*]
  }
}

#alias {check_learn_len}
{
  #FOREACH $outlearn[%*] len
  {
    #FORMAT test %L $len;
    #IF {$test > $lrnLen}
    {
      #VAR lrnLen $test
    }
  }
}

