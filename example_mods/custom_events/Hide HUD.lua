function onEvent(name, value1, value2)	
	if name == "Hide HUD" then
	local showman = tonumber(value1)
	local waitime = tonumber(value2)
		if showman == 0 then
		
	
		doTweenAlpha('hidetbarbg', 'timeBarBG', 0.0001, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('hidetbar', 'timeBar', 0.0001, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('hidehbarbg', 'healthBarBG', 0.0001, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('hidehbar', 'healthBar', 0.0001, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('hideP1', 'iconP1', 0.0001, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('hideP2', 'iconP2', 0.0001, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('hidescore', 'scoreTxt', 0.0001, waitime / playbackRate, 'cubeInOut');
		if getProperty('timeTxt') then
			doTweenAlpha('hidetimetxt', 'timeTxt', 0.0001, waitime / playbackRate, 'cubeInOut');
		end
		
		if getPropertyFromClass('Main', 'fpsVar.visible') and botPlay and waitime <= 0.1 then -- Confirms user is not in ShowcaseMode
		setProperty('botplayTxt.visible', false)
		end
		
		for index = 0, 7 do 
		noteTweenAlpha('noteTween'..index, index, 0.0001, waitime / playbackRate, 'cubeInOut');
		end
		
		end
		
		if showman == 1 then
		doTweenAlpha('showtbarbg', 'timeBarBG', 1, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('showtbar', 'timeBar', 1, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('showhbarbg', 'healthBarBG', 1, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('showhbar', 'healthBar', 1, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('showP1', 'iconP1', 1, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('showP2', 'iconP2', 1, waitime / playbackRate, 'cubeInOut');
		doTweenAlpha('showscore', 'scoreTxt', 1, waitime / playbackRate, 'cubeInOut');
		
		if not middlescroll then
			for index = 0, 7 do 
			noteTweenAlpha('noteTween'..index, index, 1, waitime / playbackRate, 'cubeInOut');
			end
		else
			for index = 0, 3 do 
			noteTweenAlpha('noteTween'..index, index, 0.35, waitime / playbackRate, 'cubeInOut');
			end
			for index2 = 4, 7 do 
			noteTweenAlpha('noteTween'..index2, index2, 1, waitime / playbackRate, 'cubeInOut');
			end
		end
		
		if getProperty('timeTxt') then
			doTweenAlpha('showtimetxt', 'timeTxt', 1, waitime / playbackRate, 'cubeInOut');
		end
		
		if getPropertyFromClass('Main', 'fpsVar.visible') and botPlay then
		setProperty('botplayTxt.visible', true)
		end
		
		end
		end
end