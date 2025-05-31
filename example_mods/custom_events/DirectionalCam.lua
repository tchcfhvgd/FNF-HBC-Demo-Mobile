local balls = 1

function onEvent(name, value1, value2)	
	if name == "DirectionalCam" then
	-- BY TPOSEJANK
	
balls = tonumber(value1)
power = tonumber(value2)
if balls == 1 then

	if power == null then
	power = 50
	else
	power = power
	end

local off = {power, power} -- x and y movement force
local opponentNotes = true -- change this to false if you dont want to trigger when opponent notes
local bfNotes = true -- change this to false if you want to trigger when player notes
local xy = {{-off[1], 0}, {0, off[2]}, {0, -off[2]}, {off[1], 0}} -- table which has the applied movement force

function goodNoteHit(i, d, n, s)
	if songName ~= 'LORE' then
		if bfNotes then resetCam(d) end
	elseif songName ~= 'Empty Memories' and n == 'GF Sing' then resetCam(d) end
end
function opponentNoteHit(i, d, n, s)
    if songName ~= 'LORE' and songName ~= 'Empty Memories' then
		if opponentNotes then resetCam(d) end
	elseif songName ~= 'Empty Memories' and n == 'GF Sing' then resetCam(d) end
end

function resetCam(d)
    runHaxeCode('game.moveCameraSection();')
    setProperty('camFollow.x', getProperty('camFollow.x') + xy[d+1][1])
    setProperty('camFollow.y', getProperty('camFollow.y') + xy[d+1][2])
end

	else
	function goodNoteHit(i, d, n, s)
	-- no
	end
	function opponentNoteHit(i, d, n, s)
    --no 
	end
	function resetCam(d)
    -- no
	end
	end
end
end