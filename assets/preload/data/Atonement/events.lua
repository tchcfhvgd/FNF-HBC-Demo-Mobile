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
			runTimer('heykiddos', 0.2)
			return Function_Stop; --Prevents the song from starting naturally
		end
	end
	
	function onUpdatePost(elapsed)
	
	end
	setProperty('camHUD.alpha', 1)
	setProperty('camGame.alpha', 1)
	doTweenAlpha('gaming', 'blackOverlay', 0, 1 / playbackRate, 'linear')
	
	return Function_Continue; --Played video and dialogue, now the song can start normally
end


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
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'heykiddos' then
	startVideo('SpookersD2'); --Play video file from "videos/" folder
	playVideo = false;
	end
end
-- song shit starts here woo!!!!!
function onBeatHit()
	if curBeat == 190 then
	--omg the real hbcbf
	doTweenZoom("zoomies", "camGame", 0.9, 1.5 / playbackRate, 'cubeOut')
	setProperty('defaultCamZoom', 0.9)
	health = getProperty('health')
	setProperty('health', 1)
	doTweenAlpha('showhbar', 'healthBar', 1, 1 / playbackRate, 'cubeInOut')
	doTweenAlpha('showhbarbg', 'healthBarBG', 1, 1 / playbackRate, 'cubeInOut')
	doTweenAlpha('showicon1', 'iconP1', 1, 1 / playbackRate, 'cubeInOut')
	doTweenAlpha('showicon2', 'iconP2', 1, 1 / playbackRate, 'cubeInOut')
	end

	if curBeat == 256 then
		health = getProperty('health')
		setProperty('health', 1)
		function opponentNoteHit()
		-- nope
		end
		setProperty('defaultCamZoom', 0.75)
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	end
	
	if curBeat == 392 then
		function opponentNoteHit()
			if getHealth() > 0.02 then
				if difficulty == 0 then
					addHealth(-0.02)
				else 
					addHealth(-0.01)
				end
			end
		end
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	end
	
end

function opponentNoteHit()
	if getHealth() > 0.02 then
		if difficulty == 0 then
			addHealth(-0.02)
		else 
			addHealth(-0.01)
		end
	end
end