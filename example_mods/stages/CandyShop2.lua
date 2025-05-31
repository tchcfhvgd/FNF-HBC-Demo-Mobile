function onCreatePost()
-- recreating the whole stage just so i can change the default zoom for atonement :skull:
	-- funni splash precache
	makeLuaSprite('spookysplash', 'CandyShop/SpookyNoteSplashes', 0, 0)
	setObjectCamera('spookysplash', 'camOther')
			setProperty('spookysplash.alpha', 0.0001);
			addLuaSprite('spookysplash')
	
	makeLuaSprite('candyvig', 'CandyShop/Background/Vignette', 0, 0)
	addLuaSprite('candyvig', false)
	setObjectOrder('candyvig', 1)
	setObjectCamera('candyvig', 'camHUD')
	
	-- original candyshop stuff
	
	makeLuaSprite('candyshop', 'CandyShop/Background/CandyShop', -300, 200)
	scaleObject('candyshop', 0.88, 0.88, false)
	addLuaSprite('candyshop', false)
	setObjectOrder('candyshop', 1)
	setObjectCamera('candyshop', 'camGame')
	
	makeLuaSprite('candywall', 'CandyShop/Background/CandyShopWall', -450, 230)
	-- i thought this was meant to be scaled, apparently it's not??? wtf
	setObjectCamera('candywall', 'camGame')
	setObjectOrder('candywall', 2)
	addLuaSprite('candywall')
	
	makeLuaSprite('candyback', 'CandyShop/Background/BackCounter', -300, 200)
	scaleObject('candyback', 0.9, 0.9, false)
	setObjectCamera('candyback', 'camGame')
	addLuaSprite('candyback', false)
	setObjectOrder('candyback', 4)

	makeLuaSprite('candyfront', 'CandyShop/Background/FrontCounter', -300, 200)
	scaleObject('candyfront', 0.9, 0.9, false)
	setObjectOrder('candyfront', 15)
	setObjectCamera('candyfront', 'camGame')
	addLuaSprite('candyfront', true)
	
	-- attic sprites are in Attic Hallucination event
	
	setProperty('healthBar.alpha', 0.0001)
	setProperty('healthBarBG.alpha', 0.0001)
	setProperty('iconP1.alpha', 0.0001)
	setProperty('iconP2.alpha', 0.0001)
	
	
	setObjectOrder('iconP1', 69)
end