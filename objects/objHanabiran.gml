#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Hirabiran should be placed along with [objHanabiranSpawnLocation](objHanabiranSpawnLocation.html). These will determine the locations to where he can spawn to during the fight and allow for custom rooms. You do not need to place a spawner underneath Hanabiran, he'll create one
// there himself.


event_inherited();
respawn = true;
doesIntro = false;
healthpointsStart = 16;
healthpoints = healthpointsStart;
contactDamage = 6;
blockCollision = 0;
grav = 0;
facePlayerOnSpawn = false;
category = "nature";

despawnRange = -1;

// Enemy specific code
image_speed = 0;
image_index = 1;
phase = -1;
attackTimer = 0;
attackTimerMax = 8;
shotsFired = -1;
animTimer = 1;

headX[0] = 0;
headX[1] = 2;
headX[2] = -2;
headX[4] = 0;

oldLocation = noone;
cLocation = noone;

cAngle = 0;
cDistance = 8;
addAngle = 8;

// creation code variables

//@cc if this is set to false, then the clock arm in his room won't be destroyed when he dies.
destroyClockArm = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (destroyClockArm)
    {
        with (objHanabiranClockArm)
        {
            if (destroyTimer > 0)
            {
                destroyTimer *= -1;
            }
            triggerDestroy = 3;
        }
    }

    attackTimer += 1;

    if (!place_meeting(x, y, objHanabiranSpawnLocation) && phase == -1)
    {
        var inst = instance_create(x, y, objHanabiranSpawnLocation);
        oldLocation = inst;
        phase = 1;
    }
    switch (phase)
    {
        case 0: // find location
            var inst = oldLocation;
            cLocation = oldLocation;

            // hanabiran cannot put itself where it used to be, or where mega man is
            for (var i = 0; i < 256; i++) // this will eventually give up if it can't find a situable place - basically idiot proofing
            {
                if (cLocation == oldLocation || place_meeting(inst.x, inst.y, objMegaman) || place_meeting(inst.x, inst.y, objHanabiran))
                {
                    inst = instance_find(objHanabiranSpawnLocation, irandom(instance_number(objHanabiranSpawnLocation) - 1));
                    cLocation = inst;
                }
            }
            if (attackTimer >= 96)
            {
                canHit = true;
                x = inst.x;
                y = inst.y;
                shotsFired = -1;
                attackTimer = 0;
                phase = 1;
                oldLocation = cLocation;
            }
            break;
        case 1: // attack
            if (animTimer < 8)
            {
                contactDamage = 4;
                if (animTimer < 5)
                {
                    animTimer += 0.25;
                }
                else
                {
                    animTimer += 0.125;
                }
                image_index = min(animTimer, 7);
                if (shotsFired == -1 && image_index >= 5) // create flower petals
                {
                    for (var i = 0; i < 4; i++)
                    {
                        var inst = instance_create((x + headX[0]) + cos((i * degtorad(90)) * cDistance), (y) + sin((i * degtorad(90)) * cDistance), objHanabiranFlower);
                        inst.image_index = 2 * i;
                        inst.cAngle = 90 * i;
                        inst.parent = id;
                        inst.flowerNumber = i;
                    }
                    shotsFired = 0;
                }
            }
            else
            {
                animTimer = 5;
            }
            if (attackTimer == 32 && shotsFired < 4) // fire off flower petals towards mega man. this is handled in that object's step code.
            {
                with (objHanabiranFlower)
                {
                    if (flowerNumber == other.shotsFired && parent == other.id)
                    {
                        hasFired = true;
                    }
                }
                shotsFired++;
                attackTimer = 0;
            }
            else if (attackTimer == 48) // change phase
            {
                phase = 2;
                attackTimer = 0;
                animTimer = 8;
            }
            break;
        case 2: // vanish
            with (objHanabiranFlower) // destroy existing attached flower petals
            {
                if (!hasFired && parent == other.id)
                {
                    instance_destroy();
                }
            }
            if (animTimer < 10)
            {
                image_index = min(animTimer, 9);
                animTimer += 0.25;
            }
            else // reset variables for changing places.
            {
                attackTimer = 0;
                oldLocation = instance_place(x, y, objHanabiranSpawnLocation);
                canHit = false;
                contactDamage = 0;
                phase = 0;
                animTimer = 1;
                image_index = 1;
            }
            break;
    }
}
else if (!insideView())
{
    image_index = 1;
    y = ystart;
    x = xstart;
    attackTimer = 0;
    phase = -1;
    shotsFired = -1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// if shot, stop firing.
shotsFired = 4;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (ceil(image_index) != 1)
    event_inherited();
