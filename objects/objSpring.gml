#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

isSolid = 1;

canHit = false;
contactDamage = 0;
bubbleTimer = -1;
grav = 0;
blockCollision = 0;

respawnRange = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (image_index > 0 && image_index <= 4)
    {
        image_index += (1 / 3);
    }
    else if (image_index > 4)
    {
        image_index = 0;
    }

    with (prtEntity)
    {
        if (!dead)
        {
            if (blockCollision && grav!=0)
            {
                if (ground || ycoll > 0)
                {
                    with (other)
                    {
                        if (collision_rectangle(bbox_left, bbox_top - 1, bbox_right, bbox_top, other.id, false, false))
                        {
                            image_index = 1 / 3;

                            with (other)
                            {
                                if (object_index == objMegaman)
                                {
                                    yspeed = -(4.5 + global.keyJump[playerID] * 3);
                                }
                                else
                                {
                                    yspeed = -6;
                                }

                                if (insideView())
                                {
                                    playSFX(sfxSpring);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
