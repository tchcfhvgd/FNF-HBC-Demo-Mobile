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
    if not seenCutscene and playVideo then
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
	startVideo('star_this_video'); --Play video file from "videos/" folder
	playVideo = false;
	end
end

function onCreatePost()
	if not seenCutscene then
	setProperty('camHUD.alpha', 0.0001)
	setProperty('camGame.alpha', 0.0001)
	end
end
-- ############## intro cutscene ###########

function onCreate()
	makeLuaSprite('discord', 'discord/discordcall', -50, 0)
	addLuaSprite('discord', false)
	setScrollFactor('discord', 1, 1);
	scaleObject('discord', 1.4, 1.4);
	
	makeAnimatedLuaSprite('defsplash', 'noteSplashes', 0, 0) --splash precache
	setObjectCamera('defsplash', 'camOther')
	setProperty('defsplash.alpha', 0.0001);
	addLuaSprite('defsplash', true)
	
	
	
	makeLuaSprite('blackOverlay', nil, 0, 0);
	makeGraphic('blackOverlay', 1, 1, '000000');
	scaleObject('blackOverlay', screenWidth, screenHeight, false)
	setObjectCamera('blackOverlay', 'other');
	setProperty('blackOverlay.alpha', 0.0001);
	screenCenter('blackOverlay')
	addLuaSprite('blackOverlay', true);
	
	if not seenCutscene then
		setProperty('blackOverlay.alpha', 1)
	end
end