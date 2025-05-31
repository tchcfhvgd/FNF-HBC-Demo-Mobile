function onCreate()
	precacheSound('smoke')
	playSound('smoke', 0.0001)
	
	makeAnimatedLuaSprite('snote1', 'Bar/ChudSmokeNotes', 0, 0)
	setObjectCamera('snote1', 'other')
	setProperty('snote1.alpha', 0.0001)
	addLuaSprite('snote1', true)
	
	makeAnimatedLuaSprite('snote2', 'Bar/ChudSmokeNotesALT', 0, 0)
	setObjectCamera('snote2', 'other')
	setProperty('snote2.alpha', 0.0001)
	addLuaSprite('snote2', true)
	
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'smokeNote' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Bar/ChudSmokeNotes'); --Change notetexture
			
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true)
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true)
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', -0.1)

			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); -- make it so original character doesn't sing these notes

			
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
end

function onCreatePost()
	makeAnimatedLuaSprite('smokescreen', 'Bar/Background/D2/smokescreen', 0, 0)
	addAnimationByPrefix('smokescreen', 'idle', 'smoke', 32, true)
	setObjectCamera('smokescreen', 'camOther')
	scaleObject('smokescreen', 5, 2.8126, false)
	screenCenter('smokescreen', 'XY')
	addLuaSprite('smokescreen')
	setProperty('smokescreen.alpha', 0.0001) 
	
	makeLuaSprite('smokevig', 'CandyShop/Background/Vignette', 0, 0)
	setObjectCamera('smokevig', 'camOther')
	screenCenter('smokevig', 'XY')
	addLuaSprite('smokevig', true)
	setProperty('smokevig.alpha', 0.0001)
end

function onSpawnNote()
	if curBeat > 202 and getProperty('notes.members[0].noteType') == 'smokeNote' then
		setProperty('notes.members[0].texture', 'Bar/ChudSmokeNotesALT')
		setProperty('notes.members[0].hitHealth', -0.08)
	end
end

local smokeStage = 0 -- 0 = No smoke present

function goodNoteHit(i, _, t)
	if t == 'smokeNote' then
		smokeStage = smokeStage + 1
		
		cancelTween('showSmoke1')
		cancelTween('showSmoke2')
		
		cancelTween('hideSmoke1')
		cancelTween('hideSmoke2')
		
		cancelTimer('smokeExists')
		
		if smokeStage <= 1 then -- Stage 1 is Some smoke present
		
			doTweenAlpha('showSmoke1', 'smokescreen', 0.4, 0.5 / playbackRate, 'cubeInOut')
			doTweenAlpha('showSmoke2', 'smokevig', 0.4, 0.5 / playbackRate, 'cubeInOut')

			runTimer('smokeExists', 2 / playbackRate) -- More forgiving timer if you only hit one
			
		elseif smokeStage == 2 then -- 2 is more smoke
	
			doTweenAlpha('showSmoke1', 'smokescreen', 0.6, 1 / playbackRate, 'cubeInOut')
			doTweenAlpha('showSmoke2', 'smokevig', 0.6, 1 / playbackRate, 'cubeInOut')
			
			runTimer('smokeExists', 2.6 / playbackRate)
			
		elseif smokeStage == 3 then -- 3 is alost completely obscured
	
			doTweenAlpha('showSmoke1', 'smokescreen', 0.8, 1 / playbackRate, 'cubeInOut')
			doTweenAlpha('showSmoke2', 'smokevig', 0.8, 1 / playbackRate, 'cubeInOut')
			
			runTimer('smokeExists', 3 / playbackRate)
			
		elseif smokeStage >= 4 then -- 4 is literally fucking cant see anything lmfao
	
			doTweenAlpha('showSmoke1', 'smokescreen', 0.94, 1 / playbackRate, 'cubeInOut')
			doTweenAlpha('showSmoke2', 'smokevig', 0.94, 1 / playbackRate, 'cubeInOut')

			runTimer('smokeExists', 3.25 / playbackRate)
			
		end
		
		
		
		------------misc stuff--------------
		
		addMisses(1) --Doesn't use hitCausesMiss so that the smoke sound can be heard
		
		if getPropertyFromGroup('notes', i, 'texture') == 'Bar/ChudSmokeNotesALT' then
		playSound('smoke', 0.9)
		
		else
		playSound('smoke', 1)
		
		end
		
	end
end

function onTimerCompleted(tag)
	if tag == 'smokeExists' then
		smokeStage = 0
		
		cancelTween('hideSmoke1')
		cancelTween('hideSmoke2')
		
		doTweenAlpha('hideSmoke1', 'smokescreen', 0, 	(2 + smokeStage/2) 	/ playbackRate, 'cubeInOut')
		doTweenAlpha('hideSmoke2', 'smokevig', 0, 	(2 + smokeStage/2) 	/ playbackRate, 'cubeInOut')
	end
end

function onEvent(n)
	if n == 'School Hallucination' then
		smokeStage = 0
		
		cancelTween('showSmoke1')
		cancelTween('showSmoke2')
		
		cancelTween('hideSmoke1')
		cancelTween('hideSmoke2')
		
		cancelTimer('smokeExists')
		
		setProperty('smokescreen.alpha', 0)
		setProperty('smokevig.alpha', 0)
	end
end