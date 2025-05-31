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
			runTimer('whoops', 1)
			return Function_Stop; --Prevents the song from starting naturally
	end
	
	function onUpdatePost(elapsed)
	
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoops' then
	startVideo('NeneD2'); --Play video file from "videos/" folder
	playVideo = false;
	end
end
----------------------------intro custene----------------------

function onCreate()
	-- precache time
	makeAnimatedLuaSprite('nenesplash', 'Bar/NeneNoteSplashes', 0, 0)
	setObjectCamera('nenesplash', 'camOther')
			setProperty('nenesplash.alpha', 0.0001)
			addLuaSprite('nenesplash')
	--precache ova
	
	--addLuaScript('custom_events/Bars')
	
    makeLuaSprite('barBG', 'Bar/Background/BarBG', -400, 100);
    scaleObject('barBG', 0.8, 0.8);
	addLuaSprite('barBG');

    makeAnimatedLuaSprite('barSlotMachineBopper', 'Bar/Background/BarSlotMachineBopper', 1335, 195);
    addAnimationByPrefix('barSlotMachineBopper', 'idle', 'Slot machine bopper idle0', 24, false);
    addAnimationByPrefix('barSlotMachineBopper', 'spin', 'Slot machine bopper spin0', 24, true);
    scaleObject('barSlotMachineBopper', 0.8, 0.8);
    addLuaSprite('barSlotMachineBopper');

    makeAnimatedLuaSprite('barSlotMachine', 'Bar/Background/BarSlotMachine', 1650, 200);
    addAnimationByPrefix('barSlotMachine', 'idle', 'Slot machine idle0', 24, true);
    scaleObject('barSlotMachine', 0.8, 0.8);
    addLuaSprite('barSlotMachine');

    makeAnimatedLuaSprite('unoPeople', 'Bar/Background/D2/unogaming', 730, 270);
    addAnimationByPrefix('unoPeople', 'idle', 'uno0', 24, false);
    scaleObject('unoPeople', 0.8, 0.8);
    addLuaSprite('unoPeople');
	
	makeLuaSprite('TABLEEE', 'Bar/Background/poool_tapble', 1200, 638)
	scaleObject('TABLEEE', 0.7, 0.7);
	addLuaSprite('TABLEEE')
	
	

    makeAnimatedLuaSprite('bartenderPot', 'Bar/Background/PotBartender', -765, 280);
    addAnimationByPrefix('bartenderPot', 'idle', 'Pot idle0', 24, false);
    addAnimationByPrefix('bartenderPot', 'fear', 'Pot fear0', 24, false);
    addAnimationByPrefix('bartenderPot', 'idle fear', 'Pot fear idle0', 24, false);
    scaleObject('bartenderPot', 0.78, 0.78);
    addLuaSprite('bartenderPot');
	

    makeAnimatedLuaSprite('barTopper', 'Bar/Background/BarTop', -400, -250);
    addAnimationByPrefix('barTopper', 'idle', 'Bartop0', 24, true);
    scaleObject('barTopper', 0.8, 0.8);
    addLuaSprite('barTopper');

    makeAnimatedLuaSprite('stoolBoppers', 'Bar/Background/D2/barboppers', -300, 400);
    addAnimationByPrefix('stoolBoppers', 'idle', 'barstools0', 24, false);
    scaleObject('stoolBoppers', 0.8, 0.8);
    addLuaSprite('stoolBoppers');


	-- additional stuff

	setProperty('camHUD.alpha', 0.0001)
	
end

function onCreatePost()
	if downscroll then -- fully conceals the text in black bars
	setProperty('timeTxt.y', getProperty('timeTxt.y')+5)
	setProperty('botplayTxt.y', getProperty('botplayTxt.y')+5)
	else
	setProperty('botplayTxt.y', getProperty('botplayTxt.y')-13)
	end
	
	makeLuaSprite('cinemababy', nil, 0, 0);
	makeGraphic('cinemababy', 1, 1, '000000');
	scaleObject('cinemababy', screenWidth, screenHeight, false)
	setObjectCamera('cinemababy', 'other');
	screenCenter('cinemababy')
	
	makeLuaSprite('yetdarker', nil, 0, 0);
	makeGraphic('yetdarker', 1, 1, '000000');
	scaleObject('yetdarker', screenWidth * 3, screenHeight * 3, false)
	--setObjectCamera('cinemababy', 'other');
	screenCenter('yetdarker')
	setProperty('yetdarker.alpha', 0.0001)
	addLuaSprite('yetdarker', false)
	setObjectOrder('yetdarker', getObjectOrder('gfGroup'))
	
	makeAnimatedLuaSprite('picofuckingburns', 'Bar/Characters/CPico/D2/picoburns', 800, 850)
	addAnimationByPrefix('picofuckingburns', 'idle', 'BURN MOTHERFUCKER0', 24, true);
	addAnimationByPrefix('picofuckingburns', 'idle-alt', 'uh oh no more burning0', 24, true);
	setObjectCamera('picofuckingburns', 'camGame')
	addLuaSprite('picofuckingburns', true)
	
	makeLuaSprite('candyvig', 'CandyShop/Background/Vignette', 0, 0)
	setObjectCamera('candyvig', 'camGame')
	setProperty('candyvig.alpha', 1)
	setScrollFactor('candyvig', 0, 0);
	setObjectOrder('candyvig', 15)
	scaleObject('candyvig', 1.5, 1.5)
	screenCenter('candyvig', 'XY')
	addLuaSprite('candyvig', true)
	
	makeLuaSprite('atticvig', 'CandyShop/Background/DreamVignettefix', 0, 0)
	setObjectCamera('atticvig', 'camHUD')
	addLuaSprite('atticvig')
	setProperty('atticvig.alpha', 0.0001);
	
	setObjectOrder('picofuckingburns', getObjectOrder('candyvig') - 1)
	
	--setProperty('dad.cameraPosition', {-50,90})
	--setProperty('boyfriend.cameraPosition', {0,112})
	
	doIntroStuff = true -- purely used this for debugging lolz
	if doIntroStuff then
	triggerEvent('Bars', '1', '0.0001')
	addLuaSprite('cinemababy', true);
	end
	
	barItems = {
	'barBG',
	'barSlotMachineBopper',
	'barSlotMachine',
	'unoPeople',
	'TABLEEE',
	'barTopper',
	'bartenderPot',
	'stoolBoppers',
	'picofuckingburns'
	}
	
	------------------ HALLUCINATION SHIT -----------------------------------
	
	schoolItems = {
	'schoolREAL',
	'schoolREALblood',
	'kids1',
	'kids2',
	'noose'
	}
	
	for _, thing in pairs(schoolItems) do
	makeLuaSprite(thing, 'Bar/Background/D2/School/'..thing, -600, 50)
    setProperty(thing..'.alpha', 0.0001)
	scaleObject(thing, 0.7, 0.7, false)
	addLuaSprite(thing, false)
	end
	setProperty('noose.x', 615)
	setProperty('noose.y', 160)

	
end
	
healthDrain = 0.0125

function opponentNoteHit()
	if getHealth() > healthDrain then
		if difficulty == 0 then
			addHealth(-healthDrain);
		else 
			addHealth(-healthDrain/2);
		end
	end
end

function beatHitDance(counter)
	if counter % 2 == 0 then
			objectPlayAnimation('stoolBoppers', 'idle', false);
			objectPlayAnimation('barTopper', 'idle', false);
			objectPlayAnimation('unoPeople', 'idle', false);
			objectPlayAnimation('bartenderPot', 'idle', false);
		if isNoteBoppin then playAnim('barSlotMachineBopper', 'spin', false) else playAnim('barSlotMachineBopper', 'idle', false); end
	end
end

function onCountdownTick(counter)
	beatHitDance(counter);
end

function onBeatHit()
	beatHitDance(curBeat);
	
	if isBoppin then
	setProperty('camGame.zoom', getProperty('camGame.zoom')+0.03)
	setProperty('camHUD.zoom', getProperty('camHUD.zoom')+0.03)
	end
	
end

firstSwitch = true

function onEvent(n, v1)
	if n == 'NoteBop' and tonumber(v1) == 1 then
	isNoteBoppin = true
	
	elseif n == 'NoteBop' then
	isNoteBoppin = false
	
	elseif n == 'School Hallucination' then
		
		if tonumber(v1) == 1 then
		
			setProperty('schoolREAL.alpha', 1)
			--setProperty('schoolREALblood.alpha', 1)
			--setProperty('kids1.alpha', 1)
			--setProperty('kid2.alpha', 1)
			--setProperty('noose.alpha', 1)
			
			for _, sprite in pairs(barItems) do
			setProperty(sprite..'.alpha', 0.0001)
			end
			
			setProperty('camHUD.alpha', 0.6)
			setProperty('health', 1)
			
			if firstSwitch then
			setProperty('atticvig.alpha', 1)
			setProperty('candyvig.alpha', 0)
			else
			
			setProperty('kids1.alpha', 1)
			setProperty('noose.alpha', 1)
			removeLuaSprite('schoolREAL', true)
			setProperty('schoolREALblood.alpha', 1)
			end
			
			firstSwitch = false
			
		elseif tonumber(v1) == 2 then
			removeLuaSprite('kids1', true)
			setProperty('kids2.alpha', 1)
			
			isBoppin = true
			
		elseif tonumber(v1) == 3 then
			for _, thing in pairs(schoolItems) do
			setProperty(thing..'.alpha', 0.0001)
			end
			
			for _, sprite in pairs(barItems) do
			setProperty(sprite..'.alpha', 1)
			end
			
			setProperty('camHUD.alpha', 1)
			removeLuaSprite('atticvig', true)
			setProperty('candyvig.alpha', 1)
			
			isBoppin = false
		end	
	
		
	end
end

function onSongStart()
	doTweenAlpha('thegames', 'cinemababy', 0.0001, 9 / playbackRate, 'cubeInOut')
end

function onStepHit()
	if curStep >= 128 and not shownHud then
	shownHud = true
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	doTweenAlpha('thehuds', 'camHUD', 1, 7 / playbackRate, 'expoOut')
	
	setProperty('cinemababy.alpha', 0.0001)
	
	setProperty('dad.cameraPosition', {-135, -40})
	setProperty('boyfriend.cameraPosition', {135, -40})
	setProperty('defaultCamZoom', 0.7)
	
	elseif curStep == 256 then
	--default: 420, -10
	cameraFlash('camOther', 'ffffff', 2 / playbackRate, true)
	
	setProperty('dad.cameraPosition', {370, 20})
	healthDrain = 0
	
	for i = 4, 7 do
	setProperty('strumLineNotes.members['..i..'].alpha', 0)
	end
	
	elseif curStep == 304 then
		
		for i = 4, 7 do
			noteTweenAlpha('hellonote'..i, i, 1, 3 / playbackRate, 'cubeInOut')
		end
	
	elseif curStep == 320 then

	
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	playAnim('picofuckingburns', 'idle-alt', true)
	
	healthDrain = 0.02
	
	removeLuaSprite('nenesplash', true)
	
	elseif curStep == 576 then
	cameraFlash('camOther', 'ffffff', 1.5 / playbackRate, true)
	setProperty('yetdarker.alpha', 0.15)
	healthDrain = 0
	
	for i = 4, 7 do
	setProperty('strumLineNotes.members['..i..'].alpha', 0)
	end
	
	
	elseif curStep == 632 then 
	
	for i = 4, 7 do
	noteTweenAlpha('hellonote'..i, i, 1, 5 / playbackRate, 'cubeOut')
	end
	
	
	
	
	elseif curStep == 640 then
	setProperty('dad.cameraPosition', {420, -10})
	
	doTweenZoom('hellomario', 'camGame', 0.95, 1.2 / playbackRate, 'cubeOut')
	setProperty('defaultCamZoom', 0.95)
	
	doTweenAlpha('heappears', 'boyfriend', 1, 1 / playbackRate, 'cubeOut')
	doTweenAlpha('heappears2', 'iconP1', 1, 1 / playbackRate, 'cubeOut')
	
	healthDrain = 0.025
	
	elseif curStep == 686 then
	neneGhostCam = getProperty('dad.cameraPosition')
	setProperty('dad.cameraPosition', {getProperty('dad.cameraPosition[0]') - 200, getProperty('dad.cameraPosition[1]')})
	
	elseif curStep == 704 then
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	
	healthDrain = 0.008
	setProperty('healthGain', 2)
	
	elseif curStep == 718 then
	setProperty('dad.cameraPosition', neneGhostCam) -- revert camera change
	
	elseif curStep == 816 then
	isBoppin = false
	
	elseif curStep >= 832 and not stoppedFX then
	stoppedFX = true
	--cameraFlash('camOther', 'ffffff', 0.5 / playbackRate, true)
	removeLuaSprite('picofuckingburns', true)
	removeLuaSprite('yetdarker', true)
	
	runHaxeCode('FlxG.camera.stopFX();')
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..0.5 / playbackRate..', true);')
	
	healthDrain = 0.015
	setProperty('healthGain', 1)
	
	elseif curStep == 1008 then
		doTweenZoom('zoom1', 'camGame', 0.88, 0.6 / playbackRate, 'cubeOut')
	
	elseif curStep == 1012 then
		doTweenZoom('zoom1', 'camGame', 0.93, 0.6 / playbackRate, 'cubeOut')
	
	elseif curStep == 1016 then
		doTweenZoom('zoom1', 'camGame', 1, 1 / playbackRate, 'cubeOut')
	
	elseif curStep == 1196 then
		setProperty('boyfriend.cameraPosition[0]', getProperty('boyfriend.cameraPosition[0]') + 100)
	
	elseif curStep == 1216 then
	cameraFlash('camOther', 'ffffff', 0.5 / playbackRate, true)
	setProperty('cinemababy.alpha', 1)
	end
end