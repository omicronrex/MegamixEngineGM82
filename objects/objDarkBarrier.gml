#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A barrier used by Dark Man 4. It repels most kinds of attacks, but can be fired.
event_inherited();
image_speed = 0.2;
reflectable = 0;
canHit = true;
despawnRange = 5;
blockCollision = 0;
grav = 0;

contactDamage = 6;
stopOnFlash = false;

dir = 0; // What direction is it going in?
origX = 0; // Set to be Dark Man's centre
limitX = 0; // Set to be a certain number away from Dark Man's centre
orbit = true; // Is it currently revolving around Dark Man?
comeBack = false; // Is it coming back to Dark Man?
stopHere = 0; // Where to stop when comeBack = true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    // Only work if Dark Man exists
    if (instance_exists(objDarkMan4))
    {
        origX = objDarkMan4.x; // This is where the barriers "orbit" around Dark Man
        limitX = origX + 30 * dir; // This is how far the barriers can go before turning back around

        // If orbiting Dark Man...
        if (orbit)
        {
            // Speed up when Dark Man is shooting
            if (objDarkMan4.shooting == true)
            {
                xspeed = 3 * dir;
            } // Default speed
            else
            {
                if (orbit == true)
                {
                    xspeed = 1 * dir;
                }
            }

            // Turn around when at travel limit
            if ((x <= limitX) && (dir == -1) || (x >= limitX) && (dir == 1))
            {
                dir = -dir;
                x += 2 * dir;
            }

            // Turn around when at Dark Man's center
            if (x == origX)
            {
                if (objDarkMan4.phase != 1)
                {
                    dir = -dir;
                    x += 2 * dir;
                } // Do not orbit Dark Man when he's about to jump
                else
                {
                    if (objDarkMan4.attackTimer >= 0)
                    {
                        orbit = false;
                        xspeed = 4 * dir;
                    }
                }
            }
        } // If not orbiting Dark Man...
        else if (comeBack)
        {
            if ((x < stopHere) && (dir == 1) || (x > stopHere) && (dir == -1))
            {
                xspeed = 4 * dir;
            }
            else
            {
                xspeed = 0;
                if (x != stopHere)
                {
                    x = stopHere;
                }
                comeBack = false;
            }
        }
    } // Destroy if Dark Man is dead
    else
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
