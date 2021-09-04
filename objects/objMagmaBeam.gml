#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

faction = 4;

grav = 0;

respawn = false;

blockCollision = false;

iceTimer = false;

respawnRange = -1;
despawnRange = -1;

timer = 0;

isFrozen = 0;

parent = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!isFrozen)
    {
        var cost; cost = cos(degtorad(image_angle * sign(image_yscale) - 90));
        var sint; sint = sin(degtorad(image_angle * sign(image_yscale) - 90 * sign(image_yscale)));

        if (instance_exists(objMegaman)) // Sparkle effect
        {
            if (instance_number(objMagmaBeamParticle) < 2)
            {
                var side;
                var _x; _x = x;
                var _y; _y = y;
                var fpcount; fpcount = 0;
                var spcount; spcount = 0;

                with (objMagmaBeamParticle)
                {
                    if (startYspeed == -2.5)
                    {
                        fpcount += 1;
                    }
                    else if (startYspeed == -1.75)
                    {
                        spcount += 1;
                    }
                }

                with (objMegaman)
                {
                    if (other.image_angle == 180 || other.image_angle == 0)
                    {
                        side = sign(x - other.x);
                    }
                    else
                    {
                        var x1; x1 = other.x;
                        var y1; y1 = other.y;
                        var x2; x2 = other.x + 8 * cost;
                        var y2; y2 = other.y - 8 * sint;

                        side = sign(((x2 - x1) * (y - y1)) - ((x - x1) * (y2 - y1)));

                        var angle; angle = other.image_angle + 90;
                        if (angle > 360)
                        {
                            angle -= 360;
                        }
                        if (angle < 180)
                        {
                            side *= -1;
                        }
                    }

                    if (side > 0)
                    {
                        _x = bbox_left - 4;
                    }
                    else
                    {
                        _x = bbox_right + 4;
                    }

                    _y = bbox_bottom - 10;

                    if (collision_rectangle(bbox_left - 4, bbox_top + 8, bbox_right + 4, bbox_bottom, other, true, false))
                    {
                        with (other)
                        {
                            if (spcount == 0)
                            {
                                var i; i = instance_create(_x, _y, objMagmaBeamParticle);
                                i.dir = side;
                                i.yspeed = -1.75;
                                i.grav = 0.05;
                                i.image_speed = 0.2;
                            }

                            if (fpcount == 0)
                            {
                                var i; i = instance_create(_x, _y, objMagmaBeamParticle);
                                i.dir = side;
                                i.yspeed = -2.5;
                                i.image_speed = 0.35;
                            }
                        }
                    }
                }
            }
        }

        timer -= 1;

        if (timer <= 0) // fall (final)
        {
            y -= 8 * sint;
            x += 8 * cost;

            if ((y > global.sectionBottom + 16)
                || (y <= global.sectionTop - 16)
                || (x > global.sectionRight + 16)
                || (x < global.sectionLeft - 16))
            {
                instance_destroy();
            }
        }
        else // descend (initial)
        {
            image_yscale += 0.5 * sign(image_yscale);

            // collision_line(x - sint * 15 * i, y + cost * 15 * i, x - sint * 15 * i + abs(image_yscale) * 16 * cost, y + cost * 15 * i - sint * 16 * abs(image_yscale), objMegaman, false, fal
        }

        image_index = (timer div 6) mod 3;
        image_index += 6;
        image_index = image_index mod 3;

        isSolid = 0;
    }
    else
    {
        isFrozen-=1;

        if (instance_exists(parent))
        {
            with (parent)
            {
                timer-=1;
            }
        }
    }
}

contactDamage = 28 * !isSolid;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

var i; for ( i = min(1.5, abs(image_yscale / 3)); i < abs(image_yscale); i += 3)
{
    playSFX(sfxMM3Explode);
    with (instance_create(x, y, objBigExplosion))
    {
        direction = other.image_angle - 90;
        rotationMovement(x, y, i * 16, 0);
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!isFrozen)
{
    other.guardCancel = 2;

    if (other.object_index == objIceWall || other.object_index == objConcreteShot
        || other.object_index == objIceSlasher)
    {
        isFrozen = 240;
        isSolid = 1;

        with (other)
        {
            event_user(EV_DEATH);
        }
    }
}
else
{
    if (other.object_index != objLaserTrident)
    {
        other.guardCancel = 2;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var df; df = 0;
if (isFrozen)
{
    if (isFrozen > 64 || isFrozen mod 8 < 4)
    {
        df = 1;
    }
}

var cost; cost = cos(degtorad(image_angle * sign(image_yscale) - 90));
var sint; sint = sin(degtorad(image_angle * sign(image_yscale) - 90 * sign(image_yscale)));

var i; for ( i = 0; i < abs(image_yscale); i+=1)
{
    var disp; disp = i * 16;
    var drawY; drawY = y - disp * sint;
    var drawX; drawX = x + disp * cost;
    var smg; smg = 1;
    if (i == 0 && timer <= 0)
    {
        smg = 0;
    }
    if (i == ceil(abs(image_yscale)) - 1)
    {
        smg = 2;
    }
    var subimg; subimg = smg * 3 + image_index;

    if (df)
    {
        d3d_set_fog(true, make_color_rgb(0, 120, 255), 0, 0);
    }

    draw_sprite_ext(sprite_index, subimg, drawX, drawY, sign(image_xscale), sign(image_yscale), image_angle, c_white, 1);

    if (df)
    {
        d3d_set_fog(false, 0, 0, 0);
        draw_set_blend_mode(bm_add);
        draw_sprite_ext(sprite_index, subimg, drawX, drawY, sign(image_xscale), sign(image_yscale), image_angle, c_white, 1);
        draw_set_blend_mode(bm_normal);
    }
}
