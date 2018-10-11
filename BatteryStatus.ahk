#SingleInstance force
Menu, Tray, NoStandard
	
	Loop
	{
		BatteryStatus := GetBatteryStatus()
		perc := BatteryStatus.batteryLifePercent
		
		If (BatteryStatus.acLineStatus == 1)
		{
			;Charging
			Menu, Tray, Icon, img\charging\%perc%.png
		}
		Else
		{
			;Discharging
			Menu, Tray, Icon, img\%perc%.png
		}

		Sleep, 60000
	}
return

; https://autohotkey.com/board/topic/7022-acbattery-status/
ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
}

GetBatteryStatus()
{
	VarSetCapacity(powerStatus, 1+1+1+1+4+4)
	success := DllCall("GetSystemPowerStatus", "UInt", &powerStatus)
	
	acLineStatus:=ReadInteger(&powerstatus,0,1,false)
	batteryFlag:=ReadInteger(&powerstatus,1,1,false)
	batteryLifePercent:=ReadInteger(&powerstatus,2,1,false)
	batteryLifeTime:=ReadInteger(&powerstatus,4,4,false)
	batteryFullLifeTime:=ReadInteger(&powerstatus,8,4,false)
	
	output := {}
	output.acLineStatus := acLineStatus
	output.batteryFlag := batteryFlag
	output.batteryLifePercent := batteryLifePercent
	output.batteryLifeTime := batteryLifeTime
	output.batteryFullLifeTime := batteryFullLifeTime
	
	Return output
}