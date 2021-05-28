#MACRO {\e[13~} {set_terrain} 

#ALIAS {set_terrain} {
	#map get roomterrain terrain;
	
	#switch {"$terrain"} {
		#CASE {"Arctic"}			{#var rmcol <178>;#var rmsym <178>. ,};
		#CASE {"Air"}			{#var rmcol <268>;#var rmsym <268>. .};
		#CASE {"City"}			{#var rmcol <278>;#var rmsym <278>. .};
		#CASE {"Desert"}		{#var rmcol <238>;#var rmsym <138>~ ~};
		#CASE {"Field"}	{
            #map get roomsymbol tempsym;
            #switch {"$tempsym"} {
                #CASE {"<228>, `"} {#var rmcol <228>;#var rmsym <228>. ^};
                #CASE {"<228>. ^"} {#var rmcol <228>;#var rmsym <228>, .};
                #CASE {"<228>, ."} {#var rmcol <228>;#var rmsym <228>` ^};
                #CASE {"<228>` ^"} {#var rmcol <228>;#var rmsym <228>, `};
                #default {#var rmcol <228>;#var rmsym <228>, `}  
                }   
            };
		#CASE {"Forest"}		{#var rmcol <aca>;#var rmsym <aca>( *};
		#CASE {"Hills"}			{#var rmcol <228>;#var rmsym <228>. ^};
		#CASE {"Ice"}			{#var rmcol <178>;#var rmsym <178>~ ~};
		#CASE {"Inside"}		{#var rmcol <278>;#var rmsym <278>[ ]};
		#CASE {"Mountains"}		{#var rmcol <238>;#var rmsym <238>/ \};
        #CASE {"Water"} {
            #MAP get roomsymbol tempsym;
            #SWITCH {"$tempsym"} {
                #CASE {"<148>~ ~"} {#var rmcol <148>;#var rmsym <148>~ ^};
                #CASE {"<148>~ ^"} {#var rmcol <148>;#var rmsym <148>^ ~};
                #CASE {"<148>^ ~"} {#var rmcol <148>;#var rmsym <148>, ~};
                #CASE {"<148>, ~"} {#var rmcol <148>;#var rmsym <148>~ ~};
                #DEFAULT {#var rmcol <148>;#var rmsym <148>~ ~}
                }
            };
		#CASE {"Ocean"}			{#var rmcol <148>;#var rmsym <148>~ ~};
		#CASE {"Ocean2"}		{#var rmcol <148>;#var rmsym <148>~ ^};
		#CASE {"Ocean3"}		{#var rmcol <148>;#var rmsym <148>^ ~};
		#CASE {"Ocean4"}		{#var rmcol <148>;#var rmsym <148>, ~};
		#CASE {"River"}			{#var rmcol <148>;#var rmsym <148>~ ~};
		#CASE {"Road"}			{#var rmcol <278>;#var rmsym <278>[ ]};
		#CASE {"Shore"}			{#var rmcol <268>;#var rmsym <268>~ ~};
		#CASE {"Shop"}			{#var rmcol <138>;#var rmsym <138>*<128>$<138>*};
		#CASE {"Swamp"}			{#var rmcol <228>;#var rmsym {<228>; ;}};
		#CASE {"Underground"}	{#var rmcol <148>;#var rmsym <148>. .};
		#CASE {"Underwater"}	{#var rmcol <248>;#var rmsym <248>~ ~};
		#CASE {"Water"}		{#var rmcol <148>;#var rmsym <148>~ ~};
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
