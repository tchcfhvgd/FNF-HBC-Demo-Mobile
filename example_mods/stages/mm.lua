function onCreate()

	makeLuaSprite('wall', 'mm/wall', -170, 10);

	addLuaSprite('wall', false)

	scaleObject('wall', 0.9, 0.9);

end

function onCreatePost()
	makeAnimatedLuaSprite('defsplash', 'noteSplashes', 0, 0) --splash precache
	setObjectCamera('defsplash', 'camOther')
	setProperty('defsplash.alpha', 0.0001);
	addLuaSprite('defsplash', true)
	
    makeLuaText('botplayTxtAlt', 'BOTPLAY', screenWidth - 800, 400, getProperty('timeTxt.y') + 25);
    setTextFont('botplayTxtAlt', 'vcr.ttf');
    setTextSize('botplayTxtAlt', 32);
    setTextAlignment('botplayTxtAlt', 'CENTER');
    setScrollFactor('botplayTxtAlt', 0, 0);
    setTextBorder('botplayTxtAlt', 1.25, '0xFF000000');
    addLuaText('botplayTxtAlt', false);
    setObjectCamera('botplayTxtAlt', 'camHUD');
	
	if not downscroll then setProperty('timeTxt.y', getProperty('botplayTxt.y')) end
	
	if downscroll and middlescroll or middlescroll then 
		setProperty('botplayTxtAlt.y', getProperty('botplayTxt.y')) 
		setProperty('botplayTxtAlt.x', -150)
	elseif downscroll then
		setProperty('botplayTxtAlt.y', getProperty('timeTxt.y') - 70)
	end
	
	setProperty('showRating', false)
	setProperty('showComboNum', false)
end

function onUpdatePost(elapsed)
    if botPlay then
		setProperty('botplayTxt.alpha', 0)
        botplayAltSine = getProperty('botplaySine') + (180 * elapsed);
        setProperty('botplayTxtAlt.alpha', 1 - math.sin((math.pi * botplayAltSine) / 180));
    end
end

function onCountdownTick(c)
    if c == 1 then
        loadGraphic('countdownReady','mm/hud/ready')
    end
    if c == 2 then
        loadGraphic('countdownSet','mm/hud/set')
    end
    if c == 3 then
        loadGraphic('countdownGo','mm/hud/go')
    end
end

