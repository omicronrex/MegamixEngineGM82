#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// col = <number> (0 = orange (default); 1 = red)

event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "grounded";

grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
col = 0;

phase = 0;
timer = 0;
waitDiff = 30;
spd = 0.5;

imgSpd = 0.1;
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
            // walk around
            case 0:
                imgIndex += imgSpd;
                if (imgIndex >= 6)
                {
                    imgIndex = imgIndex mod 6;
                }
                if ((imgIndex == 1) || (imgIndex == 4))
                {
                    playSFX(sfxTeck);
                }
                if (xspeed == 0 || !checkSolid(sprite_get_width(sprite_index) * 0.8 * image_xscale, bbox_top - y, 1, 1))
                {
                    image_xscale = -image_xscale;
                }
                xspeed = spd * image_xscale;
                if (instance_exists(target))
                {
                    if (abs(target.x - x) <= 58 + abs(sprite_width) / 2)
                    {
                        phase = 1;
                        xspeed = 0;
                        imgIndex = 5;
                    }
                }
                break;

            // wait & shoot
            case 1:
                if (timer < 2)
                {
                    imgIndex += imgSpd;
                    if (imgIndex >= 7 && timer == 0)
                    {
                        timer = 1;
                        shot = instance_create(x, y + sprite_height * 0.5,
                            objEnemyBullet);
                        shot.sprite_index = sprEnemyBulletMM6;
                        shot.contactDamage = 4;
                        shot.yspeed = 2.3;
                        playSFX(sfxEnemyShoot);
                    }

                    if (imgIndex >= 8 && timer == 1)
                    {
                        timer = 2;
                        imgIndex = 5;
                    }
                }
                else
                {
                    timer += 1;
                    if (timer > 16) // <-=1 time waiting after shot here
                    {
                        phase = 0;
                        timer = 0;
                        xspeed = spd * image_xscale;
                    }
                }
                break;
        }
    }
}
else if (dead)
{
    phase = 0;
    timer = 0;
    xspeed = 0;
    yspeed = 0;
    imgIndex = 0;
}

image_index = imgIndex div 1;
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// creation code setup
switch (col)
{
    case 0:
        sprite_index = sprTeckOrange;
        break;
    case 1:
        sprite_index = sprTeckRed;
        break;
}
