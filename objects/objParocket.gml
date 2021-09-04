#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A rocket that flies high into the sky, then slowly drops down via parachute. If it lands
// on the ground, or is destroyed, it releases a damaging explosion. Watch out!

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 3;

despawnRange = 35;
grav = 0;
category = "flying";

moveTimer = 60;
phase = 0;
imgSpd = 0.2;
bounceTimes = 0;
animBack = false;
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
        // On ground
        case 0:
            moveTimer-=1;
            if (moveTimer <= 0)
            {
                if (bounceTimes < 2)
                {
                    if (ground)
                    {
                        y -= 1;
                    }
                    else
                    {
                        y += 1;
                        bounceTimes+=1;
                    }
                }
                else
                {
                    phase = 1;
                    moveTimer = 30;
                }
            }
            break;
        // Rising
        case 1:
            image_index += imgSpd;
            if ((image_index >= 4) && (y > view_yview))
            {
                yspeed = -3;
                blockCollision = false;
            }
            if (image_index >= 6)
            {
                image_index = 4;
            }
            if (y < view_yview - 2)
            {
                yspeed = 0;
                moveTimer-=1;
                if (moveTimer <= 0)
                {
                    x += 40;
                    sprite_index = sprParocketFall;
                    yspeed = 1;
                    phase = 2;
                }
            }
            break;
        // Falling
        case 2:
            if (animBack == false)
            {
                image_index += 0.05;
                if (image_index >= 3)
                {
                    animBack = true;
                    image_index = 2;
                }
            }
            else
            {
                image_index -= 0.05;
                if (image_index < 0) //== 0
                {
                    animBack = false;
                    image_index = 1;
                }
            }
            if (instance_exists(target))
            {
                if (target.x > x)
                {
                    xspeed = 0.5;
                }
                else if (target.x < x)
                {
                    xspeed = -0.5;
                }
                else
                {
                    xspeed = 0;
                }
            }
            if (y > view_yview + 32)
            {
                blockCollision = true;
                if ((xcoll != 0) || (ycoll != 0))
                {
                    dead = true;
                    itemDrop = -1;
                    i = instance_create(x, y, objHarmfulExplosion);
                    i.contactDamage = 6;
                    playSFX(sfxMM9Explosion);
                }
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    moveTimer = 60;
    phase = 0;
    sprite_index = sprParocketRise;
    image_index = 0;
    blockCollision = true;
    bounceTimes = 0;
    animBack = false;
    itemDrop = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (sprite_index == sprParocketRise)
{
    var i; i = instance_create(x, y - (sprite_height / 2), objHarmfulExplosion);
    i.contactDamage = 6;
}
else
{
    var i; i = instance_create(x, y, objHarmfulExplosion);
    i.contactDamage = 6;
}
playSFX(sfxMM9Explosion);
