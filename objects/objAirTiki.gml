#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// If innactive it's invisible, while active it will spawn [objGremlin](objGremlin.html) from its sides.
event_inherited();

isSolid = 1;
isTargetable = false;

grav = 0;
blockCollision = 0;

respawnRange = -1;
despawnRange = -1;

animTimer = 0;
triggered = false;
popped = 0;

gremlinSpawn = false;
gremlinDir = -1;
gremlinArray[0] = noone;
gremlinArray[1] = noone;
gremlinArray[2] = noone;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && !dead && !global.timeStopped)
{
    alarm[0] = 90;

    if (!place_meeting(x, y - 48, target))
    {
        alarm[0] = 30;
        exit;
    }

    place = -1;

    var i;
    for (i = 0; i < 3; i += 1)
    {
        ded = false;
        if (!instance_exists(gremlinArray[i]))
        {
            ded = true;
        }
        else
        {
            if (gremlinArray[i].dead)
            {
                ded = true;
            }
        }

        if (ded)
        {
            if (place == -1)
            {
                place = i;
            }

            gremlinArray[i] = noone;
        }
    }

    if (place != -1)
    {
        if (gremlinDir == 1)
        {
            i = instance_create(x + sprite_width - 20, y + 39, objGremlin);
        }
        else
        {
            i = instance_create(x - 4 + 8, y + 39, objGremlin);
        }
        i.respawn = false;
        i.gremlinDir = gremlinDir;
        i.generated = false;
        i.alarmGenerate = 80;
        gremlinDir = -gremlinDir;
        gremlinArray[place] = i;
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (instance_exists(target) && !popped)
    {
        if (abs(target.x - bboxGetXCenter()) < 96)
        {
            if (insideView)
            {
                popped = 1;
                image_index = 2;
            }
        }
    }

    if (popped)
    {
        animTimer += 1;
        if (image_index == 0 || image_index == 1)
        {
            if (animTimer == 8)
            {
                image_index += sign(0.5 - image_index);
                animTimer = 0;
            }
        }
        else
        {
            if (animTimer == 6)
            {
                image_index = 3;
            }
            if (animTimer == 12)
            {
                image_index = 4;
            }
            if (animTimer == 18)
            {
                image_index = 0;
                animTimer = 0;
            }
        }
    }

    if ((image_index == 0 || image_index == 1) && popped && !triggered)
    {
        triggered = true;
        instance_create(x + 12, y, objTikiHorn);
        instance_create(x + sprite_width - 12, y, objTikiHorn);
    }

    if (collision_rectangle(x, y - 8, x + sprite_width, y + 4, target, false,
        false) && !gremlinSpawn)
    {
        gremlinSpawn = true;
        gremlinDir = -1;
        alarm[0] = 30;
    }
}
else if (dead)
{
    alarm[0] = 0;
    image_index = 0;
    animTimer = 0;
    triggered = false;
    gremlinSpawn = false;
    gremlinDir = -1;
    popped = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (popped)
{
    if (other.penetrate >= 2)
    {
        other.guardCancel = 2;
    }
    else
    {
        other.guardCancel = 1;
    }
}
else
{
    other.guardCancel = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!popped)
{
    exit;
}

event_inherited();
