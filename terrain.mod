#MACRO {\e[13~} {set_terrain} 

#ALIAS {set_terrain} {
	#map get roomterrain terrain;
	
	#switch {"$terrain"} {
		#CASE {"Air"}			{#var rmcol <268>;#var rmsym <268>. .<088>};
		#CASE {"Alley"}			{#var rmcol <248>;#var rmsym <248>. .<088>};
		#CASE {"Ashen_field"}		{#var rmcol <278>;#var rmsym <278>, `<088>};
		#CASE {"Areaexit"}		{#var rmcol <168>;#var rmsym <168>[<278>?<168>]<088>};
		#CASE {"Aylorcity"}		{#var rmcol <278>;#var rmsym <278>[ ]<088>};
		#CASE {"Beach"}			{#var rmcol <138>;#var rmsym <138>, `<088>};
		#CASE {"Bloodyhall"}		{#var rmcol <218>;#var rmsym <218>. .<088>};
		#CASE {"Bloodyroom"}		{#var rmcol <118>;#var rmsym <118>[ ]<088>};
		#CASE {"Bookshelves"}		{#var rmcol <238>;#var rmsym <238>"""<088>};
		#CASE {"Bookshelves_ns"}	{#var rmcol <238>;#var rmsym <238>=<148>.<238>=<088>};
		#CASE {"Bridge"}		{#var rmcol <238>;#var rmsym <238>===<088>};
		#CASE {"Cabin"}			{#var rmcol <238>;#var rmsym <238># #<088>};
		#CASE {"Cave"}			{#var rmcol <248>;#var rmsym <248>% %<088>};
		#CASE {"Castle"}		{#var rmcol <178>;#var rmsym <278>###<088>};
		#CASE {"Chaos_sea"}		{#var rmcol <258>;#var rmsym <258>~^~<088>};
		#CASE {"Chessblack"}		{#var rmcol <248>;#var rmsym <248>[ ]<088>};
		#CASE {"Chesswhite"}		{#var rmcol <178>;#var rmsym <178>[ ]<088>};
		#CASE {"City"}			{#var rmcol <278>;#var rmsym <278>. .<088>};
		#CASE {"City_underground"}	{#var rmcol <238>;#var rmsym <238>. .<088>};
		#CASE {"Cloud1"}		{#var rmcol <178>;#var rmsym <178>~ ~<088>};
		#CASE {"Cloud2"}		{#var rmcol <108>;#var rmsym <108>~ ~<088>};
		#CASE {"Cloud3"}		{#var rmcol <278>;#var rmsym <128>.<138>*<088>~<088>};
		#CASE {"Crossroad_ews"}		{#var rmcol <278>;#var rmsym <278>-+-<088>};
		#CASE {"Crossroad_nw"}		{#var rmcol <278>;#var rmsym <278>-+ <088>};
		#CASE {"Crossroad_se"}		{#var rmcol <278>;#var rmsym <278> +-<088>};
		#CASE {"Crypt"}			{#var rmcol <248>;#var rmsym <248>. <178>+<088>};
		#CASE {"Dark"}			{#var rmcol <208>;#var rmsym <208>[ ]<088>};
		#CASE {"Dead_field"}		{#var rmcol <238>;#var rmsym <238>, `<088>};
		#CASE {"Dead_forest"}		{#var rmcol <238>;#var rmsym <238>( *<088>};
		#CASE {"Dead_jungle"}		{#var rmcol <238>;#var rmsym <238>* *<088>};
		#CASE {"Desert"}		{#var rmcol <238>;#var rmsym <138>~ ~<088>};
		#CASE {"Dungeon"}		{#var rmcol <248>;#var rmsym <248># #<088>};
		#CASE {"Dustdevil"}		{#var rmcol <238>;#var rmsym <238>.\/<088>};
		#CASE {"Field"}	{
            #map get roomsymbol tempsym;
            #switch {"$tempsym"} {
                #CASE {"<228>, `<088>"} {#var rmcol <228>;#var rmsym <228>. ^<088>};
                #CASE {"<228>. ^<088>"} {#var rmcol <228>;#var rmsym <228>, .<088>};
                #CASE {"<228>, .<088>"} {#var rmcol <228>;#var rmsym <228>` ^<088>};
                #CASE {"<228>` ^<088>"} {#var rmcol <228>;#var rmsym <228>, `<088>};
                #default {#var rmcol <228>;#var rmsym <228>, `<088>}  
                }   
            };
		#CASE {"Field2"}		{#var rmcol <228>;#var rmsym <228>. ^<088>};
		#CASE {"Field3"}		{#var rmcol <228>;#var rmsym <228>, .<088>};
		#CASE {"Field4"}		{#var rmcol <228>;#var rmsym <228>` ^<088>};
		#CASE {"Flowers1"}		{#var rmcol <178>;#var rmsym <168>*<158>*<138>*<088>};
		#CASE {"Flowers2"}		{#var rmcol <178>;#var rmsym <158>*<168>*<138>*<088>};
		#CASE {"Forest"}		{#var rmcol <aca>;#var rmsym <aca>( *<088>};
		#CASE {"Fountain"}		{#var rmcol <278>;#var rmsym <278>( )<088>};
		#CASE {"Graveyard"}		{#var rmcol <238>;#var rmsym <238>. <178>+<088>};
		#CASE {"Hallway"}		{#var rmcol <268>;#var rmsym <268>[ ]<088>};
		#CASE {"Hell1"}			{#var rmcol <218>;#var rmsym <218>` <118>,<088>};
		#CASE {"Hell2"}			{#var rmcol <218>;#var rmsym <218>~ .<088>};
		#CASE {"Hell3"}			{#var rmcol <218>;#var rmsym <218>~ <118>^<088>};
		#CASE {"Hell4"}			{#var rmcol <218>;#var rmsym <118>^ <218>^<088>};
		#CASE {"Hellfountain"}		{#var rmcol <218>;#var rmsym <118>(<178>~<118>)<088>};
		#CASE {"Hellhall"}		{#var rmcol <218>;#var rmsym <088>. <218>.<088>};
		#CASE {"Hellinside"}		{#var rmcol <218>;#var rmsym <218>[ ]<088>};
		#CASE {"Hills"}			{#var rmcol <228>;#var rmsym <228>. ^<088>};
		#CASE {"Hut"}			{#var rmcol <238>;#var rmsym <238>[ ]<088>};
		#CASE {"Ice"}			{#var rmcol <178>;#var rmsym <178>~ ~<088>};
		#CASE {"Icehills"}		{#var rmcol <178>;#var rmsym <178>^ ~<088>};
		#CASE {"Icemount"}		{#var rmcol <178>;#var rmsym <178>/ \<088>};
		#CASE {"Inside"}		{#var rmcol <278>;#var rmsym <278>[ ]<088>};
		#CASE {"Insideice"}		{#var rmcol <178>;#var rmsym <178>[ ]<088>};
		#CASE {"Jungle"}		{#var rmcol <228>;#var rmsym <228>* *<088>};
		#CASE {"Lightning"}		{#var rmcol <138>;#var rmsym <138>  /<088>};
		#CASE {"Mist"}			{#var rmcol <178>;#var rmsym <178>~ ~<088>};
		#CASE {"Moon"}			{#var rmcol <248>;#var rmsym <248> * <088>};
		#CASE {"Mountains"}		{#var rmcol <238>;#var rmsym <238>/ \<088>};
		#CASE {"Mountain_cyan"}		{#var rmcol <268>;#var rmsym <268>/ \<088>};
		#CASE {"Ocean"}			{#var rmcol <148>;#var rmsym <148>~ ~<088>};
		#CASE {"Ocean2"}		{#var rmcol <148>;#var rmsym <148>~ ^<088>};
		#CASE {"Ocean3"}		{#var rmcol <148>;#var rmsym <148>^ ~<088>};
		#CASE {"Ocean4"}		{#var rmcol <148>;#var rmsym <148>, ~<088>};
		#CASE {"Office"}		{#var rmcol <238>;#var rmsym <238>[ ]<088>};
		#CASE {"Palace_room"}		{#var rmcol <138>;#var rmsym <138>[ ]<088>};
		#CASE {"Pillar"}		{#var rmcol <278>;#var rmsym <278> * <088>};
		#CASE {"Plain"}			{#var rmcol <238>;#var rmsym <238>, `<088>};
		#CASE {"Quicksand"}		{#var rmcol <138>;#var rmsym <138>%%%<088>};
		#CASE {"Rain"}			{#var rmcol <148>;#var rmsym <148>'.'<088>};
		#CASE {"Rainbow"}		{#var rmcol <148>;#var rmsym <118>)<138>)<148>)<088>};
		#CASE {"Redcarpet"}		{#var rmcol <118>;#var rmsym <118>. .<088>};
		#CASE {"River"}			{#var rmcol <148>;#var rmsym <148>~ ~<088>};
		#CASE {"Road"}			{#var rmcol <278>;#var rmsym <278>[ ]<088>};
		#CASE {"Road_crossroads"}	{#var rmcol <278>;#var rmsym <278>-+-<088>};
		#CASE {"Road_eastwest"}		{#var rmcol <278>;#var rmsym <278>- -<088>};
		#CASE {"Rocks"}			{#var rmcol <238>;#var rmsym <238>^ ^<088>};
		#CASE {"Ruins"}			{#var rmcol <178>;#var rmsym <178>{<148>*<178>}<088>};
		#CASE {"Ship"}			{#var rmcol <238>;#var rmsym <238>\_/<088>};
		#CASE {"Shore"}			{#var rmcol <268>;#var rmsym <268>~ ~<088>};
		#CASE {"Shop"}			{#var rmcol <138>;#var rmsym <138>*<128>$<138>*<088>};
		#CASE {"Smallroad"}		{#var rmcol <278>;#var rmsym <228>,<278>|<228>`<088>};
		#CASE {"Smallroad_ew"}		{#var rmcol <278>;#var rmsym <278>---<088>};
		#CASE {"Snow"}			{#var rmcol <178>;#var rmsym <178>. ,<088>};
		#CASE {"Space1"}		{#var rmcol <108>;#var rmsym <208>[ ]<088>};
		#CASE {"Space2"}		{#var rmcol <278>;#var rmsym <278>*  <088>};
		#CASE {"Space3"}		{#var rmcol <278>;#var rmsym <278>  .<088>};
		#CASE {"Space4"}		{#var rmcol <108>;#var rmsym <208>[ ]<088>};
		#CASE {"Stairs"}		{#var rmcol <278>;#var rmsym <278>.@.<088>};
		#CASE {"Sun"}			{#var rmcol <138>;#var rmsym <138> * <088>};
		#CASE {"Swamp"}			{#var rmcol <228>;#var rmsym {<228>; ;<088>}};
		#CASE {"Temple"}		{#var rmcol <268>;#var rmsym <268>{<178>+<268>}<088>};
		#CASE {"Tornado"}		{#var rmcol <108>;#var rmsym <108>.\/<088>};
		#CASE {"Trail_ew"}		{#var rmcol <238>;#var rmsym <238>. .<088>};
		#CASE {"Tunnel"}		{#var rmcol <238>;#var rmsym <238>] [<088>};
		#CASE {"Underground"}		{#var rmcol <148>;#var rmsym <148>. .<088>};
		#CASE {"Underwater"}		{#var rmcol <248>;#var rmsym <248>~ ~<088>};
		#CASE {"Vertical_shaft"}	{#var rmcol <278>;#var rmsym <278>< ><088>};
		#CASE {"Volcano"}		{#var rmcol <218>;#var rmsym <218>/ \<088>};
		#CASE {"Water"}		{#var rmcol <148>;#var rmsym <148>~ ~<088>};
		#CASE {"Well"}			{#var rmcol <238>;#var rmsym <238>(<148>~<238>)<088>};
		#CASE {"Wind1"}			{#var rmcol <168>;#var rmsym <168>~ ~<088>};
		#CASE {"Wind2"}			{#var rmcol <108>;#var rmsym <108>~-~<088>};
		#default			{#var rmcol {};#var rmsym {}};
	};

	#format {rmsym_len} {%L} {$rmsym};

	#if {"$rmcol" != ""} {
		#map set roomcolor $rmcol
	};
	#if {$rmsym_len > 0} {
		#map set roomsymbol $rmsym
	};
}
