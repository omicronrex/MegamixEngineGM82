#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 24;
category = "bulky, nature";
contactDamage = 3;
respawnRange = 0;
despawnRange = 16;

// Enemy specific code

//@cc sets how far it moves to the left of its starting position in pixels
leftLimit = 32;

//@cc sets far it moves to the right of its starting position in pixels
rightLimit = 16;

phase = 0;
animFrame = 0;
timer = 0;
shotCount = 0;

//@cc random shenanigans
timescale = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (timescale < 0)
    timescale = abs(timescale);
grav = 0.25 * timescale;
var prexscale = image_xscale;
image_xscale=1;
mask_index = mskStegorus;
event_inherited();
image_xscale = prexscale;
mask_index = sprStegorus;

if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            if (timer == 0) // walk
            {
                var prevFrame = floor(animFrame);
                animFrame += 0.165 * timescale;
                if (floor(animFrame) != prevFrame)
                {
                    if (floor(animFrame) > 1)
                        playSFX(sfxStegorusStomp);
                    if (floor(animFrame) > 4)
                    {
                        animFrame = 0;
                        xspeed = 0;
                        timer = 5 / timescale;
                        screenShake(5, 1, 1);
                        if (x < (xstart - leftLimit) || x > (xstart + rightLimit) || xcoll != 0 || checkFall(65 * image_xscale, true))
                        {
                            var tx = 0;
                            if (instance_exists(target))
                            {
                                tx = target.x;
                            }
                            if (sign(tx - x) == image_xscale)
                            {
                                phase = 1;
                                shotCount = -1;
                                timer = -1;
                            }
                            else
                            {
                                phase = 2;
                                shotCount = -1;
                                timer = 0;
                            }
                            turn = true;
                        }
                    }
                }
                if (floor(animFrame) != 0)
                {
                    xspeed = 0.365 * timescale * image_xscale;
                }
            }
            else
            {
                timer -= 1 * timescale;
                if (timer < 0)
                    timer = 0;
            }
            image_index = floor(animFrame);
            break;
        case 1: // Shoot spikes
            var prev = floor(animFrame);
            if (timer != -10)
                animFrame += 0.185 * timescale * timer;
            else
            {
                animFrame += 0.175 * timescale;
                if (floor(animFrame) > 6)
                {
                    animFrame = 0;
                    timer = 0;
                    phase = 3 * turn;
                }
            }
            if (timer == 1)
            {
                if (floor(animFrame) != prev && floor(animFrame) > 2)
                {
                    timer = -1;
                    animFrame = 2.9;
                }
            }
            else if (timer == -1 && animFrame <= 0)
            {
                timer = 1;
                animFrame = 0;
                shotCount += 1;
                if (shotCount != 3)
                    playSFX(sfxStegorusSpikes);
                switch (shotCount)
                {
                    case 0:
                        var i = instance_create(x + 21 * image_xscale, y - 23, objStegorusSpike);
                        i.sprite_index = sprStegorusSpikeSmall;
                        i.xsp = 2.65;
                        i.image_xscale = image_xscale;
                        i.timescale = timescale;
                        i.parent = id;
                        break;
                    case 1:
                        var i = instance_create(x + 16 * image_xscale, y - 28, objStegorusSpike);
                        i.sprite_index = sprStegorusSpikeMedium;
                        i.xsp = 1.85;
                        i.ysp = -4;
                        i.image_xscale = image_xscale;
                        i.timescale = timescale;
                        i.parent = id;
                        break;
                    case 2:
                        var i = instance_create(x + 10 * image_xscale, y - 34, objStegorusSpike);
                        i.sprite_index = sprStegorusSpikeBig;
                        i.xsp = 1.5;
                        i.ysp = -5;
                        i.image_xscale = image_xscale;
                        i.timescale = timescale;
                        i.parent = id;
                        break;
                    case 3:
                        timer = -10;
                        shotCount = 2;
                        animFrame = 3;
                        break;
                }
            }
            if (phase == 1)
                image_index = floor(animFrame) + 5 + 3 * shotCount;
            else
                image_index = 17;
            break;
        case 2: // Shoot missiles
            timer += 1 * timescale;
            if (timer >= 30 && shotCount < 1)
            {
                image_index = 17 + ((ceil(timer) div 10) mod 2);
            }
            else
            {
                image_index = 0;
            }
            if (timer > 40)
            {
                timer = 0;
                shotCount += 1;
                if (shotCount >= 2)
                {
                    phase = turn * 3;
                }
                else
                {
                    var i = instance_create(x + 16 * image_xscale, y - 25, objStegorusMissile);
                    if (image_xscale == 1)
                    {
                        i.angle = 45;
                        i.newAngle = 90;
                    }
                    else
                    {
                        i.angle = 90 + 45;
                        i.newAngle = 90 + 45;
                    }
                    i.parent = id;
                    i.timescale = timescale;
                    playSFX(sfxStegorusMissile);
                }
            }
            break;
        case 3: // turning
            xspeed = 0;
            var prevFrame = floor(animFrame);
            if (floor(animFrame) != 8)
                animFrame += 0.15 * timescale;
            else
                animFrame += 0.065 * timescale;
            if (floor(animFrame) != prevFrame && floor(animFrame) == 5)
                image_xscale *= -1;
            image_index = min(10, floor(animFrame)) + 19;
            if (floor(animFrame) > 10)
            {
                animFrame = 0;
                var tx = 0;
                if (instance_exists(target))
                {
                    tx = target.x;
                }
                if (sign(tx - x) == image_xscale)
                {
                    phase = 1;
                    shotCount = -1;
                    timer = -1;
                }
                else
                {
                    phase = 2;
                    shotCount = -1;
                    timer = 0;
                }
                turn = false;
            }
            break;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
var ignore = true;
if (other.bbox_bottom > bbox_top + 24)
{
    if (collision_rectangle(x + 20 * image_xscale, y - 16, x + 34 * image_xscale, y, other.id, false, true))
    {
        ignore = false;
    }
}
if (ignore)
{
    if (!collision_rectangle(x - 22, y - 30, x + 22, y, other.id, false, true))
    {
        other.guardCancel = 2;
    }
    else
    {
        other.guardCancel = 1;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
phase = 0;
animFrame = 0;
timer = 0;
shotCount = 0;
