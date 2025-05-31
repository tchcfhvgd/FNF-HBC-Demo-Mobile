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
		if not fixedNotes then
		setObjectOrder('boyfriendGroup', getObjectOrder('startBack')+1)
		setObjectOrder('gfGroup', getObjectOrder('startBack')+2)
		end
		if getProperty('heartBeats') <= 0.25 then setProperty('iconP1.animation.curAnim.curFrame', 1) elseif getProperty('heartBeats') > 0.25 and getHealth > 0.4 then setProperty('iconP1.animation.curAnim.curFrame', 0) end
	end
	setProperty('camHUD.alpha', 1)
	setProperty('camGame.alpha', 1)
	
	doTweenAlpha('lettucebegin', 'blackOverlay', 0.0001, 1 / playbackRate, 'linear')
	
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function activateMiddlescroll()
	for i = 0, 3 do
	setProperty('opponentStrums.members['..i..'].visible', false)
	end
	
	setPropertyFromGroup('playerStrums', 0, 'x', 410)
	setPropertyFromGroup('playerStrums', 1, 'x', 522)
	setPropertyFromGroup('playerStrums', 2, 'x', 633)
	setPropertyFromGroup('playerStrums', 3, 'x', 745)
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'whoops' then
	startVideo('SpookersD4'); --Play video file from "videos/" folder
	playVideo = false;
	
	elseif tag == 'fadeTip' then
	doTweenAlpha('heartTipFade', 'heartTip', 0, 2 / playbackRate, 'linear')
	
	elseif tag == 'spaceBuffer' then
		if heartMechanic and not botPlay and not alreadyHit and canHit then
			alreadyHit = false
			canHit = false
		
			setProperty('heartBeats', getProperty('heartBeats') -  ( (e / 10 * 6)) * heartLossMult )
			
		elseif heartMechanic and not botPlay and alreadyHit and canHit then -- redemption
			canHit = false
			alreadyHit = false
			setProperty('heartBeats', getProperty('heartBeats') +  ( (e / 10 * 25)) * heartGainMult )
		end
		
	end
		
end

----cutscene-----------------------------

function onCreatePost()

if isStoryMode and not seenCutscene then
setProperty('camHUD.alpha', 0.0001)
setProperty('camGame.alpha', 0.0001)
end

-- funni splash precache
	makeAnimatedLuaSprite('spookysplash', 'CandyShop/SpookyNoteSplashes', 0, 0)
	setObjectCamera('spookysplash', 'camOther')
	setProperty('spookysplash.alpha', 0.0001);
	addLuaSprite('spookysplash')
	
-- intro section
	for i = 0, 3 do
	setProperty('opponentStrums.members['..i..'].visible', false)
	end
	
	if not middlescroll and not downscroll then setProperty('timeTxt.y', 10) end
	
	setPropertyFromGroup('playerStrums', 0, 'x', 410)
	setPropertyFromGroup('playerStrums', 1, 'x', 522)
	setPropertyFromGroup('playerStrums', 2, 'x', 633)
	setPropertyFromGroup('playerStrums', 3, 'x', 745)
	
	setProperty('dad.alpha', 0.0001)

	setProperty('scoreTxt.alpha', 0.0001)
	setProperty('healthBar.alpha', 0.0001)
	setProperty('healthBarBG.alpha', 0.0001)
	setProperty('iconP1.alpha', 0.0001)
	setProperty('iconP2.alpha', 0.0001)
	
	setProperty('botplayTxt.visible', false)
	
	setProperty('isCameraOnForcedPos', true)
	
-- STAGE SHIT
	addHaxeLibrary('FlxTrail','flixel.addons.effects') --lol
	addHaxeLibrary('FlxBar','flixel.ui') --oh god no
	addHaxeLibrary('FlxBarFillDirection','flixel.ui') --NOOOOOO
	addHaxeLibrary('Type') -- wait this ones fine

	makeLuaSprite('startBack', 'CandyShop/Background/StartBack', -225, 175)
	setObjectOrder('startBack', 4)
	addLuaSprite('startBack', false)
	
	makeAnimatedLuaSprite('streetBack', 'CandyShop/Background/StreetBack', -250, -45)
	addAnimationByPrefix('streetBack', 'idle', 'back0015', 1, true)
	playAnim('streetBack', 'idle', true)
	addAnimationByPrefix('streetBack', 'flick', 'back', 24, false)
	setScrollFactor('streetBack', 0.6, 0.9)
	scaleObject('streetBack', 0.88, 0.88, true)
	addLuaSprite('streetBack', false)
	
	
	makeAnimatedLuaSprite('rainFront', 'CandyShop/Background/RainFront', -150, 205)
	addAnimationByPrefix('rainFront', 'idle', 'rainFUCK YOU', 24, true)
	playAnim('rainFront', 'idle', true)
	scaleObject('rainFront', 0.8, 0.8, true)
	setObjectOrder('rainFront', 2)
	addLuaSprite('rainFront', false)
	
	makeAnimatedLuaSprite('rainBack', 'CandyShop/Background/RainBack', 0, 705)
	addAnimationByPrefix('rainBack', 'idle', 'rain2', 24, true)
	playAnim('rainBack', 'idle', true)
	setScrollFactor('rainBack', 0.6, 0.9)
	scaleObject('rainBack', 0.8, 0.8, true)
	setObjectOrder('rainBack', 3)
	addLuaSprite('rainBack', false)
	
	
	makeAnimatedLuaSprite('candyShopNight', 'CandyShop/Background/CandyShopNight', -380, 220)
	addAnimationByPrefix('candyShopNight', 'idle', 'wallIDLE', 1, true)
	addAnimationByPrefix('candyShopNight', 'flash', 'wallFUCKYOU', 24, false)
	playAnim('candyShopNight', 'idle', true)
	addAnimationByPrefix('candyShopNight', 'flick', 'back', 24, false)
	scaleObject('candyShopNight', 0.7, 0.7, true)
	addLuaSprite('candyShopNight', false)
	
	
	-- TEXTS
	
	makeLuaSprite('awakeText', 'CandyShop/Background/Text/Awake', 0, 0)
	setObjectCamera('awakeText', 'camOther')
	scaleObject('awakeText', 0.66, 0.66, true)
	screenCenter('awakeText')
	setProperty('awakeText.alpha', 0.0001)
	setObjectOrder('awakeText', 8)
	addLuaSprite('awakeText', true)
	
	
	makeLuaSprite('fineText', 'CandyShop/Background/Text/Fine.', 0, 0)
	setObjectCamera('fineText', 'camOther')
	scaleObject('fineText', 0.66, 0.66, true)
	screenCenter('fineText')
	setProperty('fineText.alpha', 0.0001)
	setObjectOrder('fineText', 9)
	addLuaSprite('fineText', true)
	
	
	makeLuaSprite('fixText', 'CandyShop/Background/Text/Fix', 0, 0)
	setObjectCamera('fixText', 'camOther')
	scaleObject('fixText', 0.66, 0.66, true)
	screenCenter('fixText')
	setProperty('fixText.alpha', 0.0001)
	setObjectOrder('fixText', 10)
	addLuaSprite('fixText', true)
	
	
	
	
	
	makeLuaSprite('blackOverlay', nil, 0, 0);
	makeGraphic('blackOverlay', 1, 1, '000000');
	scaleObject('blackOverlay', screenWidth, screenHeight, false)
	setObjectCamera('blackOverlay', 'other');
	setProperty('blackOverlay.alpha', isStoryMode and not seenCutscene and 1 or 0.0001) 
	screenCenter('blackOverlay')
	setObjectOrder('blackOverlay', 7)
	addLuaSprite('blackOverlay', true);
	
	
	makeLuaSprite('vignette', 'CandyShop/Background/Vignette', -170, -120)
	setObjectOrder('vignette', 5)
	scaleObject('vignette', 1.3, 1.3, true)
	setObjectCamera('vignette', 'camHUD')
	screenCenter('vignette')
	addLuaSprite('vignette', false)

	
	makeLuaSprite('heartBarBG', 'heartBar', -27, 167)
	setObjectCamera('heartBarBG', 'camHUD')
	setObjectOrder('heartBarBG', 39)
	addLuaSprite('heartBarBG', false)
	
	
	runHaxeCode([[		
			heartBar = new FlxBar(58, 178, Type.resolveEnum('flixel.ui.FlxBarFillDirection').BOTTOM_TO_TOP, 27, 360, null, 'heartBeats', 0, 1, false);
			heartBar.createFilledBar(0x00000000, 0xFFb1f9f1, false, null);
            game.add(heartBar);
			heartBar.value = 1;


			setVar('heartBar', heartBar);
			setVar('heartBeats', heartBar.value);
			]])
			
	setObjectCamera('heartBar', 'camHUD')
	setObjectOrder('heartBar', 20)
	setProperty('heartBeats', 0.994)
	
	makeAnimatedLuaSprite('heartNormal', 'Normalheart', 34, 496)
	addAnimationByPrefix('heartNormal', 'idle', 'heartbeat', 24, false)
	scaleObject('heartNormal', 0.5, 0.5, true)
	setObjectCamera('heartNormal', 'camHUD')
	setObjectOrder('heartNormal', 40)
	addLuaSprite('heartNormal', false)
	
	makeAnimatedLuaSprite('heartCracked', 'Crackedheart', 36, 494)
	addAnimationByPrefix('heartCracked', 'idle', 'heartbeat 2', 24, false)
	scaleObject('heartCracked', 0.5, 0.5, true)
	setObjectCamera('heartCracked', 'camHUD')
	setObjectOrder('heartCracked', 40)
	addLuaSprite('heartCracked', false)
	
	makeAnimatedLuaSprite('heartDamaged', 'Damagedheart', 40, 496)
	addAnimationByPrefix('heartDamaged', 'idle', 'heartbeat 3', 24, false)
	scaleObject('heartDamaged', 0.5, 0.5, true)
	setObjectCamera('heartDamaged', 'camHUD')
	setObjectOrder('heartDamaged', 40)
	addLuaSprite('heartDamaged', false)
	
	makeAnimatedLuaSprite('heartBroken', 'Brokenheart', 45, 505)
	addAnimationByPrefix('heartBroken', 'idle', 'heartbeat 4', 24, false)
	scaleObject('heartBroken', 0.5, 0.5, true)
	setObjectCamera('heartBroken', 'camHUD')
	setObjectOrder('heartBroken', 40)
	addLuaSprite('heartBroken', false)
	
	makeLuaSprite('corruptionOverlay', 'CandyShop/Background/CorruptionOverlay', 0, 0)
	setObjectCamera('corruptionOverlay', 'camOther')
	setProperty('corruptionOverlay.alpha', 0.0001)
	screenCenter('corruptionOverlay')
	addLuaSprite('corruptionOverlay', true)
	
	
	for _, heartImage in pairs(hearts) do
		setProperty(heartImage..'.alpha', 0.0001)
	end
	
	setProperty('heartNormal.alpha', 1)
end

hearts = {
'heartNormal',
'heartCracked',
'heartDamaged',
'heartBroken'
}


function onStepHit()
	
	if curStep >= 425 and not finishedIntro then
	finishedIntro = true
	removeLuaSprite('startBack', true)
	addLuaSprite('halloweenWhite', true);
	
	doTweenAlpha('killfix', 'fixText', 0, 1 / playbackRate, 'smoothStepOut')
	
	
	elseif curStep >= 435 and not fixedNotes then
	fixedNotes = true
		setObjectOrder('boyfriendGroup', 14)
		setObjectOrder('gfGroup', 16)
		for i = 0, 3 do
			setProperty('opponentStrums.members['..i..'].visible', true)
		end
	
		setPropertyFromGroup('playerStrums', 0, 'x', middlescroll and 410 or defaultPlayerStrumX0)
		setPropertyFromGroup('playerStrums', 1, 'x', middlescroll and 522 or defaultPlayerStrumX1)
		setPropertyFromGroup('playerStrums', 2, 'x', middlescroll and 633 or defaultPlayerStrumX2)
		setPropertyFromGroup('playerStrums', 3, 'x', middlescroll and 745 or defaultPlayerStrumX3)
		
		if not downscroll and not middlescroll then setProperty('timeTxt.y', 58) end
		setProperty('scoreTxt.alpha', 1)
		if botPlay then setProperty('botplayTxt.visible', not getPropertyFromClass('ClientPrefs', 'showFPS')) end
		setProperty('isCameraOnForcedPos', false)
		
	elseif curStep >= 440 and not startedSong then
		startedSong = true
		setProperty('dad.alpha', 1)
		setProperty('healthBar.alpha', 1)
		setProperty('healthBarBG.alpha', 1)
		setProperty('iconP1.alpha', 1)
		setProperty('iconP2.alpha', 1)
	
	elseif curStep == 329 then
	doTweenAlpha('yapsession', 'blackOverlay', 1, 2.5 / playbackRate, 'linear')
	
	elseif curStep == 365 then
	doTweenAlpha('awake', 'awakeText', 1, 1 / playbackRate, 'smoothStepOut') -- Still awake
	
	heartLossMult = 0
	
	elseif curStep == 385 then
	doTweenAlpha('killawake', 'awakeText', 0, 0.5 / playbackRate, 'smoothStepOut')
	
	elseif curStep == 389 then
	doTweenAlpha('fine', 'fineText', 1, 0.5 / playbackRate, 'smoothStepOut')
	
	elseif curStep == 401 then
	doTweenAlpha('killfine', 'fineText', 0, 1 / playbackRate, 'smoothStepOut')
	
	elseif curStep == 409 then
	doTweenAlpha('fix', 'fixText', 1, 1 / playbackRate, 'smoothStepOut')
	
	elseif curStep >= 445 and not doneYapping then -- Intro ends
	doneYapping = true
	doTweenAlpha('yapfinished', 'blackOverlay', 0.0001, 2.5 / playbackRate, 'linear')
	removeLuaSprite('awakeText', true)
	removeLuaSprite('fineText', true)
	removeLuaSprite('fixText', true)
	
	heartLossMult = 1.2
	
	elseif curStep == 768 then
	setProperty('defaultCamZoom', 1.25)
	
	elseif curStep == 960 then
	setProperty('defaultCamZoom', 1.4)
	
	elseif curStep == 1024 then -- skid starts dying
	setProperty('defaultCamZoom', 1.1)
	
	if heartMechanic and getProperty('heartBeats') > 0.3 then setProperty('heartBeats', getProperty('heartBeats') - 0.1) end
	heartLossMult = 1.6
	heartGainMult = 0.5
	
	elseif curStep >= 1168 and not pumpTrailing then
	pumpTrailing = true
	
	if heartMechanic then setProperty('heartBeats', getProperty('heartBeats') + 0.3) end
	heartLossMult = 1.5
	heartGainMult = 1.2
	
	setProperty('defaultCamZoom', 1.25)
		
	runHaxeCode([[

			pumpTrail = new FlxTrail(game.gf, null, 4, 24, 0.35, 0.05);
            game.addBehindBF(pumpTrail);
			setVar('pumpTrail', pumpTrail);
			]])
			setProperty('pumpTrail.color', getColorFromHex('84f5e4'))
	
	elseif curStep == 1200 then
	setProperty('defaultCamZoom', 1.4)
	
	elseif curStep == 1248 then
	setProperty('defaultCamZoom', 1.1)
	
	
	elseif curStep >= 1424 and not skidTrailing then
	skidTrailing = true
	
	if heartMechanic then setProperty('heartBeats', getProperty('heartBeats') + 0.4) end
	heartLossMult = 1
	heartGainMult = 1.5
	
	setProperty('defaultCamZoom', 1.25)
	
	runHaxeCode([[

			skidTrail = new FlxTrail(game.boyfriend, null, 4, 24, 0.35, 0.05);
            game.addBehindBF(skidTrail);
			setVar('skidTrail', skidTrail);
			]])
			setProperty('skidTrail.color', getColorFromHex('84f5e4'))
			
	elseif curStep == 1456 then
	setProperty('defaultCamZoom', 1.4)
	
	elseif curStep >= 1488 and not lastZoom then
	lastZoom = true
	setProperty('defaultCamZoom', 1.1)
	
	elseif curStep >= 1552 and not fixedTrails then
	fixedTrails = true
	
	heartLossMult = 0.9
	heartGainMult = 0.6
	
	setProperty('pumpTrail.visible', false)
	setProperty('skidTrail.visible', false)
	
		runHaxeCode([[

			pumpTrail2 = new FlxTrail(game.gf, null, 4, 24, 0.35, 0.05);
            game.addBehindBF(pumpTrail2);
			setVar('pumpTrail2', pumpTrail2);
			]])
			setProperty('pumpTrail2.color', getColorFromHex('84f5e4'))
		
		runHaxeCode([[

			skidTrail2 = new FlxTrail(game.boyfriend, null, 4, 24, 0.35, 0.05);
            game.addBehindBF(skidTrail2);
			setVar('skidTrail2', skidTrail2);
			]])
			setProperty('skidTrail2.color', getColorFromHex('84f5e4'))
			
	elseif curStep >= 1680 and not killedTrails then
		killedTrails = true
		
		if heartMechanic then setProperty('heartBeats', getProperty('heartBeats') + 0.1) end
		heartLossMult = 0.8
		heartGainMult = 1
		
		setProperty('pumpTrail.visible', false)
		setProperty('skidTrail.visible', false)
		setProperty('pumpTrail2.visible', false)
		setProperty('skidTrail2.visible', false)
		
		
	elseif curStep == 1863 then
		doTweenAlpha('thegoodending', 'blackOverlay', 1, 2.5 / playbackRate, 'linear')
		
		heartLossMult = 0
		
	end
end

function isEven(number)
	return (number % 2 == 0) 
end

function onCountdownTick(counter)
	if counter == 0 or counter == 2 then
		for _, heart in pairs(hearts) do
			playAnim(heart, 'idle', true)
		end
	end
end

function onSongStart()
	for _, heart in pairs(hearts) do
		playAnim(heart, 'idle', true)
	end
end


function onGameOverStart()
	if deadHeart then -- Player died to heart mechanic, let em know to not do that
	makeLuaText('heartTip', "The heart meter ran out.\n(Press SPACE on every other beat to refill it!)", screenWidth, getProperty('boyfriend.x')-100, getProperty('boyfriend.y') - 125)
	setTextSize('heartTip', 20)
	setProperty('heartTip.alpha', 0.0001)
	addLuaText('heartTip', true)
	doTweenAlpha('heartTipAppear', 'heartTip', 1, 2 / playbackRate, 'linear')
	end
end

function onGameOverConfirm(retry)
	if retry then
		cancelTween('heartTipAppear')
		runTimer('fadeTip', 0.7 / playbackRate)
	end
end




alreadyHit = false
canHit = false

function onUpdate(elapsed)
		e = elapsed / playbackRate
		
		if curBeat < 1 then activateMiddlescroll() end
		
		runHaxeCode('heartBar.value = getVar("heartBeats");')
		if getProperty('heartBeats') <= 0 and heartMechanic then
		deadHeart = true;
		setHealth(-69) --owned bozo
		
		elseif getProperty('heartBeats') > 1 then
		setProperty('heartBeats', 1)
	
		end
		
	----- heart mechanic shit ------
	
	if curDecBeat >= hitBeat and not isEven(curBeat) then
	alreadyHit = false
	canHit = true
	end
	
	if alreadyHit then
		cancelTimer('spaceBuffer')
	end
	
	if keyJustPressed('space') and canHit and heartMechanic and not botPlay and not alreadyHit then
		alreadyHit = true
		canHit = false
	
		setProperty('heartBeats', getProperty('heartBeats') +  ( (e / 10 * 25)) * heartGainMult )
		
	end
end

heartGainMult = 1
heartLossMult = 0.5

function heartBeatHit() -- Same thing as onBeatHit, just this for the heart mechanic
	--[[if heartMechanic and not botPlay and alreadyHit then
		canHit = false
		
		setProperty('heartBeats', getProperty('heartBeats') +  ( (e / 10 * 25)) * heartGainMult )]]
		
	if heartMechanic and not botPlay and not alreadyHit and canHit then -- Haven't pressed space yet, give em a little more time
		runTimer('spaceBuffer', 0.1 / playbackRate)
		
	end
	
	if curBeat % 2 == 0 then

		for _, heart in pairs(hearts) do
			playAnim(heart, 'idle', true)
		end

		--canHit = false
		
		if not heartMechanic or botPlay then setProperty('heartBeats', getProperty('heartBeats') +   (e / 10 * 7) ) end
		
		pulseBeat = curBeat + 1
		
	end
	
	if not isEven(curBeat) then
	hitBeat = curBeat + 0.9 -- 0.1 sec window to hit BEFORE the beat
	end
	
	if curBeat == pulseBeat then
		if not heartMechanic or botPlay then 
			setProperty('heartBeats', getProperty('heartBeats') -   (e / 10 * 6) )
			alreadyHit = false
		
			canHit = false
		-- "Pulsing" motion of heart/bar
		end
	end
	
	if getProperty('heartBeats') <= 0.25 then -- Broken heart
	updateHeartStage(4)
	
	elseif getProperty('heartBeats') <= 0.5 then -- Damaged heart
	updateHeartStage(3)
	
	elseif getProperty('heartBeats') <= 0.75 then -- Cracked heart
	updateHeartStage(2)
	
	else -- Normal heart
	updateHeartStage(1)
	
	end
end

function updateHeartStage(curHeartStage)
	if prevStage ~= curHeartStage then
		for _, heartImage in pairs(hearts) do
			setProperty(heartImage..'.alpha', 0.0001)
		end
		setProperty(hearts[curHeartStage]..'.alpha', 1)
		
		cancelTween('corruption')
		
		if curHeartStage == 4 then -- Broken
			runHaxeCode("heartBar.createFilledBar(0x00000000, 0xFF4c6859, false, null);")
			setProperty('iconP1.animation.curAnim.curFrame', 1)
			
			doTweenAlpha('corruption', 'corruptionOverlay', 0.7, 1.5 / playbackRate, 'smoothStepOut')
			
		elseif curHeartStage == 3 then -- Damaged
			runHaxeCode("heartBar.createFilledBar(0x00000000, 0xFF8dcdbf, false, null);")
			
			doTweenAlpha('corruption', 'corruptionOverlay', 0.4, 1.5 / playbackRate, 'smoothStepOut')
			
		elseif curHeartStage == 1.5 then -- Cracked
			runHaxeCode("heartBar.createFilledBar(0x00000000, 0xFFb1f9f1, false, null);")
			
			doTweenAlpha('corruption', 'corruptionOverlay', 0.2, 1.5 / playbackRate, 'smoothStepOut')
			
		else -- Normal
			runHaxeCode("heartBar.createFilledBar(0x00000000, 0xFFb1f9f1, false, null);")
			
			doTweenAlpha('corruption', 'corruptionOverlay', 0.001, 1 / playbackRate, 'smoothStepOut')
			
		end
		
		runHaxeCode("heartBar.updateBar();")
		
	end
	prevStage = curHeartStage
end


------------ Stuff for Lightning Strikes/Light flickers ------------ onCreate, onBeatHit, onTweenCompleted



function onCreate()

	makeLuaSprite('halloweenWhite', nil, 0, 0)
	setScrollFactor('halloweenWhite', 0, 0)
	makeGraphic('halloweenWhite', 1, 1, 'FFFFFF')
	scaleObject('halloweenWhite', screenWidth * 3, screenHeight * 3, false)
	setProperty('halloweenWhite.alpha', 0.0001)
	setBlendMode('halloweenWhite', 'add')
	
end

local lightningStrikeBeat = 0
local lightningOffset = 8
function onBeatHit()
	
	if getRandomBool(10) and curBeat > lightningStrikeBeat + lightningOffset and startedSong then
		lightningStrikeShit()
	end
	
	if getRandomBool(10) then
		playAnim('streetBack', 'flick', true)
	end
	
	heartBeatHit()
end

function lightningStrikeShit()
	lightningStrikeBeat = curBeat
	lightningOffset = getRandomInt(8, 24)
	
		playAnim('candyShopNight', 'flash', true)
	
	if cameraZoomOnBeat then
		setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015)
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03)
	end
		
		if not getProperty('camZooming') then
			doTweenZoom('cG', 'camGame', getProperty('defaultCamZoom'), 0.5 / playbackRate, 'linear')
			doTweenZoom('cH', 'camHUD', 1, 0.5 / playbackRate, 'linear')
		end
	
		setProperty('halloweenWhite.alpha', 0.4)
		doTweenAlpha('hWA', 'halloweenWhite', 0.5, 0.075 / playbackRate, 'linear')
	
end

function onTweenCompleted(t)
	if t == 'hWA' then
		doTweenAlpha('hWA0', 'halloweenWhite', 0, 0.25 / playbackRate, 'linear')
	end
end