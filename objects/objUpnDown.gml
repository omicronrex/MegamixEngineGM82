#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cluster";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.75;

yend = irandom_range(16, 112);

action = 0;
actionTimer = 0;

col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprUpnDown;
            break;
        case 1:
            sprite_index = sprUpnDownBlue;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (action)
    {
        actionTimer += 1;
        switch (action)
        {
            case 1:
                if (actionTimer == 11)
                {
                    action += 1;
                    actionTimer = 0;
                    xspeed = -xspeed;
                }
                break;
            case 2:
                if (actionTimer == 22)
                {
                    actionTimer = 0;
                    xspeed = -xspeed;
                }
                break;
        }
    }

    if (y <= view_yview + yend)
    {
        yspeed = 0.75;
        xspeed = -(yspeed * 0.5) * image_xscale;
        action = 1;
    }
}
else if (dead)
{
    action = 0;
    actionTimer = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn event
event_inherited();

if (spawned)
{
    yspeed = -3;
}
