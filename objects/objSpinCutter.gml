#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;

contactDamage = 3;
facePlayerOnSpawn = true;

grav = 0;
respawnRange = 0;
despawnRange = 4;

if (image_xscale < 0)
{
    x += 27 - sprite_get_xoffset(sprSpinCutterPreview);
}

image_xscale = 1;
sprite_index = sprSpinCutter;
mask_index = sprSpinCutter;

x += sprite_get_xoffset(sprSpinCutter) - sprite_get_xoffset(sprSpinCutterPreview);
y += sprite_get_yoffset(sprSpinCutter) - sprite_get_yoffset(sprSpinCutterPreview);

xstart = x;
ystart = y;

//@cc col 0: green; 1: pink
x -= 4;
x = xstart;

col = 0;
angle = 0;
timer = 0;

phase = 0;
pivot = 0;
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
    if (phase == 0) // Fall
    {
        grav = 0;
        xspeed -= 0.2 * sign(x - pivot); // A cos wave didn't quite feel like the original, so here's this
        if (xspeed != 0)
            image_xscale = sign(xspeed);
        yspeed = abs(xspeed) * 0.865;
        if (abs(xspeed) < 0.7)
            animFrame = 1;
        else
            animFrame = 0;

        if (xcoll != 0 || ycoll != 0)
        {
            phase = 1;
            animFrame = 0;
            xspeed = 0;
            grav = 0.25;
            timer = 60;
        }
    }
    else if (phase == 1) // Wait a bit before moving
    {
        if (floor(animFrame) < 1)
            animFrame += 0.15;
        else
            animFrame += 0.35;
        if (floor(animFrame) > 4)
            animFrame = 1;
        timer -= 1;

        if (timer == 0)
        {
            phase = 2;
            animFrame = 0;
            calibrateDirection();
            xspeed = 0.45 * image_xscale;
        }
    }
    else if (phase == 2)
    {
        if (ground && abs(xspeed) < 3.25) // accelerate
        {
            xspeed += 0.25 * image_xscale;
        }
        if (ground && xcoll != 0) // Bump on walls
        {
            yspeed = -2;
            image_xscale *= -1;
            xspeed = 0.35 * image_xscale;
        }
        animFrame += 0.35;
        if (floor(animFrame) > 3)
            animFrame = 0;
    }
    image_index = 7 * col + 2 * (phase == 1) + 3 * (phase > 1) + floor(animFrame);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (!insideSection(x, y + 8))
    {
        dead = true;
    }
    phase = 0;
    angle = 0;
    grav = 0;
    xspeed = 1 * image_xscale;
    pivot = x + 28 * image_xscale;
}
