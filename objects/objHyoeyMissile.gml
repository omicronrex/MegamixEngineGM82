#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpoints = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

itemDrop = -1;

respawn = false;
grav = 0;
blockCollision = false;

parent = noone;
phase = 0;
despawnRange = 0;

waitTimer = 0;
startWait = 15;
jetTimer = 0;
speed = 1.4;
rotateChange = 2;
totalChange = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        switch (phase)
        {
            case 0:
                if (startWait > 0)
                {
                    startWait--;
                }
                else
                {
                    phase = 1;
                }
                break;
            case 1:
                if (waitTimer < 15)
                {
                    waitTimer++;
                    break;
                }
                pxd = target.x - x;
                pyd = target.y - y;
                pangle = 0;
                if (pxd != 0)
                {
                    pangle = point_direction(x, y, target.x, target.y);
                }
                else
                {
                    if (pyd >= 0)
                    {
                        pangle = 270;
                    }
                    if (pyd < 0)
                    {
                        pangle = 90;
                    }
                }

                // and now that we have the angle the player is facing, we take the difference of the angles
                change = direction - pangle;

                // loop degree check, so the angle isn't above 360 or below 0
                if (change > 360)
                {
                    change -= 360;
                }
                else if (change < 0)
                {
                    change += 360;
                }

                /* this is interesting. So, by subtracting it by 180 it sort of aligns change to be how far away our angle to megaman is from our own angle
                we're pointing at as if our own angle is centered at 0 */
                change -= 180;

                /* and now, we just check how off mega man is, and do stuff accordingly (and also I reuse change to become the distance we change the
                angle )*/
                if (change > rotateChange)
                {
                    change = rotateChange;
                }
                if (change < -rotateChange)
                {
                    change = -rotateChange;
                }

                // Force the direction change to always be a 45 degree change (accurate to MM9)
                if ((change < 45) && (change > 0))
                {
                    change = 45;
                }
                else if ((change < 0) && (change > -45))
                {
                    change = -45;
                }

                direction += change;
                waitTimer = 0; // set cooldown

                totalChange += abs(change);

                break;
        }
    }
    // Jet Animation
    jetTimer += 1;
    if (jetTimer >= 4)
    {
        // <-- jet animation speed here
        if (sprite_index == sprHyoeyMissile)
        {
            sprite_index = sprHyoeyMissile2;
        }
        else if (sprite_index == sprHyoeyMissile2)
        {
            sprite_index = sprHyoeyMissile3;
        }
        else
        {
            sprite_index = sprHyoeyMissile;
        }

        jetTimer = 0;
    }

    image_index = round((direction) / 45);

    if (instance_exists(parent))
    {
        if (parent.killed == true)
        {
            event_user(EV_DEATH);
        }
    }
}

// image_index = (image_index div 1) + (col*8);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(x, y, objExplosion);
playSFX(sfxEnemyHit);
