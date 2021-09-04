#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = red(default); 1 = green; 2 = game gear colouration; )

event_inherited();

healthpointsStart = 13;
healthpoints = healthpointsStart;
contactDamage = 8;

category = "big eye, bulky";

facePlayerOnSpawn = true;

// enemy specific
actionTimer = 0;
dummyTimer = 999;
slamTimer = 0;
imageOffset = 0;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // turn around on hitting a wall
    xSpeedTurnaround();

    actionTimer += 1;

    if (actionTimer == 80)
    {
        dummyTimer = 0;
        imageOffset = 1;
        y -= 6;
        yspeed = -5;
        xspeed = 2 * image_xscale;
    }

    if (ground && imageOffset == 1 && actionTimer > 85)
    {
        playSFX(sfxPowerLand);
        slamTimer = 0;
        imageOffset = 2;
        xspeed = 0;
        calibrateDirection();
        actionTimer = 0;
    }
    if (ground && imageOffset != 1)
    {
        dummyTimer += 1;
        if (dummyTimer > 10)
        {
            imageOffset = 0;
        }
        else if (dummyTimer < 10 && dummyTimer > 4)
        {
            imageOffset = 2;
        }
        else
        {
            imageOffset = 0;
        }
    }

    if (imageOffset == 1)
    {
        if (collision_rectangle(x - 16, y, x + 16, y + 224, target, false,
            true) && slamTimer == 0)
        {
            yspeed = 0;
            xspeed = 0;
            slamTimer = 120;

            if (image_xscale == 1)
            {
                instance_create(x - 12, y - 67, objPowerMusclerSmoke);
                instance_create(x + 6, y - 67, objPowerMusclerSmoke);
            }
            else
            {
                instance_create(x - 14, y - 67, objPowerMusclerSmoke);
                instance_create(x + 4, y - 67, objPowerMusclerSmoke);
            }
        }

        if (slamTimer == 105)
        {
            yspeed = 5;
        }
    }
    if (slamTimer > 0)
    {
        slamTimer -= 1;
        yspeed -= grav;
    }
}
else if (dead)
{
    actionTimer = 0;
    dummyTimer = 999;
    slamTimer = 0;
    imageOffset = 0;
}

image_index = (3 * col) + imageOffset;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    imageOffser = 0;
}
