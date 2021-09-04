#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
isSolid = true;
blockCollision=true;
grav = 0;
itemDrop = -1;
dir = 1;

canTurn = true;
destroy = false; // SET ROOM EDITOR - what platforms are destroyed on activation
canMove = 0;
accel = 0.1;

setup = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!setup && !destroy)
{
    setup = true;
    with (object_index)
    {
        if (destroy)
        {
            y -= 32;
        }
    }
    combineObjects(object_index,true,false);
    with (object_index)
    {
        if (destroy)
        {
            y += 32;
        }
    }

}

event_inherited();

if (entityCanStep())
{
    if (instance_exists(objTKhamen))
    {
        if (objTKhamen.phase == 1)
        {
            // Destroy marked blocks
            if (destroy)
            {
                event_user(EV_DEATH);
                playSFX(sfxEnemyHit);
            }

            // Movement
            if (xspeed != 1 * dir)
            {
                xspeed += accel * dir;
            }

            if ((bbox_right > view_xview + view_wview - 10) || (checkSolid(xspeed,0)))
            {
                with (objTKhamenPlatform)
                {
                    dir = -1;
                }
            }
            else if ((bbox_left < view_xview + 10) || (checkSolid(xspeed,0)))
            {
                with (objTKhamenPlatform)
                {
                    dir = 1;
                }
            }
        }
    }
    else
    {
        if (xspeed != 0)
        {
            xspeed -= accel * dir;
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    for (var i = 0; i < image_xscale; i++)
    {
        draw_sprite(sprite_index, 0, round(x + i * 16), round(y));
    }
}
