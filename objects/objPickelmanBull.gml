#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A pickerlman in a bulldozer that can only be damaged when shot in the head of from behind
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "shielded, rocky";

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.1;

alarmMove = 45;
ground = 1;

shakeDir = 1;
shake = 0;
shaketimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!ground)
    {
        shake = 0;
    }
    else if (xspeed != 0)
    {
        if (xspeed > 0)
        {
            xs = bbox_right + 1;
        }
        else
        {
            xs = bbox_left - 1;
        }

        if (checkFall(32 * image_xscale))
        {
            image_xscale *= -1;
            xspeed = 1 * image_xscale;
        }
    }

    alarmMove -= 1;
    if (alarmMove == 45)
    {
        xspeed = 0;
        shake = 1;
    }
    if (alarmMove == 0)
    {
        alarmMove = choose(60, 90);
        xspeed = 1 * image_xscale;
        shake = 0;
    }
    if (shake)
    {
        shaketimer += 1;
        if (shaketimer mod 3 == 0)
        {
            x += image_xscale * shakeDir;
            shakeDir *= -1;
        }
    }
}
else if (dead)
{
    alarmMove = 45;
    shake = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (bboxGetYCenterObject(other.id) <= y - 40)
{
    exit;
}
else
{
    other.guardCancel = 1;
}
