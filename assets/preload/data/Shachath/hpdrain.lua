function opponentNoteHit()
    if getHealth() > 0.02 then
		if difficulty == 0 then
			addHealth(-0.02)
		else
			addHealth(-0.01)
		end
    end
end