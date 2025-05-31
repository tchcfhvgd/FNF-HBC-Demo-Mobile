onCreatePost = function()
	setProperty('boyfriendGroup.visible', false)
	
	for i=0,3 do
		noteTweenX(i+4, i+4, 420+(i*110), 0.0001 / playbackRate)
	end  	
end

onSongStart = function()
	if not downscroll then 
	setProperty('timeTxt.y', 10) 
	setProperty('timeTxt.x', getProperty('timeTxt.x') + 5) 
	end
	
	makeAnimatedLuaSprite('defsplash', 'noteSplashes', 0, 0) --splash precache
	setObjectCamera('defsplash', 'camOther')
	setProperty('defsplash.alpha', 0.0001);
	addLuaSprite('defsplash', true)
end

function onStepHit()
   --if curStep < 185 then 
   --   for i=0,3 do
   --      noteTweenAlpha(i+0, i, 0, 0.3)
   --   end  
   --end
   --if curStep > 185 then 
	--	noteTweenAlpha("NoteAppear0", 0, 1, 0.3, cubeInOut)
	--	noteTweenAlpha("NoteAppear1", 1, 1, 0.3, cubeInOut)
	--	noteTweenAlpha("NoteAppear2", 2, 1, 0.3, cubeInOut)
	--	noteTweenAlpha("NoteAppear3", 3, 1, 0.3, cubeInOut)
   --end
  -- 
  --    setProperty('defaultCamZoom', 1.4);
  -- end
end



function onUpdate(elpased)

		for i=0,3 do
			noteTweenX(i+0, i, -1000, 0.3)
		end	
	  	
		for i = 0, 3 do
		setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
		end
		
end
