#!/bin/sh
# For this to work the Minecraft server must be ran inside a screen that was created by the www-data user, or the user that runs
# the webserver (www-data by default). use "sudo -u www-data screen -A -m -d -S minecraft" to start the screen through www-data.
# Then use "sudo -u www-data screen -x minecraft" to enter the screen and start the server.
    echo "Content-type: text/html\n"     
    # read in our parameters
    CMD=`echo "$QUERY_STRING" | sed -n 's/^.*cmd=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    FOLDER=`echo "$QUERY_STRING" | sed -n 's/^.*folder=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`
    FOLDER1=`echo "$QUERY_STRING" | sed -n 's/^.*folder1=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`
    FOLDER2=`echo "$QUERY_STRING" | sed -n 's/^.*folder2=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`

    # our html header
    echo "<style>\n#submit {\n\twidth: 140px;\n\theight: 60px;\nfont-size: 1.3em;\n}</style>"   
    echo "<style>\n#suicide {\n\twidth: 140px;\n\theight: 60px;\nbackground-color: red;\nfont-size: 1.3em;\n}</style>"   
    echo "<html>"
    echo "<head>\n"
    echo "<title>Nate's Minecraft Control Panel</title>\n"
    echo "<link rel=icon type=image/ico href=favicon.png />"
    echo "</head>\n"
    echo "<body>"
     
    # test if any parameters were passed
    if [ $CMD ]
    then
      case "$CMD" in
	Home)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger home^M'
	;;
	Back)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger back^M'
	;;
	SetHome)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger sethome^M'
	;;
	Spawn)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger spawn^M'
	;;
	Jay)
	screen -S minecraft -p 0 -X stuff 'tp happy_dagger neeher^M'
	;;
	Tyler)
	screen -S minecraft -p 0 -X stuff 'tp happy_dagger vladiemir^M'
	;;
	Kelsey)
	screen -S minecraft -p 0 -X stuff 'tp happy_dagger bopx^M'
	;;
	Hollow-Island)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp HollowIsland^M'
	;;
	Battlefield)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp Battlefield^M'
	;;
	Castle)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp Castle^M'
	;;
	Stable)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp Stable^M'
	;;
	Witch)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp Witch^M'
	;;
	Town)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp Town^M'
	;;
	Nates-Castle)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp NatesCastle^M'
	;;
	First-Town)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger warp FirstTown^M'
	;;
	Time)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger time^M'
	;;
	Compass)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger Compass^M'
	;;
	Position)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger GetPos^M'
	;;
	Basic-Tools)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger Kit Tools^M'
	;;
	List)
	screen -S minecraft -p 0 -X stuff 'sudo happy_dagger List^M'
	;;
	Suicide)
	screen -S minecraft -p 0 -X stuff 'kill happy_dagger^M'
	;;
      esac
    fi
     
    # print out the form
     
    # page header
    echo "<p>"
    echo "<center>"
    echo "<h2>Nate's Minecraft Control Panel</h2>"
    echo "</center>"
    echo "<h2>Quick Travel</h2>"
    echo "<form method=get>"
    echo "<!--"
    echo "<input type=radio name=cmd value=Home checked> Teleport Home<br>"
    echo "<input type=radio name=cmd value=Bome checked> Teleport Back<br>"	
    echo "<input type=submit>"
    echo "-->"
    echo "<input name=cmd value=Home type=submit id=submit>"
    echo "<input name=cmd value=Back type=submit id=submit>"
    echo "<input name=cmd value=SetHome type=submit id=submit>"
    echo "<input name=cmd value=Spawn type=submit id=submit>"
    echo "<h2>Teleport</h2>"
    echo "<input name=cmd value=Jay type=submit id=submit>"
    echo "<input name=cmd value=Tyler type=submit id=submit>"
    echo "<input name=cmd value=Kelsey type=submit id=submit>"
    echo "<h2>Warp</h2>"
    echo "<input name=cmd value=Hollow-Island type=submit id=submit>"
    echo "<input name=cmd value=Castle type=submit id=submit>"
    echo "<input name=cmd value=Battlefield type=submit id=submit>"
    echo "<input name=cmd value=Witch type=submit id=submit>"
    echo "</br>"
    echo "</br>"
    echo "<input name=cmd value=Stable type=submit id=submit>"
    echo "<input name=cmd value=Nates-Castle type=submit id=submit>"
    echo "<input name=cmd value=Town type=submit id=submit>"
    echo "<input name=cmd value=First-Town type=submit id=submit>"
    echo "<h2>Misc.</h2>"
    echo "<input name=cmd value=Time type=submit id=submit>"
    echo "<input name=cmd value=Compass type=submit id=submit>"
    echo "<input name=cmd value=Position type=submit id=submit>"
    echo "<input name=cmd value=Basic-Tools type=submit id=submit>"
    echo "</br>"
    echo "</br>"
    echo "<input name=cmd value=List type=submit id=submit>"
    echo "<input name=cmd value=Suicide type=submit id=suicide>"

    echo "</form>"
    echo "</body>"
    echo "</html>"
