#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A fat bird from Uranus. It spits Chuncos out the nest on its head and fires three shots at a time.

event_inherited();

healthpointsStart = 9;
healthpoints = healthpointsStart;
contactDamage = 4;

facePlayerOnSpawn = true;

category = "nature, bird";

phase = 0;
shotLimit = 3;
animTimer = 30;
moveTimer = 60;
chunco = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    calibrateDirection();

    moveTimer--;
    switch (phase)
    {
        case 0:
            if (!instance_exists(chunco))
            {
                if (moveTimer == 0)
                {
                    image_index = 2;
                    animTimer = 10;
                }

                if ((image_index == 2) && (animTimer == 0))
                {
                    image_index = 1;
                    animTimer = 30;
                    phase = 1;
                    moveTimer = 60;

                    chunco = instance_create(x, y - 23, objChunco);
                    chunco.respawn = false;
                    chunco.moveTimer = 140;
                }
            }
            break;
        case 1:
            if (moveTimer == 0)
            {
                if (shotLimit > 0)
                {
                    i = instance_create(x, y - 4, objEnemyBullet);
                    i.xspeed = 2 * image_xscale;
                    playSFX(sfxEnemyShootClassic);
                    shotLimit--;
                    moveTimer = 90;
                }
                else
                {
                    if (instance_exists(chunco))
                    {
                        moveTimer = 120;
                    }
                    else
                    {
                        moveTimer = 1;
                        phase = 0;
                    }
                    shotLimit = 3;
                }
            }
            break;
    }

    // Blinking animation
    animTimer--;
    if (animTimer == 0)
    {
        if (image_index == 0)
        {
            image_index = 1;
            animTimer = 10;
        }
        else if (image_index == 1)
        {
            image_index = 0;
            animTimer = 30;
        }
    }
}
else if (dead)
{
    phase = 0;
    healthpoints = healthpointsStart;
    shotLimit = 3;
    animTimer = 30;
    moveTimer = 60;
    image_index = 0;
    chunco = noone;
}
