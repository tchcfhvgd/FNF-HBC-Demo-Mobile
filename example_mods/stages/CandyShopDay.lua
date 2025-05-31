playVideo = true

function onUpdatePost(elapsed)
	if keyboardPressed('ENTER') and playVideo then
	playVideo = false;
	function onUpdatePost(elapsed)
	
	end
	return Function_Continue;
	end
end

function onStartCountdown()
    if isStoryMode and not seenCutscene and playVideo then
			runTimer('whoops', 0.2)
			return Function_Stop; --Prevents the song from starting naturally
	end
	
	function onUpdatePost(elapsed)
	
	end
	setProperty('camHUD.alpha', 1)
	setProperty('camGame.alpha', 1)
	doTweenAlpha('gaming', 'blackOverlay', 0, 1 / playbackRate, 'linear')
	
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

----cutscene-----------------------------

function onCreate()
		makeLuaSprite('blackOverlay', nil, 0, 0);
		makeGraphic('blackOverlay', 1, 1, '000000');
		scaleObject('blackOverlay', screenWidth, screenHeight, false)
		setObjectCamera('blackOverlay', 'other');
		screenCenter('blackOverlay')
		setProperty('blackOverlay.alpha', 0.0001)
		addLuaSprite('blackOverlay', true);
		
		if isStoryMode and not seenCutscene then
		setProperty('blackOverlay.alpha', 1)
		end
end



function onCreatePost()

if isStoryMode and not seenCutscene then
setProperty('camHUD.alpha', 0.0001)
setProperty('camGame.alpha', 0.0001)
end

	-- funni splash precache
	makeAnimatedLuaSprite('spookysplash', 'CandyShop/SpookyNoteSplashes', 0, 0)
	setObjectCamera('spookysplash', 'camOther')
			setProperty('spookysplash.alpha', 0.0001);
			addLuaSprite('spookysplash')
	makeLuaSprite('truefade', 'court/fade', 0, 0)
addLuaSprite('truefade')
setProperty('truefade.alpha', 0.0001)
setObjectCamera('truefade', 'camOther')
setObjectOrder('truefade', 2)	

	setObjectOrder('boyfriendGroup', 16)
	setObjectOrder('dadGroup', 24)
	setObjectOrder('gfGroup', 30)
	
	
	
	---stage stuff----
	
	shopItems = {
	'candyShopDayBGSprite'
	}
	
	
	makeAnimatedLuaSprite('candyShopBack', 'CandyShop/Background/CandyShopBack', 30, -50)
	addAnimationByPrefix('candyShopBack', 'idle', 'back', 24, false)
	setScrollFactor('candyShopBack', 0.6, 0.9)
	scaleObject('candyShopBack', 0.95, 0.95, true)
	setObjectOrder('candyShopBack', 1)
	addLuaSprite('candyShopBack', false)
	
	makeAnimatedLuaSprite('boppers0', 'CandyShop/Background/CorruptedBoppersfix', -180, 250)
	addAnimationByPrefix('boppers0', 'idle', 'bobbers0', 24, false)
	setObjectOrder('boppers0', 5)
	scaleObject('boppers0', 0.85, 0.85, true)
	setScrollFactor('boppers0', 0.85, 0.95)
	addLuaSprite('boppers0', false)
	
	makeLuaSprite('candyShopDayBGSprite', 'CandyShop/Background/CandyShopDay', -380, 220)
	scaleObject('candyShopDayBGSprite', 0.95, 0.95, true)
	setObjectOrder('candyShopDayBGSprite', 13)
	addLuaSprite('candyShopDayBGSprite', false)
	
	makeLuaSprite('candyShopVignette', 'CandyShop/Background/Vignette', 0, 0)
	setObjectOrder('candyShopVignette', 0)
	setObjectCamera('candyShopVignette', 'camHUD')
	screenCenter('candyShopVignette')
	addLuaSprite('candyShopVignette', false)
	
	makeLuaSprite('candyShopFrontCounter', 'CandyShop/Background/CandyShopFrontCounter', -250, 240)
	setScrollFactor('candyShopFrontCounter', 1.1, 1.1)
	scaleObject('candyShopFrontCounter', 0.93, 0.93, true)
	setObjectOrder('candyShopFrontCounter', 21)
	addLuaSprite('candyShopFrontCounter', false)
	
	makeAnimatedLuaSprite('candyShopLights', 'CandyShop/Background/CandyShopLights', 30, 125)
	addAnimationByPrefix('candyShopLights', 'idle', 'upperlightfull', 24, false)
	scaleObject('candyShopLights', 0.95, 0.95, true)
	setObjectOrder('candyShopLights', 16)
	addLuaSprite('candyShopLights', false)
	
end

healthDrain = 0.02
function opponentNoteHit()
   if getHealth() > healthDrain then
		if difficulty == 0 then
			addHealth(-healthDrain);
		else 
			addHealth(-healthDrain/2);
		end
	end
end

function onStepHit()
	if curStep == 1854 then
		doTweenZoom('ghost', 'camGame', 1.6, 0.25 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.6)
		--triggerEvent('Add Camera Zoom', '', '')
	end
end

isBoppin = false

function onBeatHit()
	if isBoppin then
	setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.035)
	setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.035)
	end


	playAnim('candyShopBack', 'idle', true)
	
	if curBeat % 2 == 0 then
		playAnim('candyShopLights', 'idle', true)
		playAnim('boppers0', 'idle', true, false, 0)
		
			playAnim('boppers1', 'idle', true, false, 0)
			playAnim('boppers2', 'idle', true, false, 0)
			--playAnim('back1', 'idle', true, false, 0)
			--playAnim('back2', 'idle', true, false, 0)
	end
	
	
	if curBeat >= 28 and not e1 then
	e1 = true
		setProperty('camFollow.x', 1000)
		setProperty('camFollow.y', 800)
		setProperty('isCameraOnForcedPos', true)

		doTweenZoom('firstZoom', 'camGame', 1.2, 1 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1.2)
		
	elseif curBeat >= 60 and not e2 then
	e2 = true
		doTweenZoom('zoom1', 'camGame', 1.3, 0.1 / playbackRate, 'linear')
		setProperty('defaultCamZoom', 1.3)
		
	elseif curBeat >= 61 and not e3 then
	e3 = true
		doTweenZoom('zoom2', 'camGame', 1.4, 0.1 / playbackRate, 'linear')
		setProperty('defaultCamZoom', 1.4)
		
	elseif curBeat >= 62 and not e4 then
	e4 = true
		doTweenZoom('zoom3', 'camGame', 1.5, 0.1 / playbackRate, 'linear')
		setProperty('defaultCamZoom', 1.5)
		
	elseif curBeat >= 64 and not e5 then
	e5 = true
		setProperty('isCameraOnForcedPos', false)
		setProperty('defaultCamZoom', 0.8)
		
	elseif curBeat >= 126 and not e6 then
	e6 = true
		setProperty('camFollow.x', 300)
		setProperty('camFollow.y', 800)
		setProperty('isCameraOnForcedPos', true)

		doTweenZoom('zoom4', 'camGame', 1, 1 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1)
		
	elseif curBeat >= 156 and not e7 then
	e7 = true
		setProperty('isCameraOnForcedPos', false)
		setProperty('camFollow.x', 1000)
		setProperty('camFollow.y', 800)
		setProperty('isCameraOnForcedPos', true)
	
	elseif curBeat >= 187 and not e8 then
	e8 = true
		setProperty('isCameraOnForcedPos', false)
	
		doTweenZoom('zoom5', 'camGame', 0.8, 1 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 0.8)
		
		
	elseif curBeat >= 249 and not e9 then -- pump dies
	e9 = true
		setProperty('camFollow.x', 240)
		setProperty('camFollow.y', 875)
		setProperty('isCameraOnForcedPos', true)

		doTweenZoom('zoom6', 'camGame', 1.4, 0.5 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1.4)
		
		
	elseif curBeat >= 254 and not e10 then
	e10 = true
		setProperty('isCameraOnForcedPos', false)

		doTweenZoom('a', 'camGame', 1, 0.5 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1)
		cameraSetTarget('dad')
		
		healthDrain = 0.031
		
	elseif curBeat >= 288 and not e11 then
	e11 = true
		--healthDrain = 0.02
		setProperty('healthGain', 2)
		
	elseif curBeat >= 349 and not e12 then
	e12 = true
		doTweenZoom('ext', 'camGame', 1.025, 0.25 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1.025)
		
	elseif curBeat >= 350 and not e13 then
	e13 = true
		doTweenZoom('ext1', 'camGame', 1.05, 0.25 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1.05)
		
	elseif curBeat >= 351 and not e14 then
	e14 = true
		doTweenZoom('ext2', 'camGame', 1.075, 0.25 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1.075)
	
	elseif curBeat >= 352 and not e15 then
	e15 = true
		setProperty('defaultCamZoom', 1)
	
	elseif curBeat >= 384 and not plswork then
	plswork = true
		for _, item in pairs(shopItems) do
			setProperty(item..'.alpha', 0.0001)
		end
		setProperty('healthGain', 1)
		healthDrain = 0.031
	
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
		
		if not middlescroll then
			noteTweenX('middle1', 4, 410, 2 / playbackRate, 'expoOut')
			noteTweenX('middle2', 5, 522, 2 / playbackRate, 'expoOut')
			noteTweenX('middle3', 6, 633, 2 / playbackRate, 'expoOut')
			noteTweenX('middle4', 7, 745, 2 / playbackRate, 'expoOut')
		end
		
		
	elseif curBeat == 400 or curBeat == 404 then
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.04)
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.2)
		
	elseif curBeat >= 408 and not e16 then
	e16 = true
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.4)
		
		
	elseif curBeat >= 416 and not e17 then
	e17 = true
		isBoppin = true
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
		
	elseif curBeat == 448 then
		doTweenZoom('ghost', 'camGame', 1.1, 0.25 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.1)
		triggerEvent('Add Camera Zoom', '', '')
		
		
	elseif curBeat == 452 then
		doTweenZoom('ghost', 'camGame', 1.15, 0.2 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.15)
		triggerEvent('Add Camera Zoom', '', '')
		
	elseif curBeat == 456 then
		doTweenZoom('ghost', 'camGame', 1.25, 0.255 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.25)
		triggerEvent('Add Camera Zoom', '', '')
		
	elseif curBeat == 460 then
		doTweenZoom('ghost', 'camGame', 1.3, 0.25 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.3)
		triggerEvent('Add Camera Zoom', '', '')
		
	elseif curBeat == 461 then
		doTweenZoom('ghost', 'camGame', 1.35, 0.25 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.3)
		--triggerEvent('Add Camera Zoom', '', '')
		
	elseif curBeat == 462 then
		doTweenZoom('ghost', 'camGame', 1.45, 0.25 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.45)
		--triggerEvent('Add Camera Zoom', '', '')
		
	elseif curBeat == 463 then
		doTweenZoom('ghost', 'camGame', 1.5, 0.25 / playbackRate, 'smootherStepOut')
		setProperty('defaultCamZoom', 1.5)
		--triggerEvent('Add Camera Zoom', '', '')
		
		--step event on beat 463.5
		
	elseif curBeat >= 464 and not e18 then
	e18 = true
		doTweenZoom('zoom8', 'camGame', 1, 1 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 1)
		
	elseif curBeat >= 476 and not fixedNotes then
	fixedNotes = true
		if not middlescroll then
			noteTweenX('middle1', 4, defaultPlayerStrumX0, 2 / playbackRate, 'expoOut')
			noteTweenX('middle2', 5, defaultPlayerStrumX1, 2 / playbackRate, 'expoOut')
			noteTweenX('middle3', 6, defaultPlayerStrumX2, 2 / playbackRate, 'expoOut')
			noteTweenX('middle4', 7, defaultPlayerStrumX3, 2 / playbackRate, 'expoOut')
		end
	

	elseif curBeat >= 478 and not e19 then
	e19 = true
		doTweenZoom('ext3', 'camGame', 0.8, 0.5 / playbackRate, 'smoothStepOut')
		setProperty('defaultCamZoom', 0.8)
		

	elseif curBeat >= 480 and not e20 then
	e20 = true
		
		for _, item in pairs(shopItems) do
		setProperty(item..'.alpha', 1)
		end
		
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
		
		isBoppin = false
		
	elseif curBeat == 512 then
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
		

	elseif curBeat == 575 then 
		for i = 0, getProperty('notes.length')-1 do
			if getPropertyFromGroup('notes', i, 'mustPress') then setPropertyFromGroup('notes', i, 'ignoreNote', not getProperty('cpuControlled')) end -- Miss has no penalties
		end
		for ind = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', ind, 'mustPress') then setPropertyFromGroup('unspawnNotes', ind, 'ignoreNote', not getProperty('cpuControlled')) end-- Miss has no penalties
		end
	
	elseif curBeat >= 576 and not e21 then
	e21 = true
	setProperty('canPause', false)
	-- video sprite for SpookersD3End1 gets called in other script
	end
	
end
----event shit---- yea idk it fuckin sucks



local durating = 1

function onEvent(name, value1, value2)
	if name == "DevotionFade" then
		--looking back...this shit hurts to read
		function onUpdate()
		setProperty('camGame.alpha', 0)
		setProperty('camHUD.alpha', 0)
		end
		
	end
	
	if name == "DFlash" then
		durating = tonumber(value2)
		
		doTweenAlpha('fadestuffs', 'truefade', 1, durating / playbackRate, 'linear')
		runTimer('fadetima', 4 / playbackRate)
	end	
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'fadetima' then 
	doTweenAlpha('fadestuffs2', 'truefade', 0, 5 / playbackRate, 'linear')
	end
	
	if tag == 'whoops' then
	startVideo('SpookersD3fix'); --Play video file from "videos/" folder
	playVideo = false;
	end
end

endVideo = true
function onEndSong()
	if endVideo then
	startVideo('SpookersD3End2')
	endVideo = false
	return Function_Stop
	end
return Function_Continue
end