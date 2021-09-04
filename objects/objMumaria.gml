#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "semi bulky";

grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_index = 1;

actionTimer = 0;
action = 1;

mypower = contactDamage;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (action)
    {
        iaction = action;
        actionTimer += 1;
        switch (action)
        {
            case 1:
                if (actionTimer == 32)
                {
                    action += 1;
                    image_index += 1;
                    calibrateDirection();
                }
                break;
            case 2:
            case 3:
            case 4:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index += 1;
                }
                break;
            case 5:
                if (actionTimer == 24)
                {
                    // image_index = 6;
                    action += 1;
                    image_index = 6;
                }
                break;
            case 6:
                if (actionTimer == 3)
                {
                    // image_index = 7;
                    action += 1;
                    image_index = 7;
                }
                break;
            case 7:
                if (actionTimer == 3)
                {
                    // image_index = 8;
                    action += 1;
                    image_index = 8;
                }
                break;
            case 8:
                if (actionTimer == 3)
                {
                    // image_index = 7;
                    action = 8.25;
                    image_index = 7;
                }
                break;
            case 8.25:
                if (actionTimer == 3)
                {
                    // image_index = 6;
                    action = 8.5;
                    image_index = 6;
                }
                break;
            case 8.5:
                if (actionTimer == 3)
                {
                    // image_index = 7;
                    action = 9;
                    image_index = 7;
                }
                break;
            case 9:
                if (actionTimer == 3)
                {
                    // image_index = 9
                    action += 1;
                    image_index = 9;
                    i = instance_create(x + 3 * image_xscale, y - 24,
                        objEnemyBullet);
                    with (i)
                    {
                        contactDamage = 2;
                        sprite_index = sprMumariaHead;
                        image_speed = 0.2;
                        image_xscale = other.image_xscale;
                        depth = other.depth - 1;
                        if (instance_exists(other.target))
                        {
                            move_towards_point(other.target.x, other.target.y,
                                2);
                        }
                        else
                        {
                            move_towards_point(x + 48 * image_xscale, y, 2);
                        }
                        direction = round(direction / 45) * 45;
                        if (direction == 90)
                        {
                            direction += -45 * other.image_xscale;
                        }
                        if (direction == 270)
                        {
                            direction += 45 * other.image_xscale;
                        }
                        if (direction == 225)
                        {
                            direction -= 22.5;
                        }
                        if (direction == 315)
                        {
                            direction += 22.5;
                        }
                    }
                }
                break;
            case 10:
            case 11:
            case 12:
                if (actionTimer == 5)
                {
                    action += 1;
                    image_index += 1;
                }
                break;
            case 13:
                if (actionTimer == 80)
                {
                    action += 1;
                    image_index += 1;
                }
                break;
            case 14:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index += 1;
                }
                break;
            case 15:
                if (actionTimer == 6)
                {
                    action += 1;
                    image_index += 1;
                }
                break;
            case 16:
                if (actionTimer == 6)
                {
                    action = 1;
                    image_index = 1;
                }
                break;
        }
        if (iaction != action)
        {
            actionTimer = 0;
        }
    }

    contactDamage = mypower * (image_index != 1);
}
else if (dead)
{
    actionTimer = 0;
    action = 1;
    image_index = 1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index >= 5 && image_index <= 13)
{
    exit;
}

other.guardCancel = 2;
