function onCreatePost()
	makeLuaText('sub1', "Foolish angel you've sealed your doom", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub2', "Sentenced to an eternal tomb", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub3', "Welcome boyfriend to your fate", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub4', "The fire burns within hells gate", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub5', "You sicken me to the core", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub6', "I dont wanna see your face anymore", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub7', "You angels are all the same", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub8', "Can't get one simple thing in your brain", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub9', "You think you're so much better?", screenWidth, -350, getProperty('healthBarBG.y')-70)
	
	makeLuaText('sub10', "Why not make things get redder", screenWidth, -350, getProperty('healthBarBG.y')-70)
	setTextColor('sub10', '0xFFFF0000')
	
	makeLuaText('sub11', "Just let go of your mind", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub12', "I promise youll be fine", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub13', "Just let up and give control", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub14', "Or the consequences grow", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub15', "I work so hard yet here you are", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub16', "So lets change that for good you're", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub17', "Just a sinning angel at the end of your rope", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub18', "Losing hope", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub19', "Repeating all tropes", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub20', "Your empty pleas may fill the air", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub21', "But theres nothing but despair", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub22', "Oh you're slowly falling", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub23', "A fallen angel", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub24', "You're broken down disgraced and lost", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub25', "Let me fix you", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub26', "Just let go of your mind", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub27', "I promise youll be fine", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub28', "Just let up and give control", screenWidth, -350, getProperty('healthBarBG.y')-70)
	makeLuaText('sub29', "Or the consequences grow", screenWidth, -350, getProperty('healthBarBG.y')-70)
	

	
	if hideHud then
		for i = 1, 29 do
		setProperty('sub'..i..'.visible', false)
		end
	end
	
	if downscroll then
		for oops = 1, 29 do
		setProperty('sub'..oops..'.y', 550)
		end
	end
	
	
	--i optimized your lyric system kinda ciovo 
	for index = 1, 29 do
	setTextFont('sub'..index, 'vcr.ttf')
	setTextAlignment('sub'..index, 'center')
	setTextBorder('sub'..index, 1.25, '000000')
	setTextSize('sub'..index, 20)
	setObjectCamera('sub'..index, 'camHUD')
	setProperty('sub'..index..'.alpha', 0)
	addLuaText('sub'..index)
	end
end

function onStepHit()
	if curStep == 64 then
	setProperty('sub1.alpha', 1)
	
	
	elseif curStep == 80 then
	removeLuaText('sub1', true)
	setProperty('sub2.alpha', 1)
	
	
	elseif curStep == 96 then
	removeLuaText('sub2', true)
	setProperty('sub3.alpha', 1)
	
	
	elseif curStep == 111 then
	removeLuaText('sub3', true)
	setProperty('sub4.alpha', 1)
	
	
	elseif curStep == 128 then
	removeLuaText('sub4', true)

	
	elseif curStep == 193 then
	setProperty('sub5.alpha', 1)
	
	
	elseif curStep == 206 then
	removeLuaText('sub5', true)
	setProperty('sub6.alpha', 1)
	
	
	elseif curStep == 224 then
	removeLuaText('sub6', true)
	
	
	elseif curStep == 258 then
	setProperty('sub7.alpha', 1)
	
	
	elseif curStep == 272 then
	removeLuaText('sub7', true)
	setProperty('sub8.alpha', 1)
	
	
	elseif curStep == 290 then
	removeLuaText('sub8', true)
	setProperty('sub9.alpha', 1)
	
	
	elseif curStep == 306 then
	removeLuaText('sub9', true)
	setProperty('sub10.alpha', 1)
	
	
	elseif curStep == 322 then
	removeLuaText('sub10', true)
	setProperty('sub11.alpha', 1)
	
	
	elseif curStep == 338 then
	removeLuaText('sub11', true)
	setProperty('sub12.alpha', 1)
	
	
	elseif curStep == 354 then
	removeLuaText('sub12', true)
	setProperty('sub13.alpha', 1)
	
	
	elseif curStep == 366 then
	removeLuaText('sub13', true)
	setProperty('sub14.alpha', 1)
	
	
	elseif curStep == 384 then
	removeLuaText('sub14', true)
	
	
	elseif curStep == 462 then
	setProperty('sub15.alpha', 1)
	
	
	elseif curStep == 480 then
	removeLuaText('sub15', true)
	
	
	elseif curStep == 494 then
	setProperty('sub16.alpha', 1)
	
	
	elseif curStep == 508 then
	removeLuaText('sub16', true)
	setProperty('sub17.alpha', 1)
	
	
	elseif curStep == 528 then
	removeLuaText('sub17', true)
	setProperty('sub18.alpha', 1)
	
	
	elseif curStep == 534 then
	removeLuaText('sub18', true)
	setProperty('sub19.alpha', 1)
	
	
	elseif curStep == 544 then
	removeLuaText('sub19', true)
	setProperty('sub20.alpha', 1)
	
	
	elseif curStep == 558 then
	removeLuaText('sub20', true)
	setProperty('sub21.alpha', 1)
	
	
	elseif curStep == 576 then
	removeLuaText('sub21', true)
	
	
	elseif curStep == 578 then
	setProperty('sub22.alpha', 1)
	
	
	elseif curStep == 590 then
	removeLuaText('sub22', true)
	setProperty('sub23.alpha', 1)
	
	
	elseif curStep == 610 then
	removeLuaText('sub23', true)
	setProperty('sub24.alpha', 1)
	
	
	elseif curStep == 628 then
	removeLuaText('sub24', true)
	setProperty('sub25.alpha', 1)
	
	
	elseif curStep == 640 then
	removeLuaText('sub25', true)
	
	
	
	elseif curStep == 706 then
	setProperty('sub26.alpha', 1)
	
	
	elseif curStep == 722 then
	removeLuaText('sub26', true)
	setProperty('sub27.alpha', 1)
	
	
	elseif curStep == 738 then
	removeLuaText('sub27', true)
	setProperty('sub28.alpha', 1)
	
	
	elseif curStep == 750 then
	removeLuaText('sub28', true)
	setProperty('sub29.alpha', 1)
	
	
	elseif curStep == 768 then
	removeLuaText('sub29', true)
	end
end