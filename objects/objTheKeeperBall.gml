#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 4;
healthpoints = 4;
blockCollision = false;
dir = 1;
grav = 0.234;
bounces = 0;
timer = 0;
startSpeed = 0;
canHit = true;
contactDamage = 2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (timer >= 0)
        timer += 1;
    if (timer > 15)
    {
        blockCollision = true;
        timer = -1;
    }
    prevXspeed = xspeed;
    xSpeedTurnaround();
    if (prevXspeed != xspeed)
    {
        bounces += 1;
        if (blockCollision)
            playSFX(sfxBallBounce);
        var hand = collision_rectangle(bbox_left - abs(xspeed) - 1, bbox_top, bbox_right + abs(xspeed) + 1, bbox_bottom, objTheKeeperHand, false, false);
        if (hand != noone && (sign(hand.xspeed) != -sign(xspeed)))
        {
            xspeed += sign(xspeed) * 3.65;
        }
        else if (hand == noone)
        {
            var s = sign(xspeed);
            xspeed -= s * 3.456;
            if (s > 0 && xspeed < 0)
                xspeed = 2;
            else if (s < 0 && xspeed > 0)
                xspeed = -2;
        }
    }
    if (ground && ycoll != 0)
    {
        yspeed = -6.85;
        if (blockCollision)
            playSFX(sfxBallBounce);
        bounces += 1;
        ground = false;
    }
    if (bounces > 4)
    {
        blockCollision = false;
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (xspeed != 0 && startSpeed == 0)
    startSpeed = abs(xspeed);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(x, y, objExplosion);
playSFX(sfxEnemyHit);
