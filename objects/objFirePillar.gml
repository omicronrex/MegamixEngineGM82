#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;
isTargetable = false;

init = 1;
image_speed = 0.25;
y += sprite_height;

alarmRise = 0;
rise = true;
init = true;

freezeTimer = 0;
preImgSpeed = 0.25;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// initial setup
if (init)
{
    init = false;
    y += sprite_height;
    spriteWidth = sprite_get_width(sprite_index);
    spriteHeight = sprite_get_height(sprite_index);
}

// actual step code
if (entityCanStep())
{
    healthpoints = 1;

    if (freezeTimer > 0)
    {
        // freeze control
        freezeTimer -= 1;

        if (freezeTimer == 1)
        {
            isSolid = 0;
            if sprite_index == sprFirePillarFrozen
            {
                sprite_index = sprFirePillar;
                image_speed = 0.25;
            }
        }
    }
    else
    {
        // actual bobbing up and down
        alarmRise += 1;
        if (alarmRise >= 40)
        {
            if (rise)
            {
                y -= 2;
                if (y <= ystart)
                {
                    rise = !rise;
                    alarmRise = 0;
                    y = ystart;
                }
            }
            else
            {
                y += 2;
                if (y >= ystart + spriteHeight && !rise)
                {
                    rise = !rise;
                    alarmRise = 0;
                }
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top + (sprite_height + (ystart - y)), other.id, false, false))
{
    // freeze pillar
    if (other.object_index == objIceWall || other.object_index == objIceSlasher)
    {
        freezeTimer = 240;
        isSolid = 1;
        image_speed = 0;

        if (sprite_index == sprFirePillar)
        {
            sprite_index = sprFirePillarFrozen;
        }

        playSFX(sfxEnemyHit);
    }

    with (other)
    {
        if (pierces == 0 || pierces == 1)
        {
            event_user(EV_DEATH);
            playSFX(sfxEnemyHit);
        }
    }
}

// only Rain Flush can stop fire....even if it's invisible......
if (other.object_index != objRainFlush)
{
    other.guardCancel = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    draw_sprite_part(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), max(0, sprite_get_height(sprite_index) + (ystart - y)), x, y);
    image_yscale = 1/spriteHeight;
    image_yscale *= max(0, sprite_get_height(sprite_index) + (ystart - y));
}
