#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
grav = 0.325;
contactDamage = 4;
xspeed = 0;
yspeed = -4;
storeX = 0;
reflectable = 0;
stopOnFlash = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (global.frozen == false)
{
    image_speed = 0;
    if (storeX == 0)
        storeX = xspeed;

    // if abs(xspeed) > 0
    // xspeed -= (abs(storeX)*0.10)*image_xscale;
    if (yspeed < 0)
        image_index = 0;
    else if (yspeed < 3)
        image_index = 1;
    else
        image_index = 2;
    if (ycoll != 0)
    {
        playSFX(sfxExplosion);
        i = instance_create(x, y, objHarmfulExplosion);
        i.sprite_index = sprExplosion;
        screenShake(60, 1, 1);
        if (instance_exists(target))
            with (target)
                playerGetShocked(false, 0, true, 40);
        instance_destroy();
    }
}
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (contactDamage > 0)
{
    with (instance_create(x, y, objHarmfulExplosion))
    {
        sprite_index = sprExplosion;
    }

    with (other)
    {
        // manual damage to player
        if (iFrames == 0 && canHit)
        {
            with (other)
            {
                entityEntityCollision();
            }
        }
    }

    instance_destroy();
}
