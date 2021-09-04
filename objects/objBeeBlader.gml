#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_xscale = 1 or -1 //(Use editor for this!!) determines starting direction of mini boss.

event_inherited();
respawn = true;
introSprite = sprBeeBladerTeleport;
healthpointsStart = 28;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 0;
grav = 0;
category = "flying, nature";

// Enemy specific code
storeXScale = image_xscale;
setSide = 0;
phase = 0;
attackTimer = 0;
attackTimerMax = 8;
bullet[0] = noone;
bullet[1] = noone;
bullet[2] = noone;
cAngle = 90;
cDistance = 2;
addAngle = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep()
    && introTimer <= 0)
{
    image_index += 0.4;

    if (storeXScale == 0)
        storeXScale = image_xscale;

    if (phase == 0)
        y = ystart + cos(degtorad(cAngle)) * cDistance;

    cAngle += addAngle;

    if (cAngle >= 360)
        cAngle -= 360;

    attackTimer += 1;
    if (attackTimer == attackTimerMax)
    {
        bullet[0] = instance_create(x + 12 * image_xscale, y + 8, objBeeBladerProjectile);
        bullet[0].xspeed = 0.5 * image_xscale;
        bullet[0].yspeed = -0.25;
        bullet[1] = instance_create(x + 12 * image_xscale, y + 8, objBeeBladerProjectile);
        bullet[1].xspeed = 0.75 * image_xscale;
        bullet[1].yspeed = 0;
        bullet[2] = instance_create(x + 12 * image_xscale, y + 8, objBeeBladerProjectile);
        bullet[2].xspeed = 0.5 * image_xscale;
        bullet[2].yspeed = 0.25;
        playSFX(sfxEnemyShoot);
        setSide = 32;
    }
    if ((attackTimer > attackTimerMax && !instance_exists(bullet[0]) && !instance_exists(bullet[1]) && !instance_exists(bullet[2])) && phase == 0)
    {
        yspeed = -6;
        grav = 0.325;
        for (var i = 32; i < 256; i += 1)
        {
            if (checkSolid(i*image_xscale, -8) || x + i >= view_xview + view_wview - 16 && image_xscale == 1 || x - i <= view_xview + 16 && image_xscale == -1  )
            {
                setSide = i;
                break;
            }
        }
        aimDir = 1;
        if (image_xscale == -1)
        {
            aimDir = -1;
        }
        if (image_xscale == 1)
        {
            aimDir = 1;
        }

        xspeed = xSpeedAim(x, y, x + setSide * aimDir, y, yspeed, grav);
        phase = 1;
    }
    if (phase == 1 && y >= ystart && yspeed >= 0)
    {
        image_xscale *= -1;
        yspeed = 0;
        xspeed = 0;
        grav = 0;
        attackTimer = 0;
        phase = 0;
        setSide = 32;
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    if (storeXScale != 0)
    {
        image_xscale = storeXScale;
    }

    // shootTimer = 0;
}
