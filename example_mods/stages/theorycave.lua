--[["defaultZoom": 0.68
"boyfriend": [1400, 200],
	"girlfriend": [875, 425],
	"opponent": [50, 350],
	"hide_girlfriend": false,

	"camera_boyfriend": [-570, -100],
	"camera_opponent": [450, -200],
	"camera_girlfriend": [0, 0],
	"camera_speed": 1
	]]--
	
function onCreatePost()
	
	makeAnimatedLuaSprite('defsplash', 'noteSplashes', 0, 0) --splash precache
	setObjectCamera('defsplash', 'camOther')
	setProperty('defsplash.alpha', 0.0001);
	addLuaSprite('defsplash', true)

	makeLuaSprite('thecave', 'theorycave/Background/mackpacktheorycave', -50, 0)
	addLuaSprite('thecave', false)
	setScrollFactor('thecave', 1, 1);
	scaleObject('thecave', 1.5, 1.5);
	--setProperty('thecave.y', getProperty('thecave.y')-40);
	
	makeLuaSprite('blackOverlay', nil, 0, 0);
	makeGraphic('blackOverlay', 1, 1, '000000');
	scaleObject('blackOverlay', screenWidth * 2, screenHeight * 2, false)
	screenCenter('blackOverlay')
	addLuaSprite('blackOverlay', false);
	
	setProperty('blackOverlay.alpha', 0.0001)
	
	makeLuaSprite('candyvig', 'CandyShop/Background/Vignette', 0, 0)
	setObjectCamera('candyvig', 'camGame')
	setProperty('candyvig.alpha', 1)
	setScrollFactor('candyvig', 0, 0);
	scaleObject('candyvig', 1.5, 1.5)
	screenCenter('candyvig', 'XY')
	addLuaSprite('candyvig', false)
	setProperty('candyvig.alpha', 0.3)
	
	setProperty('iconP1.antialiasing', getProperty('boyfriend.antialiasing'))
end

function onBeatHit()
	if curBeat >= 30 and not thing then
	thing = true
	setProperty('boyfriend.cameraPosition', {100, 0})
	
	elseif curBeat >= 64 and not thing1 then
	thing1 = true
		setProperty('dad.cameraPosition', {160, 225})
		
	elseif curBeat >= 256 and not thing2 then
	thing2 = true
		setProperty('dad.cameraPosition', {-45, 295})
		setProperty('boyfriend.cameraPosition', {-150, 20})
		
	elseif curBeat >= 320 and not thing3 then
	thing3 = true
	setProperty('dad.cameraPosition', {160, 225})
	setProperty('boyfriend.cameraPosition', {75, 0})
	
	--elseif curBeat == 368 then
	--doTweenZoom('idklol', 'camGame', 0.9, 4 / playbackRate, 'sineInOut')
	--setProperty('defaultCamZoom', 0.9)
		
	elseif curBeat == 384 then
		isZoomin = true
		setProperty('defaultCamZoom', 0.78)
		doTweenZoom("thephoneawakens", "camGame", 1.3, 11 / playbackRate, 'sineInOut')
		setProperty('isCameraOnForcedPos', true)
		
	elseif curBeat >= 448 and not fixedCam then
		fixedCam = true
		setProperty('isCameraOnForcedPos', false)
		
	elseif curBeat >= 480 and not thing3andahalflolz then
	thing3andahalflolz = true
		setProperty('boyfriend.cameraPosition', {150, -10}) -- all 3 singing
		
	elseif curBeat >= 543 and not thing4 then
	thing4 = true
	setProperty('dad.cameraPosition', {160, 225})
	setProperty('boyfriend.cameraPosition', {75, 0})
	
	elseif curBeat >= 608 and not thing5 then
	thing5 = true
	setProperty('boyfriend.cameraPosition', {100, 0})
	
	end
	
	if curBeat == sectionToBeat(96) - 1 or curBeat == sectionToBeat(98) - 1 or curBeat == sectionToBeat(100) - 1 or curBeat == sectionToBeat(102) - 1 or curBeat == sectionToBeat(104) - 1 or curBeat == sectionToBeat(106) - 1 or curBeat == sectionToBeat(108) - 1 then
	setProperty('camZoomingMult', 1)
	
	elseif curBeat == sectionToBeat(96) + 2 or curBeat == sectionToBeat(98) + 2 or curBeat == sectionToBeat(100) + 2 or curBeat == sectionToBeat(102) + 2 or curBeat == sectionToBeat(104) + 2 or curBeat == sectionToBeat(106) + 2 or curBeat == sectionToBeat(108) + 2 then
	setProperty('camZoomingMult', 0)
	
	elseif curBeat == 448 then
	setProperty('camZoomingMult', 1)
	
	elseif curBeat == 592 then
	setProperty('gf.cameraPosition[1]', getProperty('gf.cameraPosition[1]') + 30)
	
	end
end

function sectionToBeat(section)
	return section * 4
end

function onSectionHit()

	if curSection == 64 then
		doTweenAlpha('slowpart', 'blackOverlay', 0.5, 2 / playbackRate, 'cubeOut')
		
	elseif curSection == 76 then
		doTweenAlpha('lettherebesomelight', 'blackOverlay', 0.4, 1 / playbackRate, 'cubeOut')
	
	elseif curSection == 80 then
		doTweenAlpha('slowpartover', 'blackOverlay', 0, 1 / playbackRate, 'cubeInOut')

	elseif curSection == 96 or curSection == 98 or curSection == 100 or curSection == 102 or curSection == 104 or curSection == 106 or curSection == 108 then
		playAnim('gf', 'ring', true)
		
		setProperty('camZoomingMult', 1)
		
		cameraShake('hud', 0.004, 0.8 / playbackRate)
		
	
	end
	
	
	if curSection >= 96 and curSection < 113 then -- Keep cam focused on gf so dad and bf can sing
		triggerEvent('Camera Follow Pos',getMidpointX('gf')+getProperty('gf.cameraPosition[0]')-40,getMidpointY('gf')+getProperty('gf.cameraPosition[1]')-35);
	end
end

function onTweenCompleted(tag)
	if tag == 'thephoneawakens' then
		isZoomin = false
		setProperty('camZoomingMult', 1)
		setProperty('defaultCamZoom', 1.3)
	
	elseif tag == 'slowpartover' then
		removeLuaSprite('defsplash', true)
		removeLuaSprite('blackOverlay', true)
	
	end
end

function onPause()
	shakeProgress = getProperty('camHUD._fxShakeDuration') -- Stops shaking while paused, resumes shake when unpaused
	setProperty('camHUD._fxShakeDuration', 0)
end

function onResume()
	setProperty('camHUD._fxShakeDuration', shakeProgress)
end