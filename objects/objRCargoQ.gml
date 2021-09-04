#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Entity setup
healthpointsStart = 6;
healthpoints = 6;
contactDamage = 4;
canHit = true;
facePlayerOnSpawn = true;
facePlayer = false;
behaviourType = 1;
category = "grounded, semi bulky";

// Enemy specific code

shootFrame = 5;
wait = 120;
timer = wait * 0.9;
animSpeed = 0.2;
ballImage = 1;
myBall = noone;
image_speed = 0;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (!instance_exists(myBall))
    {
        timer = wait;
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var ball; ball = instance_create(x - image_xscale * 5, bbox_top + 6, objCargoQBall);
ball.type = self.ballImage;
ball.dead = false;
ball.visible = true;
ball.dir = image_xscale;
with (ball)
    event_user(0);
myBall = ball;
