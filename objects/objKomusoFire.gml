#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 999;
healthpoints = healthpointsStart;
contactDamage = 4;
stopOnFlash = false;
blockCollision = 0;
grav = 0;

// Enemy specific code
image_speed = 0;

imgalarm = 0;
img = 0;

startY = view_yview + view_hview;


yspeed = 0;
xspeed = 0;

moveDist = 70;
moveCounter = moveDist / 2;
cDir = -1;

destroyCounter = 3;

cAngle = degtorad(90);
cDistance = 4;
addAngle = 0.05;

imageTimer = 4;

if (!instance_exists(objKomusoMan))
{
    instance_destroy();
    exit;
}
yMin = abs((view_yview + view_hview) - (objKomusoMan.y - 48));
yScale = ceil(yMin / 16);

image_yscale = yScale + 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(objKomusoMan))
    {
        if (startY > objKomusoMan.y - 16 && destroyCounter > 0)
            yspeed = -1;
        else if (startY == objKomusoMan.y - 16 && destroyCounter > 0)
            yspeed = 0;
        else
        {
            yspeed = 1;
            xspeed = 0;
        }
    }

    if (imageTimer > 0)
        imageTimer -= 1;

    if (imageTimer == 0 && img < 3)
    {
        imageTimer = 3;
        img += 1;
    }
    if (imageTimer == 0 && img == 3)
    {
        imageTimer = 3;
        img = 0;
    }
    startY += yspeed;

    y = startY + cos(cAngle) * cDistance;

    if (yspeed == 0 && moveCounter < moveDist)
    {
        xspeed = cDir * 0.5;
        moveCounter += 0.5;
        cAngle += addAngle;
    }
    if (yspeed == 0 && moveCounter == moveDist)
    {
        cDir = cDir * -1;
        moveCounter = 0;
        destroyCounter -= 1;
    }
}
else if ((dead) || (!instance_exists(objKomusoMan)))
{
    instance_destroy();
    with (objKomusoMan)
        phase = 10;
}

if (healthpoints < healthpointsStart)
    healthpoints = healthpointsStart;

if (!instance_exists(objKomusoMan))
    instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i = 0; i < image_yscale; i += 1)
{
    if (i == 0 || i == image_yscale - 1)
    {
        draw_sprite(sprKomusoFireTop, img, x, y + i * 16);
    }
    else
    {
        draw_sprite(sprKomusoFireMid, img, x, (y + 8) + i * 16);
    }
}
