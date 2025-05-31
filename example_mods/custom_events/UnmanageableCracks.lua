paused = false
-- cracks dont fade during hallucination transition 
function onCreatePost()
        makeLuaSprite('unmanageablecrack', 'court/cracks', 0, 0);
        addLuaSprite('unmanageablecrack');
        scaleObject('unmanageablecrack', 0.66666666666, 0.66666666666); --lmao
        setObjectCamera('unmanageablecrack', 'other');
		setObjectOrder('unmanageablecrack', 0)
        setProperty('unmanageablecrack.alpha', 0.0001);
		end

function onEvent(name, value1, value2)
    if name == 'UnmanageableCracks' then
		
	men = tonumber(value1)
	
	if men == 1 then
	setObjectCamera('unmanageablecrack', 'other');
	doTweenAlpha('hola', 'unmanageablecrack', 0.8, 1 / playbackRate, 'cubeInOut');
	paused = false
	
	function onTimerCompleted(tag, loops, loopsLeft)
		if tag == 'loopContinues' and not paused then
			doTweenAlpha('whitetoblack', 'unmanageablecrack', 0.8, 2 / playbackRate, 'cubeInOut');
		end	
	
		if tag == 'loopBegins' then
			doTweenAlpha('blacktowhite', 'unmanageablecrack', 0.4, 1 / playbackRate, 'cubeInOut');
		end
	
		if tag == 'waitasec' then
			doTweenAlpha('blacktowhite', 'unmanageablecrack', 0.4, 1 / playbackRate, 'cubeInOut');
		end
		
		if tag == 'afterHi' then
			doTweenAlpha('blacktowhite', 'unmanageablecrack', 0.4, 1 / playbackRate, 'cubeInOut');
		end
	end

	function onTweenCompleted(tag, loops, loopsLeft)
		if tag == 'hola' then
			runTimer('afterHi', 1 / playbackRate)
		end
	
		if tag == 'blacktowhite' then
			runTimer('loopContinues', 2.5 / playbackRate);
		end
	
		if tag == 'whitetoblack' then
		runTimer('waitasec', 1 / playbackRate)
		end
	end




	elseif men == 0 then
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function onTimerCompleted(tag, loops, loopsLeft)
		-- nope
	end
	
	function onTweenCompleted(tag, loops, loopsLeft)
	-- nope
	end
	
	cancelTween('blacktowhite')
	cancelTween('whitetoblack')
	
	setProperty('unmanageablecrack.alpha', 0.0001)
	end
	end
	paused = false
end