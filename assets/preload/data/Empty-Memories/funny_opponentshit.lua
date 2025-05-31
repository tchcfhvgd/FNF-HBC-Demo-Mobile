function onCreatePost()
	for i = 0, 3 do
	setPropertyFromGroup('strumLineNotes', i, 'visible', false)
	end
	
	setProperty('dad.alpha', 0.0001)
	setProperty('gf.alpha', 0.0001)
	
	dadX = getProperty('dad.x')
	dadY = getProperty('dad.y')
	
	gfX = getProperty('gf.x')
	gfY = getProperty('gf.y')
end

function onSongStart()
	for i = 0, 3 do
	setPropertyFromGroup('strumLineNotes', i, 'visible', true)
	setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.0001)
	end
end

function onUpdatePost() -- Realized the notes dont get hidden on higher playback speeds?? weird
	if curBeat < 10 then
		for i = 0, 3 do
			--setPropertyFromGroup('strumLineNotes', i, 'visible', true)
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.0001)
		end
	end
end

function onSpawnNote()
	if not getProperty('notes.members[0].mustPress') then
		
		
		if not notesVisible then
		showOppoStrums()
		end
		
		cancelTimer('oppoSinging')
		runTimer('oppoSinging', 2.8 / playbackRate)
		
	end
end

function onTimerCompleted(tag)
	if tag == 'oppoSinging' then
			hideOppoStrums()
	
	
	
	elseif tag == 'showOppoStrums' then -- Needed to delay the transition
			for i = 0, 3 do
				noteTweenAlpha('show'..i, i, 0.3, duration / playbackRate, 'cubeInOut')
			end
	
	
	
	end
end

function opponentNoteHit(i, d, t, s)
	if t == 'GF Sing' and not s then --pump singing
	memoryFlash('gf')
	gfSinging = true
	
	elseif not s then --skid singing
	memoryFlash('dad')
	dadSinging = true
	
	end
end


-- functions
duration = 0.5
hideDuration = 1

function showOppoStrums()
	notesVisible = true
	
	if canTween then
	
	runTimer('showOppoStrums', 1 / playbackRate)
	
	end
end

function hideOppoStrums()
	notesVisible = false
	if canTween then
	
	for i = 0, 3 do
		noteTweenAlpha('hide'..i, i, 0.0001, hideDuration / playbackRate, 'cubeInOut')
	end
	
	end
end


function memoryFlash(character)
	
	if character == 'dad' and not dadSinging then -- Skid
		setProperty('dad.x', getRandomInt(dadX+20, dadX+140))
		setProperty('dad.y', getRandomInt(dadY-100, dadY+80))
	
	elseif character == 'gf' and not gfSinging then -- Pump
		if not inStage4 then setProperty('gf.x', getRandomInt(gfX-115, gfX+95)) else setProperty('gf.x', getRandomInt(gfX-20, gfX+95)) end
		setProperty('gf.y', getRandomInt(gfY-85, gfY+130))
	end
	
	if character == 'dad' and canTween or character == 'gf' then -- Prevent tween from happening to skid near end s4
	doTweenAlpha('show '..character, character, 0.4, duration / playbackRate, 'cubeInOut')
	end
	
	if curBeat >= 385 then
	canTween = false
	end
	
end

canTween = true
function onUpdate()
	if dadSinging and getProperty('dad.animation.curAnim.finished') and canTween then
		dadSinging = false
		doTweenAlpha('hide dad', 'dad', 0, 0.7 / playbackRate, 'cubeInOut')
	end
	
	if gfSinging and getProperty('gf.animation.curAnim.finished') then
		gfSinging = false
		doTweenAlpha('hide gf', 'gf', 0, 0.7 / playbackRate, 'cubeInOut')
	end
	
end

function onTweenCompleted(tag)
	if tag == 'hide dad' then
	setProperty('dad.x', 0)
	setProperty('dad.y', 0)
	
	elseif tag == 'hide gf' then
	setProperty('gf.x', 0)
	setProperty('gf.y', 0)
	
	end
end

function onEvent(n, v1)
	if n == 'lila depression' and tonumber(v1) == 4 then
		inStage4 = true
	
	elseif n == 'lila depression' and tonumber(v1) == 5 then
		setProperty('dad.visible', false) -- Hide Skid
		setProperty('gf.visible', false) -- Hide Pump
		
		for i = 0, getProperty('notes.length')-1 do
			if not getProperty('notes.members['..i..'].mustPress') then
				setProperty('notes.members['..i..'].visible', false) -- Hide opponent notes
			end
		end
		
		for i = 0, 3 do
			setProperty('strumLineNotes.members['..i..'].visible', false) -- Hide opponent strums
		end
		
	end
end

function onBeatHit()
	if curBeat == 387 then
	doTweenAlpha('memoryfades', 'dad', 0, 7 / playbackRate, 'linear')
		for i = 0, 3 do
			noteTweenAlpha('kill'..i, i, 0, 7 / playbackRate, 'linear')
		end
	end
end