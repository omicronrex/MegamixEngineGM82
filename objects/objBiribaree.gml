#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A pseudo Joe robot that uses electricity for a shield. For Piriparee (which does the
// same thing but actually looks like a Joe), set col to 1 in creation code.

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "joes";

facePlayerOnSpawn = true;

// Enemy specific code
shooting = false;
animTimer = 0;
bulletID = -10;

col = 0; // 0 = Biribareee; 1 = Piriparee;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 1:
            sprite_index = sprPiripareeJoe;
            break;
        default:
            sprite_index = sprBiribaree;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    animTimer += 1;
    if (image_index <= 1)
    {
        calibrateDirection();
    }

    if (((animTimer == floor(animTimer / 10) * 10 && animTimer < 60)
        || (animTimer == floor(animTimer / 4) * 4 && animTimer >= 60))
        && animTimer > 0)
    {
        if (animTimer < 60)
        {
            if (image_index == 0)
            {
                image_index = 1;
            }
            else
            {
                image_index = 0;
            }
        }
        else
        {
            if (image_index < 4 && image_index >= 2)
            {
                image_index += 1;
            }
            else
            {
                image_index = 2;
            }
        }
    }

    if (animTimer >= 120)
    {
        image_index = 5;
        bulletID = instance_create(x + 16 * image_xscale, y, objEnemyBullet);
        if (col)
            bulletID.sprite_index = sprPiripareeJoeBullet;
        else
            bulletID.sprite_index = sprBiribareeBullet;
        bulletID.xspeed = image_xscale * 2;
        bulletID.image_speed = 0.3;
        animTimer = 0;
    }
}
else if (dead)
{
    shooting = false;
    animTimer = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index >= 2 && image_index <= 4)
{
    other.guardCancel = 1;
}
