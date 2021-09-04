#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

contactDamage = 3;
image_speed = 0.3;
reflectable = 0;

image_angle = 270;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    var d; d = instance_place(x, y, objFireWaveGoDirector);
    if (instance_exists(d))
    {
        if (image_angle != d.image_angle)
        {
            if (place_meeting(x - xspeed * 2, y - yspeed * 2, d))
            {
                shiftObject(d.x - x, d.y - y, 0);
                image_angle = d.image_angle;
            }
        }
    }

    xspeed = cos(degtorad(image_angle)) * 3;
    yspeed = -sin(degtorad(image_angle)) * 3;

    // special interaction
    with (objWaterShield)
    {
        if (place_meeting(x - other.xspeed, y - other.yspeed, other))
        {
            with (other)
            {
                instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
                instance_destroy();
            }
            playSFX(sfxEnemyHit);
            instance_create(x, y, objBubblePopEffect);
            instance_destroy();
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    if (image_angle == 90)
    {
        draw_sprite_ext(sprFireWaveVertical, -1, round(x), round(y), image_xscale, -image_yscale, 0, image_blend, image_alpha);
    }
    else if (image_angle == 270)
    {
        draw_sprite_ext(sprFireWaveVertical, -1, round(x), round(y), image_xscale, image_yscale, 0, image_blend, image_alpha);
    }
    else
    {
        draw_sprite_ext(sprite_index, -1, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}
