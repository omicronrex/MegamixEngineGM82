#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "flying";

grav = 0;
blockCollision = 0;

despawnRange = 48;
respawnRange = 48;

// Enemy specific code
image_speed = 0;
animTimer = 0;

action = 0;
actionTimer = 0;
sinCounter = 0;

doesLightning = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    actionTimer += 1;
    switch (action)
    {
        // wait for its prey
        case 0:
            if (instance_exists(target))
            {
                if (abs(target.x - x) < 48)
                {
                    yspeed = -3;
                    action = 1;
                    actionTimer = 0;
                    animTimer = 0;
                }
            }
            break;
        // GAMERS RISE UP
        case 1:
            if (y <= view_yview + 48)
            {
                yspeed = 1.25 * (!doesLightning);
                action = 2 + doesLightning;
                actionTimer = 0;
            }
            break;
        // WAAAAYYYVVVVVVVVEEEEEEEEE
        case 2:
            sinCounter += .15;
            xspeed = -(cos(sinCounter) * 1.7);

            if (y > view_yview[0] + view_hview[0])
            {
                image_index = 0;
                action = 4;
                actionTimer = 0;
                xspeed = 0;
                yspeed = 0;
                x = xstart;
                sinCounter = 0;
                y = view_yview[0] + view_hview[0];
            }
            break;
        // Lightning time. this code kinda sucks
        case 3: // finish spinning until at front
            if (image_index == 0 && actionTimer < 100)
            {
                actionTimer = 100;
                animTimer = 0;
            }

            // blink before shock
            if (actionTimer == 120 || actionTimer == 130)
            {
                image_index = 4;
            }

            if (actionTimer == 125)
            {
                image_index = 5;
            }

            if (actionTimer == 135)
            {
                image_index = 0;
            }

            // start flashing
            if (actionTimer == 140)
            {
                image_index = 6;
            }

            // eyes open + thunderbolt loop
            if (actionTimer > 140 && actionTimer <= 188 && actionTimer mod 4 == 0)
            {
                image_index += 1;
                if (image_index > 8)
                {
                    image_index = 6;
                }

                // thunderbolt
                if (actionTimer == 164)
                {
                    playSFX(sfxThunderWoolThunder);
                    instance_create(x, y, objKaminariKogoroLightning);
                }
            }

            // time for a SHOCK ha ha ha
            if (actionTimer == 189)
            {
                image_index = 9;
            }

            if (actionTimer == 220)
            {
                image_index = 0;
                action = 2;
                yspeed = 1.25;
                actionTimer = 0;
            }
            break;
        // cooldown before rise up again
        case 4:
            if (actionTimer == 60)
            {
                actionTimer = 0;
                action = 0;
            }
            break;
    }

    // Animation
    if (action == 1 || action == 2 || (action == 3 && actionTimer < 100))
    {
        animTimer += 1;

        if (animTimer == 6 + ((action == 2) * 2))
        {
            image_index += 1;
            if (image_index > 3)
            {
                image_index = 0;
            }

            animTimer = 0;
        }
    }

    // Tel Tel weather forces lightning
    if (global.telTelWeather > 0)
    {
        doesLightning = true;
    }
}

visible = (action != 0 && action != 4);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn event
event_inherited();

if (spawned)
{
    action = 0;
    actionTimer = 0;
    animTimer = 0;
    image_index = 0;
    sinCounter = 0;

    y = view_yview[0] + view_hview[0];
}
