function onCreatePost()
	makeLuaSprite('picocrack', 'court/cracks', 0, 0);
       setProperty('picocrack.alpha', 0.0001)
       addLuaSprite('picocrack', true);
       scaleObject('picocrack', 0.7, 0.7);
       setObjectCamera('picocrack', 'other');
end

function onEvent(name, value1, value2)
    if name == 'cracks' then
        runTimer('holdon1', 0.1  / playbackRate);
		runTimer('holdon2', value2 / playbackRate);
	end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'holdon1' then
		doTweenAlpha('hola', 'picocrack', 0.5, 0.3 / playbackRate, 'linear');
	end
	if tag == 'holdon2' then
		doTweenAlpha('byeflicia', 'picocrack', 0.00001, 0.3 / playbackRate, 'linear');
	end		
end
-- this code is atrocious mate! whoever wrote this, i fixed it for ya -bakugo