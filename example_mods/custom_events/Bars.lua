function onCreate()
	makeLuaSprite('barTop', nil, 0, -100);
	makeGraphic('barTop', screenWidth, 100, '000000');
	setObjectCamera('barTop', 'other');
	addLuaSprite('barTop', true);
	
	makeLuaSprite('barBottom', nil, 0, 720);
	makeGraphic('barBottom', screenWidth, 500, '000000');
	setObjectCamera('barBottom', 'other');
	addLuaSprite('barBottom', true);
end

function onEvent(name, value1, value2)
    local penieses = tonumber(value1)
    local aughgh = tonumber(value2)
    if name == 'Bars' then
	
		if aughgh == null then
		aughgh = 7
		else
		aughgh = aughgh
		end
		
		if not downscroll then
		
		--bar size was meant to be customizable, couldnt get it to work lmao
		if penieses == 1 then
					doTweenY('INtopBar', 'barTop', getProperty('barTop.y')+100, aughgh / playbackRate, 'expoOut')
				
					doTweenY('INhudMove', 'camHUD', 65, aughgh / playbackRate, 'expoOut')
			
					doTweenY('INbottomBar', 'barBottom', getProperty('barBottom.y')-100, aughgh / playbackRate, 'expoOut')
					
					runTimer('annoying', (aughgh - 3) / playbackRate)
				
				
		elseif penieses == null then
			doTweenY('OUTtopBar', 'barTop', -100, aughgh / playbackRate, 'expoOut')
			doTweenY('OUTbottomBar', 'barBottom', 720, aughgh / playbackRate, 'expoOut')
			doTweenY('OUThudMove', 'camHUD', 0, aughgh / playbackRate, 'expoOut')
			
			doTweenAlpha('beegmonitor5', 'healthBar', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor6', 'healthBarBG', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor7', 'iconP1', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor8', 'iconP2', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor9', 'scoreTxt', 1, 0.5 / playbackRate, 'cubeInOut')
		end
		
		else
		
		if penieses == 1 then
					doTweenY('INtopBar', 'barTop', getProperty('barTop.y')+100, aughgh / playbackRate, 'expoOut')
				
					doTweenY('INhudMove', 'camHUD', -65, aughgh / playbackRate, 'expoOut')
			
					doTweenY('INbottomBar', 'barBottom', getProperty('barBottom.y')-100, aughgh / playbackRate, 'expoOut')
					
					runTimer('annoying', (aughgh - 3) / playbackRate)
				
				
		elseif penieses == null then
			doTweenY('OUTtopBar', 'barTop', -100, aughgh / playbackRate, 'expoOut')
			doTweenY('OUTbottomBar', 'barBottom', 720, aughgh / playbackRate, 'expoOut')
			doTweenY('OUThudMove', 'camHUD', 0, aughgh / playbackRate, 'expoOut')
			
			doTweenAlpha('beegmonitor5', 'healthBar', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor6', 'healthBarBG', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor7', 'iconP1', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor8', 'iconP2', 1, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('beegmonitor9', 'scoreTxt', 1, 0.5 / playbackRate, 'cubeInOut')
		end
		
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'annoying' then
	doTweenAlpha('beegmonitor1', 'healthBar', 0.0001, 1 / playbackRate, 'cubeInOut')
	doTweenAlpha('beegmonitor2', 'healthBarBG', 0.0001, 1 / playbackRate, 'cubeInOut')
	doTweenAlpha('beegmonitor3', 'iconP1', 0.0001, 1 / playbackRate, 'cubeInOut')
	doTweenAlpha('beegmonitor4', 'iconP2', 0.0001, 1 / playbackRate, 'cubeInOut')
	doTweenAlpha('beegmonitoriforgotthis', 'scoreTxt', 0.0001, 1 / playbackRate, 'cubeInOut')
	end
end