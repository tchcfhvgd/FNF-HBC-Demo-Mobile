local barFeared = false;
function beatHitDance(counter)
	if counter % 2 == 0 then
		if barFeared then
			-- objectPlayAnimation('stoolBoppers', 'idle fear', false);
			objectPlayAnimation('bartenderPot', 'idle fear', false);
			objectPlayAnimation('poolBopper', 'idle fear', false);
			objectPlayAnimation('unoPeople', 'idle fear', false);
		else
			objectPlayAnimation('stoolBoppers', 'idle', false);
			objectPlayAnimation('bartenderPot', 'idle', false);
			objectPlayAnimation('poolBopper', 'idle', false);
			objectPlayAnimation('unoPeople', 'idle', false);
		end
		objectPlayAnimation('barSlotMachineBopper', 'idle', false);
	end
end

function onCountdownTick(counter)
	beatHitDance(counter);
end

function onBeatHit()
	beatHitDance(curBeat);
end

function onUpdatePost(elapsed)
	anim = getProperty('unoPeople.animation.curAnim.name');
	if startsWith(anim, "fear") and getProperty('unoPeople.animation.curAnim.finished') then
		barFeared = true;
	end
end

function startsWith(String, Start)
   return string.sub(String, 1, string.len(Start)) == Start;
end