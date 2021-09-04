#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
grav = 0;
category = "flying";
blockCollision = false;

// Enemy specific code
phase = 0;
cooldownTimer = 0;

xspeed = 0;
yspeed = 0;

animBack = false;
imgSpd = 0.4;
imgIndex = 0;
propellerTimer = 0;
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
    if (instance_exists(target))
    {
        switch (phase)
        {
            // face mega man and change speed
            case 0:
                calibrateDirection();
                xspeed = 1 * image_xscale; // <-- speed here
                phase = 1;

                break;

            // fly around and detect for mega man
            case 1:
                if (cooldownTimer > 0)
                {
                    cooldownTimer -= 1;
                    break;
                }

                if (instance_exists(target))
                {
                    if (abs(x - target.x) < 20)
                    {
                        phase = 2;
                        xspeed = 0;
                    }

                    if (abs(x - target.x) > 40)
                    {
                        phase = 0;
                    }
                }

                break;

            // drop needle
            case 2:
                if (!animBack)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 4)
                    {
                        imgIndex = 2 - imgIndex mod 4;
                        animBack = true;
                        instance_create(x, y + sprite_height / 2,
                            objHotchkissnNeedle);
                    }
                }
                else
                {
                    imgIndex -= imgSpd;
                    if (imgIndex < 0)
                    {
                        phase = 0;
                        imgIndex = 0;
                        animBack = false;
                        cooldownTimer = 80; // <-- cooldown timer here
                    }
                }
                break;
        }

        // animate propeller
        propellerTimer += 1;
        if (propellerTimer >= 5)
        {
            propellerTimer = 0;

            if (sprite_index == sprHotchkissnPropeller1)
            {
                sprite_index = sprHotchkissnPropeller2;
            }
            else
            {
                sprite_index = sprHotchkissnPropeller1;
            }
        }
    }
}
else
{
    if (dead)
    {
        phase = 0;
        cooldownTimer = 0;
        xspeed = 0;
        propellerTimer = 0;
        imgIndex = 0;
    }
}

image_index = imgIndex div 1;
