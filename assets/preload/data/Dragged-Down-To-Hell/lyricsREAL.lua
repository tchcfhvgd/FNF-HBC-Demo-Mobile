songLyrics = {
"Seems you couldn't listen well",
"Never come back I did tell",
"Heed my warning you did not",
"Now the consequence is all your fault",
"You're a pest just like the rest",
"Time to put you to the test",
"weigh your heart and all of your sins",
"and find the demon deep within.",
"you angels are all the same",
"just talking to one makes me go insane.",
"You shouldn't be here at all",
"So now it's time for you to take a FALL.",
"You can't escape from me",
"Now all of hell will see",
"take a seat and watch the show",
"as i make your darkness known",
"Close your eyes and say goodbye",
"No one can hear your cries!",
"You're just a",
"sinning angel at the end of your rope",
"losing hope repeating all tropes",
"fallen down and hit a new low",
"as I drag you down below",
"You're feeling weaker",
"Room's getting darker~",
"You come down here so much",
"so why not JOIN. US?",
"You can't escape from me",
"Now all of hell will see",
"take a seat and watch the show",
"as i make your darkness known"}

songLyricSteps = {64,80,96,108,194,208,224,240,258,270,290,301,322,338,354,366,464,494,506,512,528,544,558,578,594,610,622,706,722,738,750}

defaultLyricTxt1Y = 517
defaultLyricTxt2Y = 517 - 52
defaultLyricTxt3Y = 517 - 104

function onCreatePost()
	for i = 1, 3 do
		makeLuaText('lyricTxt'..i, "", screenWidth, 61, 517 + 52)
		setTextFont('lyricTxt'..i, 'Apocalypse Grunge.ttf')
		setTextAlignment('lyricTxt'..i, 'left')
		setTextColor('lyricTxt'..i, '8a0103')
		setTextBorder('lyricTxt'..i, 1, '000000')
		setTextSize('lyricTxt'..i, '40')
		setProperty('lyricTxt'..i..'.alpha', 0.0001)
		
		setProperty('lyricTxt'..i..'.visible', not hideHud)
		
		addLuaText('lyricTxt'..i)
	end
end


introDuration = 0.5
ease = 'quadOut'

secondAlpha = 0.4
thirdAlpha = 0.2


curLyric = 0
function onStepHit()
	for lyricNum, lyricStep in pairs(songLyricSteps) do
		if curStep == lyricStep then
			curLyric = lyricNum
		
		
			if not doneFirstLyric then
			doneFirstLyric = true
			setTextString('lyricTxt1', songLyrics[lyricNum])
			setProperty('lyricTxt1.alpha', 1)
			
				doTweenY('nextLyric1', 'lyricTxt1', defaultLyricTxt1Y, introDuration / playbackRate, ease)
				

			elseif not doneSecondLyric then
			doneSecondLyric = true
			setTextString('lyricTxt1', songLyrics[lyricNum])
			
			setTextString('lyricTxt2', songLyrics[lyricNum-1])
			setProperty('lyricTxt2.alpha', secondAlpha)
			
				doTweenY('nextLyric2', 'lyricTxt2', defaultLyricTxt2Y, introDuration / playbackRate, ease)
			
			
			elseif not doneThirdLyric then
			doneThirdLyric = true
			setTextString('lyricTxt1', songLyrics[lyricNum])
			setTextString('lyricTxt2', songLyrics[lyricNum-1])
			
			setTextString('lyricTxt3', songLyrics[lyricNum-2])
			setProperty('lyricTxt3.alpha', thirdAlpha)
			
				doTweenY('nextLyric3', 'lyricTxt3', defaultLyricTxt3Y, introDuration / playbackRate, ease)
			
			
			else
			
			
				setTextString('lyricTxt1', songLyrics[lyricNum])
				setTextString('lyricTxt2', songLyrics[lyricNum-1])
				setTextString('lyricTxt3', songLyrics[lyricNum-2])
				
			end
		end
	end
end
	