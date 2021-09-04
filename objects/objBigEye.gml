#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// The classic 'before the boss gates' beefy enemy. It jumps towards you on an interval, and randomly
// decides its jump height randomly. It telegraphs which - if it closes its eye, it'll jump high,
// otherwise it'll jump low. It's pretty beefy and does lots of damage, so use them sparingly.

event_inherited();

healthpointsStart = 20;
healthpoints = healthpointsStart;
contactDamage = 10;

category = "big eye, bulky";

// Enemy specific code

//@cc // 0 = red; 1 = blue; 2 = red with orange eyes
col = 0;
init = 1;

timer = 0;
repeatAmount = 0; // variables to make sure big eye doesn't repeat his action too much
repeatIsHigh = true;
xs = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// set color on spawn
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprBigEyeRed;
            break;
        case 1:
            sprite_index = sprBigEyeBlue;
            break;
        case 2:
            sprite_index = sprBigEyeOrange;
            break;
    }
}

if (xs != 0)
{
    xspeed = xs;
}

event_inherited();

if (entityCanStep())
{
    if (ycoll > 0) // play landing sound if colliding with the floor
    {
        playSFX(sfxHeavyLand);
    }

    // if it's on the ground, start its jump timer
    if (ground)
    {
        timer += 1;
        if (timer == 1)
        {
            xs = 0;
            if (repeatAmount < 2)
            {
                // randomize();
                highJump = choose(true, false); // False means a low jump, true means a high jump
            }
            else
            {
                highJump = !repeatIsHigh;
            }

            image_index = 4; // animation for hitting the ground

            // To not make the Big eye spam one jump height by pure randomness
            // Because if he spams low jumps, it's nearly impossible to pass him
            if (highJump && repeatIsHigh)
            {
                repeatAmount += 1;
            }
            else if (!highJump && !repeatIsHigh)
            {
                repeatAmount += 1;
            }
            else
            {
                repeatAmount = 1;
                repeatIsHigh = highJump;
            }

            calibrateDirection(); // face player

            xspeed = 0;
        } // animation stuff
        else if (timer == 4)
        {
            image_index = 0;
        }
        else if (timer == 6)
        {
            image_index = highJump;
        }
        else if (timer == 40)
        {
            yspeed = -3 * (1 + highJump);
            image_index = 2 + highJump;
            ground = 0;
            xs = image_xscale * 1;
            timer = 0;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();

timer = 0;
image_index = 2;
repeatAmount = 0;
repeatIsHigh = true;
xs = 0;
