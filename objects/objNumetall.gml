#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 3;
healthpointsStart = 1;
grav = 0.25 * image_yscale;
blockCollision = true;
category = "mets";

// Enemy specific code
animFrame = 0;
phase = 0;
timer = 0;
accelerating = true;
accel = 0.0125;
maxSpeed = 0.70;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // Walking
            if (floor(animFrame) > 4)
                animFrame = 4;
            else if (floor(animFrame) == 4)
            {
                animFrame -= 0.165;
                if (floor(animFrame) < 4)
                    animFrame = 0;
            }
            else
            {
                animFrame += 0.135; // 0.01+0.2*abs(xspeed);
                if (floor(animFrame) > 3)
                    animFrame = 0;
            }
            if (timer == 0)
            {
                if (instance_exists(target))
                {
                    var isGonnaHurt; isGonnaHurt = false;
                    if ((abs(target.x - x) < 32) || target.image_xscale == sign(x - target.x) && global.keyShootPressed[target.playerID])
                    {
                        phase = 1;
                        timer = 0;
                        animFrame = 4;
                        xspeed = 0;
                        break;
                    }
                }
                if (accelerating)
                {
                    xspeed += accel * image_xscale;
                    if (abs(xspeed) >= maxSpeed)
                    {
                        accelerating = false;
                        xspeed = maxSpeed * image_xscale;
                    }
                }
                else
                {
                    xspeed -= accel * image_xscale;
                    if (sign(xspeed) != image_xscale)
                    {
                        xspeed = 0;
                        timer = -30;
                    }
                }

                if (xcoll != 0 || checkFall(16 * image_xscale)) //! checkSolid(16 * image_xscale, 8 * image_yscale))
                {
                    xspeed = 0;
                    timer = 30;
                }
            }
            else if (timer > 0)
            {
                xspeed = 0;
                timer -= 1;
                if (timer <= 0)
                {
                    timer = 0;
                    accelerating = true;
                    image_xscale *= -1;
                }
            }
            else if (timer < 0)
            {
                xspeed = 0;
                timer += 1;
                if (timer >= 0)
                {
                    timer = 0;
                    accelerating = true;
                }
            }
            if (xspeed == 0)
                animFrame = 0;
            break;
        case 1: // Hidden
            if (instance_exists(target) && target.image_xscale == sign(x - target.x) && global.keyShootPressed[target.playerID])
                timer = 0;
            xspeed = 0;
            if (floor(animFrame) == 4)
            {
                animFrame += 0.15;
                if (floor(animFrame) > 4)
                    animFrame = 6;
            }
            else if (floor(animFrame) >= 7)
            {
                animFrame += 0.3;
                if (floor(animFrame) > 13)
                {
                    animFrame = 6;
                }
            }
            else if (animFrame == 6)
            {
                timer += 1;
                if (timer >60)
                {
                    phase = 2;
                    timer = 0;
                }
            }
            break;
        case 2: // Shooting
            xspeed = 0;
            if (timer == 0)
            {
                calibrateDirection();
                playSFX(sfxNumetallShoot);
                animFrame = 5;
                var i; i = -45;
                repeat (3)
                {
                    var b; b = instance_create(x + 8 * image_xscale, y - 8 * image_yscale, objNumetallGlob);
                    b.angle = i;
                    i += 45;
                    b.image_xscale = image_xscale;
                }
            }
            timer += 1;
            if (timer > 60)
            {
                animFrame = 0;
                phase = 0;
                timer = 0;
                accelerating = true;
            }
            break;
    }
    image_index = floor(animFrame);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (phase == 1 || (phase == 0 && timer == 0))
{
    if (phase == 0)
    {
        phase = 1;
        timer = 0;
    }
    other.guardCancel = 1;
    if (animFrame < 7)
    {
        animFrame = 7;
        timer = 0;
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
accelerating = true;
timer = 0;
animFrame = 0;
