#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A big mettal maker, will randomly choose between two types of mets
// met1 and met2 can be set to any object, but it is recommended to stick to metalls, or in the contrary
// change its sprite with one that matches the new objects
event_inherited();

respawn = true;

healthpointsStart = 15;
healthpoints = healthpointsStart;
contactDamage = 6;
grav = 0;
blockCollision = false;
category = "bulky, mets";

doesIntro = false;

// Enemy specific code
dir = image_xscale;

//@cc object_index to use as first option
met1 = objMetallRunAndGun;

//@cc //@cc object_index to use as second option
met2 = objMetallJump;

shootTimer = 0;
met = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!instance_exists(met))
    {
        shootTimer += 1;
    }
    else if (met.dead == true)
    {
        with (met)
        {
            instance_destroy();
        }
    }

    if (shootTimer == 50)
    {
        image_index = 1;
    }

    if (shootTimer == 60)
    {
        image_index = 0;
        met = instance_create(x, y + 32, choose(met1, met2));
        met.respawn = false;

        if (met.object_index == objMetallJump)
        {
            met.radius = 256;
        }

        shootTimer = 0;
    }
}
else if (!insideView())
{
    image_index = 0;
    shootTimer = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!(other.y > y - 8))
{
    other.guardCancel = 1;
}
