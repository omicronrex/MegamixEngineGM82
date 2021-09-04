#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A Sniper Joe that pilots a lilac jumping machine equipped with a machine gun.
// Destroying the armor will cause the "Returning Sniper Joe" in it to attack on foot
event_inherited();

healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 8;
killOverride = false;

category = "big eye, bulky, joes";

// Enemy specific code
shoot = false;
moveTimer = 20;

repeatAmount = 0;
repeatIsHigh = true;

doThing = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}

if (entityCanStep())
{
    if (ground) // If on ground...
    {
        moveTimer += 1; // Increase move timer.
        if (moveTimer == 10)
        {
            image_index = 0; // Set sprite to normal.
        }
        if (moveTimer == 1)
        {
            if (ycoll > 0) // If landing after a jump...
            {
                playSFX(sfxTimeStopper);
            }
            if (image_index > 1) // If sprite is set to jumping...
            {
                image_index = 1; // Set sprite to crouch/land.
            }

            calibrateDirection();
            xspeed = 0;
            yspeed = 0;
        }

        if (moveTimer == 30)
        {
            if (!doThing) // If not doing anything...
            {
                moveTimer = 0;
                doThing = true;
                shoot = true;
                if (instance_exists(target))
                {
                    if (target.bbox_bottom != bbox_bottom)
                    {
                        shoot = false;
                    }
                }
            }
        }
        if (doThing)
        {
            if (!shoot)
            {
                if (moveTimer == 30)
                {
                    image_index = 1;
                }
                else if (moveTimer == 40)
                {
                    yspeed = -5;
                    xspeed = image_xscale * 1.5;
                    ground = 0;
                    image_index = 2;

                    moveTimer = 0;
                    doThing = false;
                }
            }
            else
            {
                if (moveTimer == floor(moveTimer / 15) * 15 && moveTimer > 0)
                {
                    i = instance_create(x + image_xscale * 16, y, objEnemyBullet);
                    i.xspeed = 6 * image_xscale;
                    i.yspeed = 6 - (moveTimer / 15);
                    playSFX(sfxEnemyShootClassic);
                }
                else if (moveTimer > 60) // If timer exceeds 60...
                {
                    moveTimer = 0;
                    shoot = false;
                }
            }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
i = instance_create(x, y - 16, objMM2SniperJoe);
with (i)
{
    yspeed = -3;
    respawn = false;
    shootTimer = 0;
    shootAmount = 0;
    shooting = false;
    image_index = 0;
}
sprite_index = sprMM2SniperJoeMechEmpty;
event_inherited();
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (healthpoints - global.damage <= 0)
    sprite_index = sprMM2SniperJoeMechEmpty;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
moveTimer = 0;
image_index = 0;
sprite_index = sprMM2SniperJoeMech;
