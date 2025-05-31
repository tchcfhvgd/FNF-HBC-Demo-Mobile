function onCreate()
	runTimer('override', 0.0001 / playbackRate)
end

function onTimerCompleted(tag)
	if tag == 'override' then
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'hellNote2' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'HellGates/HellNoteAssets3'); --Change notetexture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -0.7);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 0);

			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', false); -- make it so original character doesn't sing these notes

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
	
	end
end