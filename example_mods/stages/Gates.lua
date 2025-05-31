function onCreate()
	makeLuaSprite('backCity', 'HellGates/Background/BackCity', -540, -100)
	addLuaSprite('backCity', false)
	
	makeAnimatedLuaSprite('lava', 'HellGates/Background/HellGateLava', -540, -100)
	setObjectOrder('lava', 1)
	addAnimationByPrefix('lava', 'idle', 'LavaFall', 24, true)
	playAnim('lava', 'idle', true)
	addLuaSprite('lava', false)
	
	makeLuaSprite('frontCity', 'HellGates/Background/FrontCity', -540, -80)
	addLuaSprite('frontCity', false)
	setObjectOrder('frontCity', 2)
	
	makeLuaSprite('gate', 'HellGates/Background/MainGate', -540, -120)
	addLuaSprite('gate', false)
	setObjectOrder('gate', 3)
	
	makeAnimatedLuaSprite('hellPeople1', 'HellGates/Background/NormalHellPeople', -120, 165)
	setObjectOrder('hellPeople1', 4)
	addAnimationByPrefix('hellPeople1', 'idle', 'NormalBop', 24, false)
	addLuaSprite('hellPeople1', false)
	
	makeAnimatedLuaSprite('hellPeople2', 'HellGates/Background/ConfusedHellPeople', -120, 165)
	setObjectOrder('hellPeople2', 5)
	addAnimationByPrefix('hellPeople2', 'idle', 'ConfusedBop', 24, false)
	setProperty('hellPeople2.alpha', 0.0001)
	addLuaSprite('hellPeople2', false)
	
	makeAnimatedLuaSprite('hellPeople3', 'HellGates/Background/CorruptedHellPeople', -120, 165)
	setObjectOrder('hellPeople3', 6)
	addAnimationByPrefix('hellPeople3', 'idle', 'CorruptedBop', 24, false)
	setProperty('hellPeople3.alpha', 0.0001)
	addLuaSprite('hellPeople3', false)
	
	makeAnimatedLuaSprite('lights', 'HellGates/Background/GateLights', 155, -30)
	setObjectOrder('lights', 7)
	addAnimationByPrefix('lights', 'idle', 'Flick', 24, true)
	playAnim('lights', 'idle', true)
	addLuaSprite('lights', false)
	
end

function onCreatePost()
		makeLuaText('enjoy', "Enjoy The Ride\nBoyfriend", screenWidth, 0, 0) --Finale text
		setTextFont('enjoy', 'Apocalypse Grunge.ttf')
		setTextAlignment('enjoy', 'center')
		setTextColor('enjoy', '8a0103')
		setTextBorder('enjoy', 1, '000000')
		setTextSize('enjoy', '70')
		setProperty('enjoy.alpha', 0.0001)
		
		setObjectCamera('enjoy', 'camOther')
		screenCenter('enjoy')
		setProperty('enjoy.y', getProperty('enjoy.y')+55) --lol
		addLuaText('enjoy')
end

function onCountdownTick()
	playAnim('hellPeople1', 'idle', true)
end

function onBeatHit()
	if curBeat <= 80 then playAnim('hellPeople1', 'idle', true) end
	if curBeat <= 112 then playAnim('hellPeople2', 'idle', true) end
	if curBeat <= 144 then playAnim('hellPeople3', 'idle', true) end
	
	if curBeat >= 80 and not removed1 then
	removed1 = true
		removeLuaSprite('hellPeople1', true)
		setProperty('hellPeople2.alpha', 1)
	
	elseif curBeat >= 112 and not removed2 then
	removed2 = true
		removeLuaSprite('hellPeople2', true)
		setProperty('hellPeople3.alpha', 1)
	
	elseif curBeat >= 144 and not removed3 then
	removed3 = true
		removeLuaSprite('hellPeople3', true)
	
	end
	
end

curHealthGain = 0
curHealthDrain = 0

intenseZoom = false 

function onUpdate(elapsed)
elapsed = elapsed / playbackRate

	if getHealth() > 0.1 then 
		if curHealthDrain == 1 then 
			if difficulty == 0 then
				addHealth((-elapsed / 20) * curHealthDrain) 
			else 
				addHealth((-elapsed / 40) * curHealthDrain) 
			end 
		
		elseif curHealthDrain == 2 then 
			if difficulty == 0 then
				addHealth((-elapsed / 13.6) * curHealthDrain) 
			else 
				addHealth((-elapsed / 26) * curHealthDrain) 
			end 
		
		elseif curHealthDrain == 3 then 
			if difficulty == 0 then
				addHealth((-elapsed / 12) * curHealthDrain) 
			else 
				addHealth((-elapsed / 24) * curHealthDrain) 
			end 
		
		elseif curHealthDrain == 4 then 
			if difficulty == 0 then
				addHealth((-elapsed / 10) * curHealthDrain) 
			else 
				addHealth((-elapsed / 20) * curHealthDrain) 
			end 
		
		end
		
	end
	
	if intenseZoom then
		setProperty('camGame.scroll.x', 434.5)
		setProperty('camGame.scroll.y', 486.78)
		setProperty('camFollowPos.x', 1074)
		setProperty('camFollowPos.y', 846.03)
		setProperty('camFollow.x', 1074)
		setProperty('camFollow.y', 846.03)

		setProperty('isCameraOnForcedPos', true)
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + (elapsed/10))
		
	end
	
	
end

function onGameOver()
	intenseZoom = false
end

function onStepHit()
	if curStep >= 320 and not health1 then
	health1 = true
	
	curHealthGain = 1
	curHealthDrain = 1
	
	elseif curStep >= 448 and not health2 then
	health2 = true
	
	curHealthGain = 2
	curHealthDrain = 2
	
	elseif curStep >= 576 and not health3 then
	health3 = true
	
	curHealthGain = 3
	curHealthDrain = 3
	
	elseif curStep >= 704 and not health4 then
	health4 = true
	
	curHealthGain = 4
	curHealthDrain = 4
	
	
	
	elseif curStep >= 800 and not lastPart then
	lastPart = true
		setProperty('defaultCamZoom', 0.98)
		
		cameraFlash('camOther','ffffff', 1 / playbackRate, true)
		if not downscroll then setProperty('timeTxt.y', 10) end
		setProperty('timeTxt.alpha', 0.5)
		
		setProperty('botplayTxt.visible', false)
		
		for i = 0, 3 do
			setProperty('strumLineNotes.members['..i..'].alpha', 0)
			
			setProperty('strumLineNotes.members['..(i+4)..'].x', 420+(i*110))
		end
	
		setProperty('camZooming', true)
		intenseZoom = true
		
		
	elseif curStep >= 806 and not t1 then
	t1 = true
		for i = 4, 7 do
			noteTweenAlpha('dienote'..i, i, 0.5, 2.5 / playbackRate, 'linear')
		end
	
	
	elseif curStep >= 823 and not t2 then
	t2 = true
	doTweenAlpha('killicon1', 'iconP1', 0, 2.5 / playbackRate, 'linear')
	doTweenAlpha('killicon2', 'iconP2', 0, 2.5 / playbackRate, 'linear')
	doTweenAlpha('killhealth', 'healthBar', 0, 2.5 / playbackRate, 'linear')
	doTweenAlpha('killhealthBG', 'healthBarBG', 0, 2.5 / playbackRate, 'linear')
	
	
	elseif curStep >= 841 and not t3 then
	t3 = true
	doTweenAlpha('killscore', 'scoreTxt', 0, 2.5 / playbackRate, 'linear')
	
	elseif curStep >= 896 and not end1 then
	end1 = true
	setProperty('blackOverlay.alpha', 1)
	
	elseif curStep >= 904 and not end2 then
	end2 = true
	--setProperty('enjoy.alpha', 1)
	doTweenAlpha('hahathislookscooler', 'enjoy', 1, 5 / playbackRate, 'quadOut')
	
	end
	
end

--[[function onSpawnNote()
	if curHealthGain == 4 and getProperty('notes.members[0].mustPress') then
		setProperty('notes.members[0].hitHealth', 0.013)
	
	elseif curHealthGain == 3 and getProperty('notes.members[0].mustPress') then
		setProperty('notes.members[0].hitHealth', 0.015)
	
	elseif curHealthGain == 2 and getProperty('notes.members[0].mustPress') then
		setProperty('notes.members[0].hitHealth', 0.016)
	
	elseif curHealthGain == 1 and getProperty('notes.members[0].mustPress') then
		setProperty('notes.members[0].hitHealth', 0.018)
	
	end
end]]

function goodNoteHit()
	if curHealthGain == 4 then
		if difficulty == 0 then
			addHealth(-0.010)
		else 
			addHealth(-0.0025)
		end
	
	elseif curHealthGain == 3 then
		if difficulty == 0 then
			addHealth(-0.008)
		else 
			addHealth(-0.002)
		end
	
	elseif curHealthGain == 2 then
		if difficulty == 0 then
			addHealth(-0.007)
		else 
			addHealth(-0.0015)
		end
	
	elseif curHealthGain == 1 then
		if difficulty == 0 then
			addHealth(-0.005)
		else 
			addHealth(-0.001)
		end
	
	end
end