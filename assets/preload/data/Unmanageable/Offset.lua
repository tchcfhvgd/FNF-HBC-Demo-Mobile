--function onUpdatePost(elapsed)
   -- debugPrint(getProperty('timeBarBG.y'));
--end

function opponentNoteHit()
    if curBeat < 160 then
        if getHealth() > 0.05 then
            addHealth(-0.01);
        end
    end
    if curBeat > 160 and curBeat < 432 then
        if getHealth() > 0.05 then
            addHealth(-0.02);
        end
    end
    if curBeat > 432 then
        if getHealth() > 0.05 then
            addHealth(-0.01);
        end
    end
end