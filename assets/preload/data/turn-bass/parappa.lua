local prating = 6
local flashtimer = 0
local flashcolor = '505050'
local notehit = 0
local notemiss = 0

-- Lua stuff
function onCreatePost()
	if difficultyName == 'parappa' then
	-- triggered when the lua file is started
	setObjectOrder('dad', 10)

	setProperty("healthBarBG.visible", false);
  	setProperty("healthBar.visible", false);
   	setProperty("iconP1.visible", false);
   	setProperty("iconP2.visible", false);

   	makeLuaText('rap', 'U rappin     !', 400, 885, 400)
   	setTextAlignment('sick', 'left')
   	setTextSize('rap', 30)
   	addLuaText('rap')

   	makeLuaText('sick', 'SICK', 400, 950, 350)
   	setTextColor('sick', '505050')
   	setTextAlignment('sick', 'center')
   	setTextSize('sick', 30)
   	--addLuaText('sick')

   	makeLuaText('good', 'GOOD', 400, 950, 400)
   	setTextColor('good', 'FFFFFF')
   	setTextAlignment('good', 'center')
   	setTextSize('good', 30)
   	addLuaText('good')

   	makeLuaText('bad', 'BAD', 400, 950, 450)
   	setTextColor('bad', '505050')
   	setTextAlignment('bad', 'center')
   	setTextSize('bad', 30)
   	addLuaText('bad')

   	makeLuaText('shit', 'SHIT', 400, 950, 500)
   	setTextColor('shit', '505050')
   	setTextAlignment('shit', 'center')
   	setTextSize('shit', 30)
   	addLuaText('shit')
   end
end

function onDestroy()
	-- triggered when the lua file is ended (Song fade out finished)
end


-- Gameplay/Song interactions
function onBeatHit()
	-- triggered 4 times per section
	if difficultyName == 'parappa' then
		if curBeat % 8 == 0 then
			if notehit == notemiss then

			elseif notemiss > notehit / notemiss  then
				prating = prating - 1
			else
				prating = prating + 1
			end
			if prating > 6 then
				prating = 6
			end
			notehit = 0
			notemiss = 0
			--debugPrint(prating)
		end
	end
end

function onStepHit() 
	-- triggered 16 times per section
	if difficultyName == 'parappa' then
		flashtimer = flashtimer + 1
		if flashtimer > 1 then
			flashtimer = 0
		end
		if flashtimer == 0 then
			flashcolor = '505050'
		elseif flashtimer == 1 then
			flashcolor = 'B0B0B0'
		end
		--debugPrint(flashtimer)
	end
end

function onUpdate(elapsed)
	-- start of "update", some variables weren't updated yet
	if difficultyName == 'parappa' then
		setHealth(2)
		if prating == 0 then
			setHealth(-1987)
		elseif prating == 1 then
			setTextColor('good', '505050')
			setTextColor('bad', '505050')
			setTextColor('shit', flashcolor)
		elseif prating == 2 then
			setTextColor('good', '505050')
			setTextColor('bad', '505050')
			setTextColor('shit', 'FFFFFF')
			doTweenY('rapY', 'rap', 500, 1, 'sineOut')
			setSoundVolume('badsf', 0)
			setSoundVolume('awfulsf', 1)
		elseif prating == 3 then
			setTextColor('good', '505050')
			setTextColor('bad', flashcolor)
			setTextColor('shit', flashcolor)
		elseif prating == 4 then
			setTextColor('good', '505050')
			setTextColor('bad', 'FFFFFF')
			setTextColor('shit', '505050')
			doTweenY('rapY', 'rap', 450, 1, 'sineOut')
			setSoundVolume('badsf', 1)
			setSoundVolume('awfulsf', 0)
		elseif prating == 5 then
			setTextColor('good', flashcolor)
			setTextColor('bad', flashcolor)
			setTextColor('shit', '505050')
		elseif prating == 6 then
			setTextColor('good', 'FFFFFF')
			setTextColor('bad', '505050')
			setTextColor('shit', '505050')
			doTweenY('rapY', 'rap', 400, 1, 'sineOut')
			setSoundVolume('badsf', 0)
			setSoundVolume('awfulsf', 0)
		end
	end
end

function onUpdatePost(elapsed)
	-- end of "update"
end

function onStartCountdown()
	-- countdown started, duh
	-- return Function_Stop if you want to stop the countdown from happening (Can be used to trigger dialogues and stuff! You can trigger the countdown with startCountdown())
	return Function_Continue;
end

function onCountdownTick(counter)

end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	if difficultyName == 'parappa' then
		playSound('tb_bad', 0, 'badsf')
		playSound('tb_awful', 0, 'awfulsf')
	end
end

function onEndSong()
	-- song ended/starting transition (Will be delayed if you're unlocking an achievement)
	-- return Function_Stop to stop the song from ending for playing a cutscene or something.
	return Function_Continue;
end


-- Substate interactions
function onPause()
	-- Called when you press Pause while not on a cutscene/etc
	-- return Function_Stop if you want to stop the player from pausing the game
	pauseSound('badsf')
	pauseSound('awfulsf')
	return Function_Continue;
end

function onResume()
	-- Called after the game has been resumed from a pause (WARNING: Not necessarily from the pause screen, but most likely is!!!)
	resumeSound('badsf')
	resumeSound('awfulsf')
end

function onGameOver()
	-- You died! Called every single frame your health is lower (or equal to) zero
	-- return Function_Stop if you want to stop the player from going into the game over screen
	pauseSound('badsf')
	pauseSound('awfulsf')
	return Function_Continue;
end

function onGameOverConfirm(retry)
	-- Called when you Press Enter/Esc on Game Over
	-- If you've pressed Esc, value "retry" will be false
end


-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(line)
	-- triggered when the next dialogue line starts, dialogue line starts with 1
end

function onSkipDialogue(line)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end


-- Note miss/hit
function goodNoteHit(id, direction, noteType, isSustainNote)
	-- Function called when you hit a note (after note hit calculations)
	-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
	-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
	-- noteType: The note type string/tag
	-- isSustainNote: If it's a hold note, can be either true or false
	notehit = notehit + 1
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	-- Works the same as goodNoteHit, but for Opponent's notes being hit
end

function noteMissPress(direction)
	-- Called after the note press miss calculations
	-- Player pressed a button, but there was no note to hit (ghost miss)
end

function noteMiss(id, direction, noteType, isSustainNote)
	-- Called after the note miss calculations
	-- Player missed a note by letting it go offscreen
	notemiss = notemiss + 1
end


-- Other function hooks
function onRecalculateRating()
	-- return Function_Stop if you want to do your own rating calculation,
	-- use setRatingPercent() to set the number on the calculation and setRatingString() to set the funny rating name
	-- NOTE: THIS IS CALLED BEFORE THE CALCULATION!!!
	return Function_Continue;
end

function onMoveCamera(focus)
	if focus == 'boyfriend' then
		-- called when the camera focus on boyfriend
	elseif focus == 'dad' then
		-- called when the camera focus on dad
	end
end


-- Event notes hooks
function onEvent(name, value1, value2)
	-- event note triggered
	-- triggerEvent() does not call this function!!

	-- print('Event triggered: ', name, value1, value2);
end

function eventEarlyTrigger(name)
	--[[
	Here's a port of the Kill Henchmen early trigger but on Lua instead of Haxe:

	if name == 'Kill Henchmen'
		return 280;

	This makes the "Kill Henchmen" event be triggered 280 miliseconds earlier so that the kill sound is perfectly timed with the song
	]]--

	-- write your shit under this line, the new return value will override the ones hardcoded on the engine
end


-- Tween/Timer hooks
function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
end