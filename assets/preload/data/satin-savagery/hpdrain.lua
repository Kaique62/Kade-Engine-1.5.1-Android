function opponentNoteHit()
    health = getProperty('health')
    if getProperty('dad.curCharacter') == 'momd1alt' and getProperty('health') > 0.011 then
        setProperty('health', health- 0.011);
    end
end