#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, nature, bird";

grav = -0.10;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.4;
spawnTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xspeed == 0)
    {
        xspeed = image_xscale * 1.2;
        yspeed = 2;
    }

    if (y < ystart - 8 && (xspeed == 1.2 || xspeed == -1.2))
    {
        yspeed = 0;
        xspeed = 1.5 * image_xscale;
        with (objCoswallown)
        {
            if (parent = other.id && instance_exists(target))
            {
                move_towards_point(target.x, target.y, 1.5);
                xspeed = hspeed;
                hspeed = 0;
                yspeed = vspeed;
                vspeed = 0;
                speed = 0;
                grav = 0;

                calibrateDirection();
            }
        }
    }

    spawnTimer += 1;
    if (spawnTimer == 20 || spawnTimer == 30 || spawnTimer == 40)
    {
        i = instance_create(view_xview[0] + 128 - (128 * image_xscale), y, objCoswallown);
        i.image_xscale = image_xscale;
        i.parent = id;
    }
}
else if (dead)
{
    image_speed = 0.4;
    spawnTimer = 0;
}
