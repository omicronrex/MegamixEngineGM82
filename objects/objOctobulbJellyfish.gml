#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = false;
canHit = true;
healthpointsStart = 3;
healthpoints = 3;
grav = 0;
reflectable = 0;
contactDamage = 3;

// AI
attackTimer = 0;
spd = 0;
dir = 0;

// Animation
animSpeed = 0.2;
animTimer = 0;
anim = 0;
animFrame = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (spd == 0)
        attackTimer += 1;
    if (attackTimer > 120)
    {
        attackTimer = 0;
        if (instance_exists(target))
        {
            dir = floor(point_direction(x, y, target.x, target.y) / 8) * 8;
        }
        spd = 2.35;
    }

    if (spd != 0)
    {
        spd -= 0.035;
        if (spd < 0)
            spd = 0;
    }

    if (spd == 0)
    {
        anim = 1;
    }
    else
    {
        anim = 0;
    }

    animTimer += animSpeed;
    if (animTimer > 1)
    {
        animFrame += 1;
        if (animFrame > 1)
            animFrame = 0;
        animTimer = 0;
    }

    image_index = anim * 2 + animFrame;
    xspeed = cos(degtorad(dir)) * spd;
    yspeed = -sin(degtorad(dir)) * spd;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(x, y, objExplosion);
playSFX(sfxMM3Explode);
