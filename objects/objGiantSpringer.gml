#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// It's a giant Springer/Spring head that launches missiles from its head. The missiles can be destroyed
event_inherited();

healthpointsStart = 8;
healthpoints = healthpointsStart;
contactDamage = 6;
category = "bulky, grounded";

loadTimer = 60;
springTimer = 0;
animTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mask_index = sprGiantSpringerMskA;
event_inherited();

if (entityCanStep())
{
    if (animTimer mod 12 == 0)
        calibrateDirection();

    animTimer += 1;
    image_index = ((animTimer div 8) mod 2);
    var spd; spd = 0.75;
    if (loadTimer <= 20)
    {
        // loaded missile
        spd = 1 / 30;
        image_index += 2;
    }
    xspeed = image_xscale * spd;
    if (loadTimer <= 0)
    {
        if (!instance_exists(objGiantSpringerMissile))
        {
            instance_create(x, y - 20, objGiantSpringerMissile);
            loadTimer = 60;
        }
    }
    else
        loadTimer -= 1;

    // spring out if mega man draws too near:
    if (springTimer <= 0)//-30
    {
        with (objMegaman)
        {
            if (point_distance(x, y, other.x, other.y - 16) < 60)
            {
                other.target = id;
                other.springTimer = 110;
            }
        }
    }
    if (springTimer > -50)
        springTimer -= 1;
}
else if (dead)
{
    loadTimer = 60;
    springTimer = 0;
    animTimer = 0;
}

// springing
if (springTimer > 0)
{
    xspeed = 0;
    loadTimer = 60;
    image_index = 3 + ((springTimer div 6) mod 4);
    if (image_index == 3)
        image_index = 5;
    if (image_index == 6)
        mask_index = sprGiantSpringerMskB;
    if (image_index == 4)
        mask_index = sprGiantSpringerMskC;
}
