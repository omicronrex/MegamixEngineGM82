#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation Code
// startDir: direction in which Piledan is moving when it spawns, -1->left,1->right
event_inherited();
healthpointsStart = 3;
healthpoints = 3;
contactDamage = 3;
facePlayerOnSpawn = false;
grav = 0;
blockCollision = false;
despawnRange = 16;
respawnRange = -4;
category = "floating";

waveSpeed = 0.075;
waveWidth = 3.35;
timer = 0;
horSpeed = 0.75;
fallSpeed = 0.5;
foundMachine = false;
xscaleStart = image_xscale;
startDir = 0;

destY = -1;
startY = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!foundMachine)
    {
        image_index = 0;
        timer += waveSpeed;
        xspeed = image_xscale * horSpeed + cos(timer) * waveWidth;
        yspeed = fallSpeed * image_yscale;
        with (objPiledanBomber)
        {
            if (!dead && abs(x - other.x) <= abs(other.xspeed) && image_yscale == other.image_yscale)
            {
                other.foundMachine = true;
                other.x = x;
                other.yspeed = 0;
                other.xspeed = 0;
                other.timer = 0;
                other.image_xscale = image_xscale;
                other.destY = y;
                other.startY = other.y;
                break;
            }
        }
    }
    else
    {
        image_index += 0.2;
        if (floor(image_index) > 1)
            image_index = 0;
        if (timer < 5)
            timer += 1;
        if (timer == 5)
        {
            yspeed = 1.85 * image_yscale;
            timer = 6;
            grav = 0.25 * image_yscale;
        }
    }
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
    foundMachine = false;
    xspeed = 0;
    yspeed = 0;
    image_xscale = xscaleStart;
    if (startDir == 0)
        timer = 0 + (pi * (image_xscale == 1));
    else
    {
        timer = 0 + pi * (startDir == -1);
    }

    destY = -1;
    startY = -1;
    t = 0;
    rval = -1;
}
