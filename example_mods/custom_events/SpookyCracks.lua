paused = false
-- cracks dont fade during hallucination transition 
function onCreatePost()
        makeLuaSprite('spookycrack', 'court/cracks', 0, 0);
        addLuaSprite('spookycrack');
        scaleObject('spookycrack', 0.66666666666, 0.66666666666); --lmao
        setObjectCamera('spookycrack', 'other');
		setObjectOrder('spookycrack', 0)
        setProperty('spookycrack.alpha', 0.0001);
		end

function onEvent(name, value1, value2)
    if name == 'SpookyCracks' then
		
	men = tonumber(value1)
	
	if men == 1 then
	 setObjectCamera('spookycrack', 'other');
	doTweenAlpha('hola', 'spookycrack', 0.8, 1.5 / playbackRate, 'cubeInOut');
	paused = false
	
	function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'loopContinues' and not paused then
		doTweenAlpha('whitetoblack', 'spookycrack', 0.8, 2 / playbackRate, 'cubeInOut');
	end	
	
	if tag == 'loopBegins' then
	doTweenAlpha('blacktowhite', 'spookycrack', 0.4, 1 / playbackRate, 'cubeInOut');
	end
end

function onTweenCompleted(tag, loops, loopsLeft)
	if tag == 'hola' then
	doTweenAlpha('blacktowhite', 'spookycrack', 0.4, 1 / playbackRate, 'cubeInOut');
	end
	
	if tag == 'blacktowhite' then
	runTimer('loopContinues', 3 / playbackRate);
	end
	
	if tag == 'whitetoblack' then
	doTweenAlpha('blacktowhite', 'spookycrack', 0.4, 1 / playbackRate, 'cubeInOut');
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
	
	doTweenAlpha('byebye', 'spookycrack', 0.00001, 0.5 / playbackRate)
	end
	end
	paused = false
end

function onBeatHit()
	if songName == 'Devotion' and curBeat == 377 and not paused then
	paused = true
	end
end