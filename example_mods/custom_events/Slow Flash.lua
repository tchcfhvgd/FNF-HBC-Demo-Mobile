local duratin = 1

function onEvent(name, value1, value2)
		if name == "Slow Flash" then
		duratin = tonumber(value2)
		
		runHaxeCode('FlxG.camera.fade(0xFFFFFFFF, '..duratin / playbackRate..', false);')
		
		-- lol
		if songName == 'Devotion' then
			setObjectCamera('spookycrack', 'camHUD')
		end
	end	
end