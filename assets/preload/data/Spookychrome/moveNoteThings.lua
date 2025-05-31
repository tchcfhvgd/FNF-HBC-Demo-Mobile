local xx = 100;

local yy = 650;

local xx2 = 100;

local yy2 = 650;

local ofs = 20;

local followchars = true;

local del = 0;

local del2 = 0;

function onUpdate()

if del > 0 then

del = del - 1

end

if del2 > 0 then

del2 = del2 - 1

end
if curStep > 1664 then
    if followchars == true then


        if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then

            triggerEvent('Camera Follow Pos',xx2-ofs,yy2)

        end

        if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then

            triggerEvent('Camera Follow Pos',xx2+ofs,yy2)

        end

        if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then

            triggerEvent('Camera Follow Pos',xx2,yy2-ofs)

        end

        if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then

            triggerEvent('Camera Follow Pos',xx2,yy2+ofs)

        end

        if getProperty('boyfriend.animation.curAnim.name') == 'idle' then

            triggerEvent('Camera Follow Pos',xx2,yy2)

        end

    end

    else

        triggerEvent('Camera Follow Pos','','')

    end
    

end