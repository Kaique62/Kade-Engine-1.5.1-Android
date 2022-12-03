local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not seenCutscene then --Block the first countdown
		startVideo('begincutscene');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onEndSong()
    if not seenCutscene then
        startVideo('finalcutscene')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end