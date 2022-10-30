
function opponentNoteHit(id, direction, noteType, isSustainNote)
	-- Works the same as goodNoteHit, but for Opponent's notes being hit
	if  getHealth() > 0.01 and difficultyName == 'bf' then
		addHealth(-0.01)
	end
end
