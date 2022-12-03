function opponentNoteHit()		
                health = getProperty('health')
		if getProperty('health') < 1.97 then
        		setProperty('health', health + 0.023);
		else
			setProperty('health', 1.999);
		end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
		health = getProperty('health')
		if getProperty('health') > 0.047 then
			setProperty('health', health - 0.046);
		else
			setProperty('health', 0.001);
		end
end

function onUpdate()
		health = getProperty('health')
		if getProperty('health') >= 2 then
			setProperty('health', 0);
		end
end

function noteMissPress(direction)
		health = getProperty('health')
		setProperty('health', health + 0.095)
end

function noteMiss(id, noteData, noteType, isSustainNote)
		health = getProperty('health')
		setProperty('health', health + 0.075)
end