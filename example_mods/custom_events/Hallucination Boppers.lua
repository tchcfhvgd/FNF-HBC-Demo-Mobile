function onCreatePost()
makeAnimatedLuaSprite('boppers1', 'CandyShop/Background/BoppersHallucination1fix', -180, 250)
			addAnimationByPrefix('boppers1', 'idle', 'boppers', 24, false)
			addLuaSprite('boppers1')
			setObjectOrder('boppers1', 5)
			setObjectCamera('boppers1', 'camGame')
			scaleObject('boppers1', 0.85, 0.85)
			setScrollFactor('boppers1', 0.85, 0.95)
			setProperty('boppers1.alpha', 0.0001);
			
			makeAnimatedLuaSprite('boppers2', 'CandyShop/Background/BoppersHallucination2fix', -230, 250)
			addAnimationByPrefix('boppers2', 'idle', 'evilbobbers', 24, false)
			addLuaSprite('boppers2')
			setObjectOrder('boppers2', 6)
			setObjectCamera('boppers2', 'camGame')
			scaleObject('boppers2', 0.85, 0.85)
			setScrollFactor('boppers2', 0.85, 0.95);
			setProperty('boppers2.alpha', 0.0001);
			
			makeLuaSprite('hallufloor1', 'CandyShop/Background/CandyShopHallucinationFloor1fix', -380, 220)
			setObjectCamera('hallufloor1', 'camGame')
			scaleObject('hallufloor1', 0.95, 0.95)
			setScrollFactor('hallufloor1', 1, 1)
			setObjectOrder('hallufloor1', 10)
			addLuaSprite('hallufloor1')
			setProperty('hallufloor1.alpha', 0.0001);
			
			makeLuaSprite('hallufloor2', 'CandyShop/Background/CandyShopHallucinationFloor2fix', -380, 220)
			setObjectCamera('hallufloor2', 'camGame')
			scaleObject('hallufloor2', 0.95, 0.95)
			setScrollFactor('hallufloor2', 1, 1)
			setObjectOrder('hallufloor2', 10)
			addLuaSprite('hallufloor2')
			setProperty('hallufloor2.alpha', 0.0001);
			
			--makeAnimatedLuaSprite('back1', 'CandyShop/Background/CandyShopHallucinationBack1fix', 30, -50)
			--addAnimationByPrefix('back1', 'idle', 'back', 24, false)
			--addLuaSprite('back1')
			--setObjectOrder('back1', 4)
			--setObjectCamera('back1', 'camGame')
			--scaleObject('back1', 0.95, 0.95)
			--setScrollFactor('back1', 0.6, 0.9);
			--setProperty('back1.alpha', 0.0001);
			
			--makeAnimatedLuaSprite('back2', 'CandyShop/Background/CandyShopHallucinationBack2fix', 30, -50)
			--addAnimationByPrefix('back2', 'idle', 'back', 24, false)
			--addLuaSprite('back2')
			--setObjectOrder('back2', 5)
			--setObjectCamera('back2', 'camGame')
			--scaleObject('back2', 0.95, 0.95)
			--setScrollFactor('back2', 0.6, 0.9);
			--setProperty('back2.alpha', 0.0001);
			end

function onEvent(name, value1, value2)
    local killbop = tonumber(value1)
    local aughgh = tonumber(value2)
    if name == 'Hallucination Boppers' then
		if killbop == 1 then
		runHaxeCode('FlxG.camera.stopFX();')
		runHaxeCode('FlxG.camera.flash(0xFFFFFFFF, 1, true);')
		setProperty('health', 1)
		
			setProperty('defaultCamZoom', 1)
			setProperty('boppers0.alpha', 0.0001);
			setProperty('boppers1.alpha', 1);
			setProperty('hallufloor1.alpha', 1);
			--setProperty('back1.alpha', 1);
			
				-- transparency hud
				setProperty('timeBarBG.alpha', 0.8)
				setProperty('timeBar.alpha', 0.8)
				setProperty('healthBar.alpha', 0.8)
				setProperty('healthBarBG.alpha', 0.8)
				setProperty('iconP1.alpha', 0.8)
				setProperty('iconP2.alpha', 0.8)
				setProperty('scoreTxt.alpha', 0.8)
				
				for i = 0, 3 do
				setPropertyFromGroup('opponentStrums', i, 'alpha', 0.0001)
				end
				
				for index = 0, 3 do
				setPropertyFromGroup('playerStrums', index, 'alpha', 0.8)
				end
			
				if getProperty('timeTxt') and not downscroll and not middlescroll then
				doTweenY('coolthing', 'timeTxt', 10, 0.5 / playbackRate, 'smoothStepOut')
				setProperty('timeTxt.alpha', 0.8)
				else
				setProperty('timeTxt.alpha', 0.8)
				end
				
				function onUpdatePost(elapsed)
					if getProperty('botplayTxt.alpha') > 0.8 then
					setProperty('botplayTxt.alpha', 0.8)
					end
				end
				
            end
			if killbop == 2 then
				--ignore this shit the zoom was being weird
				function onUpdate()
					setProperty('defaultCamZoom', 0.9)
					if curBeat == 447 then
						function onUpdate()
						--nope
						end
					end
				end
				removeLuaSprite('boppers1', true)
				removeLuaSprite('hallufloor1', true)
				--removeLuaSprite('back1', true)
				setProperty('boppers2.alpha', 1);
				setProperty('hallufloor2.alpha', 1);
				--setProperty('back2.alpha', 1);
			end
			if killbop == 3 then
				--removeLuaSprite('back1', true)
				--removeLuaSprite('back2', true)
				removeLuaSprite('hallufloor1', true)
				removeLuaSprite('hallufloor2', true)
				removeLuaSprite('boppers1', true)
				removeLuaSprite('boppers2', true);
				setProperty('boppers0.alpha', 1);
				
				-- NON transparency hud
				setProperty('timeBarBG.alpha', 1)
				setProperty('timeBar.alpha', 1)
				setProperty('healthBar.alpha', 1)
				setProperty('healthBarBG.alpha', 1)
				setProperty('iconP1.alpha', 1)
				setProperty('iconP2.alpha', 1)
				setProperty('scoreTxt.alpha', 1)
				
				if not middlescroll then 
				
				for i = 0, 3 do
				setPropertyFromGroup('opponentStrums', i, 'alpha', 1)
				end
				
				else
				
				for i = 0, 3 do
				setPropertyFromGroup('opponentStrums', i, 'alpha', 0.35)
				end
				
				end
				
				for index = 0, 3 do
				setPropertyFromGroup('playerStrums', index, 'alpha', 1)
				end
				
				if getProperty('timeTxt') and not downscroll and not middlescroll then
					doTweenY('finishedcoolthing', 'timeTxt', 58, 0.5 / playbackRate, 'smoothStepOut')
					setProperty('timeTxt.alpha', 1)
					--setProperty('timeTxt.x', getProperty('timeTxt.x') + 10)
				else
					setProperty('timeTxt.alpha', 1)
				end
				
				function onUpdatePost(elapsed)
					
					
					if middlescroll and curBeat >= 480 then
						for i = 0, 3 do
						setPropertyFromGroup('opponentStrums', i, 'alpha', 0.35)
						end
					end
				end
				
				--runHaxeCode('Paths.clearUnusedMemory();') -- save me fpsvar
			end
		end
	end