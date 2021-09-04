#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;
grav = 0;
blockCollision = false;
stopOnFlash = false;

// Enemy specific code
phase = 0;

imgSpd = 0.3;
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
        // setup
        case 0:
            xspeed = 3 * image_xscale; // <-=1 initial speed here
            phase = 1;
            break;

        // fly around and detect for mega man
        case 1:
            imgIndex += imgSpd;
            if (imgIndex >= 2)
            {
                imgIndex = 0;
            }
            if (instance_exists(target))
            {
                if (abs(x - target.x) < 10)
                {
                    phase = 2;
                    imgIndex += 2;
                    bomb = instance_create(x + 1 * image_xscale, y + 11, objHoneycombBomb);
                    bomb.image_xscale = image_xscale;
                    xspeed = 3.6 * image_xscale; // <-=1 after-bomb-drop speed here
                    playSFX(sfxEnemyDrop2);
                }
            }
            break;

        // dropped honeycomb
        case 2:
            imgIndex += imgSpd;
            if (imgIndex >= 4)
            {
                imgIndex = 2;
            }
            break;
    }
}
else
{
    if (dead)
    {
        phase = 0;
        xspeed = 0;
        imgIndex = 0;
    }
}

image_index = imgIndex div 1;
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objBusterShot, 1);
specialDamageValue(objBusterShotHalfCharged, 1);
specialDamageValue(objBusterShotCharged, 2);
specialDamageValue(objPharaohShot, max(2, floor(global.damage / 5)));
specialDamageValue(objSolarBlaze, 3);
specialDamageValue(objChillShot, 3);
specialDamageValue(objChillSpikeLanded, 3);
