function onUpdatePost()
	
	--Zoom fixes, probably not optimized cus i dont feel like it
	if curBeat >= 80 and curBeat < 83 then
	setProperty('defaultCamZoom', 0.83)
	end
	
	
	if curBeat >= 112 and curBeat < 115 then
	setProperty('defaultCamZoom', 0.98)
	end
	
	if curBeat >= 144 and curBeat < 147 then
	setProperty('defaultCamZoom', 0.83);
	end
	
	if curBeat >= 160 and curBeat < 163 then
	setProperty('defaultCamZoom', 1.02);
	end
	
	if curBeat >= 176 and curBeat < 179 then
	setProperty('defaultCamZoom', 0.83);
	end
	
	if curBeat >= 192 and curBeat < 195 then
	setProperty('defaultCamZoom', 0.98);
	end
end

function onBeatHit()
	if curBeat >= 80 and not changed1 then
	changed1 = true
		for index = 4, 7 do
			setPropertyFromGroup('strumLineNotes', index, 'texture', 'HellGates/HellNoteAssets2');
		end
	end

	if curBeat == 176 and not changed2 then
	changed2 = true
		for index = 4, 7 do
			setPropertyFromGroup('strumLineNotes', index, 'texture', 'HellGates/HellNoteAssets3');
		end
	end
end