#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An Up'n'Down type enemy that parachutes down and explodes on death/contact.
event_inherited();

healthpointsStart = 1;
healthpoints = 1;
respawn = false;
grav = 0;
yspeed = -3;
contactDamage = 4;

imgIndex = 0;
imgSpd = 0.2;
phase = 0;
animBack = false;
animDelay = 6;

pierces = 0; // Die on contact with the player
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
        // activate if target approaches
        case 0:
            if (instance_exists(target))
            {
                if (y >= target.y)
                {
                    imgIndex += imgSpd;
                    if (imgIndex == 2)
                    {
                        imgIndex = 0;
                    }
                }
                else
                {
                    phase = 1;
                }
            }
            break;
        // jump up + float down
        case 1:
            if (yspeed < 0)
            {
                yspeed += 0.1;
                if (imgIndex < 6)
                {
                    imgIndex += imgSpd;
                }
            }
            else
            {
                y += 1;
                if (animDelay == 6)
                {
                    if (animBack == false)
                    {
                        imgIndex += 0.1;

                        if (imgIndex == 10)
                        {
                            imgIndex = 9;
                            animBack = true;
                            animDelay = 0;
                        }
                    }
                    else
                    {
                        imgIndex -= 0.1;

                        if (imgIndex < 7)
                        {
                            imgIndex = 7.9;
                            animBack = false;
                            animDelay = 0;
                        }
                    }
                }
                else
                {
                    animDelay++;
                }
            }
            break;
    }

    // Check for wind/rain objects
    if (instance_place(x, y, objToadRain))
    {
        xspeed = instance_place(x, y, objToadRain).blowSpeed;
    }

    if (instance_exists(objTenguWind))
    {
        if (instance_nearest(x, y, objTenguWind).activated)
        {
            xspeed = instance_nearest(x, y, objTenguWind).windSpeed * instance_nearest(x, y, objTenguWind).dir;
        }
    }

    if (instance_place(x, y, objWindRight))
    {
        if (instance_place(x, y, objWindRight).dir == "right")
        {
            xspeed = instance_place(x, y, objWindRight).spd;
        }
        else if (instance_place(x, y, objWindRight).dir == "left")
        {
            xspeed = -(instance_place(x, y, objWindRight).spd);
        }
        else if (instance_place(x, y, objWindRight).dir == "up")
        {
            yspeed = 1.2 - instance_place(x, y, objWindRight).spd;
        }
        else if (instance_place(x, y, objWindRight).dir == "right")
        {
            yspeed = 1 + instance_place(x, y, objWindRight).spd;
        }
    }

    if (instance_place(x, y, objSandstorm))
    {
        xspeed = instance_place(x, y, objSandstorm).dir * 0.5;
    }

    // blow up on ground hit
    if ((xcoll) || (ycoll))
    {
        i = instance_create(x, y, objHarmfulExplosion);
        i.contactDamage = 4;
        playSFX(sfxMM9Explosion);
        itemDrop = -1;
    }
}
image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

i = instance_create(x, y, objHarmfulExplosion);
i.contactDamage = 4;
playSFX(sfxMM9Explosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// destroy the parachute
if other.y <= y - 2 && image_index >= 5
{
    instance_create(x, y - 2, objExplosion);
    healthpoints += 1;

    imgIndex = 3;
    grav = gravAccel;
    phase = 2;
}
