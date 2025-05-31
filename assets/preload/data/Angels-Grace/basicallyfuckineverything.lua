-- this was gonna be just hpdrain but now im doing a bunch of other stuff wtf

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
    if isStoryMode and not seenCutscene then
		if playVideo then --Video cutscene plays first
			runTimer('whoops', 0.2)
			return Function_Stop; --Prevents the song from starting naturally
		end
	end
	
	function onUpdatePost(elapsed)
	
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoops' then
	startVideo('PicoD3'); --Play video file from "videos/" folder
	playVideo = false;
	elseif tag == 'flashFailsafe' then
	runHaxeCode('FlxG.camera.stopFX();')
	end
end

function onCreatePost()
setProperty('camHUD.alpha', 0.0001)
triggerEvent('Hide HUD', 0, 0.0001)
	if songName == 'Angels Grace' then
	playSound('darnellsavestheday', 0.00001)
	playSound('slash', 0.00001)
		makeLuaSprite('text1', 'court/angeltext/text1', 0, 0)
		scaleObject('text1', 1, 1, false)
		setObjectOrder('text1', 69)
		setScrollFactor('text1', 0, 0)
		screenCenter('text1', 'XY')
		setObjectCamera('text1', 'camOther')
		addLuaSprite('text1', true)
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
		end
end

function opponentNoteHit()
	if getHealth() > healthDrain then
		if difficulty == 0 then
			addHealth(-healthDrain);
		else 
			addHealth(-healthDrain/2);
		end	
	end
end
		
function flashCam()
	runHaxeCode('FlxG.camera.stopFX();')
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	runTimer('flashFailsafe', 1.05 / playbackRate)
end

function onBeatHit()
	
	if curBeat == 5 then
		if getProperty('timeTxt') then
			doTweenAlpha('notimetxt', 'timeTxt', 0.0001, 0.1 / playbackRate, 'cubeInOut');
		end
	end
	
	if curBeat == 9 then
	triggerEvent('Hide HUD', 0, 0.0001)
	end
	
	if curBeat >= 10 and not hudShown then
		hudShown = true
		setProperty('camHUD.alpha', 1)
	end

	if curBeat >= 28 and not shownGame then
	shownGame = true
	doTweenAlpha('fadeinGame', 'camGame', 1, 1.8 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 64 then
		healthDrain = 0.024
		
		flashCam()
	end
	
	if curBeat == 256 then
		setProperty('healthGain', 0.65);
		setProperty('defaultCamZoom', 1.05);
		doTweenAlpha('ev1', 'text1', 1, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 259 then
		doTweenAlpha('byeev1', 'text1', 0, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 288 then
		setProperty('defaultCamZoom', 0.9);
		doTweenAlpha('ev2', 'text2', 1, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 291 then
		doTweenAlpha('byeev2', 'text2', 0, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 320 then
		healthDrain = 0
		playSound('darnellsavestheday', 1) -- just a louder version of the og fire sound
		--cameraShake('camGame', 0.014, 0.25) -- originally 0.007, 0.25 thought it was too weak
		triggerEvent('Screen Shake', '0.25, 0.007', '')
	end
	
	if curBeat == 348 then
		healthDrain = 0.02
	end
	
	if curBeat == 384 then
		healthDrain = 0.018
		setProperty('healthGain', 1)
		flashCam()
	end
	
	if curBeat == 416 then
		healthDrain = 0.016
		doTweenAlpha('ev3', 'text3', 1, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 419 then
		doTweenAlpha('byeev3', 'text3', 0, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 424 then
		doTweenAlpha('ev4', 'text4', 1, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 427 then
	doTweenAlpha('byeev4', 'text4', 0, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 448 then
		healthDrain = 0.014
		flashCam()
	end
	
	if curBeat == 480 then
		healthDrain = 0.012
	end
	
	if curBeat == 512 then
		healthDrain = 0.01
		flashCam()
	end
	
	if curBeat == 544 then
	doTweenAlpha('ev5', 'text5', 1, 1 / playbackRate, 'cubeInOut');
	end
	
	if curBeat == 547 then
	doTweenAlpha('byeev5', 'text5', 0, 1 / playbackRate, 'cubeInOut');
	end
end