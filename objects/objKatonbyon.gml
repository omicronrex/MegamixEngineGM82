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

category = "flying, nature";

grav = 0;
blockCollision = false;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;

imgSpd = 0.4;
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
            // fly around and detect for mega man
            case 1:
                imgIndex += imgSpd;
                if (imgIndex >= 3)
                {
                    imgIndex = imgIndex mod 3;
                }
                if (instance_exists(target))
                {
                    if (abs(x - target.x) < 20)
                    {
                        phase = 2;
                        imgIndex += 3;
                        instance_create(x, y + sprite_height / 2, objKatonbyonBomb);
                        xspeed = 2.4 * image_xscale; // <-- after-bomb-drop speed here
                        playSFX(sfxEnemyDrop2);
                    }
                }
                break;

            // drop bomb
            case 2:
                imgIndex += imgSpd;
                if (imgIndex >= 6)
                {
                    imgIndex = 3 + imgIndex mod 6;
                }
                break;
        }
    }
}
else
{
    if (dead)
    {
        phase = 1;
        xspeed = 0;
        imgIndex = 0;
    }
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
    xspeed = 1.9 * image_xscale; // <-- initial speed here
}
