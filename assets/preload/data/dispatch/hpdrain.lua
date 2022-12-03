function opponentNoteHit()
    health = getProperty('health')
    if getProperty('dad.curCharacter') == 'mom-2' and getProperty('health') > 0.013 then
        setProperty('health', health- 0.013);
    end
end