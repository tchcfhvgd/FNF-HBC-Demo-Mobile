function onCreatePost()
	makeLuaSprite('sky', 'court/court1', -300, -200)
	addLuaSprite('sky', false)
	setObjectOrder('sky', 1)
	
	makeLuaSprite('buildings', 'court/court2', -300, 20)
	scaleObject('buildings', 0.7, 0.7, false)
	addLuaSprite('buildings', false)
	setObjectOrder('buildings', 2)
	
	makeLuaSprite('windows', 'court/court3', -300, 20)
	scaleObject('windows', 0.7, 0.7, false)
	addLuaSprite('windows', false)
	setObjectOrder('windows', 3)
	setProperty('windows.alpha', 0.0001)
	
	
	makeLuaSprite('backwall', 'court/court4', -200, -30)
	scaleObject('backwall', 0.7, 0.7, false)
	addLuaSprite('backwall', false)
	setObjectOrder('backwall', 4)
	
	makeLuaSprite('court', 'court/court5', -200, 37)
	scaleObject('court', 0.68, 0.68, false)
	addLuaSprite('court', false)
	setObjectOrder('court', 5)
	
	makeLuaSprite('courtOverlay', 'court/vignette', 0, 0)
	scaleObject('courtOverlay', 1, 1)
	addLuaSprite('courtOverlay', false)
	setObjectCamera('courtOverlay', 'camHUD')
	--setObjectOrder('courtOverlay', 13)
	
	setObjectOrder('gfGroup', 11)
	setObjectOrder('dadGroup', 12)
	setScrollFactor('sky', 0.3, 0.3)
	setScrollFactor('buildings', 0.5, 0.8)
	setScrollFactor('windows', 0.5, 0.8)
	setScrollFactor('backwall', 0.9, 0.9)
	setScrollFactor('court', 1, 1);
	-- precache
	makeAnimatedLuaSprite('picosplash', 'picoNote_splashes', 0, 0)
	setObjectCamera('picosplash', 'camOther')
			setProperty('picosplash.alpha', 0.0001);
			addLuaSprite('picosplash')
	-- precache ova
	makeAnimatedLuaSprite('boombox', 'court/boombox', 1050, 720)
			addAnimationByPrefix('boombox', 'idle', 'thingy', 24, false)
			addLuaSprite('boombox', false)
			setObjectOrder('boombox', 6)
			setObjectCamera('boombox', 'camGame')
			setScrollFactor('boombox', 1, 1);
			
	-- dk why im doin this
	setObjectOrder('timeTxt', 69)
			
			function onBeatHit()
				if curBeat % 1 == 0 then
				for i = 0, 1 do
				playAnim('boombox', 'idle', true, false, 0)
				end
				end
			end
end

function onCountdownTick()
	playAnim('boombox', 'idle', true, false, 0)
end