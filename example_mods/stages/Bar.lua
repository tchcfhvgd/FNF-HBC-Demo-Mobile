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
			runTimer('whoops', 0.1)
			return Function_Stop; --Prevents the song from starting naturally
	end
	
	function onUpdatePost(elapsed)
	
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoops' then
	startVideo('NeneD1'); --Play video file from "videos/" folder
	playVideo = false;
	end
end
-- intro custcene

function onCreate()
	-- precache time
	makeAnimatedLuaSprite('nenesplash', 'Bar/NeneNoteSplashes', 0, 0)
	setObjectCamera('nenesplash', 'camOther')
			setProperty('nenesplash.alpha', 0.0001)
			addLuaSprite('nenesplash')
	--precache ova
	
    makeLuaSprite('barBG', 'Bar/Background/BarBG', -400, 100);
    scaleObject('barBG', 0.8, 0.8);
	addLuaSprite('barBG');

    makeAnimatedLuaSprite('barSlotMachineBopper', 'Bar/Background/BarSlotMachineBopper', 1335, 195);
    addAnimationByPrefix('barSlotMachineBopper', 'idle', 'Slot machine bopper idle0', 24, false);
    addAnimationByPrefix('barSlotMachineBopper', 'spin', 'Slot machine bopper spin0', 24, false);
    scaleObject('barSlotMachineBopper', 0.8, 0.8);
    addLuaSprite('barSlotMachineBopper');

    makeAnimatedLuaSprite('barSlotMachine', 'Bar/Background/BarSlotMachine', 1650, 200);
    addAnimationByPrefix('barSlotMachine', 'idle', 'Slot machine idle0', 24, true);
    scaleObject('barSlotMachine', 0.8, 0.8);
    addLuaSprite('barSlotMachine');

    makeAnimatedLuaSprite('unoPeople', 'Bar/Background/BarUnoBoppers', 730, 270);
    addAnimationByPrefix('unoPeople', 'idle', 'Unoboppers idle0', 24, false);
    addAnimationByPrefix('unoPeople', 'fear', 'Unoboppers fear0', 24, false);
    addAnimationByPrefix('unoPeople', 'idle fear', 'Unoboppers fear idle0', 24, false);
    scaleObject('unoPeople', 0.8, 0.8);
    addLuaSprite('unoPeople');

    makeAnimatedLuaSprite('poolBopper', 'Bar/Background/BarPoolTable', 1200, 380);
    addAnimationByPrefix('poolBopper', 'idle', 'Poolboppers idle0', 24, false);
    addAnimationByPrefix('poolBopper', 'fear', 'Poolboppers fear0', 24, false);
    addAnimationByPrefix('poolBopper', 'idle fear', 'Poolboppers fear idle0', 24, false);
    scaleObject('poolBopper', 0.7, 0.7);
    addLuaSprite('poolBopper');

    makeAnimatedLuaSprite('bartenderPot', 'Bar/Background/PotBartender', -765, 280);
    addAnimationByPrefix('bartenderPot', 'idle', 'Pot idle0', 24, false);
    addAnimationByPrefix('bartenderPot', 'fear', 'Pot fear0', 24, false);
    addAnimationByPrefix('bartenderPot', 'idle fear', 'Pot fear idle0', 24, false);
    scaleObject('bartenderPot', 0.78, 0.78);
    addLuaSprite('bartenderPot');

    makeAnimatedLuaSprite('barTopper', 'Bar/Background/BarTop', -400, -250);
    addAnimationByPrefix('barTopper', 'idle', 'Bartop0', 24, true);
    scaleObject('barTopper', 0.8, 0.8);
    addLuaSprite('barTopper');

    makeAnimatedLuaSprite('stoolBoppers', 'Bar/Background/BarStools', -300, 400);
    addAnimationByPrefix('stoolBoppers', 'idle', 'Stoolboppers idle0', 24, false);
    scaleObject('stoolBoppers', 0.8, 0.8);
    addLuaSprite('stoolBoppers');


	-- additional stuff
	makeLuaSprite('candyvig', 'CandyShop/Background/Vignette', 0, 0)
	setObjectCamera('candyvig', 'camGame') --camGame..?! unbelievable,,,
	setProperty('candyvig.alpha', 1)
	setScrollFactor('candyvig', 0, 0);
	setObjectOrder('candyvig', 15)
	scaleObject('candyvig', 1.5, 1.5) -- 1.43 fits the screen best but im pretty sure it's 1.5 in the vid
	screenCenter('candyvig', 'XY')
	addLuaSprite('candyvig', true)
	
	setProperty('skipArrowStartTween', true)
	--setProperty('camGame.alpha', 0.0001)
	setProperty('camHUD.alpha', 0.0001)
	
	makeLuaSprite('cinemababy', nil, 0, 0);
	makeGraphic('cinemababy', 1, 1, '000000');
	scaleObject('cinemababy', screenWidth, screenHeight, false)
	setObjectCamera('cinemababy', 'other');
	screenCenter('cinemababy')
	addLuaSprite('cinemababy', true);
end

function onCreatePost()
	if downscroll then -- fully conceals the text in black bars
	setProperty('timeTxt.y', getProperty('timeTxt.y')+5)
	setProperty('botplayTxt.y', getProperty('botplayTxt.y')+5)
	else
	setProperty('botplayTxt.y', getProperty('botplayTxt.y')-13)
	end
end
	

function smolzoom()
 zoom = getProperty('defaultCamZoom')+0.0225
		setProperty('barTop.y', getProperty('barTop.y')-7.225)
		setProperty('barBottom.y', getProperty('barBottom.y')+7.225)
		setProperty('camGame.zoom', zoom)
		setProperty('defaultCamZoom', zoom)
end

healthDrain = 0.0125 -- also these numbers are completely guessed im fairly certain the original also sets healthGain
-- going back and fixing bad code... happi
function opponentNoteHit()
		health = getProperty('health')
			if getProperty('health') > healthDrain then
				if difficulty == 0 then
				addHealth(-healthDrain);
			else 
				addHealth(-healthDrain/2);
			end
			end
end
	

function onStepHit()
	if curStep >= 5 and not shownGame then
	shownGame = true
		doTweenAlpha('introGame', 'cinemababy', 0, 1 / playbackRate, 'cubeInOut')
	end
	
	if curStep == 16 then
	setProperty('dad.cameraPosition', {-50,90})
	setProperty('boyfriend.cameraPosition', {0,112})
	doTweenZoom("zoomies2", "camGame", 0.8, 5 / playbackRate, 'expoOut')
	end
	
	if curStep == 144 then
	setProperty('dad.cameraPosition', {-50,0})
	setProperty('boyfriend.cameraPosition', {0,0})
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	--setProperty('candyvig.alpha', 1)
	doTweenAlpha('yeshud', 'camHUD', 1, 7 / playbackRate, 'expoOut')
	--setObjectCamera('candyvig', 'camHUD')
	end
	
	if curStep == 400 then
	--doTweenZoom("zoomies3", "camGame", 0.8, 5 / playbackRate, 'expoOut')
	setProperty('defaultCamZoom', 0.8)
	end
	
	if curStep == 528 then
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	setProperty('defaultCamZoom', 0.7)
	end
	
	if curStep == 784 then
	setProperty('dad.cameraPosition', {-50,90})
	setProperty('boyfriend.cameraPosition', {0,112})
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	--doTweenZoom("zoomies4", "camGame", 0.8, 5 / playbackRate, 'expoOut')
	setProperty('defaultCamZoom', 0.8)
	doTweenAlpha('longkillhud', 'camHUD', 0.0001, 7 / playbackRate, 'expoOut')
	--setObjectCamera('candyvig', 'camOther')
	--doTweenAlpha('a1sauce', 'candyvig', 0.6, 1 / playbackRate, 'expoOut')
	end
	
	--funny
	
	if curStep == 832 then
	--bigzoom
	cancelTween('INtopBar')
	cancelTween('INbottomBar')
	zoom = getProperty('defaultCamZoom')+0.03
		setProperty('barTop.y', getProperty('barTop.y')-10)
		setProperty('barBottom.y', getProperty('barBottom.y')+10)
		setProperty('camGame.zoom', zoom)
		setProperty('defaultCamZoom', zoom)
	end
	
	if curStep == 836 then
    --smolzoom
smolzoom()
    end
    
    if curStep == 840 then
    --smolzoom
smolzoom()
    end
    
    if curStep == 844 then
    --smolzoom
smolzoom()
    end
    
    if curStep == 848 then
    --smolzoom
smolzoom()
    end
	
	
	if curStep == 912 then
	setProperty('dad.cameraPosition', {-50,0})
	setProperty('boyfriend.cameraPosition', {0,0})
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	doTweenAlpha('yeshud', 'camHUD', 1, 7 / playbackRate, 'expoOut')
	--setObjectCamera('candyvig', 'camHUD')
	setProperty('defaultCamZoom', 0.7)
	--doTweenAlpha('a2', 'candyvig', 1, 1 / playbackRate, 'expoOut')
	healthDrain = 0.029
	end
	
	if curStep == 1168 then
	cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	--doTweenZoom("zoomies5", "camGame", 0.8, 5 / playbackRate, 'expoOut')
	setProperty('defaultCamZoom', 0.8)
	--doTweenAlpha('justnoticedthis', 'candyvig', 0.5, 1 / playbackRate, 'expoOut')
	healthDrain = 0.05
	end
	
	if curStep == 1232 then
	setProperty('defaultCamZoom', 0.7)
	--doTweenAlpha('justnoticedthis2', 'candyvig', 1, 1 / playbackRate, 'expoOut')
	end
	
	if curStep == 1296 then
	picoDead = true
	objectPlayAnimation('bartenderPot', 'fear', false);
	objectPlayAnimation('poolBopper', 'fear', false);
	objectPlayAnimation('unoPeople', 'fear', false);
	end
end

picoDead = false
darnLoop = false
	
function onUpdate()
	if picoDead and getProperty('gf.animation.curAnim.finished') then
	picoDead = false
	darnLoop = true
	playAnim('gf', 'Feared-loop', true)
	end
	
	if darnLoop and getProperty('gf.animation.curAnim.finished') then
	playAnim('gf', 'Feared-loop', true)
	end
	-- original anim didn't last long enough, had to mess with indices
	-- realizing much later that there was a way easier way to do this..damn
end

endVideo = true
function onEndSong()
	if isStoryMode and endVideo then
	startVideo('NeneD1End')
	endVideo = false
	return Function_Stop
	end
return Function_Continue
end