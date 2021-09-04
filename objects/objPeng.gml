#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy from Ice Man's stage. It acts basically the same as Killer Bullet, except with a wider
// arc, and it doesn't explode on death.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "bird, flying";

blockCollision = 0;
grav = 0;

// Enemy specific code
image_speed = 0.25;
sinCounter = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.25;

    // Set direction and xspeed on spawn. xspeed starts as 0 in create and is set here.
    if (xspeed == 0)
    {
        calibrateDirection();
        xspeed = image_xscale;
    }

    // The arc here is bigger than Killer Bullet's.
    // Once again, a misnomer since cosine is used for yspeed and not sine, but /shrug
    sinCounter += .045;
    yspeed = -(cos(sinCounter) * 1.6);
}
else
{
    image_speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
sinCounter = 0;
