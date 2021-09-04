#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A pseudo miniboss that will shoot homing missiles at megaman.
event_inherited();

healthpointsStart = 16;
healthpoints = healthpointsStart;
contactDamage = 4;
lockTransition = false;

category = "bulky, nature";

doesIntro = false;
rescursiveExplosion = false;

// Enemy specific code
phase = 0;
waitTimer = 0;

place = -1;
missle[0] = noone;
missle[1] = noone;

animBack = false;
imgSpd = 0.08;
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
    switch (phase)
    {
        // start facing mega man
        case 0:
            calibrateDirection();
            phase = 1;
            break;

        // wait to fire next attack
        case 1:
            imgIndex += imgSpd;
            if (imgIndex >= 2)
            {
                imgIndex = imgIndex mod 2;
            }
            waitTimer += 1;
            if (waitTimer >= 60)
            {
                waitTimer = 0;
                phase = 2;
                imgIndex = 2;
            }
            break;

        // fire ice cube
        case 2:
            imgIndex += imgSpd;
            if (imgIndex >= 4)
            {
                phase = 1;
                imgIndex = imgIndex mod 4;
                cube = instance_create(x + sprite_width * 0.35, y + 15, objSquidonIceCube);
                cube.dir = image_xscale;

                // see if a missle should be fired
                var i;
                for (i = 0; i < 2; i += 1)
                {
                    ded = false;
                    if (!instance_exists(missle[i]))
                    {
                        ded = true;
                    }
                    else
                    {
                        if (missle[i].dead == true)
                        {
                            ded = true;
                        }
                    }

                    if (ded)
                    {
                        if (place == -1)
                        {
                            place = i;
                        }

                        missle[i] = noone;
                    }
                }

                if (place != -1)
                {
                    phase = 3;
                    imgIndex = 4;
                }
            }
            break;

        // shoot missle
        case 3:
            if (!animBack)
            {
                imgIndex += imgSpd * 5;
                if (imgIndex >= 7)
                {
                    imgIndex = 6;
                    animBack = true;
                    a = instance_create(x + sprite_width * 0.22, y - 17, objSquidonMissile);
                    a.dir = image_xscale;
                    missle[place] = a;
                    place = -1;
                }
            }
            else
            {
                // stay open after firing for a brief moment
                if (waitTimer > 20)
                {
                    imgIndex -= imgSpd * 5;
                    if (imgIndex < 4)
                    {
                        phase = 1;
                        animBack = false;
                        imgIndex = 0;
                        waitTimer = 0;
                    }
                }
                else
                {
                    waitTimer += 1;
                }
            }
            break;
    }
}
else if (dead)
{
    phase = 0;
    place = -1;
    waitTimer = 0;
    animBack = false;
    imgIndex = 0;

    if (deadTimer == 2)
    {
        audio_stop_sound(sfxExplosion);
        playSFX(sfxExplosion2);
    }
}

image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
with (objSquidonMissile)
{
    event_user(EV_DEATH);
    itemDrop = -1;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Damage tables
specialDamageValue(objHornetChaser, 6);
specialDamageValue(objGeminiLaser, 5);
specialDamageValue(objIceWall, 5);
