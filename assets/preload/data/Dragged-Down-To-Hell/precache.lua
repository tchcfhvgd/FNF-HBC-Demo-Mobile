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
			runTimer('whoops', 0.1)
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

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoops' then
	startVideo('Prologue'); --Play video file from "videos/" folder
	playVideo = false;
	end
end


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
	addCharacterToList('LEMONE', 'dad')
	addCharacterToList('LEMONE2', 'dad')
	
	if isStoryMode and not seenCutscene then
	setProperty('camHUD.alpha', 0.0001)
	setProperty('camGame.alpha', 0.0001)
	end
	
	makeAnimatedLuaSprite('lemonsplash', 'HellGates/HellNoteSplashes', 0, 0)
	setObjectCamera('lemonsplash', 'camOther')
			setProperty('lemonsplash.alpha', 0.0001)
			addLuaSprite('lemonsplash')
			
	makeAnimatedLuaSprite('lemonnote2', 'HellGates/HellNoteAssets2', 0, 0)
	setObjectCamera('lemonnote2', 'camOther')
			setProperty('lemonnote2.alpha', 0.0001);
			addLuaSprite('lemonnote2', true)
			screenCenter('lemonnote2', 'XY')
			
	makeAnimatedLuaSprite('lemonnote3', 'HellGates/HellNoteAssets3', 0, 0)
	setObjectCamera('lemonnote3', 'camOther')
			setProperty('lemonnote3.alpha', 0.0001);
			addLuaSprite('lemonnote3', true)
			screenCenter('lemonnote3', 'X')
			
	makeAnimatedLuaSprite('confusedhell', 'HellGates/Background/ConfusedHellPeople', -200, 0)
	setObjectCamera('confusedhell', 'camOther')
			setProperty('confusedhell.alpha', 0.0001);
			addAnimationByPrefix('confusedhell', 'idle', 'ConfusedBop', 24, true)
			scaleObject('confusedhell', 0.5, 0.5, false)
			addLuaSprite('confusedhell')
			
	makeAnimatedLuaSprite('corrupthell', 'HellGates/Background/CorruptedHellPeople', -200, 100)
	setObjectCamera('corrupthell', 'camOther')
			setProperty('corrupthell.alpha', 0.0001);
			addAnimationByPrefix('corrupthell', 'idle', 'CorruptedBop', 24, true)
			scaleObject('corrupthell', 0.5, 0.5, false)
			addLuaSprite('corrupthell')

end

function onCountdownTick(counter)
	if counter == 0 then
	characterPlayAnim('dad', 'woope', true);
	checked = true
	
	elseif counter == 3 then
		songStarted = true
	
	end
	
end

function onUpdate()
	if checked and getProperty('dad.animation.curAnim.finished') and not songStarted then
		triggerEvent('Change Character', 'dad', 'LEMONE')
	end
end