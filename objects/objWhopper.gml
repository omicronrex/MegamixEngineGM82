#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A dancing pair of eyes covered in rings, when he opens his eyes he becomes vulnerable, and the rings
// move away and come back like boomerangs.
event_inherited();

respawn = true;

healthpointsStart = 9;
healthpoints = healthpointsStart;
contactDamage = 8;
category = "floating, shielded";
grav = 0;

// Enemy specific code
dir = image_xscale;

shootTimer = 0;
doesIntro = false;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    shootTimer += 1;
    if (shootTimer < 60)
    {
        imgIndex += 0.1;
        if (imgIndex >= image_number)
            imgIndex = 1;
        image_index = floor(imgIndex);
    }
    if (shootTimer == 60)
        image_index = 0;
    if (shootTimer == 65)
    {
        sprite_index = sprWhopperEyes;
        for (i = -2; i <= 2; i += 1)
        {
            if (i != 0)
            {
                ring = instance_create(x, y, objWhopperRing);
                ring.yspeed = i * 4;
                if (abs(i) != 2)
                    ring.xspeed = 6;
                if (abs(i) != 2)
                {
                    ring = instance_create(x, y, objWhopperRing);
                    ring.yspeed = i * 4;
                    ring.xspeed = -6;
                }
            }
        }
    }
    if (shootTimer == 67)
        image_index = 1;
    if (shootTimer == 90)
        image_index = 0;
    if (shootTimer == 93)
        image_index = 1;
    if (shootTimer == 115)
    {
        sprite_index = sprWhopper;
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
if (sprite_index == sprWhopper)
{
    other.guardCancel = 1;
}
