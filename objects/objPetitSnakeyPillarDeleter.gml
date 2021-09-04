#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpoints = 1;
healthpointsStart = healthpoints;

blockCollision = 0;
grav = 0;
contactDamage = 0;

alarmTime = -1;
inWater = -1;

respawnRange = 90000; // set to -1 to make infinite
despawnRange = -1; // set to -1 to make infinite
respawn = false;

dir = 'down';
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
visible = 0;

if (entityCanStep())
{
    alarmTime += 1;
    if (alarmTime == 7)
    {
        if (place_meeting(x, y, objPetitSnakeyPillarCorner1))
        {
            if (dir == 'up')
            {
                dir = 'right';
            }
            else if (dir == 'left')
            {
                dir = 'down';
            }
            else
            {
                instance_destroy();
                exit;
            }
        }
        if (place_meeting(x, y, objPetitSnakeyPillarCorner2))
        {
            if (dir == 'up')
            {
                dir = 'left';
            }
            else if (dir == 'right')
            {
                dir = 'down';
            }
            else
            {
                instance_destroy();
                exit;
            }
        }
        if (place_meeting(x, y, objPetitSnakeyPillarCorner3))
        {
            if (dir == 'down')
            {
                dir = 'left';
            }
            else if (dir == 'right')
            {
                dir = 'up';
            }
            else
            {
                instance_destroy();
                exit;
            }
        }
        if (place_meeting(x, y, objPetitSnakeyPillarCorner4))
        {
            if (dir == 'down')
            {
                dir = 'right';
            }
            else if (dir == 'left')
            {
                dir = 'up';
            }
            else
            {
                instance_destroy();
                exit;
            }
        }
        if (place_meeting(x, y, objPetitSnakeyPillar))
        {
            if (instance_place(x, y,
                objPetitSnakeyPillar).object_index == objPetitSnakeyPillar)
            {
                if (dir == 'right' || dir == 'left')
                {
                    instance_destroy();
                    exit;
                }
            }
        }
        if (place_meeting(x, y, objPetitSnakeyPillarHorizontal))
        {
            if (dir == 'down' || dir == 'up')
            {
                instance_destroy();
                exit;
            }
        }

        mypillar = instance_position(x + 7, y + 7, objPetitSnakeyPillar);
        if (mypillar)
        {
            with (mypillar)
            {
                if (visible && !dead)
                {
                    event_user(EV_DEATH);
                }
            }
        }
        else
        {
            instance_destroy();
            exit;
        }

        // Move
        switch (dir)
        {
            case 'right':
                x += 16;
                break;
            case 'left':
                x -= 16;
                break;
            case 'up':
                y -= 16;
                break;
            case 'down':
                y += 16;
                break;
        }

        alarmTime = 0;
        if (!insideSection(x + 7, y + 7))
        {
            instance_destroy();
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 2;
