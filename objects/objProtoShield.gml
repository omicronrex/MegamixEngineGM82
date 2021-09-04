#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

parent = 0;
faction = 2;
canDamage = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(parent)
{
    x = parent.x + 10*parent.image_xscale;
    y = parent.y + 2*parent.image_yscale;
    image_xscale = parent.image_xscale;
    image_yscale = parent.image_yscale;
    if (parent.ground == false && parent.isShoot == false && parent.isSlide == false && parent.isHit == false && parent.isShocked == false && parent.climbing == false && parent.teleporting == false && parent.isFrozen == 0 && parent.vehicle == noone) //Big boy if statement
    {
        canDamage = true;
    }
    else
    {
        canDamage = false;
    }
}
else
{
    instance_destroy();
}
#define Collision_prtEnemyProjectile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//COPY PASTING FROM JEWEL SATELLITE IS FUN. HORRAY FOR LAZINESS
if (canDamage)
{
    if (!global.factionStance[faction, other.faction])
    {
        exit;
    }

    switch (other.reflectable)
    {
        case 0:
            exit;
            break;
        case -1:
            playSFX(sfxEnemyHit);
            with (other)
            {
                i = instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
                event_user(EV_DEATH);
            }
            break;
        case 1:
            playSFX(sfxEnemyHit);
            with (other)
            {
                faction = other.faction;
                xspeed *= -1;
                yspeed *= -1;
                hspeed *= -1;
                vspeed *= -1;
                direction += 180;
                image_xscale *= -1;
                pierces = 0;
            }
            break;
    }
}
