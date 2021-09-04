#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Entity setup
healthpointsStart = 4;
healthpoints = 4;
contactDamage = 4;
category = "grounded";
canHit = true;
facePlayerOnSpawn = true;
facePlayer = true;
behaviourType = 1;

// Enemy specific code

shootFrame = 4;
wait = 120;
timer = wait * 0.9;
animSpeed = 0.25;
ballImage = 1;
image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (timer == -1)
    {
        timer = wait * 0.9;
    }
    else
    {
        timer += 1;
    }
    if (timer < wait)
    {
        image_speed = 0;
        image_index = 0;
    }
    else if (timer >= wait)
    {
        image_speed = animSpeed;
        if (image_index == shootFrame)
        {
            event_user(0);
        }
    }
}
else if (dead)
{
    timer = -1;
    image_index = 0;
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timer = 0;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var ball; ball = instance_create(x + image_xscale * 10, y + 5, objMechaPitchanBall);

playSFX(sfxMechaPitchanDrop);

ball.target = self.target;
ball.sprite_index = sprMechaPitchanBall;
ball.image_index = self.ballImage;
ball.dead = false;
ball.visible = true;
ball.h = x + 20 * image_xscale;
ball.k = bbox_bottom + 20;
ball.ix = x + 40 * image_xscale;
var yDist; yDist = 0;

if (instance_exists(target))
{
    yDist = abs(target.y - y);
    yDist *= 0.65;
    ball.ix = target.x + yDist * image_xscale;
    ball.h = ((target.x + yDist * image_xscale) + x) * 0.5;
    if (image_xscale < 0)
    {
        if (ball.h > x + 20 * image_xscale)
            ball.h = x + 20 * image_xscale;
        if (ball.ix > x + 40 * image_xscale)
            ball.ix = x + 40 * image_xscale;
    }
    else
    {
        if (ball.h < x + 20 * image_xscale)
            ball.h = x + 20 * image_xscale;
        if (ball.ix < x + 40 * image_xscale)
            ball.ix = x + 40 * image_xscale;
    }
    ball.k = target.bbox_bottom + 5;
    if (ball.k < bbox_bottom + 20)
        ball.k = bbox_bottom + 20;
}
ball.dir = image_xscale;



with (ball)
{
    event_user(0);
}
