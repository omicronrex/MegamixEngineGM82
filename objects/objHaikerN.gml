#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This enemy apears near the sides of the screen from above and flies towards its position in the editor
// Once in place it will spit projectiles aiming at megaman
event_inherited();
healthpointsStart = 6;
category = "semi bulky";

grav = 0;
blockCollision = false;
facePlayerOnSpawn = true;
respawnRange = 12;
despawnRange = 8;
contactDamage = 3;

// Enemy specific code
if (image_xscale == -1)
{
    image_xscale = 1;
    x -= 16;
}
sprite_index = sprHaikerN;
x += 8;
y += 16;
xstart = x;
ystart = y;

prevX = 0;
prevY = 0;
horSpeed = 0;
timer = 0;
phase = 0;
animFrame = 0;

// Parabola Variables
spawnYOffset = 0;
spawnXOffset = 0;
endXoffset = 16;
SPEED = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            xspeed = SPEED * -image_xscale;
            if (abs(x - xstart) > endXoffset)
                y = a * ((x - (xstart + endXoffset * image_xscale)) * (x - (xstart + endXoffset * image_xscale))) + ystart;
            else
                y = ystart;
            if (abs(x - xstart) <= abs(xspeed))
            {
                x = xstart;
                y = ystart;
                xspeed = 0;
                isSolid = true;
            }

            if (x == xstart && y == ystart && floor(animFrame == 0))
                phase = 1;

            animFrame += 0.175;
            if (floor(animFrame) > 5)
                animFrame = 0;
            break;
        case 1:
            animFrame += 0.175;
            if (floor(animFrame) > 0)
            {
                animFrame = 6;
                playSFX(sfxPiledan);
                phase = 2;
                timer = 60;
            }
            break;
        case 2:
            timer += 1;
            if (timer > 120)
            {
                timer = 0;
                animFrame = 7;
            }
            if (animFrame > 6)
            {
                var prevFrame = floor(animFrame);
                animFrame += 0.3;
                if (floor(animFrame) > 10)
                    animFrame = 6;
                if (floor(animFrame) == 9 && prevFrame != floor(animFrame))
                {
                    playSFX(sfxHaikerNShoot);
                    var tx = 0;
                    var ty = 0;
                    if (instance_exists(target))
                    {
                        tx = target.x;
                        ty = target.y;
                    }
                    var i = instance_create(x + 8 * image_xscale, y, objEnemyBullet);
                    i.grav = 0.15;
                    i.sprite_index = sprHaikerNGlob;
                    i.mask_index = sprHaikerNGlob;
                    i.contactDamage = 2;
                    i.imageSpeed = 0.175;
                    i.yspeed = -2;
                    i.xspeed = xSpeedAim(i.x, i.y, x + image_xscale * abs(tx - x), ty, i.yspeed, i.grav, 3);
                }
            }
            with (objMegaman)
            {
                if (!dead && iFrames == 0 && canHit && collision_rectangle(bbox_left - 2, bbox_top - 2, bbox_right + 2, bbox_bottom + 2, other, false, false))
                {
                    with (other)
                    {
                        entityEntityCollision();
                    }
                }
            }
            break;
    }
    image_index = floor(animFrame);
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawn Event
event_inherited();
if (spawned)
{
    isSolid = false;
    calibrateDirection();
    if (instance_exists(target))
    {
        x = target.x + (22 * image_xscale == -1);
    }
    else
    {
        x = view_xview + 16 * image_xscale * -1;
    }
    if (abs(x - xstart) < 16)
    {
        x = xstart + 24 * image_xscale;
    }
    y = view_yview - (bbox_bottom - bbox_top) * 0.5;
    animFrame = 0;
    phase = 0;
    timer = 0;

    a = y - ystart;
    var den = (x - (endXoffset * image_xscale + xstart)) * (x - (endXoffset * image_xscale + xstart));
    a = a / den;
    y = a * ((x - (xstart + endXoffset * image_xscale)) * (x - (xstart + endXoffset * image_xscale))) + ystart;
    SPEED = min(point_distance(x, y, xstart, ystart) / 180, 2); // reach in 180 frames, but limit its speed
}
