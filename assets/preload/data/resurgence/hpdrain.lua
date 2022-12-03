function opponentNoteHit()
    health = getProperty('health')
    if getProperty('dad.curCharacter') == 'dad-resurgence2' and getProperty('health') > 0.025 then
        setProperty('health', health- 0.025);
    end
end