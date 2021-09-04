#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "flying, nature, bird";

grav = 0;
blockCollision = false;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;
cooldownTimer = 0;

spd = 1;

animBack = false;
imgSpd = 0.4;
imgIndex = 0;
propellerTimer = 0;
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
            // fly around and detect for mega man
            case 0:
                if (cooldownTimer > 0)
                {
                    cooldownTimer -= 1;
                    break;
                }

                if (instance_exists(target))
                {
                    if (abs(x - target.x) < 32)
                    {
                        phase = 1;
                        xspeed = 0;
                    }
                }

                break;

            // drop pelican
            case 1:
                if (!animBack)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 5)
                    {
                        cooldownTimer = 0;
                        imgIndex = 4 - imgIndex mod 4;
                        animBack = true;
                        fluffytheironicallynamedfish = instance_create(
                            x + sprite_width * 0.7, y + 9, objPelicanuFish);
                        fluffytheironicallynamedfish.image_xscale = image_xscale;
                        xspeed = spd * image_xscale;
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
                        cooldownTimer = 30; // <-- cooldown time here
                    }
                }

                break;
        }

        // animate propeller
        propellerTimer += 1;
        if (propellerTimer >= 5)
        {
            propellerTimer = 0;

            if (sprite_index == sprPelicanuPropeller1)
            {
                sprite_index = sprPelicanuPropeller2;
            }
            else
            {
                sprite_index = sprPelicanuPropeller1;
            }
        }
    }
}
else if (dead)
{
    phase = 0;
    cooldownTimer = 0;
    xspeed = 0;
    propellerTimer = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = spd * image_xscale;
}
