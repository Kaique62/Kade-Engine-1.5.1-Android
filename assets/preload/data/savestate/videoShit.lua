function onEndSong()
    if not seenCutscene then
        startVideo('savestateEnding')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end
