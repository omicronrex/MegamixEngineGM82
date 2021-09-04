#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster, bird, flying, nature";

grav = 0;
blockCollision = 0;

// Enemy specific code
phase = 0;
breakY = 0;
timer = 0;

imgSpd = 0.2;
imgIndex = 0;
ded=false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if(!ded)
    {
         switch (phase)
        {
            // set break height
            case 0:
                visible = false;
                canHit = false;
                canDamage = false;

                if (instance_exists(target) && !place_meeting(x, y, objXBlock))
                {
                    phase = 1;
                    breakY = target.y - 16;

                    canHit = true;
                    canDamage=true;
                }

                break;

            // rise in egg
            case 1:
                if (!visible)
                    visible = true;
                yspeed = -0.9; // <-=1 egg rise speed here

                // break out of egg
                if (y <= breakY || healthpoints < healthpointsStart)
                {
                    phase = 2;
                    imgIndex = 1;
                    calibrateDirection();
                    yspeed = 0;

                    // spawn egg shell particles
                    yOUwILLgIVEmEaNeGG = instance_create(x - 4, y,
                        objPeatEggParticle);
                    yOUwILLgIVEmEaNeGG.xspeed = -0.5;

                    yOUwILLgIVEmEaNeGG = instance_create(x + 1, y,
                        objPeatEggParticle);
                    yOUwILLgIVEmEaNeGG.xspeed = 0.2;
                    yOUwILLgIVEmEaNeGG.image_index = 1;

                    yOUwILLgIVEmEaNeGG = instance_create(x + 4, y,
                        objPeatEggParticle);
                    yOUwILLgIVEmEaNeGG.xspeed = 0.5;
                    yOUwILLgIVEmEaNeGG.image_index = 2;
                }

                break;

            // wait until flying
            case 2:
                waitTime = 20; // <-=1 time waiting until flying here

                // set direction to fly to
                if (timer == waitTime / 2)
                {
                    if (instance_exists(target))
                    {
                        direction = point_direction(x, y, target.x, target.y);
                        direction = floor(direction / 45) * 45;
                        var s; s = 0;
                        if (direction == 270)
                            s = 1;
                        else if (direction == 90)
                            s = -1;
                        if (s != 0 && image_xscale == -1)
                        {
                            direction = direction - 45 * s;
                        }
                        else if (image_xscale == 1)
                        {
                            direction = direction + 45 * s;
                        }



                        // restriction on flight angle (can't fly 90 degrees above or below)
                    }
                }

                timer += 1;
                if (timer >= 40)
                {
                    phase = 3;
                    timer = 0;
                }

                break;

            // fly
            case 3:
                speed = 4.5; // <-=1 flying speed here

                break;
        }

        // animation
        if (phase == 2 || phase == 3)
        {
            imgIndex += imgSpd;
            if (imgIndex >= 3)
            {
                imgIndex = 1;
            }
        }
    }
    else
    {
        x=xstart;
        y=ystart;
        speed=0;
        if (insideView())
        {
            if(!place_meeting(round(x),round(y),objXBlock))
            {
                timer += 1;
                if (timer >= 120)
                {
                    timer = 0;
                    ded=false;
                }
            }
        }
        else
        {
            timer = 0;
        }
    }

}


image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
spawned=false;
event_user(EV_SPAWN);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

    phase = 0;
    direction = 0;
    xpeed = 0;
    yspeed = 0;
    breakY = 0;
    calibrateDirection();
    imgIndex = 0;
    timer = 0;
    visible = false;
    grav = 0;
    blockCollision = false;
    canHit=false;
    canDamage=false;
if(!spawned)
{
    ded=true;
    dead=false;
}
