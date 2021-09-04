#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

respawn = false;
image_speed = 0.1;
moveTimer = 60;
parent = noone;
myLock = 0;

despawnRange = -1;
shiftVisible = 1;

sectionBottom = global.sectionBottom;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(objMegaman)
{
    with (objMegaman)
    {
        if gravfactor == 1.975 && !place_meeting(x, y, other.object_index)
        {
            gravfactor = 1;
            blockCollision = true;
        }
    }
    myLock = lockPoolRelease(myLock);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (place_meeting(x, y, objMegaman))
    {
        with (objMegaman)
        {
            if (climbing)
            {
                if (yspeed != 0)
                {
                    climbing = false;
                    yspeed = jumpSpeed * gravDir;
                    gravfactor = 1.975;
                    blockCollision = false;
                    climbLock = lockPoolRelease(climbLock);
                    if (other.myLock == 0)
                    {
                        other.myLock = lockPoolLock(localPlayerLock[PL_LOCK_CLIMB]);
                    }
                }
            }
            else
            {
                gravfactor = 1.975;
                blockCollision = false;
                if (other.myLock == 0)
                {
                    other.myLock = lockPoolLock(localPlayerLock[PL_LOCK_CLIMB]);
                }
            }
        }
    }
    else
    {
        with (objMegaman)
        {
            if( gravfactor == 1.975 && !place_meeting(x, y, other.object_index))
            {
                gravfactor = 1;
                blockCollision = true;
            }
        }
        if(lockPoolExists(myLock)&&isLocked(myLock))
        {
            lockPoolRelease(myLock);
            myLock=0;
        }

    }

    // force despawn
    if (bbox_top > sectionBottom) || (x > global.sectionRight) || (x < global.sectionLeft)
    || (instance_exists(objSectionSwitcher))
    {
        if(lockPoolExists(myLock)&&isLocked(myLock))
        {
            lockPoolRelease(myLock);
        }
        instance_destroy();
    }
}
else if (dead || instance_exists(objSectionSwitcher))
{
    with (objMegaman)
    {
        if(!place_meeting(x,y,other.object_index))
        {
            gravfactor = 1;
            blockCollision = true;
        }
    }
    if(lockPoolExists(myLock)&&isLocked(myLock))
    {
        lockPoolRelease(myLock);
    }

    // force despawn
    instance_destroy();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// overriding shiftVisible be like.....bottom text
if (instance_exists(objSectionSwitcher))
{
    exit;
}

for (var i = 0; i < image_yscale; i++)
{
    draw_sprite(sprite_index, image_index, round(x), round(y + i * 8));
}
