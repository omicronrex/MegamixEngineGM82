#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "nature, bird";

facePlayerOnSpawn = true;

// Enemy specific code
jumped = false;
fallen = false;
delay = 0;
jumpY = -6;
walkX = 2;
timeToJump = 0;
turnAroundDelay = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    image_index += 0.15;
    x = ceil(x);


    // reduce delay timers.
    if (delay > 0)
        delay -= 1;

    if (turnAroundDelay > 0 && ground == true)
        turnAroundDelay -= 1;

    if (turnAroundDelay < 0 && ground == true)
        turnAroundDelay += 1;

    // when landing, prevent egg from doing things for a small period of time.
    if (delay == 0 && jumped == true && ground == true)
    {
        jumped = false;
        turnAroundDelay = 10;
    }

    // if the egg hits a wall whilst turnAroundDelay is active, turn round.  Make turnAroundDelay negative in order to prevent the egg from jumping straight away afterwards.
    if (xspeed == 0 && ground == true && turnAroundDelay > 0
        && turnAroundDelay < 5)
    {
        jumped = false;
        xspeed = -xspeed;
        image_xscale = -image_xscale;
        turnAroundDelay = -5;
        timeToJump = 0;
    }

    // if time to jump is 0, set it to 1 as soon as egg hits the floor.
    if (yspeed == 0 && ground == true && jumped == false && timeToJump == 0)
    {
        xspeed = 1 * image_xscale;
        timeToJump += 1;
    }

    // whilst egg is falling, and if it hasn't jump, reset variables and speed.
    if (yspeed > 0 && jumped == false)
    {
        xspeed = 0;
        delay = 5;
        timeToJump = 0;
    }

    // if egg is  jumping and is not next to the wall, start it moving again.
    if (delay == 0 && jumped == true
        && !checkSolid(image_xscale * sprite_get_width(sprite_index) * 0.8 + xspeed, (bbox_bottom + 1) - y, 1))
        xspeed = 1 * image_xscale;

    // if egg is next to a wall, and on floor, increase timeToJump variable.
    if (xspeed == 0 && ground == true && turnAroundDelay == 0)
        timeToJump += 1;

    // JUMP!
    if (timeToJump == 2)
    {
        yspeed = -6;
        jumped = true;
        delay = 5;
        timeToJump = 0;
    }
}
else if (dead == true)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    jumped = false;
    turnAroundDelay = 0;
    timeToJump = 0;
    delay = 0;
}
