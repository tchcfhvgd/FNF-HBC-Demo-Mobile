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

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoops' then
	startVideo('SpookersD1fix'); --Play video file from "videos/" folder
	playVideo = false;
	end
end
--intro cutscene


endVideo = true
function onEndSong()
	if isStoryMode and endVideo then
	startVideo('SpookersD1End')
	endVideo = false
	return Function_Stop
	end
return Function_Continue
end

-------------------------cutscene stuff----------------------

-- cutscene stuff
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
	setProperty('gf.alpha', 0.0001)
	
	-- funni splash precache
	makeLuaSprite('spookysplash', 'CandyShop/SpookyNoteSplashes', 0, 0)
	setObjectCamera('spookysplash', 'camOther')
			setProperty('spookysplash.alpha', 0.0001);
			addLuaSprite('spookysplash')
			
	makeLuaSprite('candyShop', 'CandyShop/Background/CandyShop', -300, 200)
	scaleObject('candyShop', 0.88, 0.88, true)
	addLuaSprite('candyShop', false)
			
	makeLuaSprite('candyWall', 'CandyShop/Background/CandyShopWall', -560, 175)
	--scaleObject('candyWall', 0.88, 0.88, false)
	addLuaSprite('candyWall', false)
	
	makeLuaSprite('backCounter', 'CandyShop/Background/BackCounter', -300, 200)
	scaleObject('backCounter', 0.9, 0.9, true)
	addLuaSprite('backCounter', false)
	
	makeLuaSprite('frontCounter', 'CandyShop/Background/FrontCounter', -300, 200)
	scaleObject('frontCounter', 0.9, 0.9, true)
	addLuaSprite('frontCounter', true)
	
	--hud
	
	makeLuaSprite('candyvig', 'CandyShop/Background/Vignette', 0, 0)
	setObjectOrder('candyvig', 2)
	setObjectCamera('candyvig', 'camHUD')
	addLuaSprite('candyvig', true)
	
	makeLuaSprite('visitText', 'CandyShop/Background/Text/Visit', 0, 0) -- visit a fren
	setObjectCamera('visitText', 'camHUD')
	screenCenter('visitText')
	setObjectOrder('visitText', 1)
	setProperty('visitText.alpha', 0.0001)
	addLuaSprite('visitText', true)

	
	if isStoryMode and not seenCutscene then
	setProperty('camHUD.alpha', 0.0001)
	setProperty('camGame.alpha', 0.0001)
	end
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
		
shopItems = {
	'candyShop',
	'candyWall',
	'backCounter',
	'frontCounter'
	}
	
function onBeatHit()
		
	if curBeat == 122 then
		doTweenAlpha('visit_a_fren', 'visitText', 1, 1 / playbackRate, 'cubeInOut')
		
	elseif curBeat == 125 then
		doTweenAlpha('nowvisitingtheredman', 'visitText', 0, 1 / playbackRate, 'cubeInOut')
		
	elseif curBeat == 128 then
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..8 / playbackRate..', true);')
		
		setProperty('gf.alpha', 1)
		
		for _, item in pairs(shopItems) do
		setProperty(item..'.alpha', 0.0001)
		end
		
		healthDrain = 0
		setHealth(1)
		
		setProperty('defaultCamZoom', 0.75)
		
	elseif curBeat >= 192 and not fixed then
	fixed = true
		setProperty('gf.alpha', 0.0001)
		
		for _, item in pairs(shopItems) do
		setProperty(item..'.alpha', 1)
		end
		
		setProperty('defaultCamZoom', 0.9)
		healthDrain = 0.03
		setHealth(0.03)
		
		setProperty('dad.cameraPosition', {getProperty('dad.cameraPosition[0]'),getProperty('dad.cameraPosition[1]')-20})
		setProperty('boyfriend.cameraPosition', {getProperty('boyfriend.cameraPosition[0]')+35,getProperty('boyfriend.cameraPosition[1]')-10})
	
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
		
	elseif curBeat == 256 then
		setProperty('defaultCamZoom', 1)
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	
	elseif curBeat == 298 and isStoryMode then
		-- fade out for the cutscene
		cameraFade('camHUD', '000000', 1 / playbackRate, true)
	end
end