function onEndSong()
    if not seenCutscene then
        startVideo('afflictionend')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end
