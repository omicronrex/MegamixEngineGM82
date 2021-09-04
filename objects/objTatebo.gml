#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cannons, shielded";

facePlayerOnSpawn = true;

// enemy specific code
phase = 0;
timer = 0;
waitDiff = 30;

imgSpd = 0.1;
imgIndex = 0;
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
            // wait & shoot arc shot
            case 0:
                shootWait = 100;
                if (timer == shootWait - waitDiff)
                {
                    calibrateDirection();
                }
                if (imgIndex == 0)
                {
                    timer += 1;
                    if (timer == shootWait)
                    {
                        imgIndex = 1;
                        shot = instance_create(x + sprite_width * 0.35, y - 11,
                            objEnemyBullet);
                        with (shot)
                        {
                            sprite_index = sprTateboShot;
                            contactDamage = 3;
                            yspeed = -4;
                            grav = 0.13;
                            xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                        }

                        playSFX(sfxEnemyDrop);
                    }
                }
                else
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 2)
                    {
                        imgIndex = 0;
                    }
                }
                if (timer >= shootWait + waitDiff)
                {
                    phase = 1;
                    timer = 0;
                    imgIndex = 2;
                }
                break;

            // wait & shoot straight shot
            case 1:
                shootWait = 30;
                if (imgIndex == 2)
                {
                    timer += 1;
                    if (timer == shootWait)
                    {
                        imgIndex = 3;
                        shot = instance_create(x + sprite_width * 0.5, y + 5, objEnemyBullet);
                        shot.sprite_index = sprTateboShot;
                        shot.contactDamage = 3;
                        shot.xspeed = 1.9 * image_xscale;
                        playSFX(sfxEnemyShoot);
                    }
                }
                else
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 4)
                    {
                        imgIndex = 2;
                    }
                }
                if (timer >= shootWait + waitDiff)
                {
                    phase = 0;
                    timer = 0;
                    imgIndex = 0;
                }
                break;
        }
    }
}
else if (dead)
{
    phase = 0;
    timer = 0;
    xspeed = 0;
    yspeed = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!(image_index <= 1))
{
    exit;
}

if (image_xscale == -1)
{
    if (bboxGetXCenterObject(other.id) < bboxGetXCenter())
    {
        other.guardCancel = 1;
    }
}
else
{
    if (bboxGetXCenterObject(other.id) > bboxGetXCenter())
    {
        other.guardCancel = 1;
    }
}
