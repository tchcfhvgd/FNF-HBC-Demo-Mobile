function onSpawnNote(_, _, t)
	if t == 'ignorableNote' and getProperty('notes.members[0].mustPress') then
		setProperty('notes.members[0].ignoreNote', not getProperty('cpuControlled')) -- Miss has no penalties
	
	elseif t == 'ignorableNote' and songName == 'Empty Memories' and not getProperty('notes.members[0].mustPress') then
		setProperty('notes.members[0].noteType', 'GF Sing')
		setProperty('notes.members[0].gfNote', true)
		
		setProperty('notes.members[0].noAnimation', true)
	end
end