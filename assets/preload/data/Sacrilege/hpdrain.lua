function opponentNoteHit(_, _, t)
    if t ~= 'GF Sing' and dadName == 'pico_d1_confused' and getHealth() > 0.02 then
        if difficulty == 0 then
			addHealth(-0.02)
		else 
			addHealth(-0.01)
		end
    
	elseif t == 'GF Sing' and gfName == 'darnell_d1_confused' and getHealth() > 0.02 then
        if difficulty == 0 then
			addHealth(-0.02)
		else 
			addHealth(-0.01)
		end
    end
end

playVideo = true
function onStartCountdown()
	if playVideo and isStoryMode and not seenCutscene then
	playVideo = false
	runTimer('whoops', 0.2)
	return Function_Stop;
	end
	
setProperty('camHUD.alpha', 1)
setProperty('camGame.alpha', 1)
return Function_Continue;
end

function onCreatePost()
setProperty('camGame.zoom', 1)
setProperty('defaultCamZoom', 1)

if isStoryMode and not seenCutscene then
setProperty('camHUD.alpha', 0.0001)
setProperty('camGame.alpha', 0.0001)
end

end

endVideo = true
function onEndSong()
	if endVideo and isStoryMode then
	endVideo = false
	setProperty('camHUD.alpha', 0)
	setProperty('camGame.alpha', 0)
	startVideo('PicoD1End')
	return Function_Stop;
	end
return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'whoops' then
	startVideo('PicoD1'); --Play video file from "videos/" folder
	playVideo = false;
	end
end