function onCreatePost()
	if songName == 'Shachath' then
		makeLuaSprite('stext1', 'court/shachathtext/text1', 0, 0)
		scaleObject('stext1', 1, 1, false)
		setObjectOrder('stext1', 69)
		setScrollFactor('stext1', 0, 0)
		screenCenter('stext1', 'XY')
		setObjectCamera('stext1', 'camGame') -- originally was camOther, but i like the effect this has
		addLuaSprite('stext1')
		setProperty('stext1.alpha', 0.0001)
		
		makeLuaSprite('stext2', 'court/shachathtext/text2', 0, 0)
		scaleObject('stext2', 1, 1, false)
		setObjectOrder('stext2', 69)
		setScrollFactor('stext2', 0, 0)
		screenCenter('stext2', 'XY')
		setObjectCamera('stext2', 'camOther')
		addLuaSprite('stext2')
		setProperty('stext2.alpha', 0.0001)
		
		makeLuaSprite('stext3', 'court/shachathtext/text3', 0, 0)
		scaleObject('stext3', 1, 1, false)
		setObjectOrder('stext3', 69)
		setScrollFactor('stext3', 0, 0)
		screenCenter('stext3', 'XY')
		setObjectCamera('stext3', 'camOther')
		addLuaSprite('stext3')
		setProperty('stext3.alpha', 0.0001)
	end
end


local imgtag = ""
local timer = 1


function onEvent(name, value1, value2)
		if name == "Display Image" then
		imgtag = tostring(value1)
		timer = tonumber(value2)
		
		if imgtag == 'stext1' then
			doTweenAlpha('hellofirst', imgtag, 0.5, 0.5 / playbackRate, 'cubeInOut');
		else
			doTweenAlpha('hello1', imgtag, 1, 0.5 / playbackRate, 'cubeInOut');
		end	
		
		end
end



function onTweenCompleted(tag, loops, loopsleft)
		if tag == 'hellofirst' then
		runTimer('waitfirst', timer / playbackRate);
		end
		if tag == 'hello1' then
		runTimer('wait2', timer / playbackRate);
		end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'waitfirst' then
	doTweenAlpha('byefirst', imgtag, 0, 0.3 / playbackRate, 'cubeInOut');
	end
	if tag == 'wait2' then
	doTweenAlpha('bye2', imgtag, 0, 0.5 / playbackRate, 'cubeInOut');
	end
end