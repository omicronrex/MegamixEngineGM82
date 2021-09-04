#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Whatever this freaky thing from Venus is, it flies around and splits into two smaller
// variants when destroyed. This is the smallest variant, so, uh... disregard that "splitting"
// thing.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

facePlayerOnSpawn = true;
grav = 0;
category = "flying, cluster";

image_speed = 0.2;
cosCounter = 0;
moveTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (moveTimer > 0)
    {
        x += 2 * image_xscale;
        moveTimer--;
    }

    xspeed = 0.5 * image_xscale;

    cosCounter += .025;
    yspeed = -(cos(cosCounter) * 0.7);

    if (xcoll != 0)
    {
        image_xscale *= -1;
    }

    if ((ycoll == 1) && (yspeed > 0) || (ycoll == 1) && (yspeed < 0))
    {
        yspeed = yspeed / 2;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    cosCounter = 0;
    //instance_destroy(); // Why was this here?
}
