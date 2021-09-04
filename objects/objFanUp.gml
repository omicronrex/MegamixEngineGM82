#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

image_speed = 0.35;

shiftVisible = 1;

dir = 0;
velocity = 0;
playSound = true;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    switch (dir)
    {
        case 0: // up
            with (collision_rectangle(bbox_left, bbox_top, bbox_right - 2,
                bbox_top - 16 * 10, objMegaman, 0, 1))
                with (other)
                {
                    if (collision_rectangle(bbox_left, bbox_top,
                        bbox_right - 2, bbox_top - 16 * 4, other, 0, 1)
                        || (velocity <= 0 && collision_rectangle(bbox_left,
                        bbox_top, bbox_right - 2, bbox_top - 16 * 7, other,
                        0, 1)))
                    {
                        if (velocity > -2)
                        {
                            velocity -= 0.1;
                        }
                        if (other.yspeed < velocity)
                        {
                            velocity = other.yspeed;
                        }

                        //        if velocity < -2
                        //            velocity += 0.1;
                    }
                    else if (velocity < 3)
                    {
                        velocity += 0.1;
                        if (other.yspeed < velocity)
                        {
                            velocity = other.yspeed;
                        }
                    }

                    if (instance_exists(other))
                    {
                        if ((!other.ground || velocity < 0)
                            || place_meeting(x, y - 1, other)
                            || other.yspeed > velocity)
                        {
                            other.yspeed = velocity;
                        }
                        else if (velocity > 0)
                        {
                            velocity = 0;
                        }
                    }
                    if (velocity >= 0)
                    {
                        playSound = true;
                    }
                    else if (playSound)
                    {
                        playSFX(sfxFan);
                        playSound = false;
                    }

                    for (i = 1; i >= -1; i -= 2)
                    {
                        if (instance_place(x + i, y, objFanUp))
                        {
                            otherFan = instance_place(x + i, y, objFanUp);
                            if (otherFan.object_index == object_index)
                            {
                                otherFan.velocity = velocity;
                                otherFan.playSound = playSound;
                            }
                        }
                    }
                }
        case 1: // down
            with (collision_rectangle(bbox_left, bbox_bottom, bbox_right - 2,
                bbox_bottom + 16 * 10, objMegaman, 0, 1))
                with (other)
                {
                    if (instance_exists(other))
                        if (!other.ground)
                        {
                            other.yspeed = other.yspeed + 0.1;
                        }
                    if (other.yspeed >= 0)
                    {
                        playSound = true;
                    }
                    else if (playSound)
                    {
                        playSFX(sfxFan);
                        playSound = false;
                    }
                    for (i = 1; i >= -1; i -= 2)
                    {
                        if (instance_place(x + i, y, objFanUp))
                        {
                            otherFan = instance_place(x + i, y, objFanUp);
                            if (otherFan.object_index == object_index)
                            {
                                otherFan.velocity = velocity;
                                otherFan.playSound = playSound;
                            }
                        }
                    }
                }
            break;
        case 2: // right
            with (collision_rectangle(bbox_right, bbox_top,
                bbox_right + 16 * 7, bbox_bottom - 2, objMegaman, 0, 1))
                with (other)
                {
                    if (collision_rectangle(bbox_right, bbox_top,
                        bbox_right + 16 * 6, bbox_bottom - 2, other, 0, 1))
                    {
                        if (velocity > -2)
                        {
                            velocity -= 0.1;
                        }
                        if (velocity < -1 && collision_rectangle(bbox_right,
                            bbox_top, bbox_right + 16 * 3, bbox_bottom - 2,
                            other, 0, 1))
                        {
                            playSound = true;
                        }
                        else if (playSound)
                        {
                            playSFX(sfxFan);
                            playSound = false;
                        }
                    }
                    else if (velocity < 0)
                    {
                        velocity += 0.1;
                    }

                    with (other)
                    {
                        if (isSlide)
                        {
                            if (xspeed < -1)
                            {
                                xspeed = xspeed / 2;
                            }
                            if (xspeed > 0 && xspeed < 3)
                            {
                                xspeed = 3;
                            }
                        }
                        else
                        {
                            shiftObject(-other.velocity, 0, 1);
                        }
                    }
                }
            break;
        case 3: // left
            with (collision_rectangle(bbox_left, bbox_top, bbox_left - 16 * 7,
                bbox_bottom - 2, objMegaman, 0, 1))
                with (other)
                {
                    if (collision_rectangle(bbox_left, bbox_top,
                        bbox_left - 16 * 6, bbox_bottom - 2, other, 0, 1))
                    {
                        if (velocity > -2)
                        {
                            velocity -= 0.1;
                        }
                        if (velocity < -1 && collision_rectangle(bbox_left,
                            bbox_top, bbox_left - 16 * 3, bbox_bottom - 2,
                            other, 0, 1))
                        {
                            playSound = true;
                        }
                        else if (playSound)
                        {
                            playSFX(sfxFan);
                            playSound = false;
                        }
                    }
                    else if (velocity < 0)
                    {
                        velocity += 0.1;
                    }

                    with (other)
                    {
                        if (isSlide)
                        {
                            if (xspeed > 1)
                            {
                                xspeed = xspeed / 2;
                            }
                            if (xspeed < 0 && xspeed > -3)
                            {
                                xspeed = -3;
                            }
                        }
                        else
                        {
                            shiftObject(other.velocity, 0, 1);
                        }
                    }
                }
            break;
    }
}
