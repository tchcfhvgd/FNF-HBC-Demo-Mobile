
canDodge = false
dodged = false

-- removes dodge indicator on space press for multiple dodges at once
multiDodge = false --getting rid of this cause i found a better fix lol

function onCreate()
	if not dodgeMechanic then -- i hardcoded this and heartMechanic into FunkinLua, source code is fun lol  -future cv
	close(true)
	end
end

function onCreatePost()

	makeAnimatedLuaSprite('dodgePrecache', 'court/spacebar_icon', 0, 0)
	setProperty('dodgePrecache.alpha', 0.0001)
	setObjectCamera('dodgePrecache', 'other')
	addLuaSprite('dodgePrecache')
end

function onEvent(name, value1, value2)
	if name == "DodgeMechanic" then
		--show the dodge warning
		makeAnimatedLuaSprite('dodgeWarning', 'court/spacebar_icon', 0, 5)
		addAnimationByPrefix('dodgeWarning', 'idle', 'spacebar', 24, false)
		scaleObject('dodgeWarning', 0.5, 0.5, false)
		screenCenter('dodgeWarning', 'X')
		if not middlescroll then setProperty('dodgeWarning.x', getProperty('dodgeWarning.x') - 20) else setProperty('dodgeWarning.x', getProperty('dodgeWarning.x') - 350) end
		setObjectOrder('dodgeWarning', getObjectOrder('text2')+1)
		setObjectCamera('dodgeWarning', 'camOther')
		addLuaSprite('dodgeWarning', true)
		
		-- fix for spam dodge sections
		if not runHaxeCode('game.modchartTimers.get("dodgeBuffer").finished') and not botPlay then -- if the timer is still running when another dodge comes, missed the prev dodge.
			cancelTimer('dodgeBuffer')
			
			health = getProperty('health')
			setProperty('health', health - (0.5 * getProperty('healthLoss')))
	
			characterPlayAnim('bf', 'singRIGHTmiss', true)
			setProperty('boyfriend.specialAnim', true)
		end
		
		-- downscroll stuff
		if downscroll then
		setProperty('dodgeWarning.y', getProperty('dodgeWarning.y')-50)
		end
		
		-- vars reset
		canDodge = true
		dodged = false
	end
	
	if name == 'the S' then
	removeLuaSprite('dodgeWarning', true)
	if dodged then
		characterPlayAnim('bf', 'dodge', true)
		setProperty('boyfriend.specialAnim', true)
		dodged = false
		
		elseif not multiDodge then
		-- extra time to dodge, im too nice frfr
			if songName == 'Angels Grace V5' then
			runTimer('dodgeBuffer', (crochet / 6000) / playbackRate)
			else -- crochet 6000 equates to like 0.0525 seconds in agv5, 5000 is 0.0631
			runTimer('dodgeBuffer', (crochet / 5000) / playbackRate)
			end
			
		else
		health = getProperty('health')
		setProperty('health', health - (0.5 * getProperty('healthLoss')))
		
		characterPlayAnim('bf', 'singRIGHTmiss', true)
		setProperty('boyfriend.specialAnim', true)
		
		canDodge = false
		end
	end
end

function onUpdatePost()
		if keyJustPressed('space') and canDodge then
		dodged = true
		canDodge = false
			if multiDodge then
			removeLuaSprite('dodgeWarning', true)
			end
		end
		
		if botPlay then
		canDodge = false
		dodged = true
		multiDodge = false
		end
end

function onTimerCompleted(tag)
	if tag == 'dodgeBuffer' and not botPlay and not dodged then
		health = getProperty('health')
		setProperty('health', health - (0.5 * getProperty('healthLoss')))
		
		characterPlayAnim('bf', 'singRIGHTmiss', true)
		setProperty('boyfriend.specialAnim', true)
		
		canDodge = false
	elseif tag == 'dodgeBuffer' and not botPlay and dodged then
		-- REDEMPTION
		characterPlayAnim('bf', 'dodge', true)
		setProperty('boyfriend.specialAnim', true)
		
		dodged = false
		canDodge = false
	end
end