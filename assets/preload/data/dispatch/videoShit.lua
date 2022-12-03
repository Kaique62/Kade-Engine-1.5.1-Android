function onEndSong()
    if not seenCutscene then
        startVideo('dispatchend')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end
