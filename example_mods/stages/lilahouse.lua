debuggin = false

function onStartCountdown()
	setProperty('introSoundsSuffix', 'blank')
end

function onSongStart()
	setProperty('cameraSpeed', 1) -- JSON speed is 10 so camera doesnt pan across, this sets it back to normal
	
	doTweenAlpha('letusbegin', 'blackOverlay', 0.0001, 7.5 / playbackRate, 'linear')
end

--[[assetList = {
	'noteSplashes',
	'LilaHouse/Background/noteSplashes_desat1',
	'LilaHouse/Background/noteSplashes_desat2',
	'LilaHouse/Background/noteSplashes_desat3',
}
--'LilaHouse/Background/noteSplashes_desat2',
--'LilaHouse/Background/NOTE_assets_desat2',
--'LilaHouse/Background/NOTE_assets_desat1',
--'LilaHouse/Background/NOTE_assets_desat3'

function onCreate() -- literally just for precaching stuff
	for _, asset in pairs(assetList) do
	makeAnimatedLuaSprite(assetList[asset], assetList[asset])
	setObjectCamera(assetList[asset], 'other')
	setProperty(assetList[asset]..'.alpha', 0.0001)
	addLuaSprite(assetList[asset], true)
	end
end]]-- realized this tanks frames

function onCountdownTick(counter)
	if counter == 0 then
		playSound('intro3-earth', 0.175)
	
	elseif counter == 1 then
		playSound('intro2-earth', 0.2)
		
	elseif counter == 2 then
		playSound('intro1-earth', 0.2)
	
	elseif counter == 3 then
		playSound('introGo-earth', 0.2)
		
	end
end

onCreatePost = function()

precacheSound('intro3-earth')
precacheSound('intro2-earth')
precacheSound('intro1-earth')
precacheSound('introGo-earth')

setProperty('iconP2.visible', false)

makeLuaSprite('noteSplashes', 'noteSplashes', 0, 0)
setObjectCamera('noteSplashes', 'camOther')
setProperty('noteSplashes.alpha', 0.0001)
addLuaSprite('noteSplashes', true)


makeLuaSprite('window1', 'LilaHouse/Background/lilawindow1real', 0, 0) -- Window Stage 1 
addLuaSprite('window1', true)

makeLuaSprite('window2light', 'LilaHouse/Background/lilalight2', 0, 0) -- Window Stage 2 LIGHT
addLuaSprite('window2light', true)

makeLuaSprite('window2arm', 'LilaHouse/Background/lilaarm2', 0, 0) -- Window Stage 2 ARM
addLuaSprite('window2arm', true)
	
-- added this last sec cause i thought it looked cool
makeLuaSprite('candyvig', 'CandyShop/Background/Vignette', 0, 0)
	setObjectCamera('candyvig', 'camGame')
	setScrollFactor('candyvig', 0, 0);
	scaleObject('candyvig', 1.5, 1.5)
	screenCenter('candyvig', 'XY')
	addLuaSprite('candyvig', true)
	setProperty('candyvig.alpha', 0.2)
	
	makeLuaSprite('atticvig', 'CandyShop/Background/DreamVignettefix', 0, 0)
	setObjectCamera('atticvig', 'camGame')
	setScrollFactor('atticvig', 0, 0);
	scaleObject('atticvig', 1.5, 1.5)
	screenCenter('atticvig', 'XY')
	addLuaSprite('atticvig', false)
	setProperty('atticvig.alpha', 0.0001);
--

makeLuaSprite('blackOverlay', nil, 0, 0);
makeGraphic('blackOverlay', 1, 1, '000000');
scaleObject('blackOverlay', screenWidth, screenHeight, false)
setObjectCamera('blackOverlay', 'other');
--setProperty('blackOverlay.alpha', 0.0001);
screenCenter('blackOverlay')
addLuaSprite('blackOverlay', true);

makeLuaSprite('fullMemories', 'LilaHouse/Background/wholesomeskid');
setObjectCamera('fullMemories', 'other');
setProperty('fullMemories.alpha', 0.0001);
screenCenter('fullMemories')
addLuaSprite('fullMemories', true);

makeLuaSprite('Vignette', 'CandyShop/Background/Vignette');
setObjectCamera('Vignette', 'other');
setProperty('Vignette.alpha', 0.0001);
screenCenter('Vignette')
addLuaSprite('Vignette', true);

makeLuaSprite('darkness', nil, 0, 0);
makeGraphic('darkness', 1, 1, '000000');
scaleObject('darkness', screenWidth, screenHeight, false)
setObjectCamera('darkness', 'other');
setProperty('darkness.alpha', 0.0001);
screenCenter('darkness')
addLuaSprite('darkness', true);
--setBlendMode('darkness', 'overlay')

-- Constant sprites, present in all main Lila stages.
	makeLuaSprite('sky', 'LilaHouse/Background/lilasky', 0, 0) -- Sky
	addLuaSprite('sky', false)

	makeAnimatedLuaSprite('stars', 'CandyShop/Background/AtticStarsfix', -1190, -1030) -- Stars
	addAnimationByPrefix('stars', 'idle', 'stars', 24, true)
	scaleObject('stars', 0.65, 0.65, false)
	setScrollFactor('stars', 0.5, 0.5);
	addLuaSprite('stars', false)
	
	
-- Stage 1 -- Base Lila Stage
	makeLuaSprite('house1', 'LilaHouse/Background/lilahouse', 0, 0) -- House Stage 1
	addLuaSprite('house1', false)
	
	makeLuaSprite('interior1', 'LilaHouse/Background/lilabg1', 0, 0) -- Interior Stage 1
	addLuaSprite('interior1', false)


stage1Items = {
	'house1',
	'interior1'
	}
	
	
-- Stage 2
	makeLuaSprite('house2', 'LilaHouse/Background/lilahouse2', 0, 0) -- House Stage 2
	addLuaSprite('house2', false)
	
	makeLuaSprite('interior2', 'LilaHouse/Background/lilabg2', 0, 0) -- Interior Stage 2
	addLuaSprite('interior2', false)
	
	-- Window remains the same until stage 4
	
stage2Items = {
	'house2',
	'interior2'
	}
	
for s2 = 1, #stage2Items do
	setProperty(stage2Items[s2]..'.alpha', 0.0001)
end
	
-- Stage 3
	makeLuaSprite('house3', 'LilaHouse/Background/lilahouse3', 0, 0) -- House Stage 3
	addLuaSprite('house3', false)
	
	makeLuaSprite('interior3', 'LilaHouse/Background/lilabg3', 0, 0) -- Interior Stage 3
	addLuaSprite('interior3', false)
	
stage3Items = {
	'house3',
	'interior3'
	}

for s3 = 1, #stage3Items do
	--setProperty(stage3Items[s3]..'.alpha', 0)
	removeLuaSprite(stage3Items[s3], false)
end

-- Stage 4
	makeLuaSprite('house4', 'LilaHouse/Background/lilahouse4', 0, 0) -- House Stage 4
	addLuaSprite('house4', false)
	
	makeLuaSprite('interior4', 'LilaHouse/Background/lilabg4', 0, 0) -- Interior Stage 4
	addLuaSprite('interior4', false)

	
stage4Items = {
	'house4',
	'interior4',
	'window2arm',
	'window2light'
	}

for s4 = 1, #stage4Items do
	--setProperty(stage4Items[s4]..'.alpha', 0)
	removeLuaSprite(stage4Items[s4], false)
end

-- Stage 5

stage5Items = {
	'space',
	'sun',
	'earth',
	'gates'
	}

for _, s5 in pairs(stage5Items) do
	makeLuaSprite(s5, 'LilaHouse/Background/Heaven/'..s5, 500, 0)
	
	addLuaSprite(s5, false)
	
	--setProperty(s5..'.alpha', 0)
	removeLuaSprite(s5, false)
end

setProperty('space.y', -300)
setProperty('space.x', 505)
setProperty('sun.y', -240)
setProperty('earth.y', -240)

scaleObject('gates', 1.1, 1, false)
scaleObject('space', 1.1, 1, false)
-- Lila Y pos offset by 70 px

end

function onEvent(n, v1, v2)
    if n == 'lila depression' then -- least messy fnf event
        if tonumber(v1) == 1 then
        
            for s1 = 1, #stage1Items do
            setProperty(stage1Items[s1]..'.alpha', 1)
            end
            for s2 = 1, #stage2Items do
            setProperty(stage2Items[s2]..'.alpha', 0.0001)
            end
			
            
        elseif tonumber(v1) == 2 then
            
            for s1 = 1, #stage1Items do
            removeLuaSprite(stage1Items[s1], true)
            end
            for s2 = 1, #stage2Items do
            setProperty(stage2Items[s2]..'.alpha', 1)
            end
            --for s3 = 1, #stage3Items do
            --setProperty(stage3Items[s3]..'.alpha', 0.0001)
            --end -- DONE IN ONTWEENCOMPLETED
 
			
			setProperty('candyvig.alpha', 0.4)
			
			-- note change / desat stage 2
			for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat1')
			end
			
			inStage2 = true
			
			for i = 0, getProperty('notes.length')-1 do
				setPropertyFromGroup('notes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat1')
				setPropertyFromGroup('notes', i, 'noteSplashSat', -0.3)
			end
			
			-- Remove unused sprites
			removeLuaSprite('noteSplashes', true)
            
        elseif tonumber(v1) == 3 then
        
		if debuggin then
			
            for s1 = 1, #stage1Items do
            removeLuaSprite(stage1Items[s1], true)
            end
			
		end
		
            for s2 = 1, #stage2Items do
            removeLuaSprite(stage2Items[s2], true)
			end
		 
            for s3 = 1, #stage3Items do
            setProperty(stage3Items[s3]..'.alpha', 1)
            end
            --for s4 = 1, #stage4Items do
            --setProperty(stage4Items[s4]..'.alpha', 0.0001)
            --end DONE IN ONTWEENCOMPLETED
			
			
            
			setProperty('candyvig.alpha', 0.7)
			
			-- note change / desat stage 3
			for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat2')
			end
			
			inStage3 = true
			
			for i = 0, getProperty('notes.length')-1 do
				setPropertyFromGroup('notes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat2')
				setPropertyFromGroup('notes', i, 'noteSplashSat', -0.55)
			end
			
			-- Remove unused sprites
			--removeLuaSprite('LilaHouse/Background/noteSplashes_desat1', true)
			--removeLuaSprite('LilaHouse/Background/NOTE_assets_desat1', true)
			
        elseif tonumber(v1) == 4 then
            
		if debuggin then
			
            for s1 = 1, #stage1Items do
            removeLuaSprite(stage1Items[s1], true)
            end
            for s2 = 1, #stage2Items do
            removeLuaSprite(stage2Items[s2], true)
            end
			
		end
			
            for s3 = 1, #stage3Items do
            removeLuaSprite(stage3Items[s3], true)
            end
            for s4 = 1, #stage4Items do
            setProperty(stage4Items[s4]..'.alpha', 1)
            end
			
			
			setProperty('candyvig.alpha', 0.8)
			
			removeLuaSprite('window1', true)
			
			-- note change / desat stage 4
			for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat3')
			end
			
			inStage4 = true
			
			for i = 0, getProperty('notes.length')-1 do
				setPropertyFromGroup('notes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat3')
				setPropertyFromGroup('notes', i, 'noteSplashSat', -0.75)
			end
			
			-- Remove unused sprites
			--removeLuaSprite('LilaHouse/Background/noteSplashes_desat2', true)
			--removeLuaSprite('LilaHouse/Background/NOTE_assets_desat2', true)
			
        elseif tonumber(v1) == 5 then
		setProperty('dad.visible', false)
		setProperty('gf.visible', false)

		
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		
		setProperty('camHUD.alpha', 0.7)
		--[[
		
		setProperty('scoreTxt.alpha', 0.7)
		for i = 0, 3 do
		setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end]]--
		removeLuaSprite('candyvig', true)
		setProperty('atticvig.alpha', 1)
		
		setProperty('scoreTxt.alpha', 0)
		
		if debuggin then 
		
			for s1 = 1, #stage1Items do
            removeLuaSprite(stage1Items[s1], true)
            end
            for s2 = 1, #stage2Items do
            removeLuaSprite(stage2Items[s2], true)
            end
            for s3 = 1, #stage3Items do
            removeLuaSprite(stage3Items[s3], true)
            end
			
		end
		
            for s4 = 1, #stage4Items do
            removeLuaSprite(stage4Items[s4], true)
            end
			
			for _, s5 in pairs(stage5Items) do 
			setProperty(s5..'.alpha', 1)
			end
			
			removeLuaSprite('window1', true)
			removeLuaSprite('window2arm', true)
			removeLuaSprite('window2light', true)
			removeLuaSprite('stars', true)
			removeLuaSprite('sky', true)
			
			setProperty('defaultCamZoom', 0.606)
			
			for i=0,3 do
			noteTweenX(i+4, i+4, 420+(i*110), 0.0001 / playbackRate)
			end
			
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
			if not downscroll and not middlescroll then setProperty('timeTxt.y', 10) end
			
			inStage4 = false
			inStage3 = false
			inStage2 = false
			
			inStage5 = true
			
			setProperty('botplayTxt.visible', false)
			
			--setProperty('blackOverlay.alpha', 0.0001)
			
			for i = 0, 7 do
				setPropertyFromGroup('strumLineNotes', i, 'texture', 'NOTE_assets')
			end
			
			for i = 0, getProperty('notes.length')-1 do
				setPropertyFromGroup('notes', i, 'texture', '')
				setPropertyFromGroup('notes', i, 'noteSplashSat', 0)
			end
			
			removeLuaSprite('LilaHouse/Background/NOTE_assets_desat3', true)
			
			end 

			runHaxeCode('Paths.clearUnusedMemory();') -- save me fpsvar
		
    end
end

function onSpawnNote(i)
	if inStage4 then
	setPropertyFromGroup('notes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat3')
	setPropertyFromGroup('notes', i, 'noteSplashSat', -0.75);
	
	elseif inStage3 then
	setPropertyFromGroup('notes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat2')
	setPropertyFromGroup('notes', i, 'noteSplashSat', -0.55);
	
	elseif inStage2 then
	setPropertyFromGroup('notes', i, 'texture', 'LilaHouse/Background/NOTE_assets_desat1')
	setPropertyFromGroup('notes', i, 'noteSplashSat', -0.3);

	end
end

local function round(number, digit_position) 
  local precision = math.pow(10, digit_position)
  number = number + (precision / 2); -- this causes value #.5 and up to round up
                                     -- and #.4 and lower to round down.

  return math.floor(number / precision) * precision
end

function onBeatHit()
	if curBeat >= 16 and not getProperty('camZooming') then
	setProperty('camZooming', true)

	elseif curBeat == 224 then
		doTweenAlpha('thememories', 'blackOverlay', 1, 5.7 / playbackRate, 'linear')
		
		doTweenZoom('zoomingWOOHOO', 'camGame', 1, 10 / playbackRate, 'sineInOut')
		setProperty('camZoomingMult', 0)
		
	elseif curBeat == 240 then 
		setProperty('camZoomingMult', 1)
		cancelTween('zoomingWOOHOO')
	
		setProperty('Vignette.alpha', 1)
		
		setProperty('darkness.alpha', 0.3)
		
		setProperty('fullMemories.alpha', 1)
		
		setProperty('fullMemories.origin.x', getProperty('fullMemories.width') / 2)
		setProperty('fullMemories.origin.y', getProperty('fullMemories.height') / 2)
		
		doTweenX('supersizemex', 'fullMemories.scale', 2, 255 / playbackRate, 'linear')
		doTweenY('supersizemey', 'fullMemories.scale', 2, 255 / playbackRate, 'linear')
		
		runTimer('darkLoop', 1 / playbackRate)
		
	elseif curBeat == 264 then
		doTweenAlpha('buhbye', 'fullMemories', 0, 1.5 / playbackRate, 'linear')
		
	elseif curBeat == 272 then -- memories over ... call that empty memories or smth
		cancelTween('thefogisgoing')
		cancelTween('thefogiscoming')
		
		cancelTween('supersizemex')
		cancelTween('supersizemey')
		
		removeLuaSprite('fullMemories', true)
		removeLuaSprite('Vignette', true)
		
		setProperty('blackOverlay.alpha', 0.0001)
		cameraFlash('camOther','ffffff', 1 / playbackRate, true)
		
	elseif curBeat >= 273 and not changedDark then
	changedDark = true
	setObjectCamera('darkness', 'camHUD')
	setObjectOrder('darkness', 0)
	setProperty('darkness.alpha', 0.0001)
		
	elseif curBeat == 336 then
		doTweenZoom("thezooms", "camGame", 0.85, 5 / playbackRate, 'sineInOut')
		setProperty('camZoomingMult', 0)
		
	elseif curBeat == 384 then
		setObjectCamera('darkness', 'camGame')
		setScrollFactor('darkness', 0, 0)
		scaleObject('darkness', screenWidth * 2, screenHeight * 2, false)
		screenCenter('darkness')
		
		setObjectOrder('darkness', getObjectOrder('boyfriend') + 10)
		setObjectOrder('window2light', getObjectOrder('boyfriend') + 20)
		
		setObjectOrder('window2arm', getObjectOrder('darkness') - 1)
		
		doTweenAlpha('thenshedied', 'darkness', 1, 3.9 / playbackRate, 'linear')
		doTweenAlpha('thenshediedphysically', 'boyfriend', 0, 9 / playbackRate, 'linear')
		
	elseif curBeat == 390 then
		doTweenAlpha('killwindow', 'window2light', 0, 3.2 / playbackRate, 'linear')
		
	elseif curBeat == 399 then
		setProperty('cameraSpeed', 100)
		cancelTween('thenshediedphysically')
	
	elseif curBeat == 400 then
		setProperty('boyfriend.alpha', 1)
		doTweenAlpha('sentencedtoaneternalheaven', 'darkness', 0, 1.5 / playbackRate, 'cubeOut')
	
	elseif curBeat == 401 then
		setProperty('cameraSpeed', 1)
	
	elseif curBeat == 416 then
		doTweenAlpha('therealization.', 'blackOverlay', 1, 12 / playbackRate, 'linear')
		
		doTweenZoom('yomykidsdead', 'camGame', 0.73, 4.2 / playbackRate, 'sineInOut')
		setProperty('camZoomingMult', 0)
		
		setProperty('defaultCamZoom', 0.73)

	end
end

function onTimerCompleted(tag)
	if tag == 'darkLoop' then
		doTweenAlpha('thefogisgoing', 'darkness', 0, 1 / playbackRate, 'cubeInOut')
	
	elseif tag == 'waitb4thedark' then
		darkAlpha = round(getRandomFloat(0.3, 0.4, darkAlpha), -1)
		doTweenAlpha('thefogiscoming', 'darkness', darkAlpha, 1.3 / playbackRate, 'cubeInOut')
		
	elseif tag == 'waitb4thelight' then
		lightAlpha = round(getRandomFloat(0.0, 0.1, lightAlpha), -1)
		doTweenAlpha('thefogisgoing', 'darkness', lightAlpha, 1.25 / playbackRate, 'cubeInOut')
		
	end
end

function onTweenCompleted(tag)
	if tag == 'thefogisgoing' then
	--runTimer('waitb4thedark', 1 / playbackRate)
	darkAlpha = round(getRandomFloat(0.3, 0.6, darkAlpha), -1)
		doTweenAlpha('thefogiscoming', 'darkness', darkAlpha, 2.3 / playbackRate, 'cubeInOut')
	
	elseif tag == 'thefogiscoming' then
	--runTimer('waitb4thelight', 1 / playbackRate)
		lightAlpha = round(getRandomFloat(0.0, 0.2, lightAlpha), -1)
		doTweenAlpha('thefogisgoing', 'darkness', lightAlpha, 2.25 / playbackRate, 'cubeInOut')
	
	
	
	elseif tag == 'thememories' then
			for s3 = 1, #stage3Items do
			addLuaSprite(stage3Items[s3], false)
            setProperty(stage3Items[s3]..'.alpha', 0.0001)
            end
	
	elseif tag == 'buhbye' then
			addLuaSprite('house4', false)
			addLuaSprite('interior4', false)
			
			addLuaSprite('window2arm', true)
			addLuaSprite('window2light', true)
			
		--if stage4Items[s4] ~= 'window2arm' or stage4Items[s4] ~= 'window2light' then addLuaSprite(stage4Items[s4], false) else addLuaSprite(stage4Items[s4], true) end
        
		
		for s4 = 1, #stage4Items do
			setProperty(stage4Items[s4]..'.alpha', 0.0001)
        end
		
		for _, s5 in pairs(stage5Items) do 
			addLuaSprite(s5, false)
			setProperty(s5..'.alpha', 0.0001)
		end
	
	elseif tag == 'thezooms' then
	setProperty('defaultCamZoom', 0.85)
	setProperty('camZoomingMult', 1)
	
	elseif tag == 'sentencedtoaneternalheaven' then
	removeLuaSprite('darkness', true)
	
	end
end

function onStepHit()
	if curStep > 1087 and not inStage4 then
	setProperty('healthGain', 0.6)
	
		if getHealth() > 0.01 then
			addHealth(-0.01);
		end
	
	
	elseif curStep > 1343 and inStage4 then
	setProperty('healthGain', 0)
	
		if getHealth() > 0.007 then
		addHealth(-0.007);
		end
	
	elseif curStep == 1600 then
	setProperty('health', 1)
	setProperty('healthGain', 1)
	
	end
end