#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cannons, shielded";

facePlayerOnSpawn = true;

// Enemy specific code
delay = 10;
calibrated = 0;

actionTimer = 0;
action = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (action) // Checking if action > 0
    {
        actionTimer += 1;
        switch (action)
        {
            case 1: // Waiting to pop up for 70 frames (a little over a second)
                if (actionTimer == 60 + delay)
                {
                    action += 1;
                    actionTimer = 0; // reset timer
                    image_index += 1;

                    // delay = choose(0,0,10,20); //Removed to make enemy more tolerable.
                    delay = 10;
                }
                break;
            case 2: // pop open, shoot generic bullet
                if (actionTimer == 8)
                {
                    action += 1;
                    actionTimer = 0;
                    image_index += 1;
                    i = instance_create(x + 8 * image_xscale, y - 11,
                        objEnemyBullet);
                    i.xspeed = image_xscale
                        * 2; // Base xspeed on the enemy's direction
                    i.contactDamage = 2; // Setting custom damage for bullet
                }
                break;
            case 3: // Peek open until actionTimer is 24 (roughly under half a second)
                if (actionTimer == 24)
                {
                    action = 1;
                    actionTimer = 0;
                    image_index = 0;
                }
                break;
        }
    }
}
else if (dead) // reset variables if dead/offscreen
{
    actionTimer = 50;
    action = 1;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index < 1)
{
    other.guardCancel = 1;
}
if (collision_rectangle(x - 16 * image_xscale, y - 29, x, y + 1, other.id,
    false, false))
{
    other.guardCancel = 1;
}
