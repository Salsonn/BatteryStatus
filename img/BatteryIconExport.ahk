﻿sleep, 5000
;SetKeyDelay, 100
name := 0
Loop, 10
{

	no := A_Index - 1
	no2 := no + 10
	send, {Down %no2%}
	send, {Space}
	send, {Up %no2%}
	Loop 10
	{
		IfWinNotActive, ahk_exe gimp-2.8.exe
			Exit
		send, {Space}
		send, ^e
		sleep, 100
		FileMove, out.png, %name%.png
		name := name + 1
		send, {Space}
		send, {Down}
	}
	send, {Down %no%}
	send, {Space}
	send, {Up 20}
}