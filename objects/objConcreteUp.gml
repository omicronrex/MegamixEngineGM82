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

phase = 0;

accel = 0.2;
maxSpeed = 4;

image_speed = 0.15;

imgspalarm = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (phase == 0)
    {
        with (objMegaman)
        {
            if (place_meeting(x, y + gravDir, other.id))
            {
                if (ground)
                {
                    with (other)
                    {
                        phase = 1;
                        yspeed = 4 * other.gravDir;
                        ys = -yspeed;
                        event_inherited();
                        yspeed = 0;
                        if (object_index == objConcreteUp)
                        {
                            playSFX(sfxConcretePlatformUp);
                        }
                        if (object_index == objConcreteDown)
                        {
                            playSFX(sfxConcretePlatformDown);
                        }
                        imgsp = image_speed;
                        image_speed = 0;

                        // imgspalarm = 20;
                    }
                }
            }
        }
    }
    if (phase >= 1 && phase < 2)
    {
        phase += 0.125;
        if (phase == 2)
        {
            yspeed = ys;
            event_inherited();
            yspeed = 0;
            image_speed = imgsp;
        }
    }
    if (phase == 2) // Moving up
    {
        if (object_index == objConcreteUp)
        {
            yspeed += -accel;
            if (yspeed < -maxSpeed)
            {
                yspeed = -maxSpeed;
            }
        }
        if (object_index == objConcreteDown)
        {
            yspeed += accel;
            if (yspeed > maxSpeed)
            {
                yspeed = maxSpeed;
            }
        }
        if (place_meeting(x, y, objSpike))
        {
            dead = 1;
            visible = 0;
            instance_create(bboxGetXCenter(), bboxGetYCenter(),
                objExplosion);
        }
    }
    if (imgspalarm)
    {
        imgspalarm -= 1;
        if (imgspalarm == 0)
        {
            image_speed = imgsp;
        }
    }
}
else if (dead)
{
    phase = 0;
}
