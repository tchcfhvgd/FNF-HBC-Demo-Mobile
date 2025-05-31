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
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoops' then
	startVideo('Unmanageable'); --Play video file from "videos/" folder
	playVideo = false;
	end
end

function onCreatePost()
	if not seenCutscene then
	setProperty('camHUD.alpha', 0.0001)
	setProperty('camGame.alpha', 0.0001)
	end
end

-- ####### intro cuscene ###############

function onCreate()
	makeAnimatedLuaSprite('splash', 'Bonus/Unmanageable/WendysNoteSplashes', 0, 0)
	setObjectCamera('splash', 'camOther')
			setProperty('splash.alpha', 0.0001)
			addLuaSprite('splash')
			
	makeLuaSprite('blackOverlay', nil, 0, 0);
	makeGraphic('blackOverlay', 1, 1, '000000');
	scaleObject('blackOverlay', screenWidth, screenHeight, false)
	setObjectCamera('blackOverlay', 'other');
	--if not isStoryMode or seenCutscene then setProperty('blackOverlay.alpha', 0.0001); end
	screenCenter('blackOverlay')
	addLuaSprite('blackOverlay', true);
			
	makeLuaSprite('minenow', 'Bonus/Unmanageable/thisismywendysnow', 0, 0)
	setObjectCamera('minenow', 'other')
	scaleObject('minenow', 0.66666667, 0.66666667, false)
	screenCenter('minenow')
	setProperty('minenow.alpha', 0.0001)
	addLuaSprite('minenow', true)
			

    --Hi Gays
    --makeLuaSprite('gay', nil, -750, 0);
	--makeGraphic('gay', 3000, 3000, 'FFFFFF');
	--addLuaSprite('gay', false);
	
    makeLuaSprite('WendyCity', 'Bonus/Unmanageable/Background/Wendy City', -745, -250);
	setScrollFactor('WendyCity', 0.9, 0.9);
	scaleObject('WendyCity', 1.4, 1.3);
	addLuaSprite('WendyCity', false);

	makeAnimatedLuaSprite('Zertou', 'Bonus/Unmanageable/Background/Zertou', -45, 135);
	addAnimationByIndices('Zertou', 'Bop', 'zertwo', '1,2,3,4,5,6,7,8,9,10', 24, true);
	setScrollFactor('Zertou', 1, 1);
	scaleObject('Zertou', 1.3, 1.3);
	addLuaSprite('Zertou', false);

	makeLuaSprite('WendyShop', 'Bonus/Unmanageable/Background/Wendy Shop', -908, -100);
	setScrollFactor('WendyShop', 1, 1);
	scaleObject('WendyShop', 1.05, 1.25);
	addLuaSprite('WendyShop', false);

	makeAnimatedLuaSprite('WendyTable', 'Bonus/Unmanageable/Background/Wendy Table', -620, 450);
	addAnimationByIndices('WendyTable', 'Bop', 'tables and friends', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16', 24, true);
	setScrollFactor('WendyTable', 1, 1);
	addLuaSprite('WendyTable', false);

	makeAnimatedLuaSprite('CorruptArvehu', 'Bonus/Unmanageable/Background/CArvehu', -120, 410);
	addAnimationByIndices('CorruptArvehu', 'CBop', 'CArvehu', '1,2,3,4,5,6,7,8,9,10', 24, true);
	setScrollFactor('CorruptArvehu', 1, 1);
	scaleObject('CorruptArvehu', 1.15, 1.15);
	addLuaSprite('CorruptArvehu', false);

	makeAnimatedLuaSprite('WendyCounter', 'Bonus/Unmanageable/Background/Wendy Counter', -1040, 470);
	addAnimationByIndices('WendyCounter', 'Fucked', 'counter', '1,2,3,4,5,6,7,8', 24, true);
	setScrollFactor('WendyCounter', 1, 1);
	scaleObject('WendyCounter', 1.2, 1.2);
	addLuaSprite('WendyCounter', false);

	makeLuaSprite('vignette', 'Bonus/Unmanageable/Background/vignette', -330, -180)
	setScrollFactor('vignette', 0, 0);
	scaleObject('vignette', 1.5, 1.5);
	addLuaSprite('vignette', true)
end

function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('Zertou', 'Bop');
		objectPlayAnimation('WendyTable', 'Bop');
		objectPlayAnimation('CorruptArvehu', 'CBop');
		objectPlayAnimation('WendyCounter', 'Fucked');
	end
	
	if curBeat >= 11 and not doneTween then
	doneTween = true
	doTweenAlpha('letusbegin', 'blackOverlay', 0.0001, 5 / playbackRate)
	
	elseif curBeat == 160 then
		cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	
	elseif curBeat == 288 then
		cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
		
	elseif curBeat == 352 then
		cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
		
	elseif curBeat == 416 then
		cameraFlash('camOther', 'ffffff', 2.5 / playbackRate, true)
	
	elseif curBeat == 448 then
		cameraFlash('camOther', 'ffffff', 1 / playbackRate, true)
	
	elseif curBeat == 512 then
		doTweenAlpha('uhoh', 'blackOverlay', 1, 1.75 / playbackRate, 'linear')
		
	elseif curBeat == 524 then
		doTweenAlpha('thisismywendysnow', 'minenow', 1, 0.75 / playbackRate, 'cubeInOut')
		
	elseif curBeat == 528 then
		doTweenAlpha('theend', 'minenow', 0, 0.75 / playbackRate, 'cubeInOut')
	end
end