function onCreate()

--Iterate over all notes

for i = 0, getProperty('unspawnNotes.length')-1 do

--Check if the note is an Blammed Note

if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'bluefireNote' then

setPropertyFromGroup('unspawnNotes', i, 'texture', 'bluefireNote_assets'); --Change texture

setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);

if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored

setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties

end

end

end

--debugPrint('Script started!')

end

-- Function called when you hit a note (after note hit calculations)

-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"

-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right

-- noteType: The note type string/tag

-- isSustainNote: If it's a hold note, can be either true or false

function noteMiss(id, noteData, noteType, isSustainNote)

if noteType == 'bluefireNote' then

setProperty('health', -500);

end

end 

      function goodNoteHit(id, i, noteType, isSustainNote)

      if noteType == 'bluefireNote' then
	  darn = true
       triggerEvent('Play Animation','fire', '2')
	   setProperty('gf.specialAnim', true)
       triggerEvent('Play Animation','dodge', 'BF')
	   setProperty('bf.specialAnim', true)
       playSound('fire', 0.8);
       end
end

function onUpdate()

	if darn then
	darn = false
	runTimer('darnCooldown', 0.1 / playbackRate );
	
	for i = 0, getProperty('notes.length')-1 do
		
			if getPropertyFromGroup('notes', i, 'mustPress') == false then
				if getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' then
					if getPropertyFromGroup('notes', i, 'noAnimation') == false then
						setPropertyFromGroup('notes', i, 'noAnimation', true)
					end
				end
			end
		
	end
	
	end
	
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'darnCooldown' then
	
	for i = 0, getProperty('notes.length')-1 do
		
			if getPropertyFromGroup('notes', i, 'mustPress') == false then
				if getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' then
					if getPropertyFromGroup('notes', i, 'noAnimation') == true then
						setPropertyFromGroup('notes', i, 'noAnimation', false)
					end
				end
			end
		
	end

	end

end