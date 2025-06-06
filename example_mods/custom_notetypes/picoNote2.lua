function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'picoNote2' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'picoNote_assets2'); --Change notetexture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -0.6);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', -0.2);

			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', false); -- make it so original character doesn't sing these notes

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end