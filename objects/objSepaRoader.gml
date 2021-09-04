#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 3;
contactDamage = 3;
category = "grounded";
grav = 0.25 * image_yscale;

// Enemy specific code
hasCannon = true;
animFrame = 0;
timer = 0;
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
    if (xcoll != 0)
    {
        event_user(EV_DEATH);
        exit;
    }
    animFrame += 0.2;
    if (floor(animFrame) > 1)
    {
        animFrame = 0;
    }
    if (hasCannon)
    {
        xspeed = 2.25 * image_xscale;
    }
    else
    {
        if (timer > 15)
        {
            xspeed = 3.25 * image_xscale;
        }
        else
        {
            timer += 1;
            xspeed = 0;
        }
    }
    image_index = floor(animFrame) + (!hasCannon) * 2 + col * 4;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (hasCannon)
{
    var i = instance_create(x, y - 12 * image_yscale, objSepaRoaderCannon);
    i.image_xscale = image_xscale;
    i.respawn = false;
    i.col = col;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (other.bbox_bottom <= bbox_top + 12)
{
    if (hasCannon)
    {
        hasCannon = false;
        global.damage = 0;
        event_user(EV_HURT);
        var i = instance_create(x, bbox_top + 12, prtEntity);
        i.respawn = false;
        with (i)
        {
            event_user(EV_DEATH);
        }
        if (other.penetrate == 0)
            other.dead = true;
        other.guardCancel = 2;
        exit;
    }
    else
    {
        other.guardCancel = 2;
        global.damage = 0;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
hasCannon = true;
animFrame = 0;
timer = 0;
