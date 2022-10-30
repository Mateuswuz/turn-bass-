function onCreatePost() -- huge credits to shadowmario
	luaDebugMode = true;
	runHaxeCode([[
		game.dadGroup.y += 40;
		for (dad in game.dadGroup)
		{
			dad.cameraPosition[1] -= 40;
		}
		
		bfX = game.dadGroup.x;
		bfY = game.dadGroup.y;

		mario = new Character(bfX + 150, bfY + 25, 'melodii');
		mario.scrollFactor.set(0.97, 0.97);
		mario.y += mario.positionArray[1] - 50;
		game.add(mario);
	]]);
	makeLuaSprite('table', 'bg/table', 0, 600);

	addLuaSprite('table', true);
end

function onCountdownTick(counter)
	runHaxeCode([[
		if (]]..counter..[[ % mario.danceEveryNumBeats == 0 && mario.animation.curAnim != null && !StringTools.startsWith(mario.animation.curAnim.name, 'sing') && !mario.stunned)
		{
			mario.dance();
		}
	]]);
end

function onBeatHit()
	runHaxeCode([[
		if (]]..curBeat..[[ % mario.danceEveryNumBeats == 0 && mario.animation.curAnim != null && !StringTools.startsWith(mario.animation.curAnim.name, 'sing') && !mario.stunned)
		{
			mario.dance();
		}
	]]);
end

function onUpdate(elapsed)
	runHaxeCode([[
		if (game.startedCountdown && game.generatedMusic)
		{
			if (!mario.stunned && mario.holdTimer > Conductor.stepCrochet * 0.0011 * mario.singDuration && StringTools.startsWith(mario.animation.curAnim.name, 'sing') && !StringTools.endsWith(mario.animation.curAnim.name, 'miss'))
			{
				mario.dance();
			}
		}
	]]);
end

function strumNoteHit(id, direction, noteType, isSustainNote)
	runHaxeCode([[
		mario.playAnim(game.singAnimations[]]..direction..[[], true);
		mario.holdTimer = 0;
	]]);
end