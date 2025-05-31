noteBops = false
alt = false

duration = 0.05

function onEvent(name, value1, value2)
	if name == 'NoteBop' then
	idkhowtocodethis = tonumber(value1)
	
		if songName == 'Apathetic Wrath' and curBeat >= 207 then
			duration = 0.04
			--debugPrint('fastBop')
		end
		
		if idkhowtocodethis == 1 then
			noteBops = true
			alt = false
		else
			noteBops = false
			if not downscroll then

			for i = 0,7 do
			noteTweenY('killbop'..i, i, 50, duration / playbackRate, 'linear')
			end
			
			else
			
			for i = 0,7 do
			noteTweenY('killbop'..i, i, 570, duration / playbackRate, 'linear')
			end
			
			end
		end
	end
end

function onBeatHit()
	if not downscroll then
	
	if noteBops and curBeat % 1 == 0 and not alt then
		-- DOWN STRUMS
			noteTweenY('oppoleft', 0, 65, duration / playbackRate, 'linear')
			noteTweenY('oppoup', 2, 65, duration / playbackRate, 'linear')
			
			noteTweenY('left', 4, 65, duration / playbackRate, 'linear')
			noteTweenY('up', 6, 65, duration / playbackRate, 'linear')
			
		-- UP STRUMS
			noteTweenY('oppodown', 1, 35, duration / playbackRate, 'linear')
			noteTweenY('opporight', 3, 35, duration / playbackRate, 'linear')
			
			noteTweenY('down', 5, 35, duration / playbackRate, 'linear')
			noteTweenY('right', 7, 35, duration / playbackRate, 'linear')
			alt = not alt
			
	elseif noteBops and curBeat % 1 == 0 and alt then
	
		--Alternation, Y values switch
			noteTweenY('oppoleft', 0, 35, duration / playbackRate, 'linear')
			noteTweenY('oppoup', 2, 35, duration / playbackRate, 'linear')
			
			noteTweenY('left', 4, 35, duration / playbackRate, 'linear')
			noteTweenY('up', 6, 35, duration / playbackRate, 'linear')
			
			
			noteTweenY('oppodown', 1, 65, duration / playbackRate, 'linear')
			noteTweenY('opporight', 3, 65, duration / playbackRate, 'linear')
			
			noteTweenY('down', 5, 65, duration / playbackRate, 'linear')
			noteTweenY('right', 7, 65, duration / playbackRate, 'linear')
			alt = not alt
	end
	
	else
	
	if noteBops and curBeat % 1 == 0 and not alt then
		-- DOWN STRUMS
			noteTweenY('oppoleft', 0, 585, duration / playbackRate, 'linear')
			noteTweenY('oppoup', 2, 585, duration / playbackRate, 'linear')
			
			noteTweenY('left', 4,585, duration / playbackRate, 'linear')
			noteTweenY('up', 6, 585, duration / playbackRate, 'linear')
			
		-- UP STRUMS
			noteTweenY('oppodown', 1, 555, duration / playbackRate, 'linear')
			noteTweenY('opporight', 3, 555, duration / playbackRate, 'linear')
			
			noteTweenY('down', 5, 555, duration / playbackRate, 'linear')
			noteTweenY('right', 7, 555, duration / playbackRate, 'linear')
			alt = not alt
			
	elseif noteBops and curBeat % 1 == 0 and alt then
	
		--Alternation, Y values switch
			noteTweenY('oppoleft', 0, 555, duration / playbackRate, 'linear')
			noteTweenY('oppoup', 2, 555, duration / playbackRate, 'linear')
			
			noteTweenY('left', 4, 555, duration / playbackRate, 'linear')
			noteTweenY('up', 6, 555, duration / playbackRate, 'linear')
			
			
			noteTweenY('oppodown', 1, 585, duration / playbackRate, 'linear')
			noteTweenY('opporight', 3, 585, duration / playbackRate, 'linear')
			
			noteTweenY('down', 5, 585, duration / playbackRate, 'linear')
			noteTweenY('right', 7, 585, duration / playbackRate, 'linear')
			alt = not alt
	end
	
	end
end