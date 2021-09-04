#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Default
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

grav = 0;
blockCollision = 0;

respawn = false;

// enemy specific code
destroyTimer = 0;

animTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // slow down
    if (xspeed != 0)
    {
        xspeed -= .125 * sign(xspeed);
    }

    // AI
    destroyTimer+=1;

    if (destroyTimer == 60)
    {
        event_user(10);
    }

    // animation
    if (destroyTimer > 20)
    {
        animTimer+=1;

        if (animTimer == 4)
        {
            animTimer = 0;
            image_index = !image_index;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

// probably don't want to spew projectiles past this shield huh
if (hitterID != 0)
{
    if (hitterID.object_index == objWaterShield)
    {
        exit;
    }
}

// this code is kinda lazy but........ eh
for (i = 1; i <= 6; i += 1)
{
    a = instance_create(x, y, objEnemyBullet);
    a.sprite_index = sprite_index;
    a.image_index = 2;

    switch (i)
    {
        case 1:
            a.xspeed = 0;
            a.yspeed = -4;
            break;
        case 2:
            a.xspeed = -4;
            a.yspeed = -2;
            break;
        case 3:
            a.xspeed = -4;
            a.yspeed = 2;
            break;
        case 4:
            a.xspeed = 0;
            a.yspeed = 4;
            break;
        case 5:
            a.xspeed = 4;
            a.yspeed = 2;
            break;
        case 6:
            a.xspeed = 4;
            a.yspeed = -2;
            break;
    }
}
