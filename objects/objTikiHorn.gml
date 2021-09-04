#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

contactDamage = 2;
image_speed = 0.25;

respawn = false;
isTargetable = false;

respawnRange = -1;
despawnRange = -1;

phase = 0;
timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    switch (phase)
    {
        case 0: // rising
            y -= 0.11;
            if (y <= ystart - 15)
            {
                phase = 1;
                y = ystart - 15;
            }
            break;
        case 1: // pause at height
            timer += 1;
            if (timer >= 55)
            {
                phase = 2;
                timer = 0;
            }
            break;
        case 2: // go back down
            y += 1;
            if (y >= ystart)
            {
                phase = 3;
                y = ystart;
            }
            break;
        case 3: // wait to go again
            timer += 1;
            if (timer >= 120)
            {
                timer = 0;
                phase = 0;
            }
            break;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
