


--[[
    Made By BBPanzu
    Improved By Cherry
    Fixed By Laztrix

    How To Use:
        Put this script in scripts folder
        if you want to use it on a certain script do this
            callScript('scripts/videoSpriteHandler', 'makeVideoSprite', {'videotag', 'videoname', X, Y, 'camera', hasVolume})
       
        for the camera you can put
            -camHUD
            -camGame
            -camOther
        for hasVolume you can set it to true or false
        
]]--

local videoCache = {'SpookersD3End1'}
--[[ 
    put your videoname here to cache it
    example: {'videoname','videoname2'}
    or leave it leave it like that if you do not want to cache it.

    do note!
        IF YOU DONT CACHE THE VIDEO YOU WILL RECEIVE A MASSIVE LAG SPIKE FOR A MOMENT
                ]]


-- [[the stuff ]] --
function onCreate()
    addHaxeLibrary('VideoHandler', 'hxcodec')
    addHaxeLibrary('Event', 'openfl.events')
    cacheFuck()
end
local videoSprites = {}
function makeVideoSprite(tag, videoPath, x, y, camera, hasVolume)
    makeLuaSprite(tag, nil, x, y)
    setObjectCamera(tag, camera)
	scaleObject(tag, 1280 / 1920, 720 / 1080, false)
    addLuaSprite(tag, false)
    runHaxeCode([[
        ]]..tag..[[ = new VideoHandler();
        ]]..tag..[[.playVideo(Paths.video("]]..videoPath..[["));
        ]]..tag..[[.visible = false; 
        ]]..tag..[[.volume = ]]..(hasVolume and 1 or 0)..[[;
        setVar("]]..tag..[[hasVolume", ]]..(hasVolume and 1 or 0)..[[);

        ]]..tag..[[.finishCallback = function()
        { 
            game.remove(game.getLuaObject("]]..tag..[[")); 
            return;
        }
        FlxG.stage.removeEventListener("enterFrame", ]]..tag..[[.update);
    ]])
    table.insert(videoSprites, tag)
end
---// i dont know the other way to cache this :sob: \\ --
function cacheFuck()
    if #videoCache == 0 then

    else
        for i = 1,#videoCache do
            local tag = videoCache[i]..'c'
            runHaxeCode([[
            ]]..tag..[[ = new VideoHandler();
            ]]..tag..[[.playVideo(Paths.video("]]..videoCache[i]..[["));
            ]]..tag..[[.dispose();
            ]])
        end
        --debugPrint('bro the video has been cached!')
    end
end
function onUpdatePost()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            if (game.getLuaObject("]]..__..[[") != null)
            {
                game.getLuaObject("]]..__..[[").loadGraphic(]]..__..[[.bitmapData);
                if (getVar("]]..__..[[hasVolume"))
                    ]]..__..[[.volume = 1;
            }
        ]])
    end
end
function onPause()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            ]]..__..[[.pause();
        ]])
    end
end
function onResume()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            ]]..__..[[.resume();
        ]])
    end
end

--- devotion shit

function onBeatHit()
	if curBeat == 576 then
	makeVideoSprite('devotionEnding', 'SpookersD3End1', -320, -180, 'camOther', false)
	
	setProperty('camGame.visible', false)
	setProperty('camHUD.visible', false)
	end
end