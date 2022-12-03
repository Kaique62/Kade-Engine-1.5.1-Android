function onEndSong()
    if not seenCutscene then
        startVideo('picod3cutscene')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end
