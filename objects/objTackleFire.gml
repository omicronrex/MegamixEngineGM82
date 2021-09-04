#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;
contactStart = contactDamage;

category = "floating, cluster, fire";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;
dummyLogic = false;

// Enemy specific code
image_speed = 0.25;

timer = 0;
phase = 1;

//@cc how long it is until the tackle fire pops up.
popDelay = 1;

//@cc how long it is until the tackle fire drops down.
alarmDrop = 60;

//@cc whether to drop down from its original position or to drop down at a random position.
randomOffset = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.25;
    timer += 1;
    if (dummyLogic)
    {
        phase = 0;
    }
    switch (phase)
    {
        case 0: // controlled externally
            if (xspeed != 0)
            {
                image_xscale = sign(xspeed);
            }
            break;
        case 1: // wait
            if (timer >= popDelay)
            {
                yspeed = -3;
                phase = 2;
            }
            break;
        case 2: // Go up
            if (y < global.sectionTop)
            {
                yspeed = 0;
                timer = 0;
                if (randomOffset)
                {
                    x = random_range(view_xview[0] + 32, view_xview[0] + view_wview[0] - 32);
                }
                phase = 3;
            }
            break;
        case 3: // wait and then drop down
            if (timer > alarmDrop)
            {
                yspeed = 1;
                xspeed = choose(-0.5, 0.5);
                image_xscale = sign(xspeed);
                phase = 4;
            }
            break;
    }
}
else
{
    image_speed = 0;
}

visible = (yspeed != 0) || dummyLogic;
canHit = visible;
contactDamage = contactStart * visible;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
timer = 0;
phase = 1;
