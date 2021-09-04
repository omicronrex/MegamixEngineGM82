#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// They will drop a nest creating five Chibees
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "flying, nature";

blockCollision = 0;
grav = 0;

// Enemy specific code
phase = 0;
radius = 6 * 16; // this is how far AWAY have su bee is, but only after flying past megaman
dropTimer = 0;
spd = 4.5;

imgSpd = 0.2;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        switch (phase)
        {
            // when onscreen, teleport to the back end of the screen mega man is coming from, and start flying toward him from there
            case 0:
                calibrateDirection();
                if (image_xscale < 0)
                {
                    x = view_xview; // fly in from the left of the screen
                }
                else
                {
                    x = view_xview + view_wview; // fly in from the right
                }

                calibrateDirection(); // now actually face megaman to move properly
                xspeed = spd * image_xscale;
                phase = 1;
                break;
            // flying towards megaman
            case 1:
                if (image_xscale > 0)
                {
                    if (x > target.x && abs(target.x - x) >= radius)
                    {
                        phase = 2;
                        xspeed = 0;
                    }
                }
                else
                {
                    if (x < target.x && abs(target.x - x) >= radius)
                    {
                        phase = 2;
                        xspeed = 0;
                    }
                }
                break;
            // stop and drop hive
            case 2:
                if (dropTimer == 0)
                {
                    image_xscale = -image_xscale; // face mega man to drop the hive
                }

                dropTimer += 1;

                // it rises up slightly and then back down before dropping the hive
                if (dropTimer < 30)
                {
                    yspeed = -0.2;
                }
                else if (dropTimer < 60)
                {
                    yspeed = 0.2;
                }

                if (dropTimer == 60)
                {
                    hive = instance_create(x, y + sprite_height / 2, objHaveSuBeeHive);
                    hive.image_xscale = image_xscale; // to turn around the sprite. even though it's mostly not noticeable, I just wanted to be complete about it XP
                    imgIndex = 2;
                }

                if (dropTimer == 80)
                {
                    phase = 3;
                    image_xscale = -image_xscale; // face back away
                    xspeed = spd * image_xscale;
                }
                break;
            // fly away
            case 3: // don't need to do anything here  :P
        }

        // animation
        imgIndex += imgSpd;
        if (dropTimer < 60)
        {
            if (imgIndex >= 2)
            {
                imgIndex -= 2;
            }
        }
        else
        {
            if (imgIndex >= 4)
            {
                imgIndex = 2 + (imgIndex mod 4);
            }
        }
    }
}
else if (dead)
{
    phase = 0;
    dropTimer = 0;
}

image_index = imgIndex div 1;
