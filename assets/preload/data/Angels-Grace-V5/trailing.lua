-- NOTHING HERE SHOULD BE TOUCHED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- DON'T MODIFY ANYTHING HERE IF YOU DON'T KNOW WHAT YOU'RE DOING AND JUST USE THIS AS IT IS, THOUGH!!
-- this is a modification i made for fun of a vs impostor v4 trail note script i made for fun
-- original script by CJRed#6258, modified by Kaite#1102

function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', math.min(array[1]+50,255), math.min(array[2]+50,255), math.min(array[3]+50,255))
end

function makeSmth(ea, ae, alph)
	local thing = 0
	thing = ae
	
	if ea == 'boyfriend' then
		for i = 1, 2 do
			ghostTrail(ea, {getProperty(ea..'.animation.frameName'), getProperty(ea..'.offset.x'), getProperty(ea..'.offset.y'), thing, getProperty(ea..'.animation.curFrame')}, alph)
			thing = -1
		end
	else
		ghostTrail(ea, {getProperty(ea..'.animation.frameName'), getProperty(ea..'.offset.x'), getProperty(ea..'.offset.y'), thing, getProperty(ea..'.animation.curFrame')}, alph)
		thing = -1
	end
end

local chars = {}

function goodNoteHit(id, direction, noteType, isSustainNote)
	chars['boyfriend'] = direction
	makeSmth('boyfriend', direction, 1)
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
	chars['boyfriend'] = noteData
	makeSmth('boyfriend', direction, 1)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if dadName ~= 'black' and noteType ~= 'Both Opponents Sing' then
		if noteType ~= 'Opponent 2 Sing' then
			chars['dad'] = direction
			makeSmth('dad', direction, 1)
		else
			chars['mom'] = direction
			makeSmth('mom', direction, 1)
		end
	end
end

local ghostNum = 0
local funniDis = 130
function ghostTrail(char, noteData, alph)
	-- debugPrint(char)
	local ghost = char..'Ghost'..ghostNum
	local group = char
	if char == 'mom' then
		group = 'dad'
	end
	
	if char ~= 'dad' and bfTrailing or char == 'dad' and picoTrailing then
	
	makeAnimatedLuaSprite(ghost, getProperty(char..'.imageFile'), getProperty(char..'.x'), getProperty(char..'.y'))
	addAnimationByPrefix(ghost, 'idle', noteData[1], 0, false)
	setProperty(ghost..'.antialiasing', getProperty(char..'.antialiasing'))
	setProperty(ghost..'.offset.x', noteData[2])
	setProperty(ghost..'.offset.y', noteData[3])
	setProperty(ghost..'.scale.x', getProperty(char..'.scale.x'))
	setProperty(ghost..'.scale.y', getProperty(char..'.scale.y'))
	setProperty(ghost..'.flipX', getProperty(char..'.flipX'))
	setProperty(ghost..'.flipY', getProperty(char..'.flipY'))
	setProperty(ghost..'.visible', getProperty(char..'.visible'))
	
	if char ~= 'dad' then
	setProperty(ghost..'.color', getColorFromHex('66FFFF'))
	setProperty(ghost..'.alpha', 0.85 * getProperty(char..'.alpha') * alph)
	else
	setProperty(ghost..'.color', getColorFromHex('ff00bc'))
	setProperty(ghost..'.alpha', 0.85 * getProperty(char..'.alpha') * alph)
	end
	
	setBlendMode(ghost, 'add')
	
	addLuaSprite(ghost)
	
	playAnim(ghost, 'idle', true, false, noteData[5])
	setObjectOrder(ghost, getObjectOrder(group..'Group') - 0.1)
	cancelTween(ghost)
	--doTweenAlpha(ghost, ghost, 0, 1, 'quadInOut')
	
	if char ~= 'dad' then
	doTweenAlpha(ghost, ghost, 0, (crochet*0.001) / playbackRate, 'linear')
	funniDis = 75
	doTweenY(ghostNum..'', ghost, getProperty(char..'.y') - funniDis, (crochet*0.001) / playbackRate, 'sineInOut')
	else
	doTweenAlpha(ghost, ghost, 0, 1 / playbackRate, 'smootherStepOut')
	funniDis = 210
	doTweenY(ghostNum..'', ghost, getProperty(char..'.y') - funniDis, 1 / playbackRate, 'smootherStepInOut')
	end

	ghostNum = ghostNum + 1
	
	end
end

function onTweenCompleted(tag)
	if string.match(tag, 'Ghost') then
		removeLuaSprite(tag, true)
	end
end

-- agv5 event
bfTrailing = true
picoTrailing = true
function onBeatHit()
	if curBeat >= 256 and bfTrailing then -- Stay on track
		bfTrailing = false
		
	elseif curBeat >= 324 and not bfTrailing then -- Why did you return
		picoTrailing = false
		bfTrailing = true
		
	end
end