thing = false


function onCreatePost()

	

	if songName == 'Angels Grace V5' then
	setProperty('boyfriendGroup.x', getProperty('boyfriendGroup.x') + 100)
	end
	
	makeLuaSprite('sky', 'court/court1', -300, -200)
	addLuaSprite('sky', false)
	setObjectOrder('sky', 1)
	
	makeLuaSprite('buildings', 'court/court2', -300, 20)
	scaleObject('buildings', 0.7, 0.7, false)
	addLuaSprite('buildings', false)
	setObjectOrder('buildings', 2)
	
	makeLuaSprite('windows', 'court/court3', -300, 20)
	scaleObject('windows', 0.7, 0.7, false)
	addLuaSprite('windows', false)
	setObjectOrder('windows', 3)
	setProperty('windows.alpha', 0.0001)
	
	
	makeLuaSprite('backwall', 'court/court4', -200, -30)
	scaleObject('backwall', 0.7, 0.7, false)
	addLuaSprite('backwall', false)
	setObjectOrder('backwall', 4)
	
	makeLuaSprite('court', 'court/court5', -200, 37)
	scaleObject('court', 0.68, 0.68, false)
	addLuaSprite('court', false)
	setObjectOrder('court', 5)
	
	makeLuaSprite('courtOverlay', 'court/vignette', 0, 0)
	scaleObject('courtOverlay', 1, 1)
	addLuaSprite('courtOverlay', false)
	setObjectCamera('courtOverlay', 'camHUD')
	--setObjectOrder('courtOverlay', 13)
	setScrollFactor('courtOverlay', 0, 0)
	
	setObjectOrder('gfGroup', 11)
	setObjectOrder('dadGroup', 12)
	setScrollFactor('sky', 0.3, 0.3)
	setScrollFactor('buildings', 0.5, 0.8)
	setScrollFactor('windows', 0.5, 0.8)
	setScrollFactor('backwall', 0.9, 0.9)
	setScrollFactor('court', 1, 1);
	
	
	
	
	makeAnimatedLuaSprite('boombox', 'court/boombox', 1050, 720)
		addAnimationByPrefix('boombox', 'idle', 'thingy', 24, false)
		addLuaSprite('boombox')
		setObjectOrder('boombox', 6)
		setObjectCamera('boombox', 'camGame')
		setScrollFactor('boombox', 1, 1)
		
	makeAnimatedLuaSprite('flagger', 'court/voj', 989, 220)
		addAnimationByPrefix('flagger', 'idle', 'flagwave', 24, false)
		addLuaSprite('flagger')
		scaleObject('flagger', 0.8, 0.8, false)
		setObjectOrder('flagger', getObjectOrder('court')+0.3)
		setObjectCamera('flagger', 'camGame')
		setScrollFactor('flagger', 1, 1)
		
		makeAnimatedLuaSprite('funny', 'court/funnyman', 250, 390)
		addAnimationByPrefix('funny', 'idle', 'funnyman', 24, false)
		addLuaSprite('funny')
		scaleObject('funny', 0.73, 0.73, false)
		setObjectOrder('funny', 7)
		setObjectCamera('funny', 'camGame')
		setScrollFactor('funny', 1, 1)
		
		makeAnimatedLuaSprite('nya', 'court/nya2', 1370, 240)
		addAnimationByPrefix('nya', 'idle', 'nya idle', 24, false)
		addLuaSprite('nya')
		scaleObject('nya', 0.8, 0.8, false)
		setObjectOrder('nya', 7)
		setObjectCamera('nya', 'camGame')
		setScrollFactor('nya', 1, 1)
		
		makeAnimatedLuaSprite('mitch', 'court/bounces', 20, 600)
		addAnimationByPrefix('mitch', 'idle', 'bouncing', 24, false)
		scaleObject('mitch', 0.9, 0.9, false)
		setObjectCamera('mitch', 'camGame')
		setScrollFactor('mitch', 1, 1)
		addLuaSprite('mitch', true)
		
		
		setProperty('flagger.alpha', 0.001)
		setProperty('funny.alpha', 0.001)
		setProperty('nya.alpha', 0.001)
		setProperty('mitch.alpha', 0.001)

	if songName == 'Angels Grace' or songName == 'Angels Grace V5' then
	triggerEvent('Hide HUD', 0, 0.0001)
	doTweenAlpha('blackintrogame', 'camGame', 0.0001, 0.1 / playbackRate, 'cubeInOut');
	

--precache shit
	precacheSound('fire');
	precacheSound('darnellsavestheday');
	makeAnimatedLuaSprite('bluechudfire', 'bluefireNote_assets', 0, 0)
	setObjectCamera('bluechudfire', 'camOther')
			setProperty('bluechudfire.alpha', 0.0001);
			addLuaSprite('bluechudfire');
			
	setProperty('gfGroup.alpha', 0.0001);
	triggerEvent('Play Animation','chuddin time', '2')
	
	makeAnimatedLuaSprite('picosplash', 'picoNote_splashes', 0, 0)
	setObjectCamera('picosplash', 'camOther')
			setProperty('picosplash.alpha', 0.0001);
			addLuaSprite('picosplash')
	end
end

function onStartCountdown()
	setProperty('introSoundsSuffix', '-angel')
end

function onBeatHit()
	if curBeat % 2 == 0 then
		for i = 0, 2 do
			playAnim('flagger', 'idle', true, false, 0)
			playAnim('funny', 'idle', true, false, 0)
			playAnim('nya', 'idle', true, false, 0)
		end
	end
	
	if curBeat % 1 == 0 then
		for i = 0, 1 do
			playAnim('mitch', 'idle', true, false, 0)
			playAnim('boombox', 'idle', true, false, 0)
		end
	end
end

function onCreate()
	setProperty('skipArrowStartTween', true)
	
	precacheSound('intro3-angel')
	precacheSound('intro2-angel')
	precacheSound('intro1-angel')
	precacheSound('introGo-angel')
	precacheSound('slash')
	precacheSound('_slash')
	
	if isRunning('custom_events/DodgeMechanic') then mechanic = true end
end

function onCountdownTick(c)
	if songName ~= 'Angels Grace V5' then
	setObjectCamera('countdownReady', 'other')
	setObjectCamera('countdownSet', 'other')
	setObjectCamera('countdownGo', 'other')
	end
end

function onEvent(name, value1, value2)	
	
	if name == "GraceStart" then
		setProperty('flagger.alpha', 1)
		setProperty('funny.alpha', 1)
		setProperty('nya.alpha', 1)
		setProperty('mitch.alpha', 1)	
	end

	if name == 'the S' then
	--this code WILL make you vomit i dont know how to do it better :sob:
	-- update 2/16/24 - i can do it better now. i dont feel like it though
		if not mechanic then
			-- Vanilla AG mechanic
			characterPlayAnim('dad', 'attack', true);
			setProperty('dad.specialAnim', true);
			thing = true
			characterPlayAnim('bf', 'dodge', true)
			setProperty('boyfriend.specialAnim', true)
				if curBeat == 319 or curBeat == 320 then
				-- don't play when darnell arrives
				else
					if songName == 'Angels Grace' then 
					playSound('slash', 1) 
					else 
					--debugPrint(getProperty('defaultCamZoom'))
					if getProperty('camZooming') then
					setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.01)
					setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.01)
					end
					playSound('_slash', 1)
	
					end
				end
	
		else
	-- funky mechanic stuff
	characterPlayAnim('dad', 'attack', true);
	setProperty('dad.specialAnim', true);
	thing = true
	if curBeat == 319 or curBeat == 320 then
	-- don't play when darnell arrives
	else
	if songName == 'Angels Grace' then 
	playSound('slash', 1) 
	else 
	if getProperty('camZooming') then
		setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.01)
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.01)
	end
	playSound('_slash', 1)
	end
	end
	end
	end
end

function onUpdate()

	if thing then
	thing = false
	
	runTimer('attackCooldown', 0.2 / playbackRate ); -- Prevents pico attack from being interrupted early
	
		for i = 0, getProperty('notes.length')-1 do
			if getPropertyFromGroup('notes', i, 'mustPress') == false then
				if getPropertyFromGroup('notes', i, 'noteType') ~= 'GF Sing' then
					if getPropertyFromGroup('notes', i, 'noAnimation') == false then
						setPropertyFromGroup('notes', i, 'noAnimation', true)
					end
				end
			end
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'attackCooldown' then
	
	for i = 0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', i, 'mustPress') == false then
			if getPropertyFromGroup('notes', i, 'noteType') ~= 'GF Sing' then
				if getPropertyFromGroup('notes', i, 'noAnimation') == true then
					setPropertyFromGroup('notes', i, 'noAnimation', false)
				end
			end
		end
	end
	
	end
end

--new function define method just dropped
onTweenCompleted = function(tag)
	if tag == 'byeev1' then
	removeLuaSprite('text1', true)
	elseif tag == 'byeev2' then
	removeLuaSprite('text2', true)
	elseif tag == 'byeev3' then
	removeLuaSprite('text3', true)
	elseif tag == 'byeev4' then
	removeLuaSprite('text4', true)
	elseif tag == 'byeev5' then
	removeLuaSprite('text5', true)
	runHaxeCode('Paths.clearUnusedMemory();')
	
	elseif tag == 'Sacrilegedie' then
	removeLuaSprite('Sacrilege', true)
	elseif tag == 'Sacrilege-Enddie' then
	removeLuaSprite('Sacrilege-End', true)
	elseif tag == 'Shachathdie' then
	removeLuaSprite('Shachath', true)
	elseif tag == 'Shachath-Enddie' then
	removeLuaSprite('Shachath-End', true)
	runHaxeCode('Paths.clearUnusedMemory();')
	
	elseif tag == 'v5text1die' then
	removeLuaSprite('v5text1', true)
	elseif tag == 'v5text2die' then
	removeLuaSprite('v5text2', true)
	elseif tag == 'v5text3die' then
	removeLuaSprite('v5text3', true)
	elseif tag == 'v5text4die' then
	removeLuaSprite('v5text4', true)
	runHaxeCode('Paths.clearUnusedMemory();')
	
	elseif tag == 'killparticles2' then
	removeLuaSprite('particles', true) --100 mb of memory btw
	runHaxeCode('Paths.clearUnusedMemory();')
	end
end