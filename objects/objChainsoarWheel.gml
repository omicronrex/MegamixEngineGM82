#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

moveSpeed = 0;
imgSpd = 0.2;
grav = 0.25;
accel = 0.05;

respawn = false;
contactDamage = 2;
reflectable = 0;
facePlayerOnSpawn = true;

blockCollision = true;
bounceTimes = 0;
itemDrop = -1;

moveTimer = 60;
canLive = 9; // time until wheel is destroyed.
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += imgSpd;

    if (xcoll != 0)
    {
        image_xscale *= -1;
    }

    if (bounceTimes < 4)
    {
        xspeed = accel * image_xscale;
        if (ground) // If touching floor...
        {
            yspeed = -ycoll * 0.5;
            if (yspeed > -0.5)
            {
                yspeed = 0;
            }
            bounceTimes++;
        }
        if (bounceTimes == 3)
        {
            playSFX(sfxWheelCutter2);
        }

        if (image_index > 1)
        {
            image_index = 0;
        }
    }
    else
    {
        if (abs(moveSpeed) < 3)
        {
            moveSpeed += accel;
        }
        xspeed = moveSpeed * image_xscale;
    }

    // Countdown to destruction
    moveTimer--;
    if (moveTimer == 0)
    {
        canLive--;
        moveTimer = 60;
        if (canLive == 0)
        {
            event_user(10);
            playSFX(sfxEnemyHit);
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 1 + (other.penetrate == 2);
