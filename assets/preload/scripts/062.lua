function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Third Player Note' then
		runHaxeCode([[
			var stupidStrum = game.strumLineNotes.members[]]..direction-4 ..[[];
			var smartStrum = game.strumLineNotes.members[]].. direction ..[[];

			if (smartStrum != null)
			{
				stupidStrum.playAnim('static', true);
				smartStrum.playAnim('confirm', true);
				smartStrum.resetAnim = 0.15;
			}
		]]);
	end
end