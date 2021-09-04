#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 4;
blockCollision = 0;
canHit = true;
grav = 0;
stopOnFlash = false;

xspeed = 0;
launchTimer = 24;
launched = 0;

// flameSpawned = 0;
flameCleared = 0;
flameTimer = 0;

image_speed = 0.2;
reflectable = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (flameCleared == 0)
    {
        if (instance_exists(objFireFlame))
        {
            with (objFireFlame)
            {
                instance_destroy();
            }
            flameCleared = 1;
        }
    }

    launchTimer -= 1;
    if (launchTimer <= 0)
    {
        if (launchTimer == 0)
        {
            playSFX(sfxFireManFireStorm);
        }
        xspeed = 5 * image_xscale;
        launched = 1;
    }
    if (launched == 1)
    {
        if (instance_exists(target))
        {
            flameTimer += 1;
            if ((x >= target.bbox_left) && (x <= target.bbox_right))
            {
                // if (flameTimer >= 2)
                //{
                if (instance_exists(objFireFlame))
                {
                    with (objFireFlame)
                    {
                        instance_destroy();
                    }
                }
                if (image_xscale == -1)
                {
                    instance_create(x + xspeed, y, objFireFlame);
                }
                if (image_xscale == 1)
                {
                    instance_create(x - xspeed, y, objFireFlame);
                }

                // flameTimer = 0;
                //}
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((other.object_index == objIceWall) || (other.object_index == objWaterShield)
    || (other.object_index == objJewelSatellite))
{
    reflectable = -1;
    if (other.object_index == objIceWall)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
else
{
    other.guardCancel = 2;
}
