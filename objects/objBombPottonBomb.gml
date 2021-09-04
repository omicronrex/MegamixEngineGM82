#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 2;
canHit = false;
blockCollision = true;
grav = 0.25;
yspeed = 0.25;
attackDelay = 4;
remaining = 2;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ycoll != 0)
    {
        event_user(EV_DEATH);
    }
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
dead = true;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

var i; i = instance_create(x + 16, y, objBombPottonExplosion);
i.image_xscale = 1;
if (image_index == 1)
{
    i.sprite_index = sprBombPottonExplosionBlue;
}
i.remaining = remaining;

i = instance_create(x - 16, y, objBombPottonExplosion);
i.image_xscale = -1;
if (image_index == 1)
{
    i.sprite_index = sprBombPottonExplosionBlue;
}
i.remaining = remaining;
