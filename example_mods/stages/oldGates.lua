function onCreate()
	addCharacterToList('senorlemon2', 'dad')
end

function onCreatePost()
-- precache time
	makeAnimatedLuaSprite('lemonsplash', 'HellGates/HellNoteSplashes', 0, 0)
	setObjectCamera('lemonsplash', 'camOther')
			setProperty('lemonsplash.alpha', 0.0001)
			addLuaSprite('lemonsplash')
			
	makeAnimatedLuaSprite('lemonnote2', 'HellGates/HellNoteAssets2', 0, 0)
	setObjectCamera('lemonnote2', 'camOther')
			setProperty('lemonnote2.alpha', 0.0001)
			addLuaSprite('lemonnote2')
			
			makeAnimatedLuaSprite('lemonnote3', 'HellGates/HellNoteAssets3', 0, 0)
	setObjectCamera('lemonnote3', 'camOther')
			setProperty('lemonnote3.alpha', 0.0001)
			addLuaSprite('lemonnote3')
			

-- preache ova

	makeLuaSprite('hellBack', 'senorlemon/back', -600, -200)
	setScrollFactor('hellBack', 0.9, 0.9)
	addLuaSprite('hellBack')
	
	makeLuaSprite('hellLava', 'senorlemon/placeholderlava', -600, -200)
	setScrollFactor('hellLava', 0.9, 0.9)
	addLuaSprite('hellLava')
	
	makeLuaSprite('hellRoof', 'senorlemon/roof', -600, -200)
	setScrollFactor('hellRoof', 0.9, 0.9)
	addLuaSprite('hellRoof')
	
	makeLuaSprite('hellDoor', 'senorlemon/door', -600, -200)
	scaleObject('hellDoor', 1.1, 1.1, false)
	addLuaSprite('hellDoor')
	
	makeLuaSprite('hellFloor', 'senorlemon/floor', -600, -200)
	scaleObject('hellFloor', 1.1, 1.1, false)
	addLuaSprite('hellFloor')
	
	
	-- SHUT THE FUCK UP DEBUGGER
	for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then
            setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true);
        end
    end
end


--[[function onSpawnNote(i) --realized this isnt needed because of hellNote
	if change1 then
	setPropertyFromGroup('notes', i, 'texture', 'HellGates/HellNoteAssets2')
	elseif change2 then
	setPropertyFromGroup('notes', i, 'texture', 'HellGates/HellNoteAssets3')
	end
end]]--


function onBeatHit()
	if curBeat == 78 then
	runHaxeCode('FlxG.camera.fade(0xFFFFFFFF, '..1 / playbackRate..', false);')
	end
	
	if curBeat == 80 then
	runHaxeCode('FlxG.camera.stopFX();')
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	setProperty('defaultCamZoom', 1)
		--change1 = true
		--for index = 0, 7 do
       -- setPropertyFromGroup('strumLineNotes', index, 'texture', 'HellGates/HellNoteAssets2');
		--end
	end

	if curBeat == 112 then
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	setProperty('defaultCamZoom', 0.7)
	end
	
	if curBeat == 144 then
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	setProperty('healthGain', 0.5)
	end
	
	if curBeat == 176 then
	function opponentNoteHit()
			if getHealth() > 0.032 then
			addHealth(-0.032)
			end
		end
		
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..2 / playbackRate..', true);')
	setProperty('defaultCamZoom', 1)
	setProperty('healthGain', 0.25)
		--change1 = false
		--change2 = true
		--for index = 0, 7 do
        --setPropertyFromGroup('strumLineNotes', index, 'texture', 'HellGates/HellNoteAssets3');
		--end
	end
	
	if curBeat == 192 then
	setProperty('healthGain', 0.0)
	end
	
	if curBeat == 208 then
	setProperty('defaultCamZoom', 0.625)
	end
	
	if curBeat == 220 then
	setProperty('defaultCamZoom', 0.7)
	end
	
	if curBeat == 224 then
	runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, '..1 / playbackRate..', true);')
	runHaxeCode('FlxG.camera.fade(0x00000000, '..1.2 / playbackRate..', false);')
	setProperty('healthBar.alpha', 0)
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	setProperty('defaultCamZoom', 0.7)
	doTweenAlpha('nohud', 'camHUD', 0, 1.2 / playbackRate, 'cubeInOut')
	end
end

function onStepHit()
	if curStep == 880 or curStep == 882 or curStep == 884 or curStep == 886 or curStep == 888 or curStep == 890 or curStep == 892 or curStep == 894 then
	zoom = getProperty('defaultCamZoom')
	setProperty('defaultCamZoom', zoom+ 0.075)
	end
end