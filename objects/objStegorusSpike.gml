#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = true;
contactDamage = 2;
grav = 0;

timescale = 1;
xsp = 3;
ysp = -3;
timer = 0;
phase = 0;
animFrame = 0;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (mask_index != sprite_index)
{
    mask_index = sprite_index;
}

event_inherited();

if (entityCanStep())
{
    timer += 1 * timescale;

    if (timer > 60)
        timer = 30;
    if (phase == 0)
    {
        animFrame += 0.4 * timescale;
        if (floor(animFrame) > 3)
            animFrame = 0;
        if (timer >= 30)
        {
            grav = 0.25 * timescale;
            yspeed = ysp * timescale;
            xspeed = xsp * timescale * image_xscale;
            phase = 1;
            animFrame = 4;
        }
    }
    else
    {
        animFrame += 0.45 * timescale;
        if (floor(animFrame) > 5)
            animFrame = 4;

        if (phase == 1)
        {
            xSpeedTurnaround();
        }
        else
        {
            if (xcoll != 0)
                event_user(EV_DEATH);
        }
        if (ground && phase < 30)
        {
            phase += 1 * timescale;
            xspeed = 0;
        }
        else if (phase >= 30)
        {
            xspeed += 0.25 * image_xscale * timescale;
            if (abs(xspeed) > 5 * timescale)
            {
                xspeed = 5 * timescale * sign(xspeed);
            }
        }
    }
    image_index = floor(animFrame);
    var hasParent = instance_exists(parent);
    if (!hasParent || (hasParent && parent.dead))
        event_user(EV_DEATH);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(x, y, objExplosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.damage = 0;
other.guardCancel = 3;
