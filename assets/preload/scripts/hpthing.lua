
function onSpawnNote()
	if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
		setPropertyFromGroup('unspawnNotes', i, 'hitHealth', 0.02); --Default value is: 0.23, health gained on hit
		setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.1); --Default value is: 0.0475, health lost on miss
		setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	-- Function called when you hit a note (after note hit calculations)
	-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
	-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
	-- noteType: The note type string/tag
	-- isSustainNote: If it's a hold note, can be either true or false
end

function noteMiss(id, direction, noteType, isSustainNote)
	-- Called after the note miss calculations
	-- Player missed a note by letting it go offscreen
end