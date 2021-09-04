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
contactDamage = 0;
canHit = false;
stopOnFlash = false;
blockCollision = 1;
grav = 0;

// Enemy specific code
image_speed = 0;

imgalarm = 0;
img = 0;

yStart = ystart - 16;


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


yMin = yStart;
yScale = ceil(1);

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
    if (instance_exists(parent))
    {
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

        x = round(parent.x - 4 * parent.image_xscale);
        y = round(parent.y);
        for (var i = 0; i < view_hview; i++)
        {
            yStart = i;
            image_yscale = ceil(yStart / 16);
            if (checkSolid(0, 0))
            {
                break;
            }
        }
    }
}
else if ((dead) || (!instance_exists(parent)))
{
    instance_destroy();
}

if (!instance_exists(parent))
    instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i = 0; i < image_yscale; i += 1)
{
    if (i == image_yscale - 1)
    {
        draw_sprite(sprBubbleManWaterPillarTop, img, x, (ceil(y / 16) * 16) - 8 + i * 16);
    }
    else
    {
        draw_sprite(sprBubbleManWaterPillar, img, x, (ceil(y / 16) * 16) - 8 + i * 16);
        draw_sprite(sprBubbleManWaterPillar, img, x, (ceil(y / 16) * 16) + i * 16);
    }
}
