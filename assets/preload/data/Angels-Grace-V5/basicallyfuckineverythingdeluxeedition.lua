function onCreatePost()
setProperty('camHUD.alpha', 0.0001)
triggerEvent('Hide HUD', 0, 0.0001)

	playSound('_slash', 0.00001)
	
	setProperty('botplayTxt.y', getProperty('botplayTxt.y')+10)
	
	-- Flashbacks
	
	makeLuaSprite('Sacrilege', 'court/v5/court1', 0, 0)
	setObjectCamera('Sacrilege', 'camOther')
	scaleObject('Sacrilege', 0.525, 0.525, false)
	screenCenter('Sacrilege')
	setProperty('Sacrilege.alpha', 0.0001)
	addLuaSprite('Sacrilege', true)
	
	makeLuaSprite('Sacrilege-End', 'court/v5/court2', 0, 0)
	setObjectCamera('Sacrilege-End', 'camOther')
	scaleObject('Sacrilege-End', 0.525, 0.525, false)
	screenCenter('Sacrilege-End')
	setProperty('Sacrilege-End.alpha', 0.0001)
	addLuaSprite('Sacrilege-End', true)
	
	makeLuaSprite('Shachath', 'court/v5/court3alt/'..getRandomInt(1, 5), 0, 0)
	setObjectCamera('Shachath', 'camOther')
	scaleObject('Shachath', 0.525, 0.525, false)
	screenCenter('Shachath')
	setProperty('Shachath.alpha', 0.0001)
	addLuaSprite('Shachath', true)
	
	makeLuaSprite('Shachath-End', 'court/v5/court4', 0, 0)
	setObjectCamera('Shachath-End', 'camOther')
	scaleObject('Shachath-End', 0.525, 0.525, false)
	screenCenter('Shachath-End')
	setProperty('Shachath-End.alpha', 0.0001)
	addLuaSprite('Shachath-End', true)
	
		-- bars funni
		
	makeLuaSprite('barTop', nil, 0, -250);
	makeGraphic('barTop', screenWidth, 250, '000000');
	setObjectCamera('barTop', 'other');
	addLuaSprite('barTop', true);
	
	makeLuaSprite('barBottom', nil, 0, screenHeight);
	makeGraphic('barBottom', screenWidth, 250, '000000');
	setObjectCamera('barBottom', 'other');
	addLuaSprite('barBottom', true);
	
	
	makeAnimatedLuaSprite('particles', 'court/v5/theparticles', 0, 0)
	addAnimationByPrefix('particles', 'idle', 'particleshit', 33, true)
	scaleObject('particles', 2.56, 2.56227758007, false)
	screenCenter('particles', 'XY')
	setObjectCamera('particles', 'camOther')
	addLuaSprite('particles') -- this was a living nightmare to get working and also adds like 150 mb of memory lolz
	setProperty('particles.alpha', 0.0001) 
	
	
		makeLuaSprite('text1', 'court/angeltext/text1', 0, 0)
		scaleObject('text1', 1, 1, false)
		setObjectOrder('text1', 69)
		setScrollFactor('text1', 0, 0)
		screenCenter('text1', 'XY')
		setObjectCamera('text1', 'camOther')
		addLuaSprite('text1')
		setProperty('text1.alpha', 0.0001)
		
		makeLuaSprite('text2', 'court/angeltext/text2', 0, 0)
		scaleObject('text2', 1, 1, false)
		setObjectOrder('text2', 69)
		setScrollFactor('text2', 0, 0)
		screenCenter('text2', 'XY')
		setObjectCamera('text2', 'camOther')
		addLuaSprite('text2')
		setProperty('text2.alpha', 0.0001)
		
		makeLuaSprite('text3', 'court/angeltext/text3', 0, 0)
		scaleObject('text3', 1, 1, false)
		setObjectOrder('text3', 69)
		setScrollFactor('text3', 0, 0)
		screenCenter('text3', 'XY')
		setObjectCamera('text3', 'camOther')
		addLuaSprite('text3')
		setProperty('text3.alpha', 0.0001)
		
		makeLuaSprite('text4', 'court/angeltext/text4', 0, 0)
		scaleObject('text4', 1, 1, false)
		setObjectOrder('text4', 69)
		setScrollFactor('text4', 0, 0)
		screenCenter('text4', 'XY')
		setObjectCamera('text4', 'camOther')
		addLuaSprite('text4')
		setProperty('text4.alpha', 0.0001)
		
		makeLuaSprite('text5', 'court/angeltext/text5', 0, 0)
		scaleObject('text5', 1, 1, false)
		setObjectOrder('text5', 69)
		setScrollFactor('text5', 0, 0)
		screenCenter('text5', 'XY')
		setObjectCamera('text5', 'camOther')
		addLuaSprite('text5')
		setProperty('text5.alpha', 0.0001)
		
		-- v5 texts
		makeLuaSprite('v5text1', 'court/v5/text/text1', 0, 0)
		scaleObject('v5text1', 1, 1, false)
		setObjectOrder('v5text1', 69)
		setScrollFactor('v5text1', 0, 0)
		screenCenter('v5text1', 'XY')
		setObjectCamera('v5text1', 'camOther')
		addLuaSprite('v5text1')
		setProperty('v5text1.alpha', 0.0001)
		
		makeLuaSprite('v5text2', 'court/v5/text/text2', 0, 0)
		scaleObject('v5text2', 1, 1, false)
		setObjectOrder('v5text2', 69)
		setScrollFactor('v5text2', 0, 0)
		screenCenter('v5text2', 'XY')
		setObjectCamera('v5text2', 'camOther')
		addLuaSprite('v5text2')
		setProperty('v5text2.alpha', 0.0001)
		
		makeLuaSprite('v5text3', 'court/v5/text/text3', 0, 0)
		scaleObject('v5text3', 1, 1, false)
		setObjectOrder('v5text3', 69)
		setScrollFactor('v5text3', 0, 0)
		screenCenter('v5text3', 'XY')
		setObjectCamera('v5text3', 'camOther')
		addLuaSprite('v5text3')
		setProperty('v5text3.alpha', 0.0001)
		
		makeLuaSprite('v5text4', 'court/v5/text/text4', 0, 0)
		scaleObject('v5text4', 1, 1, false)
		setObjectOrder('v5text4', 69)
		setScrollFactor('v5text4', 0, 0)
		screenCenter('v5text4', 'XY')
		setObjectCamera('v5text4', 'camOther')
		addLuaSprite('v5text4')
		setProperty('v5text4.alpha', 0.0001)
		
	
	-- hud stuff
	setProperty('iconP1.visible', false)
	setProperty('iconP2.visible', false)
	
	setProperty('healthBar.visible', not getPropertyFromClass('ClientPrefs', 'showFPS'))
	setProperty('healthBarBG.visible', not getPropertyFromClass('ClientPrefs', 'showFPS'))
	
end


function onSongStart()
	flash('Sacrilege', 1)
	
	if middlescroll and not downscroll then
	setProperty('timeTxt.y', 10)
	end
end


-- custom shit lol

local balls
function flash(sprite, duration)
    setProperty(sprite..'.alpha', 1)
    runTimer(sprite..'Timer', duration / playbackRate)
    balls = sprite
end

function onTimerCompleted(tag)
    if tag == balls..'Timer' then
        doTweenAlpha(balls..'die', balls, 0, 1 / playbackRate, 'linear')
    elseif tag == 'flashFailsafe' then
	runHaxeCode('FlxG.camera.stopFX();')
	end
end

function flashCam()
	runHaxeCode('FlxG.camera.stopFX();')
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	runTimer('flashFailsafe', 1.05 / playbackRate)
end

function onUpdatePost()
	if not started and aj then
	setProperty('timeTxt.alpha', 0.0001)
	setProperty('botplayTxt.alpha', 0.0001)
	
	elseif started and aj then
	
	aj = false
	setProperty('timeTxt.alpha', 1)
	setProperty('botplayTxt.alpha', 1)
	end
end

aj = true

function opponentNoteHit()
	if getHealth() > healthDrain then
		addHealth(-healthDrain);
	end
end

function onTweenCompleted(tag)
	if tag == '1bbot' and not middlescroll and not downscroll then
	scaleObject('healthBar', 0.195, 1, true)
	scaleObject('healthBarBG', 0.195, 1, true)
	setProperty('scoreTxt.y', getProperty('barBottom.y') - 58)
	setProperty('healthBar.y', getProperty('barBottom.y') - 70)
	setProperty('healthBarBG.y', getProperty('barBottom.y') - 70)
	setProperty('healthBar.x', 0)
	setProperty('healthBarBG.x', 0)
	elseif tag == '1btop' and not middlescroll and downscroll then
	scaleObject('healthBar', 0.195, 1, true)
	scaleObject('healthBarBG', 0.195, 1, true)
	setProperty('scoreTxt.y', getProperty('barTop.y') + 260)
	setProperty('healthBar.y', getProperty('barTop.y') + 330)
	setProperty('healthBarBG.y', getProperty('barTop.y') + 330)
	setProperty('healthBar.x', 0)
	setProperty('healthBarBG.x', 0)
	
	setProperty('timeTxt.y', getProperty('timeTxt.y')-20)
	setProperty('botplayTxt.y', getProperty('botplayTxt.y')-26)
	setProperty('botplayTxt.x', getProperty('botplayTxt.x')+15)
	elseif tag == '1btop' and middlescroll and not downscroll then --kms
	scaleObject('healthBar', 0.195, 1, true)
	scaleObject('healthBarBG', 0.195, 1, true)
	setProperty('scoreTxt.y', getProperty('barBottom.y') - 58)
	setProperty('healthBar.y', getProperty('barBottom.y') - 70)
	setProperty('healthBarBG.y', getProperty('barBottom.y') - 70)
	setProperty('healthBar.x', 0)
	setProperty('healthBarBG.x', 0)
	
	scaleObject('timeTxt', 0.75, 0.75, false)
	setProperty('timeTxt.y', getProperty('timeTxt.y')+15)
	elseif tag == '1btop' and middlescroll and downscroll then --kms x2
	scaleObject('healthBar', 0.195, 1, true)
	scaleObject('healthBarBG', 0.195, 1, true)
	setProperty('scoreTxt.y', getProperty('barTop.y') + 260)
	setProperty('healthBar.y', getProperty('barTop.y') + 330)
	setProperty('healthBarBG.y', getProperty('barTop.y') + 330)
	setProperty('healthBar.x', 0)
	setProperty('healthBarBG.x', 0)
	
	scaleObject('timeTxt', 0.7, 0.7, false)
	setProperty('timeTxt.y', getProperty('timeTxt.y')-11)
	setProperty('botplayTxt.y', getProperty('botplayTxt.y')-26)
	end
end

function onEvent(n)
	if n == 'Change Character' then
	setHealthBarColors('FF0000', '66FF33'); -- normal healthbar colors
	end
end

-- took an hour of just testing different tweens to get the right one
barEase = 'quadOut' -- smootherStepOut also looks similar
barDuration = 1

function onBeatHit() -- tried optimizing the statements for better performance
-- Intro Prelude
	if curBeat == 8 then
		flash('Sacrilege-End', 1)
	
	elseif curBeat == 16 then
		flash('Shachath', 1)
	
	elseif curBeat == 24 then
		flash('Shachath-End', 1)
		
	end
	
-- v5 Text
	if curBeat == 48 then
		flash('v5text1', 1)
		
	elseif curBeat == 56 then
		flash('v5text2', 1)
	
	elseif curBeat == 324 then
		flash('v5text3', 1)
	
	elseif curBeat == 336 then
		flash('v5text4', 1)
		
	end
	
-- EvilText / Particles
	if curBeat >= 256 and not thing1 then -- Stay on track
	thing1 = true
		setProperty('healthGain', 0.65);
		setProperty('defaultCamZoom', 1.2);
		doTweenAlpha('ev1', 'text1', 1, 1 / playbackRate, 'cubeInOut');
		
		doTweenAlpha('killparticles1', 'particles', 0.0001 / playbackRate, 1, 'quadOut');
	
	elseif curBeat >= 259 and not thing2 then
	thing2 = true
		doTweenAlpha('byeev1', 'text1', 0, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 288 and not thing3 then -- You're stronger than this
	thing3 = true
		setProperty('defaultCamZoom', 1.05);
		doTweenAlpha('ev2', 'text2', 1, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 291 and not thing4 then
	thing4 = true
		doTweenAlpha('byeev2', 'text2', 0, 1 / playbackRate, 'cubeInOut');
		
	elseif curBeat >= 321 and not thing5 then
	thing5 = true
		doTweenAlpha('aliveparticles2', 'particles', 1, 1, 'quadOut');
	
	elseif curBeat >= 416 and not thing6 then -- His death was your fault
	thing6 = true
		healthDrain = 0.016
		doTweenAlpha('ev3', 'text3', 1, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 419 and not thing7 then
	thing7 = true
		doTweenAlpha('byeev3', 'text3', 0, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 424 and not thing8 then -- You failed him
	thing8 = true
		doTweenAlpha('ev4', 'text4', 1, 1 / playbackRate, 'cubeInOut');
		
	elseif curBeat >= 427 and not thing9 then
	thing9 = true
	doTweenAlpha('byeev4', 'text4', 0, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 512 and not thing10 then
	thing10 = true
		doTweenAlpha('killparticles2', 'particles', 0.0001, 1 / playbackRate, 'quadOut');
	
	elseif curBeat >= 544 and not thing11 then -- Just let go and sleep
	thing11 = true
	setProperty('defaultCamZoom', 1.3)
	doTweenAlpha('ev5', 'text5', 1, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 547 and not thing12 then
	thing12 = true
	doTweenAlpha('byeev5', 'text5', 0, 1 / playbackRate, 'cubeInOut');
	
	end

-- Song Events
	if curBeat >= 28 and not event1 then
	event1 = true
	setProperty('camHUD.alpha', 1)
	doTweenAlpha('fadeinGame', 'camGame', 1, 1.8 / playbackRate, 'cubeInOut')
	
	elseif curBeat >= 60 and not event2 then
	event2 = true
	doTweenY('1btop', 'barTop', -250 + 30, barDuration / playbackRate, barEase)
	doTweenY('1bbot', 'barBottom', 720 - 30, barDuration / playbackRate, barEase)
	
	elseif curBeat >= 64 and not event3 then
	event3 = true
	started = true
	healthDrain = 0.024
	flashCam()
	setProperty('particles.alpha', 1)

	elseif curBeat >= 92 and not event4 then
	event4 = true
	doTweenZoom("zoomies", "camGame", 1.7, 1.2 / playbackRate, 'smoothStepInOut')
	
	elseif curBeat >= 96 and not event5 then
	event5 = true
	doTweenZoom("zoomies2", "camGame", 0.9, 0.2 / playbackRate, 'smoothStepInOut')
	
	elseif curBeat >= 320 and not event6 then
	event6 = true
		healthDrain = 0
		setProperty('defaultCamZoom', 1.25)
		
	elseif curBeat >= 344 and not extrathing1 then -- sorry i just thought these would look cool
		extrathing1 = true
		setProperty('defaultCamZoom', 1.30)
		
	elseif curBeat >= 346 and not extrathing2 then -- sorry i just thought these would look cool
		extrathing2 = true
		setProperty('defaultCamZoom', 1.35)
		
	elseif curBeat >= 348 and not extrathing3 then -- sorry i just thought these would look cool
		extrathing3 = true
		setProperty('defaultCamZoom', 1.40)
	
	elseif curBeat >= 348 and not event7 then
	event7 = true
		healthDrain = 0.02
	
	elseif curBeat >= 352 and not event8 then
	event8 = true
	setProperty('defaultCamZoom', 1.05)

	elseif curBeat >= 384 and not event9 then
	event9 = true
		healthDrain = 0.018
		setProperty('healthGain', 1)
		flashCam()
	
	elseif curBeat >= 448 and not event10 then
	event10 = true
		healthDrain = 0.014
		flashCam()
	
	elseif curBeat >= 480 and not event11 then
	event11 = true
		healthDrain = 0.012
	
	elseif curBeat >= 512 and not event12 then
	event12 = true
		healthDrain = 0.01
		flashCam()
		
		doTweenY('2btop', 'barTop', -250 + 130, barDuration / playbackRate, barEase)
		doTweenY('2bbot', 'barBottom', 720 - 130, barDuration / playbackRate, barEase)
		if not downscroll then doTweenY('2hhud', 'camHUD', 100, barDuration / playbackRate, barEase) else doTweenY('2hhud', 'camHUD', -100, barDuration / playbackRate, barEase) end
	
	elseif curBeat >= 544 and not event13 then
	event13 = true
	setProperty('defaultCamZoom', 1.3)
	doTweenAlpha('ev5', 'text5', 1, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 547 and not event14 then
	event14 = true
	doTweenAlpha('byeev5', 'text5', 0, 1 / playbackRate, 'cubeInOut');
	
	elseif curBeat >= 568 and not event15 then
	event15 = true
		barDuration = 1.2
		
		doTweenY('3btop', 'barTop', -250 + 75, barDuration / playbackRate, barEase)
		doTweenY('3bbot', 'barBottom', 720 - 75, barDuration / playbackRate, barEase)
		if not downscroll then doTweenY('3hhud', 'camHUD', 45, barDuration / playbackRate, barEase) else doTweenY('3hhud', 'camHUD', -45, barDuration / playbackRate, barEase) end
	
	elseif curBeat >= 571 and not event16 then
	event16 = true
		cancelTween('3btop')
		cancelTween('3bbot')
		cancelTween('3hhud')
		barDuration = 1
	
	
		doTweenY('4btop', 'barTop', -250 + 115, barDuration / playbackRate, barEase)
		doTweenY('4bbot', 'barBottom', 720 - 115, barDuration / playbackRate, barEase)
		if not downscroll then doTweenY('4hhud', 'camHUD', 85, barDuration / playbackRate, barEase) else doTweenY('4hhud', 'camHUD', -85, barDuration / playbackRate, barEase) end
	
	elseif curBeat >= 576 and not event17 then
	event17 = true
	runHaxeCode('FlxG.camera.stopFX();')
	setObjectCamera('courtOverlay', 'camOther')
	cameraFlash('camHUD', 'ffffff', 1 / playbackRate, true)
	
	end
end