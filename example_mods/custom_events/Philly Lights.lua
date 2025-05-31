lightsOn = false

function onEvent(name, value1, value2)
    local lightshow = tonumber(value1)
    local aughgh = tonumber(value2)
    if name == 'Philly Lights' then
		if lightshow == 1 then
		
		lightsOn = true
		setProperty('windows.visible', true)
		
			else
			
			lightsOn = false
			setProperty('windows.visible', false)
			
		end
	end
end

function onBeatHit()
	if curBeat % 4 == 0 and lightsOn then
		noDupe = getRandomInt(1, #phillyLightsColors, noDupe)
		curLight = getColorFromHex(phillyLightsColors[noDupe])
		
		setProperty('windows.alpha', 1)
		setProperty('windows.color', curLight)
    end
end

function onUpdate(elapsed)
	  setProperty('windows.alpha', getProperty('windows.alpha') - (crochet / 1000) * elapsed * (1.5 / playbackRate));
	  
	  if getProperty('windows.alpha') == 0 then
	  -- keep windows drawn to screen to avoid stutters
		setProperty('windows.alpha', 0.0001)
	  end

end
	
phillyLightsColors = {
	'850505',
	'66FFFF',
	'FF00FF',
	'FFFF00',
	'66FF00'
};
