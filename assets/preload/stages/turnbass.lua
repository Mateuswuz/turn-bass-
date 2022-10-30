function onCreate()
	-- background shit
	makeLuaSprite('bg', 'bg/bg', 200, 0);
	scaleObject('bg', 0.8, 0.8);

	addLuaSprite('bg', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end