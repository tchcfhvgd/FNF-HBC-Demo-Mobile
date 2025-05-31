function onCreatePost()
	makeLuaSprite('jumpscare', 'spookyskid')
	setObjectCamera('jumpscare', 'camOther')
	setProperty('jumpscare.alpha', 0.0001)
	scaleObject('jumpscare', 1.25, 1.25, false)
	screenCenter('jumpscare')
	setProperty('jumpscare.y', getProperty('jumpscare.y')-15)
	addLuaSprite('jumpscare', true)
end

local jumpEnd = 0 -- dont edit

local shakeIntensity = 0.015

jumpscareStuff = function(stepLength, playSound)
	cancelTween('jumpscareFinish')
	setProperty('camGame.alpha', 1)
	setProperty('camHUD.alpha', 1)
	setProperty('jumpscare.alpha', 0.0001)
	setProperty('camOther._fxShakeDuration', 0)
	
	setProperty('jumpscare.alpha', 1)
	setProperty('camGame.alpha', 0.0001)
	setProperty('camHUD.alpha', 0.0001)
	cameraShake('other', shakeIntensity, stepLength / playbackRate)
	jumpEnd = curStep + stepLength
	
	--if playSound then playSound('jumpscare', 1) end -- (most of) the sound effects are already baked into the vocals LOL
end

finishJumpscare = function(alt)
	setProperty('camGame.alpha', 1)
	setProperty('camHUD.alpha', 1)
	
	if alt then doTweenAlpha('jumpscareFinish', 'jumpscare', 0.0001, 0.1 / playbackRate, 'linear') else doTweenAlpha('jumpscareFinish', 'jumpscare', 0.0001, 0.15 / playbackRate, 'linear') end
end

-- Jumpscares are shortened compared to the note length in the chart, marked with a comment.

function onStepHit()
	if curStep == jumpEnd then
		finishJumpscare()
		
	elseif curStep == 504 then
		jumpscareStuff(5, true) -- Shortened by 3 steps
		
	elseif curStep == 952 then
		jumpscareStuff(6, true) -- Shortened by 1 step
		
	elseif curStep == 964 or curStep == 972 or curStep == 980 or curStep == 1116 then
		jumpscareStuff(2, true) -- Shortened by 2 steps
		
	elseif curStep == 1208 then
		jumpscareStuff(5, true) -- Shortened by 2 steps
		
	elseif curStep == 1536 then
		jumpscareStuff(5, true) -- Shortened by 3 steps
		
	elseif curStep == 1912 then
		jumpscareStuff(5, true) -- Shortened by 3 steps
		
	elseif curStep == 2016 then
		jumpscareStuff(5, true) 
		
	elseif curStep == 2080 then
		jumpscareStuff(5, true)
		
	elseif curStep == 2168 then
		jumpscareStuff(6, true) -- Shortened by 2 steps
		
	elseif curStep == 2180 then
		jumpscareStuff(3, true) -- Shortened by 1 step
	
	elseif curStep == 2188 then
		jumpscareStuff(3, true)
		
	elseif curStep == 2196 then
		jumpscareStuff(3, true)
		
	elseif curStep == 2208 then
		jumpscareStuff(5, true)
	
	elseif curStep == 2328 then
		jumpscareStuff(6, true) -- Shortened by 2 steps
		
	elseif curStep == 2344 or curStep == 2346 then
		altJumpscare(0.05, true)
		
	elseif curStep == 2360 then
		jumpscareStuff(4, true)
	
	elseif curStep == 2380 or curStep == 2384 then
		altJumpscare(0.05, true)
	
	elseif curStep == 2412 then
		jumpscareStuff(3, true)
	
	elseif curStep == 2420 or curStep == 2422 then
		altJumpscare(0.05, true)
		
	elseif curStep == 2456 then
		altJumpscare(0.1, true)
		
	elseif curStep == 2536 then
		jumpscareStuff(1, true)
	
	elseif curStep == 2544 then
		jumpscareStuff(1, true)
	
	elseif curStep == 2552 or curStep == 2554 or curStep == 2556 then
		altJumpscare(0.02, true)
		
	elseif curStep == 2560 then
		jumpscareStuff(1, true)
	
	elseif curStep == 2584 then
		jumpscareStuff(3, true)	
		
	elseif curStep == 2680 then
		jumpscareStuff(3, true)
		
	elseif curStep == 2692 or curStep == 2700 then
		jumpscareStuff(2, true)

	elseif curStep == 2708 or curStep == 2710 then
		altJumpscare(0.02, true)
		
	elseif curStep == 2716 then
		jumpscareStuff(2, true)	
		
	elseif curStep == 2784 then
		jumpscareStuff(3, true)
		
	elseif curStep == 2808 then
		jumpscareStuff(3, true)
		
	elseif curStep == 2820 or curStep == 2828 then
		jumpscareStuff(3, true)	
		
	elseif curStep == 2836 then
		jumpscareStuff(3, true)
		
	elseif curStep == 3104 then
		jumpscareStuff(6, true)
	end
end

function onTimerCompleted(tag)
	if tag == 'jumpscareTimer' then
	finishJumpscare(true)
	end
end

function onTweenCompleted(tag)
	if tag == 'jumpscareFinish' then
	setProperty('camOther._fxShakeDuration', 0)
	end
end

altJumpscare = function(secondLength, playSound) -- Alternate jumpscare function, uses seconds for length instead of song steps. Made this for the jumpscares that last less than 1 step.
	cancelTween('jumpscareFinish')
	setProperty('camGame.alpha', 1)
	setProperty('camHUD.alpha', 1)
	setProperty('jumpscare.alpha', 0.0001)
	setProperty('camOther._fxShakeDuration', 0)
	
	setProperty('jumpscare.alpha', 1)
	setProperty('camGame.alpha', 0.0001)
	setProperty('camHUD.alpha', 0.0001)
	cameraShake('other', shakeIntensity, (secondLength / playbackRate) * 10)
	
	runTimer('jumpscareTimer', secondLength / playbackRate)
end

local shakeProgress = 0;

function onPause()
	shakeProgress = getProperty('camOther._fxShakeDuration') -- Stops shaking while paused, resumes shake when unpaused
	setProperty('camOther._fxShakeDuration', 0)
end

function onResume()
	setProperty('camOther._fxShakeDuration', shakeProgress)
end