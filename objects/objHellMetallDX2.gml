#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
contactDamage = 8;
facePlayer = true;

category = "mets, shielded";

phase = 0;
imgIndex = 0;
imgSpd = 0.1;
moveTimer = 120;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        xspeed = 0;
    }
    else
    {
        xspeed = -1 * image_xscale;
    }

    switch (phase)
    {
        case 0:
            moveTimer--;
            if (moveTimer <= 0)
            {
                if ((moveTimer == 0) && (instance_exists(target)))
                {
                    imgIndex = 4;

                    var i = instance_create(x, y - 14, objEnemyBullet);
                    i.image_xscale = image_xscale;
                    i.grav = 0.25;
                    i.image_xscale = image_xscale;
                    i.yspeed = -4;

                    with (i)
                    {
                        xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                    }

                    playSFX(sfxEnemyShootClassic);
                }

                imgIndex += imgSpd;

                if (imgIndex >= 6)
                {
                    imgIndex = 0;
                    moveTimer = 120;
                }
            }
            break;
        case 1:
            imgIndex += 0.5;
            if (imgIndex == 3)
            {
                phase = 2;
            }
            moveTimer = 20;
            break;
        case 2:
            moveTimer--;
            if (moveTimer <= 0)
            {
                imgIndex -= imgSpd;
                if (imgIndex <= 0)
                {
                    moveTimer = 10;
                    phase = 0;
                }
            }
            break;
    }
}
else if (dead)
{
    instance_destroy();
}

image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 0)
{
    if (other.object_index == objBusterShotCharged)
    {
        other.guardCancel = 1;
        phase = 1;
        if (imgIndex > 0)
        {
            imgIndex = 0;
        }
        other.dead = true;
    }
    else if ((other.object_index != objTornadoBlow) && (other.object_index != objBlackHoleBomb))
    {
        other.guardCancel = 1;
    }
}
