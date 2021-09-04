#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false; // can totally use this just by itself seperate from have su bee

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;
grav = 0;
blockCollision = 0;

despawnRange = 0;

dir = 1;

// Enemy specific code
phase = 0;
waitTimer = 0;
rotateSpd = 2;
totalChange = 0;

spd = 1.4;
speed = 0;
xspeed = 0;
yspeed = 0;

jetTimer = 0;
imgIndex = 0;
image_speed = 0;
image_index = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    speed = spd;

    if (instance_exists(target))
    {
        switch (phase)
        {
            // setup initial direction
            case 0:
                phase = 1;

                if (dir == -1)
                {
                    direction = 135;
                }
                else
                {
                    direction = 45;
                }

                break;

            // chase megaman
            case 1: // spawn grace period before aiming towards the player
                if (waitTimer < 30)
                {
                    waitTimer += 1;
                    break;
                }

                // stop aiming after the missle turns enough
                if (totalChange >= 450)
                {
                    break;
                }

                preDirection = direction;

                correctDirection(point_direction(x, y, target.x, target.y), rotateSpd);

                // this is basically so it doesn't add way too much when crossing from 0 degrees to 360 degrees
                c = abs(direction - preDirection);
                if (c > rotateSpd)
                {
                    c = rotateSpd;
                }

                totalChange += c;

                break;
        }

        // animaion
        jetTimer += 1;
        if (jetTimer >= 3)
        {
            // <-=1 jet animation speed here
            if (sprite_index == sprSquidonMissleJet1)
            {
                sprite_index = sprSquidonMissleJet2;
            }
            else
            {
                sprite_index = sprSquidonMissleJet1;
            }

            jetTimer = 0;
        }

        imgIndex = round((direction) / 45);
    }
}
else
{
    speed = 0;

    if (dead)
    {
        phase = 0;
        startWaitTimer = 20;
    }
}

image_index = imgIndex div 1;
