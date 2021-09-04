#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0;
canHit = false;
isSolid = 2;
grav = 0;
blockCollision = true;
rotorTimer = 0;
activateTimer = 0;
phase = 0; // 0: inactive. 1: moving
dir = 1; // 1: left. -1: right.
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var pressed = false;
    visible = true;
    with (prtEntity)
        if (ground && place_meeting(x, y + 2*sign(grav), other) && !dead)
        {
            pressed = true;
            if (other.phase == 0)
                other.dir += image_xscale * (0.0001 + (object_index == objMegaman));
        }

    dir = sign(dir);

    xspeed = 0;
    yspeed = 0;
    if (phase == 0)
    {
        // inactive -- rise up unless pressed.
        if (pressed)
        {
            activateTimer++;
            rotorTimer--;
            if (activateTimer > 10)
                phase = 1;
        }
        else
        {
            if ((y - ystart) * image_yscale > 0)
                yspeed = -image_yscale;
            activateTimer = 0;
        }
        image_index = 4;
        if ((y - ystart) * image_yscale > 0)
            image_index = 0;
    }
    else
    {
        // move diagonally downward.
        xspeed = dir / 2;
        yspeed = image_yscale / 2;
        image_index = 8;
        if (rotorTimer mod 5 == 0)
            rotorTimer++;
        if (!pressed)
            phase = 0;

        // die to spikes
        if (place_meeting(x, y + image_yscale, objSpike))
        {
            with (prtEntity)
                if (ground && place_meeting(x, y + 2*sign(grav) , other) && canHit)
                    event_user(EV_DEATH);
            event_user(EV_DEATH);
        }
    }

    rotorTimer = (rotorTimer + 1) mod 20;
    image_index += rotorTimer div 5;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

rotorTimer = 0;
activateTimer = 0;
phase = 0; // 0: inactive. 1: moving
