function onEvent(name, value1, value2)	
	if name == "Play Sound" then
	
	local soundnutz = tostring(value1)
	local volume = tonumber(value2)
	
	playSound(soundnutz, volume);

		
	end
end