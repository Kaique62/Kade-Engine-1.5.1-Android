function opponentNoteHit()
    health = getProperty('health')
    if getProperty('dad.curCharacter') == 'dad-afaltfinal' and getProperty('health') > 0.1 then
        setProperty('health', health- 0.05);
    end
end