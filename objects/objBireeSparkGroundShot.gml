#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;
respawn = false;
facePlayerOnSpawn = false;
facePlayer = false;

image_speed = 0.5;

phase = 0;
animTimer = 0;
sp = 3;
_groundDir = -1;
_dir = 1;
_velX = 0;
_velY = 0;
_prevCollision = 0;
itemDrop = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (phase == 0) // Coming out
    {
        _groundDir = 270;
        image_index = 0;
        phase = 1;
        grav = 0;
        yspeed = 0;
        xspeed = 0;
        shiftObject(0, 2, 1);
        grav = 0.25;
        checkGround();
    }
    else if (phase == 1) // Attached to solids
    {
        if (!snapToGround(sp, 4, 1))
        {
            event_user(EV_DEATH); // Die if the script fails
        }
        else if (_groundDir == 90) // Also die if on a ceiling
        {
            event_user(EV_DEATH);
        }
        switch (_groundDir)
        {
            case 90:
            case 270:
                if (sign(_velX) == _dir)
                {
                    image_index = 0;
                }
                else
                {
                    image_index = 2;
                }
                break;
            case 180:
            case 0:
                if (sign(_velY) > 0)
                {
                    image_index = 4;
                }
                else
                {
                    image_index = 6;
                }
                break;
        }
    }

    image_index += (_dir == -1) * 8 + (animTimer div 5) mod 2;

    animTimer += 1;
    if (phase == 0)
    {
        if (animTimer >= 30)
            animTimer = 0;
    }
    else if (animTimer >= 10)
        animTimer = 0;
}
