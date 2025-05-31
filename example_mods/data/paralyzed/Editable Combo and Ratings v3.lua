-- Settings (Player) --
    local visible = true  -- Show it?

    --local unholyStyle = https://gamebanana.com/tools/10174  please

    local pixel = false   -- Pixel check

    local showCombo = false           -- Show the "unused" combo thing
    local msTxt     = false           -- Show your hit milliseconds next to the rating

    local foreverCount = false       -- Shows combo number like forever engine 
    local countMisses  = false       -- Show the amount of misses each miss (Like Forever Engine)
    local missSprite   = false       -- Show a thing when you fuck up

    -- path to images, for both ratings and numbers | Will be used for all proceeding images 
    local path = {
        ratings = 'mm/hud/',
        nums = 'mm/hud/'
    }
    
    local ratingGrab = {'sick', 'good', 'bad', 'shit'} -- What it'll grab
    local numPrefix  = 'num'               
    local numSuffix  = ''

    local combType   = 'combo'        -- For swappin with pixel 'n such
    local missType   = 'miss'

    local constantGameCam =  true    -- Keeps things hooked onto characters

    local ratingPos = {
        game   = {x = nil, y = nil},  -- camGame position
        cam    = {x = 450, y = 280},  -- HUD and Other position | DEFAULT: {450, 280}
        offset = {x = 405, y = 230}}  -- onPlayerCombo offsets

    local numPos = {
        game   = {x = nil, y = nil},
        cam    = {x = 450, y = 400},
        offset = {x = 444, y = 385}}

    local comboPos = {
        game   = {x = nil, y = nil},  -- will be dependant on the number and rating postion if left nil
        cam    = {x = nil, y = nil}, 
        offset = {x = 470, y = 390}}

    local scales = {
        rating = {0.69, 0.69},  -- DEFAULT: {0.69, 0.69}
        nums   = {0.5, 0.5},    -- DEFAULT: {0.5, 0.5}   | IF messed with, be sure to adjust it's spacing down below as they might overlap
        combo  = {0.58, 0.58},  -- DEFAULT: {0.58, 0.58}
        miss   = {0.69, 0.69}}  -- DEFAULT: {0.69, 0.69] | fuck it

    local onPlayerCombo = true  -- It'll show on where the player has the ratings offsets, IF TIED TO HUD

    local camSet = 'hud'       -- Should it be on the Hud or Game or Other?  Hud | Game | Other  
    -- (NOTICE: for game cam, I have its default set to rely on bfs/opponents position)

    local add5thRating = false -- cosmetic-ish
    local customRating = {
        image = 'marvelous',
        color = 'ff00ff',
        score = 500,        -- Points added on hit
        hitWindow = 22.5,   -- Amount of time you have to hit in ms | Has to be less than the 'sick' window
        total = 0           -- For counting total amount hit, don't change
    }

-- Settings (Opponent) --

    local visibleOp = false   -- Show it?

    local pixelOp = false

    local foreverCountOp = false

    local pathOp  = {
        ratings = '',
        nums = ''
    }

    local ratingGrabOp = {'sick', 'good', 'bad', 'shit'}
    local numPrefixOp  = 'num'
    local numSuffixOp  = ''

    local ratingPosOp = {
        game   = {x = nil, y = nil}, 
        cam    = {x = 350, y = 440},   -- Default: 350, 440 | Positions it'll use
        offset = {x = 405, y = 230}}

    local numPosOp = {
        game   = {x = nil, y = nil}, 
        cam    = {x = 380, y = 535},   -- Default: 380, 535
        offset = {x = 444, y = 385}}
        
    local ratingScaleOp        = {0.69, 0.69} -- DEFAULT: rating = 0.69, 0.69 | num = 0.5, 0.5
    local numScaleOp           = {0.5, 0.5}

    local onPlayerComboOp = false

    local camSetOp = 'game'  -- Hud | Game | Other

    -- Chances for other ratings to appear | Set to 0 to disable
    local ratingChance = {good = 0, bad = 0, shit = 0}  

function onCreate()
MODES = {
    PLAYER = {
        single         = not getPropertyFromClass('ClientPrefs', 'comboStacking'), -- Only 1 set of numbers and ratings are shown at a time | Helps prevent lag

        stationary     = false, -- Prevent the Rating hop | Single mode recommended

        showRating     = true, -- Shows rating (who coulda guessed)
        showNums       = true, -- Shows numbers (who coulda guessed)

        colorRatings   = false, -- Color the ratings based on which you get, Sick is blue, good is green, etc | NEEDS TO BE ON FOR THESE OTHER RATING COLOR SETTINGS TO WORK
        colorSyncing   = false, -- Rating takes color of direction pressed | Overwrites colorRatings and fcColorRating
        fcColorRating  = false, -- Colors Ratings based of FC level, like andromeda!!!
        colorFade      = false, -- Fades color back to baseColor's value

        colorNumbers   = false, -- Same as above, but for numbers
        colorSyncNums  = false,
        fcColorNums    = false,
        colorFadeNums  = false,

        comboColor      = false,
        comboColorFade  = false,

        randomColor    = false, -- Randomized 'sick' color | Only 'colorRatings' or 'colorNumbers' should be on
        COLORSWAP_rate = false, -- Colorswap your sick ratin (and combo sprite) | 6.1 and above
        COLORSWAP_num  = false  -- Colorswap your combo nums | 6.1 and above
    },
    OPPONENT = {
        single         = false,

        stationary     = false,

        showRating     = true,
        showNums       = true, 

        colorRatings   = true,  -- Colors based on which rating you get
        colorSyncing   = false,  -- Rating takes color of direction pressed 
        colorFade      = false,  -- Fade back to base color

        colorNumbers   = false, -- Same as above, but for numbers
        colorSyncNums  = false,
        colorFadeNums  = false
    }
}
end

-- Colors --

    -- Best with white ratings --
    local ratingColors = {'68fafc', '48f048', 'fffecb', 'ffffff'} 

    local colorSync = {'c24b99', '68fafc', '12fa05', 'f9393f'} 

    local comboUse -- Uses rating colors, no unique value

    -- Opponent --

    local ratingColorsOp = {'68fafc', '48f048', 'fffecb', 'ffffff'}     

    local colorSyncOp = {'c24b99', '68fafc', '12fa05', 'f9393f'} 

-- Dont touch these unless you know what you're doing | I do :)
    local isThousand = false
    local eh = 0         -- Make the sprites load in the way it does
    local curRating = ''
    ---
    local fakeCombo = 0
    local ehOp = 0
    local curRatingOp = ''
    --
    local addedOffset = false -- for the combo sprite
    local brokeCombo = nil  -- only one set of 0's will appear if you miss more than 1 time in a row
    local mainOffset = {}
    local isEarly = ''

-- Dumb Quotes --
    -- you angered him. | Swords 8/24/2022
    -- Everyone makes bad scripts | Unholy 1/10/2023 | Shaggy 1/10/2023

    -- 💣 | Mark_Zer0 1/10/23
    -- 🥚 | Maru 1/10/23
    -- 🏺 | Betopia 1/10/23
    -- yes. | Gank 1/10/23
    -- no 😠 | Canndiez 1/10/23
    -- I definetly didnt already ask to add my quote to be put here | Definetly Not Shaggy believe me (this is a joke)
    -- toilet waters yummy in my tummy | stupid guy 1/10/23
    -- i pissed my ass 😭 | Saltyboii 1/10/23
    -- Look a stupid kid! That's me btw. | Rodney 1/10/23
    -- bombastic side eye, criminal offensive side eye | me | Cherry 3/1/23
    -- im going to jail | plank 3/1/23
    -- im in insanity | raltyro 3/1/23
    -- 🪀 yo yo. | Tiny Games 3/1/23
    -- Hi guys I'm sanster but without the music part | popcat 3/1/23
    -- i'm a definition of a heart candy to her ❤️ | 🇵🇷TPRS🇵🇷 3/1/23

--------------------------------------------------------------------------|The Code Shit|---------------------------------------------------------------------------------------------
-----------------------------------------------------------------------|By Unholywanderer04|------------------------------------------------------------------------------------------

function onDestroy()
    --setPropertyFromClass('ClientPrefs', 'hideHud', false) -- So the thing unhides once you complete a song
end

function onCreatePost()
    mainOffset = getPropertyFromClass('ClientPrefs', 'comboOffset') -- rating offsets 
    -- ( [1] Rating X | [2] Rating Y | [3] Number X | [4] Number Y ) 

    if msTxt then
        makeLuaText('msTxt', '', 200, 0, 0)
        addLuaText('msTxt')
        setTextSize('msTxt', (camSet == 'game' and 25 or 20))
        setTextAlignment('msTxt', 'center')
        setObjectCamera('msTxt', camSet)
        setTextFont('msTxt', 'font.ttf')
    end

    pixel = getPropertyFromClass('PlayState', 'isPixelStage')
    pixelOp = getPropertyFromClass('PlayState', 'isPixelStage')

    -- Pixel shit --
    if pixel then 
        path.ratings = 'pixelUI/'
        path.nums = 'pixelUI/'

        for i = 1, #ratingGrab do
            ratingGrab[i] = ratingGrab[i].. '-pixel' end
        
        customRating.image = customRating.image .. '-pixel'
        scales.rating = {5, 5}

        numSuffix = '-pixel'
        scales.nums = {5.5, 5.5}

        ratingPos.game = {x = getProperty('boyfriend.x') - 120, y = getProperty('boyfriend.y') - 250}
        numPos.game    = {x = ratingPos.game.x + 30, y = ratingPos.game.y + 100}
        comboPos.offset.x = 480

        combType = 'combo-pixel'
        missType = 'miss-pixel'
        scales.combo = {4, 4}
        
        colorSync = {'e276ff', '3dcaff', '71e300', 'ff884e'}

        ratingColors[1] = '3dcaff'
        ratingColors[2] = '71e300'
    end
    
    if pixelOp then
        pathOp.ratings = 'pixelUI/'
        pathOp.nums = 'pixelUI/'

        for i = 1, #ratingGrabOp do
            ratingGrabOp[i] = ratingGrabOp[i].. '-pixel' end      
            
        ratingScaleOp = {5, 5}

        numSuffixOp = '-pixel'
        numScaleOp = {5.5, 5.5}

        ratingPosOp.game = {x = getProperty('dad.x') + 250, y = getProperty('dad.y') + 5}
        numPosOp.game    = {x = ratingPosOp.game.x + 30, y = ratingPosOp.game.y + 100}

        colorSyncOp = {'e276ff', '3dcaff', '71e300', 'ff884e'}

        ratingColorsOp[1] = '3dcaff'
        ratingColorsOp[2] = '71e300'
    end
    
    -- PLAYER nil checks!!!! --
    ratingPos.game.x = (ratingPos.game.x or getProperty('boyfriend.x') - 100)
    ratingPos.game.y = (ratingPos.game.y or getProperty('boyfriend.y') - 100)
         
    numPos.game.x = (numPos.game.x or ratingPos.game.x + 30)
    numPos.game.y = (numPos.game.y or ratingPos.game.y + 100)

    comboPos.cam.x = (comboPos.cam.x or numPos.cam.x + 30)
    comboPos.cam.y = (comboPos.cam.y or numPos.cam.y)
    
    comboPos.game.x = (comboPos.game.x or numPos.game.x + 30)
    comboPos.game.y = (comboPos.game.y or numPos.game.y)
    
    -- DAD nil checks!!!! --
    ratingPosOp.game.x = (ratingPosOp.game.x or getProperty('dad.x') + 370)
    ratingPosOp.game.y = (ratingPosOp.game.y or getProperty('dad.y') + 150)
     
    numPosOp.game.x = (numPosOp.game.x or ratingPosOp.game.x + 30)
    numPosOp.game.y = (numPosOp.game.y or ratingPosOp.game.y + 100)        

    fakeFC = string.sub(customRating.image:upper(), 1, 1)..'FC'
    if MODES.PLAYER.COLORSWAP_rate or MODES.PLAYER.COLORSWAP_num then
        addHaxeLibrary('ColorSwap')
        runHaxeCode('colorSw = new ColorSwap();')
    end
end

local colorsRand = {}
local noNeed = false
function onUpdate(elapsed)
    --setPropertyFromClass('ClientPrefs', 'hideHud', visible)

    if constantGameCam then
        if camSet == 'game' and visible then -- no point in doing it if not on game cam
            bf1 = (getProperty('boyfriend.x') + (getMidpointX('boyfriend') / (getProperty('boyfriend.width'))) - 120)
            bf2 = ((getMidpointY('boyfriend') - (getProperty('boyfriend.height') / 1.7)) / (pixel and 1.5 or 1))

            ratingPos.game = {x = bf1, y = bf2}
            numPos.game    = {x = ratingPos.game.x + 30, y = ratingPos.game.y + 100}
            comboPos.game  = {x = numPos.game.x + (not isThousand and 30 or 70), y = numPos.game.y}
        end

        if camSetOp == 'game' and visibleOp then
            dad1 = getProperty('dad.positionArray')[1] + (getProperty('dad.x') + (getProperty('dad.width') / (1.2 * (pixelOp and 6 or 1)))) -- pico is a motherfucker
            dad2 = getMidpointY('dad') - (getProperty('dad.height') / (pixelOp and 2 or 4))

            ratingPosOp.game = {x = dad1, y = dad2}
            numPosOp.game    = {x = ratingPosOp.game.x + 30, y = ratingPosOp.game.y + 100}
        end
    end
    
    -- For the combo sprite
    if showCombo then
        isThousand = getProperty('combo') >= 999

        comboPos.game.x = numPos.game.x + (isThousand and 70 or 30)
        comboPos.cam.x = numPos.cam.x + (isThousand and 70 or 30)

        if isThousand and not addedOffset then
            addedOffset = true 
            comboPos.offset.x = comboPos.offset.x + 42
        elseif not isThousand and addedOffset then 
            addedOffset = false 
            comboPos.offset.x = comboPos.offset.x - 42
        end
    end
    
    if ratingName ~= '?' and not noNeed and add5thRating then -- a bit stupid, but it works 
        isC = customRating.total == getProperty('sicks')
        for _, v in pairs({'goods', 'bads', 'shits', 'songMisses'}) do
            if getProperty(v) > 0 or not isC then noNeed = true break end
        end
        setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' | Rating: '..ratingName..' ('.. round(rating * 100, 2)..'%) - '..(isC and fakeFC or ratingFC))
    end

    eh = getProperty('combo') + misses
    
    if (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') or 
        getPropertyFromClass('flixel.FlxG', 'keys.justPressed.EIGHT')) then
        --setPropertyFromClass('ClientPrefs', 'hideHud', false)
    end

    if msTxt then
        setProperty('msTxt.scrollFactor.x', camSet == 'game' and 1 or 0)
        setProperty('msTxt.scrollFactor.y', camSet == 'game' and 1 or 0)
    end

    if MODES.PLAYER.randomColor then
        colorsRand = {getRandomInt(1, 255), getRandomInt(1, 255), getRandomInt(1, 255)}
        ratingColors[1] = rgb_to_hex(colorsRand)
    end

    if MODES.PLAYER.COLORSWAP_rate or MODES.PLAYER.COLORSWAP_num then
        runHaxeCode([[
            if (colorSw.hue > 0) colorSw.hue -= ]]..elapsed..[[;
            if (colorSw.saturation > 0) colorSw.saturation -= ]]..elapsed..[[;
        ]])
    end
end

function goodNoteHit(id, d, noteType, isSustainNote)
    if visible then
        if not isSustainNote then
            brokeCombo = false

            if MODES.PLAYER.single then eh = 0 end 

            -- Took from Whitty mod >:)
            strumTime = getPropertyFromGroup('notes', id, 'strumTime')
            curRating = getRating((strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset')) / playbackRate, true)

            isEarly = strumTime < getSongPosition() and '' or '-'

            useColor = '' -- for checking rating color
       
            local ratingNumbers = {['sick'] = 1, ['good'] = 2, ['bad'] = 3, ['shit'] = 4, [customRating.image] = 5}
            ratiNum = ratingNumbers[curRating]
            local canSwap = (ratiNum == 1) or (ratiNum == 5) -- color swap only the 'sick' and 'custom' rating

            useColor = (ratiNum < 5 and ratingColors[ratiNum] or customRating.color)
            setTextColor('msTxt', useColor)

            -- so the color gets set based on rating, THEN it removes the rating
            if not MODES.PLAYER.showRating then curRating = '' ratiNum = nil end

            local fcs = {['SFC'] = 1, ['GFC'] = 2, ['FC'] = 3}
            levelNum = (fcs[ratingFC] or 4)

            thisOne, numUse = ratingColors[4], ratingColors[4]

            if MODES.PLAYER.colorRatings then
                thisOne = useColor
                if MODES.PLAYER.colorSyncing then
                    thisOne = (curRating ~= 'shit' and colorSync[d+1])
                elseif MODES.PLAYER.fcColorRating then
                    thisOne = ratingColors[levelNum]
                end
            end
            comboUse = (MODES.PLAYER.comboColor and thisOne or ratingColors[4])

            if MODES.PLAYER.colorNumbers then 
                numUse = useColor
                if MODES.PLAYER.colorSyncNums then 
                    numUse = colorSync[d+1]
                elseif MODES.PLAYER.fcColorNums then 
                    numUse = ratingColors[levelNum] 
                end
            end

            if MODES.PLAYER.COLORSWAP_rate or MODES.PLAYER.COLORSWAP_num then 
                runHaxeCode('colorSw.hue += '..(d + 1)..'; colorSw.saturation += 0.3;')
            end

            setTextSize('msTxt', (camSet == 'game' and 25 or 20))
            setObjectCamera('msTxt', camSet)    

            -------------------------------Ratings---------------------------------------            

            -- This grabs the default Rating images in either assets/shared/images or mods/images depending on if you're using a mod AND if there are Rating images in there.
            -- I recommend making a folder for ratings if you do some wacky things, specifially for ease of access.
            
            local ratingSpr = 'rating'..(MODES.PLAYER.single and '' or curRating..eh)
            local x, y = getXandY(ratingPos, true, true)
            if msTxt then setProperty('msTxt.x', x + 100) setProperty('msTxt.y', y + 70) end
           
            if ratiNum ~= nil then
                local ratingImage = (ratiNum < 5 and ratingGrab[ratiNum] or customRating.image)
           
                makeLuaSprite(ratingSpr, path.ratings .. ratingImage, x, y)
            
                setProperty(ratingSpr .. '.color', getColorFromHex(thisOne))
                setObjectCamera(ratingSpr, camSet)
                if camSet == 'hud' then 
                    setObjectOrder(ratingSpr, getObjectOrder('strumLineNotes')-1)
                end
                scaleObject(ratingSpr, scales.rating[1], scales.rating[2])
                setProperty(ratingSpr .. '.antialiasing', not pixel)

                addLuaSprite(ratingSpr, true)
                if not MODES.PLAYER.stationary then
                    setProperty(ratingSpr ..'.acceleration.y', 550 * playbackRate * playbackRate)
                    setVelocity(ratingSpr, getRandomInt(0, 10), -180)
                end

                if MODES.PLAYER.single then cancelThings(ratingSpr..'Fade') end 
                runTimer(ratingSpr..'Fade', (crochet * 0.001) / playbackRate)

                if MODES.PLAYER.COLORSWAP_rate and canSwap then 
                    runHaxeCode('game.getLuaObject("'..ratingSpr..'").shader = colorSw.shader;') 
                end

                if MODES.PLAYER.colorFade then
                    doTweenColor('coolRatn'..eh, ratingSpr, ratingColors[4], (0.2 + (crochet * 0.0005)) / playbackRate, 'quartIn')
                end
            end

            if showCombo then
                local comboSpr = 'combThing' .. eh
                local x, y = getXandY(comboPos, false, true)
                
                makeLuaSprite(comboSpr, path.ratings .. combType, x, y)
                setObjectCamera(comboSpr, camSet)
                setProperty(comboSpr .. '.antialiasing', not pixel)
                if camSet == 'hud' then 
                    setObjectOrder(comboSpr, getObjectOrder('strumLineNotes')-1) 
                end
                scaleObject(comboSpr, scales.combo[1], scales.combo[2])
                setProperty(comboSpr .. '.color', getColorFromHex(comboUse))
                addLuaSprite(comboSpr, true)
                if not MODES.PLAYER.stationary then
                    setProperty(comboSpr .. '.acceleration.y', 550 * playbackRate * playbackRate)
                    setVelocity(comboSpr, getRandomInt(0,10), -180)
                end

                if MODES.PLAYER.single then cancelThings(comboSpr..'Fade') end 
                runTimer(comboSpr..'Fade', (crochet * 0.0015) / playbackRate)

                if MODES.PLAYER.COLORSWAP_rate and canSwap then 
                    runHaxeCode('game.getLuaObject("'..comboSpr..'").shader = colorSw.shader;')
                end

                if MODES.PLAYER.comboColorFade then
                    doTweenColor('coolCom' .. eh, comboSpr, ratingColors[4], (0.2 + (crochet * 0.001)) / playbackRate, 'quartIn')
                end
            end

            if msTxt then
                if luaSpriteExists(ratingSpr) or luaSpriteExists('combThing'..eh) then
                    setObjectOrder('msTxt', getObjectOrder(showCombo and 'combThing'..eh or ratingSpr) * 2)
                end
            end

            --------------------------------Numbers----------------------------------------
            local combo = getProperty('combo')
            local split, numCount = splitNums(combo, foreverCount)

            if MODES.PLAYER.showNums then
                sequence = nil
                for i = 1, numCount do
                    multBy = (((i + 2) - numCount) * 43) -- spacing and spawning

                    local sequence = numPrefix .. split[i] .. numSuffix  
                    local numSpr = 'num' .. i .. eh

                    local x, y = getXandY(numPos, false, true) 
        
                    makeLuaSprite(numSpr, path.nums .. sequence, x - multBy, y)
                    setObjectCamera(numSpr, camSet)
                    setProperty(numSpr .. '.color', getColorFromHex(numUse))
                    if camSet == 'hud' then 
                        setObjectOrder(numSpr, getObjectOrder('strumLineNotes')-1)
                    end

                    setProperty(numSpr .. '.antialiasing', not pixel)

                    scaleObject(numSpr, scales.nums[1], scales.nums[2])
                    addLuaSprite(numSpr, true)
                    if not MODES.PLAYER.stationary then
                        setProperty(numSpr .. '.acceleration.y', getRandomInt(200, 400) * playbackRate * playbackRate)
                        setVelocity(numSpr, getRandomInt(-5, 5), getProperty(numSpr..'.velocity.y') - getRandomInt(140, 160))
                    end

                    if MODES.PLAYER.single then cancelThings(numSpr..'Fade') end 
                    runTimer(numSpr..'Fade', (crochet * 0.002 / playbackRate))

                    if MODES.PLAYER.COLORSWAP_num then 
                        runHaxeCode('game.getLuaObject("'..numSpr..'").shader = colorSw.shader;') 
                    end

                    if MODES.PLAYER.colorFadeNums then
                        doTweenColor('itsjustafad' .. numSpr, numSpr, ratingColors[4], (0.2 + (crochet * 0.0015)) / playbackRate, 'quartIn')
                    end
                end
            end
        end
    end
end

function noteMiss(id, d, noteType, isSustainNote)
    if missSprite then
        local sprName = MODES.PLAYER.single and 'rating' or 'missrating' .. eh

        local x, y = getXandY(ratingPos, true, true) 

        makeLuaSprite(sprName, path.ratings .. missType, x, y) 
        setObjectCamera(sprName, camSet)
        setProperty(sprName .. '.antialiasing', not pixel)
        scaleObject(sprName, scales.miss[1], scales.miss[2])

        if camSet == 'hud' then 
            setObjectOrder(sprName, getObjectOrder('strumLineNotes')-1)
        end
        addLuaSprite(sprName, true)
        if not MODES.PLAYER.stationary then
            setProperty(sprName .. '.acceleration.y', 650 * playbackRate * playbackRate)
            setVelocity(sprName, getRandomInt(0, 10), -100)
        end
        runTimer(sprName..'Fade', (crochet * 0.001) / playbackRate)
    end

    local missCount = {}
    if MODES.PLAYER.showNums then
        if not countMisses then
            missCount = {0, 0, 0} -- just to make three numbers appear
            numCount = 3
        else
            missCount, numCount = splitNums(misses, foreverCount) 
            numCount = numCount + 1
            table.insert(missCount, 'minus') -- always at the end for consistency
        end
        
        for i = 1, numCount do
            multBy = (((i + (countMisses and 3 or 2)) - numCount) * 43) -- spacing and spawning

            if not countMisses then 
                sequence = numPrefix..'0'..numSuffix
            else
                isMinus = type(missCount[i]) ~= 'number'
                sequence = (isMinus and '' or numPrefix)..missCount[i]..numSuffix
            end

            local missNum = 'MISSnum' .. (MODES.PLAYER.single and '' or eh) .. i
            if not brokeCombo or countMisses then
                local x, y = getXandY(numPos, false, true) 
                
                makeLuaSprite(missNum, path.nums .. sequence, x - multBy, y)
                setObjectCamera(missNum, camSet)
                setProperty(missNum .. '.color', getColorFromHex('bc0000'))
                if camSet == 'hud' then 
                    setObjectOrder(missNum, getObjectOrder('strumLineNotes')-1)
                end
                setProperty(missNum .. '.antialiasing', not pixel)
  
                scaleObject(missNum, scales.nums[1], scales.nums[2])
                addLuaSprite(missNum, true)
                if not MODES.PLAYER.stationary then
                    setProperty(missNum .. '.acceleration.y', 300 * playbackRate * playbackRate)
                    setVelocity(missNum, 0, -100)
                end
                runTimer(missNum..'Fade', (crochet * 0.002 / playbackRate))
            end
        end
    end
    brokeCombo = true
end

function noteMissPress() noteMiss() end

---------------------------- Daddy Dearest <3 (Opponent) ---------------------------------

function opponentNoteHit(id, d, noteType, isSustainNote) 
    if visibleOp then
        if not isSustainNote then
        
            ehOp = ehOp + 1 -- makes it look right
            if ehOp > 100 or MODES.OPPONENT.single then ehOp = 0 end

            good = getRandomBool(ratingChance.good)
            bad  = getRandomBool(ratingChance.bad)
            shit = getRandomBool(ratingChance.shit)

            strumTime = getPropertyFromGroup('notes', id, 'strumTime')
            curRatingOp = getRating((strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset')) / playbackRate, false)

            local ratingNumbers = {['sick'] = 1, ['good'] = 2, ['bad'] = 3, ['shit'] = 4}
            ratiNumOp = ratingNumbers[curRatingOp]

            if not MODES.OPPONENT.showRating then curRatingOp = '' ratiNumOp = nil end
            
            ratingCol = ratingColorsOp[(ratiNumOp or 4)]
        
            thisOneOp, numUseOp = ratingColorsOp[4], ratingColorsOp[4]

            if MODES.OPPONENT.colorRatings then
                if MODES.OPPONENT.colorSyncing then
                    thisOneOp = (curRatingOp ~= 'shit' and colorSyncOp[d+1])
                else thisOneOp = ratingCol end
            end

            if MODES.OPPONENT.colorNumbers then 
                if MODES.OPPONENT.colorSyncNums then 
                    numUseOp = colorSyncOp[d+1]
                else numUseOp = ratingCol end
            end
            -------------------------------Ratings---------------------------------------
            
            local ratingSpr = 'ratingO'.. (MODES.OPPONENT.single and '' or curRatingOp .. ehOp)
            if ratiNumOp ~= nil then
                local x, y = getXandY(ratingPosOp, true, false)

                makeLuaSprite(ratingSpr, pathOp.ratings .. ratingGrabOp[ratiNumOp], x, y)
            
                setProperty(ratingSpr .. '.color', getColorFromHex(thisOneOp))
                setObjectCamera(ratingSpr, camSetOp)
                if camSetOp == 'hud' then 
                    setObjectOrder(ratingSpr, getObjectOrder('strumLineNotes')-1)
                end
                scaleObject(ratingSpr, ratingScaleOp[1], ratingScaleOp[2])

                setProperty(ratingSpr .. '.antialiasing', not pixelOp)

                addLuaSprite(ratingSpr, true)
                if not MODES.OPPONENT.stationary then
                    setProperty(ratingSpr ..'.acceleration.y', 550 * playbackRate * playbackRate)
                    setVelocity(ratingSpr, getRandomInt(0, 10), -180)
                end

                if MODES.OPPONENT.single then cancelThings(ratingSpr..'Fade') end 
                runTimer(ratingSpr..'Fade', (crochet * 0.001) / playbackRate)

                if MODES.OPPONENT.colorFade then
                    doTweenColor('coolSOp' .. ehOp, ratingSpr, ratingColorsOp[4], (0.2 + (crochet * 0.0005)) / playbackRate, 'quartIn')
                end     
            end
            --------------------------------Numbers----------------------------------------
            fakeCombo = fakeCombo + 1
            if fakeCombo > 9999 then fakeCombo = 9999 end

            local splitFake, numCount = splitNums(fakeCombo, foreverCountOp)

            if MODES.OPPONENT.showNums then                    
                for i = 1, numCount do
                    multBy = (((i + 2) - numCount) * 43)

                    local sequence = numPrefixOp .. splitFake[i] .. numSuffixOp
                    local numSpr = 'numb' .. ehOp .. i

                    local x, y = getXandY(numPosOp, false, false)
                    makeLuaSprite(numSpr, pathOp.nums .. sequence, x - multBy, y)
                    
                    setObjectCamera(numSpr, camSetOp)
                    setProperty(numSpr .. '.color', getColorFromHex(numUseOp))
                    if camSetOp == 'hud' then 
                        setObjectOrder(numSpr, getObjectOrder('strumLineNotes')-1)
                    end

                    setProperty(numSpr.. '.antialiasing', not pixelOp)

                    scaleObject(numSpr, numScaleOp[1], numScaleOp[2])
                    addLuaSprite(numSpr, true)
                    if not MODES.OPPONENT.stationary then
                        setProperty(numSpr ..'.acceleration.y', getRandomInt(200, 400) * playbackRate * playbackRate)
                        setVelocity(numSpr, getRandomInt(-5, 5), getProperty(numSpr .. '.velocity.y') - getRandomInt(140, 160))
                    end

                    if MODES.OPPONENT.single then cancelThings(numSpr..'Fade') end 
                    runTimer(numSpr..'Fade', (crochet * 0.002 / playbackRate))

                    if MODES.OPPONENT.colorFadeNums then
                        doTweenColor('itsjustafadOp' .. ehOp .. i, numSpr, ratingColorsOp[4], (0.2 + (crochet * 0.001)) / playbackRate, 'quartIn')
                    end
                end
            end
        end
    end
end

function getRating(diff, isPlayer) -- fused them, cuz they basically did the same thing
    if not isPlayer then
        if good then return 'good' end 
        if bad then return 'bad' end 
        if shit then return 'shit' end
        return 'sick'
    end

	diff = math.abs(diff)

    if msTxt then
        setTextString('msTxt', isEarly..round(diff, 2)..' ms')
        cancelTween('out')
        setProperty('msTxt.alpha', 1)
        doTweenAlpha('out', 'msTxt', 0, crochet/1000, 'quartIn')
    end

    local windows = {'bad', 'good', 'sick'}
    if add5thRating then table.insert(windows, customRating.image) end

    local toReturn = 'shit'
    for i = 1, #windows do
        local hitWindow = (i < 4 and getPropertyFromClass('ClientPrefs', windows[i]..'Window') or customRating.hitWindow)
        if diff <= hitWindow then
            toReturn = windows[i]
        else break end -- if its not less than the window, no need to contine
    end
    
    if toReturn == customRating.image and not botPlay then 
        customRating.total = customRating.total + 1
        addScore(math.abs(customRating.score - 350)) -- hitting a 'sick' already adds 350
    end
    
    return toReturn
end

function rgb_to_hex(rgb) return string.format('%x', (rgb[1] * 0x10000) + (rgb[2] * 0x100) + rgb[3]) end

function setVelocity(thing, x, y)
    setProperty(thing..'.velocity.x', x * playbackRate)
    setProperty(thing..'.velocity.y', y * playbackRate)
end

function round(num, decimals)
    local mult = 10^(decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

function cancelThings(tag) -- for single mode
    cancelTimer(tag) 
    cancelTween('!'..tag:gsub('Fade', '')) 
end

function onTimerCompleted(t)
    if string.find(t, 'Fade') then
        doTweenAlpha('!'..t:gsub('Fade', ''), t:gsub('Fade', ''), 0, 0.2 / playbackRate)
    end
end

function onTweenCompleted(t)
    if string.find(t, '!') then
        local the = stringSplit(t, '!')
        removeLuaSprite(the[2], true)
    end
end

function getXandY(positionTable, isRating, isPlayer)
    local off1, off2 = (isRating and 1 or 3), (isRating and 2 or 4)
    local toGrab = isPlayer and {onPlayerCombo, camSet} or {onPlayerComboOp, camSetOp}

    if toGrab[1] and toGrab[2] == 'hud' then
        return positionTable.offset.x + mainOffset[off1], positionTable.offset.y - mainOffset[off2]
    elseif toGrab[2] == 'game' then 
        return positionTable.game.x, positionTable.game.y
    end
    return positionTable.cam.x, positionTable.cam.y
end

function splitNums(number, forev)
    local split, count = {}, 1

    local length = string.len(tostring(number)) 
    local looper = (number >= 999 and 3 or 2)

    for i = 0, looper do
        if (forev and length > i) or not forev then
            table.insert(split, math.floor(number / 10 ^ i % 10)) -- stole the math from pantszoo
        end
    end

    count = (forev and string.len(tostring(number)) or (number > 999 and 4 or 3))          
    return split, count
end