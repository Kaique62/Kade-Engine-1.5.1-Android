function opponentNoteHit()
    health = getProperty('health')
    if getProperty('dad.curCharacter') == 'momd3-1' and getProperty('health') > 0.1 then
        setProperty('health', health- 0.02);
    end
    if getProperty('dad.curCharacter') == 'momd3-2' and getProperty('health') > 0.1 then
        setProperty('health', health- 0.015);
    end
end