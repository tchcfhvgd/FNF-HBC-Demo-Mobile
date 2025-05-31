function onEvent(name, value1, value2)
		if name == "Fade Camera" then
		bolor = tostring(value1)
		duratin = tonumber(value2)
		
		cameraFade('camHUD', bolor, duratin / playbackRate, false)
		
		end	
end
