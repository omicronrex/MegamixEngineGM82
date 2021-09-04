#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A spawner for Furaibon.
event_inherited();
grav = 0;
canHit = false;
blockCollision = false;

// Enemy specific variables
col = 0; // SET IN CREATION CODE - 0 = purple, 1 = blue, 2 = red, 3 = yellow
spawnTimer = 120; // Time until next Furaibon is spawned
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
        if (abs(round(target.x) - x) <= 48)
        {
            if (spawnTimer == 120)
            {
                with (instance_create(x, y, objFuraibon))
                {
                    parent = other.id;
                    switch (other.col)
                    {
                        // Blue
                        case 1:
                            sprite_index = sprFuraibonBlue;
                            break;
                        // Red
                        case 2:
                            sprite_index = sprFuraibonRed;
                            break;
                        case 3:
                            sprite_index = sprFuraibonYellow;
                            break;
                        default:
                            sprite_index = sprFuraibonPurple;
                            break;
                    }
                }
                spawnTimer = 0;
            }
            else
            {
                spawnTimer+=1;
            }
        }
        else
        {
            spawnTimer = 120;
        }
    }
}
else if (dead)
{
    spawnTimer = 120;
}
