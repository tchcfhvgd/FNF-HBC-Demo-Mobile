local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'dialogue_2');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end

function onEndSong()
	if not allowEndShit and isStoryMode then
	setProperty('picocrack.alpha', 0)
	setObjectCamera('healthBar', 'camHUD')
	setObjectCamera('healthBarBG', 'camHUD')
	setObjectCamera('iconP1', 'camHUD')
	setObjectCamera('iconP2', 'camHUD')
	
	setObjectOrder('iconP1', getObjectOrder('courtOverlay')+3)
	setObjectOrder('iconP2', getObjectOrder('courtOverlay')+4)
	
	setObjectOrder('healthBar', getObjectOrder('iconP1')-1)
	setObjectOrder('healthBarBG', getObjectOrder('iconP1')-2)
	
	setObjectOrder('scoreTxt', getObjectOrder('courtOverlay')+1)
	 setProperty('inCutscene', true);
	 startDialogue('end-dialogue'); 
	 allowEndShit = true;
	 return Function_Stop;
	end
	return Function_Continue;
   end