function onCreatePost()
makeLuaSprite('atticsky', 'CandyShop/Background/AtticSkyfix', -1200, -450)
	scaleObject('atticsky', 0.95, 0.95, false)
	setObjectCamera('atticsky', 'camGame')
	addLuaSprite('atticsky', false)
	setProperty('atticsky.alpha', 0.0001);
	--setObjectOrder('atticsky', 3)
	
	makeLuaSprite('atticclouds', 'CandyShop/Background/AtticCloudsfix', -1200, -450)
	scaleObject('atticclouds', 0.95, 0.95, false)
	setObjectCamera('atticclouds', 'camGame')
	addLuaSprite('atticclouds', false)
	setProperty('atticclouds.alpha', 0.0001);
	--setObjectOrder('atticclouds', 4)
	
	makeAnimatedLuaSprite('atticstars', 'CandyShop/Background/AtticStarsfix', -1200, -450)
	addAnimationByPrefix('atticstars', 'idle', 'stars', 24, true)
	setObjectCamera('atticstars', 'camGame')
	scaleObject('atticstars', 0.95, 0.95, false)
	addLuaSprite('atticstars', false)
	setScrollFactor('atticstars', 0.5, 0.5);
	setProperty('atticstars.alpha', 0.0001);
	--setObjectOrder('atticstars', 5)
	
	makeLuaSprite('atticwall', 'CandyShop/Background/AtticWallfix', -1200, -450)
	scaleObject('atticwall', 0.95, 0.95, false)
	setObjectCamera('atticwall', 'camGame')
	addLuaSprite('atticwall', false)
	setProperty('atticwall.alpha', 0.0001);
	--setObjectOrder('atticwall', 10)
	
	makeLuaSprite('atticlight', 'CandyShop/Background/AtticLightfix', -1200, -450)
	scaleObject('atticlight', 0.95, 0.95, false)
	setObjectCamera('atticlight', 'camGame')
	addLuaSprite('atticlight', false)
	setProperty('atticlight.alpha', 0.0001);
	--setObjectOrder('atticlight', 11)
	
	makeLuaSprite('atticvig', 'CandyShop/Background/DreamVignettefix', 0, 0)
	setObjectCamera('atticvig', 'camHUD')
	setObjectOrder('atticvig', 1)
	addLuaSprite('atticvig', false)
	setProperty('atticvig.alpha', 0.0001);
	end

function onEvent(name, value1, value2)
    local penieses = tonumber(value1)
    local aughgh = tonumber(value2)
    if name == 'Attic Hallucination' then
	oldBFOrder = getObjectOrder('boyfriendGroup')
		if penieses == 1 then
		setProperty('health', 1)
				
			setProperty('candyvig.alpha', 0);
			setProperty('candywall.alpha', 0);
			setProperty('camHUD.alpha', 1);
			setProperty('camOther.alpha', 1);
			setProperty('camGame.alpha', 1);
			
			setProperty('atticsky.alpha', 1);
			setProperty('atticclouds.alpha', 1);
			setProperty('atticstars.alpha', 1);
			setProperty('atticlight.alpha', 1);
			setProperty('atticwall.alpha', 1);
			setProperty('atticvig.alpha', 1);
		
			
				-- transparency hud
				setProperty('timeBarBG.alpha', 0.6)
				setProperty('timeBar.alpha', 0.6)
				setProperty('healthBar.alpha', 0.6)
				setProperty('healthBarBG.alpha', 0.6)
				setProperty('iconP1.alpha', 0.6)
				setProperty('iconP2.alpha', 0.6)
				setProperty('scoreTxt.alpha', 0.6)
				
				if not middlescroll then
			
				for index = 0, 7 do 
				noteTweenAlpha(index, index, 0.6, 0.0001 / playbackRate, 'linear');
				end
				
				else
				
				for index = 0, 3 do 
				noteTweenAlpha(index, index, 0.25, 0.0001 / playbackRate, 'linear');
				end
				
				for index = 4, 7 do 
				noteTweenAlpha(index, index, 0.6, 0.0001 / playbackRate, 'linear');
				end
				
				end
			
				if getProperty('timeTxt') then
				setProperty('timeTxt.alpha', 0.6)
				end
				
				function onUpdatePost(elapsed)
					if getProperty('botplayTxt.alpha') > 0.6 then
					setProperty('botplayTxt.alpha', 0.6)
					end
				end

				if songName == 'Atonement' then
			-- did a fucky now i gotta do this
					setProperty('candyshop.alpha', 0)
					setProperty('candyfront.alpha', 0)
					setProperty('candyback.alpha', 0)
					setObjectOrder('gfGroup', getObjectOrder('boyfriendGroup')+1)
					setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1)
					
					setProperty('dad.x', -230)
					setProperty('dad.y', 330)
					setProperty('dad.cameraPosition', {0,0})
				else
				
					setObjectOrder('boyfriendGroup', getObjectOrder('gfGroup')-1)
					setObjectOrder('dadGroup', getObjectOrder('gfGroup')-2)
					setProperty('dad.cameraPosition', {getProperty('dad.cameraPosition[0]')-35,getProperty('dad.cameraPosition[1]')})
					setProperty('boyfriend.cameraPosition', {getProperty('boyfriend.cameraPosition[0]')-25,getProperty('boyfriend.cameraPosition[1]')+20})
				end
            end
			if penieses == 2 then
				doTweenAlpha('nolight', 'atticlight', 0, 3.5 / playbackRate, 'cubeInOut')
				doTweenAlpha('nowall', 'atticwall', 0, 3.5 / playbackRate, 'cubeInOut')
				doTweenAlpha('nodadlol', 'dad', 0, 3.5 / playbackRate, 'cubeInOut')
				doTweenAlpha('nodadicon', 'iconP2', 0, 3.5 / playbackRate, 'cubeInOut')
				doTweenZoom("zoomies2", "camGame", 1.15, 3.5 / playbackRate, 'cubeOut')
				setProperty('defaultCamZoom', 1.15)
			end
			if penieses == 3 then
				
				removeLuaSprite('atticsky', true)
				removeLuaSprite('atticclouds', true)
				removeLuaSprite('atticstars', true)
				removeLuaSprite('atticwall', true)
				removeLuaSprite('atticlight', true)
				removeLuaSprite('atticvig', true);
				
				setProperty('candyvig.alpha', 1);
				setProperty('candywall.alpha', 1);
				
				
			setProperty('camZooming', true)
			setProperty('defaultCamZoom', 0.75)
				
				-- NON transparency hud
				setProperty('timeBarBG.alpha', 1)
				setProperty('timeBar.alpha', 1)
				setProperty('healthBar.alpha', 1)
				setProperty('healthBarBG.alpha', 1)
				setProperty('iconP1.alpha', 1)
				setProperty('iconP2.alpha', 1)
				setProperty('scoreTxt.alpha', 1)
				
				if not middlescroll then
			for index = 0, 7 do 
			noteTweenAlpha(index, index, 1, 0.0001 / playbackRate, 'cubeInOut');
			end
		else
			for index = 0, 3 do 
			noteTweenAlpha(index, index, 0.35, 0.0001 / playbackRate, 'cubeInOut');
			end
			for index = 4, 7 do 
			noteTweenAlpha(index, index, 1, 0.0001 / playbackRate, 'cubeInOut');
			end
		end
				
				if getProperty('timeTxt') then
					setProperty('timeTxt.alpha', 1)
				end
				
				function onUpdatePost(elapsed)
					-- ty rodney
				end
				
				if songName == 'Atonement' then
					setProperty('candyshop.alpha', 1)
					setProperty('candyfront.alpha', 1)
					setProperty('candyback.alpha', 1)
					setProperty('defaultCamZoom', 1)
					setProperty('iconP2.alpha', 1)
					setProperty('dad.alpha', 1)
					
					
					setObjectOrder('gfGroup', getObjectOrder('boyfriendGroup')-1)
				else
				setObjectOrder('boyfriendGroup', oldBFOrder)
				end
			end
		end
	end