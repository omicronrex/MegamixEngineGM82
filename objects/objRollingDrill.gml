#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

faction = 5;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 28;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

// Enemy specific code
image_speed = 0.4;

ground = 1;

calibrated = 0;
mysolid = -1;

spd = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead)
{
    if (mysolid == -1)
    {
        mysolid = instance_create(x, y, prtEntity);
        mysolid.sprite_index = sprRollingDrillBlock;
        mysolid.image_xscale = image_xscale;
        mysolid.respawn = false;
        mysolid.isSolid = 1;
        mysolid.canHit = false;
        mysolid.grav = 0;
        mysolid.blockCollision = 0;
    }
    else
    {
        instance_activate_object(mysolid);
        if (!instance_exists(mysolid))
        {
            mysolid = -1;
        }
    }
}
else
{
    if (mysolid != -1)
    {
        instance_activate_object(mysolid);
        with (mysolid)
        {
            instance_destroy();
        }
        mysolid = -1;
    }
}

if (entityCanStep())
{
    xspeed = image_xscale * spd;

    while (place_meeting(x, y, objSolid))
    {
        with (instance_place(x, y, objSolid))
        {
            if (image_xscale > 1 || image_yscale > 1)
            {
                splitSolid();
            }
            else
            {
                instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
                playSFX(sfxEnemyHit);
                instance_create(x, y, objRollingDrillField);
                instance_deactivate_object(id);
            }
        }
    }

    if (mysolid != -1)
    {
        with (mysolid)
        {
            image_xscale = other.image_xscale;
            xprevious = x;
            shiftObject(other.x - x, 0, other.blockCollision);
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(bboxGetXCenter(), bboxGetYCenter(), objBigExplosion);
playSFX(sfxExplosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_xscale == 1)
{
    if (spriteGetXCenterObject(other.id) < spriteGetXCenter())
    {
        other.guardCancel = 1;
    }
}
else
{
    if (spriteGetXCenterObject(other.id) > spriteGetXCenter())
    {
        other.guardCancel = 1;
    }
}
