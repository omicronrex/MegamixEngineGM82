#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy from Tornado Man's stage. Will slowly float down, and will get pushed by wind objects.
// Has a spawner under the Spawners tab.

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "floating";

blockCollision = 0;
grav = 0;

// Enemy specific code
yspeed = 1;
image_speed = 0.065;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // force it to always float down
    yspeed = .65;

    // check for wind/rain objects
    with (instance_place(x, y, objToadRain))
    {
        other.xspeed = blowSpeed;
    }

    if (instance_exists(objTenguWind))
    {
        var inst; inst = instance_nearest(x, y, objTenguWind);
        if (inst && inst.activated)
        {
            xspeed = inst.windSpeed;
        }
    }

    with (instance_place(x, y, objWindRight))
    {
        if (dir == "right")
        {
            other.xspeed = mySpeed;
        }
        else if (dir == "left")
        {
            other.xspeed = -mySpeed;
        }
        else if (dir == "up")
        {
            other.yspeed = 1.2 - mySpeed;
        }
        else if (dir == "down")
        {
            other.yspeed = 1 + mySpeed;
        }
    }

    with (instance_place(x, y, objSandstorm))
    {
        oyher.xspeed = dir * 0.5;
    }
    var sgn; sgn = sign(xspeed);
	if(sgn==0)
		sgn=1;
    image_speed = abs(0.05 * (xspeed+1*sign(sgn)));
    if(sign(xspeed)!=0)
        image_xscale = sign(xspeed);
}
else{
    image_speed=0;
}
