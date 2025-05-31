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
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoops' then
	startVideo('kmsweekreal'); --Play video file from "videos/" folder
	playVideo = false;
	end
end

function onCreatePost()
	if isStoryMode and not seenCutscene then
	setProperty('camHUD.alpha', 0.0001)
	setProperty('camGame.alpha', 0.0001)
	end
end