function onCreate()
	if not shadersEnabled then
	close(true)
	end
end

onCreatePost = function()
	initLuaShader('GBlur')
	
	for i = 0, 3 do
		setSpriteShader('opponentStrums.members['..i..']', 'GBlur')
	end
	
	setSpriteShader('dad', 'GBlur')
	setSpriteShader('gf', 'GBlur')
end

onSpawnNote = function()
	if not getProperty('notes.members[0].mustPress') then
		setSpriteShader('notes.members[0]', 'GBlur')
	end
end