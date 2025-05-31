function onCreatePost()
	makeAnimatedLuaSprite('piconote1', 'picoNote_assets1', 0, 0)
	setObjectCamera('piconote1', 'camOther')
			setProperty('piconote1.alpha', 0.0001)
			addLuaSprite('piconote1')
			
	
	makeAnimatedLuaSprite('piconote2', 'picoNote_assets2', 0, 0)
	setObjectCamera('piconote2', 'camOther')
			setProperty('piconote2.alpha', 0.0001);
			addLuaSprite('piconote2')
			
			precacheSound('fire');
			
	makeAnimatedLuaSprite('chudfire', 'fireNote_assets', 0, 0)
	setObjectCamera('chudfire', 'camOther')
			setProperty('chudfire.alpha', 0.0001);
			addLuaSprite('chudfire')
	
end