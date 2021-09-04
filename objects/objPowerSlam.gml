#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 5;

category = "big eye, bulky";

facePlayer = true;

// Enemy specific code
phase = 0;
timer = 0;
knocked = false;

imgSpd = 0.1;
imgIndex = 0;

grav = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // wait until jetting up
        case 0:
            waitTime = 71; // <-=1 wait time until jetting up
            grav = gravAccel;
            if (timer < waitTime - 30)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 2)
                {
                    imgIndex = imgIndex mod 2;
                }
            }
            else
            {
                imgIndex = 0;
                calibrateDirection(); // only turn when readying jump
            }
            if (instance_exists(target))
            {
                timer += 1;
                if (timer >= waitTime)
                {
                    phase = 1;
                    timer = 0;
                    yspeed = -2;
                    grav = 0;
                    playSFX(sfxEnemyBoost);
                }
            }
            break;

        // moving towards the player
        case 1:
            imgIndex += imgSpd * 8;
            if (imgIndex >= 3)
            {
                imgIndex = 1 + imgIndex mod 3;
            }
            down = false;

            // go down if a ceiling is hit, or the top of the screen is hit
            if (yspeed == 0)
            {
                down = true;
            }
            xspeed = 2 * image_xscale;

            // go down anyway if enough time passes
            timer += 1;
            if (timer >= 60)
            {
                down = true;
            }
            if (instance_exists(target))
            {
                // go down if the top of the section is hit
                if (bbox_top < global.sectionTop + 8)
                {
                    down = true;
                }

                // go down if mega man is below
                if (target.bbox_left > bbox_left - 4 && target.bbox_right < bbox_right + 4)
                {
                    down = true;
                }
            }

            // go down
            if (timer >= 15 && down)
            {
                phase = 2;
                xspeed = 0;
                yspeed = 0;
                timer = 0;
                imgIndex = 1;
            }
            break;

        // slam down
        case 2: // wait until going down
            waitTime = 13;
            if (timer == waitTime)
            {
                yspeed = 6.1;
                imgIndex = 1;
                playSFX(sfxEnemyDrop2);
                timer += 1; // used timer as a boolean
            }
            else if (timer < waitTime)
            {
                timer += 1;
            }
            if (ground)
            {
                phase = 0;
                timer = 0;
                audio_stop_sound(sfxEnemyDrop2);
                playSFX(sfxLargeClamp); // that's actually the landing sfx in game. Not named the best in this engine
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    xspeed = 0;
    yspeed = 0;
    timer = 0;
    imgIndex = 0;
    grav = 0;
}

image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(bboxGetXCenter(),bboxGetYCenter(),objBigExplosion);
playSFX(sfxExplosion2);
