#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "fire, floating";

grav = 0;
blockCollision = false;

facePlayerOnSpawn = true;

// enemy specific code
phase = 1;
shootTimer = 0;
chain = 0;
previousShotType = 0;

keptYSpeed = 0;

imgSpd = 0.10;
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
    switch (phase)
    {
        // set charge time
        case 1: // choose time to wait between shots, and don't repeat the same time more than twice in a row
            shotType = choose(0, 1);

            if (shotType == previousShotType && chain >= 2)
            {
                if (shotType == 0)
                {
                    shotType = 1;
                }
                else
                {
                    shotType = 0;
                }

                chain = 0;
            }

            if (shotType == 0)
            {
                shootWait = 50;
            }
            else if (shotType == 1)
            {
                shootWait = 120;
            }

            previousShotType = shotType;

            chain += 1;

            xspeed = 1 * image_xscale; // <-- speed here
            yspeed = keptYSpeed;

            phase = 2;

            break;

        // wait to shoot
        case 2: // animation
            imgIndex += imgSpd;
            if (imgIndex >= 4)
            {
                imgIndex = imgIndex mod 4;
            }

            if (instance_exists(target))
            {
                // wait to fire
                shootWait -= 1;
                yspeed = keptYSpeed;
                if (shootWait <= 0)
                {
                    phase = 3;
                    shootWait = 0;
                    imgIndex = 4;
                    xspeed = 0;
                    yspeed = 0;

                    with (instance_create(x, y + sprite_height / 2, objFireTellyShot))
                        parent = other.id;
                }
            }

            break;

        // shoot
        case 3:
            imgIndex += imgSpd * 2;
            if (imgIndex >= 6)
            {
                imgIndex = 0;
            }
            if (imgIndex >= 1 && imgIndex < 4)
            {
                phase = 1;
            }

            break;
    }

    if (moveV)
    {
        if (keptYSpeed == 0)
        {
            if (other.y < y)
            {
                keptYSpeed = -0.5;
            }
            else
            {
                keptYSpeed = 0.5;
            }
        }
    }
    image_index = imgIndex div 1;
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
moveV = true;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
if (spawned)
{
    phase = 1;
    shootTimer = 0;
    xspeed = 0;
    yspeed = 0;
    keptYSpeed = 0;
    imgIndex = 0;
    moveV = false;
}
