#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A Metall on treads with a shield. Once the treads are destroyed, charged Mega Buster shots
// are needed to knock the shield back while it fires arcing shots.

event_inherited();

healthpointsStart = 3;
contactDamage = 8;

category = "mets, shielded";
facePlayerOnSpawn = true;
itemDrop = -1;

imgIndex = 0;
imgSpd = 0.1;
moveTimer = 120;
phase = 0;
switchSprites = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    moveTimer--;
    switch (phase)
    {
        case 0:
            if (moveTimer <= 0)
            {
                imgIndex += imgSpd;

                if (imgIndex == 2)
                {
                    phase = 1;
                    moveTimer = 180;
                }
            }
            break;
        case 1:
            if (moveTimer <= 0)
            {
                imgIndex -= imgSpd;

                if (imgIndex == 0)
                {
                    phase = 0;
                    moveTimer = 180;
                }
            }
            break;
    }

    // Movement - turn around when touching wall
    if (xcoll != 0)
    {
        image_xscale *= -1;
    }

    // Movement
    if (ground)
    {
        xspeed = 0.5 * image_xscale;

        // Turn when at edge
        if (!positionCollision(x + 14 * image_xscale, bbox_bottom + 2))
        {
            image_xscale *= -1;
        }
    }

    // Animation
    switchSprites--;

    if (switchSprites < 0)
    {
        if (sprite_index == sprHellMetallDX)
        {
            sprite_index = sprHellMetallDXUp;
        }
        else
        {
            sprite_index = sprHellMetallDX;
        }

        switchSprites = 4;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0;
    imgSpd = 0.1;
    moveTimer = 120;
    sprite_index = sprHellMetallDX;
    phase = 0;
    switchSprites = 4;
}

image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

i = instance_create(x, y - 1, objHellMetallDX2);
i.yspeed = -2;

if (other.object_index == objBreakDash)
{
    with (objSlashEffect)
    {
        sprite_index = sprHellMetallDXTreads;
        if (other.sprite_index == sprHellMetallDX)
        {
            image_index = 0;
        }
        else
        {
            image_index = 1;
        }
    }
}
else if (other.object_index == objBusterShotCharged)
{
    with (other)
    {
        instance_destroy();
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((image_index == 0) && (collision_rectangle(x + 10 * image_xscale, y, x + 13 * image_xscale, y - 28, other.id, false, true)))
{
    other.guardCancel = 1;
}
