#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 3;
blockCollision = true;
healthpointsStart = 1;
healthpoints = 1;
grav = 0.25;
dir = -1;
type = 0;
xspeed1 = 1.25;
xspeed2 = 2.45;
yspeed1 = -5;
yspeed2 = -2.85;
jumpCount = irandom(1);
xspeed = dir;
canHit = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xspeed == 0 || (yspeed == 0 && ycoll != 0 && !ground))
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
    else
    {
        if (ground)
        {
            if (type == 0)
            {
                yspeed = yspeed1;
            }
            else if (type == 1)
            {
                jumpCount += 1;
                if (jumpCount % 2 == 0)
                {
                    yspeed = yspeed1;
                    xspeed = xspeed1 * dir;
                }
                else
                {
                    yspeed = yspeed2;
                    xspeed = xspeed2 * dir;
                }
            }
            playSFX(sfxBallBounce);
            ground = false;
        }
        else
        {
            if (type == 0)
                xspeed = xspeed1 * dir;
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (type == 0)
{
    sprite_index = sprBCargoQBall;
    image_speed = 0.25;
}
else
{
    sprite_index = sprRCargoQBall;
    image_speed = 0.2;
}

image_xscale = dir;
xspeed = xspeed1 * dir;
yspeed = yspeed1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(x, y, objExplosion);
