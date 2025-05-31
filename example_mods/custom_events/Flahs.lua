function onCreate()
   makeLuaSprite('White', '', 0, 0);
   makeGraphic('White', 1, 1, 'FFFFFF');
   scaleObject('White', screenWidth, screenHeight, false)
   setProperty('White.alpha', 0.0001);
   setObjectCamera('White', 'camOther');
   screenCenter('White')
   addLuaSprite('White', true);
end

function onEvent(Name)
     if Name == 'Flahs' then
         doTweenAlpha('Yo', 'White', 1, 1 / playbackRate, 'llinear');
     end
end

function onTweenCompleted(Tween)
   if Tween == 'Yo' then
      doTweenAlpha('Adios', 'White', 0, 1.5 / playbackRate, 'linear');
   end
end