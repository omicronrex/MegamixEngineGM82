#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded, semi bulky";

facePlayerOnSpawn = true;

grav = -gravAccel;

// Enemy specific code
moveTimer = 0;
directionStore = 0;
upOrDown = false;
flag0 = false;
moveDist = 64;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!upOrDown)
        image_index += 0.15;
    if (upOrDown)
        image_index -= 0.15;


    if (xspeed == 0 && yspeed == 0 && sprite_index != sprNobita2R)
    {
        xspeed = 1 * image_xscale;
    }

    // turn round
    if (xspeed != 0)
        moveTimer += 1;

    if (moveTimer >= moveDist)
    {
        xspeed = 0;
        image_index = 0;
        sprite_index = sprNobita2R;
        moveTimer = 0;
    }

    // if it walks off an edge or hits a wall, turn round.
    if ((xspeed == 0 && sprite_index != sprNobita2R
        || !place_meeting(x + sprite_width / 2, y - image_yscale * 2,
        objSolid)) && sprite_index != sprNobita2R)
    {
        xspeed = 0;
        image_index = 0;
        sprite_index = sprNobita2R;
    }

    // if
    if (image_index >= 7 && sprite_index == sprNobita2R)
        upOrDown = true;

    if (image_index == 0 && upOrDown == true)
    {
        image_index = 0;
        sprite_index = sprNobitaR;
        upOrDown = false;
        image_xscale = -image_xscale;
    }

    // if direction is different to direction store, reset move timer.
    if (image_xscale != directionStore && sprite_index == sprNobitaR)
    {
        directionStore = image_xscale;
        moveTimer = 0;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
xspeed = 0;
yspeed = 0;
image_index = 0;
directionStore = image_xscale;
moveTimer = 0;
sprite_index = sprNobitaR;
upOrDown = false;
flag0 = false;
