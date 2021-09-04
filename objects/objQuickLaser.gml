#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

canHit = false;

image_speed = 0.25;

despawnRange = -1;

contactDamage = 28;
faction = 4;

variation = 0;
mySpeed = 5;
drainCooldown = 4;

solidList = ds_list_create();
lastXScale = image_xscale;
pauseStep = false;
pauseEndStep = true;

myPixel = -1;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_list_destroy(solidList);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xspeed = 0;
yspeed = 0;
speed = 0;

/* notes:
    - Angles are done by objQuickLaserSpawner setting this object's image_angle. And damage collision with rotation is done with Game Maker
        precise collision checking.
    - I'm multiplying and diving image_xscale by sprite_get_width(sprite_index) to convert image_xscale to and from distance in pixels
    - The polar coordinates and cartesian coordinates of GMS are misaligned from each other, so you have to multiply -1 to your x / y stuff to make it work
    - Also get ready for a bunch of trig and algebra
*/

event_inherited();

if (entityCanStep())
{
    // cut down on processing by not doing the step when offscreen and stuck on the same block
    if (bbox_right >= view_xview[0] && bbox_left <= view_xview[0] + view_wview[0] && bbox_bottom >= view_yview[0] && bbox_top <= view_yview[0] + view_hview[0])
    {
        // if in view again, unpause the step code
        pauseStep = false;
    }

    if (pauseStep)
    {
        exit;
    }

    // travel
    image_xscale = image_xscale + (mySpeed / sprite_get_width(sprite_index));

    // collision + retract (beware: resource intensive)
    checkTopSolids = (image_angle > 180 && image_angle < 360);

    step = 8; // increasing by this amount as to cut down on processing

    if (myPixel != -1)
    {
        // only 1 pixel tall, so just detect the one line
        step = sprite_get_height(sprite_index) + 1;
    }

    for (var i = 0; i <= sprite_get_height(sprite_index); i += step)
    {
        // get line coordinates
        x1 = x + i * cos(degtorad(image_angle - 90)); // go down the height of the laser (subtracts because the way angle increases is misaligned with the coordinate plane in game maker (increasing swings negative first))
        y1 = y - i * sin(degtorad(image_angle - 90)); // go down the height of the laser
        x2 = x1 + (image_xscale * sprite_get_width(sprite_index)) * cos(degtorad(image_angle)); // go down the length of the laser
        y2 = y1 - (image_xscale * sprite_get_width(sprite_index)) * sin(degtorad(image_angle)); // go down the length of the laser (subtracts because the way angle increases is misaligned with the coordinate plane in game maker (increasing swings negative first))

        // do collision check
        horM = (y2 - y1) / (x2 - x1); // slope of the collision line when solving for y
        verM = 1 / horM; // slope of the collision line when solving for x

        cx = noone;
        cy = noone;

        // section borders
        if (x2 < global.sectionLeft)
        {
            cx = global.sectionLeft;
        }

        if (x2 > global.sectionRight)
        {
            cx = global.sectionRight;
        }

        if (cx != noone)
        {
            // find the y position of the line at the given x position (bbox), and see if it's the shortest so far
            b = y1 - horM * x1; // y - mx = b
            cy = horM * cx + b; // y = mx + b

            if (cy > global.sectionTop && cy < global.sectionBottom)
            {
                newDist = point_distance(x1, y1, cx, cy);
                if (newDist / sprite_get_width(sprite_index) < image_xscale)
                {
                    image_xscale = newDist / sprite_get_width(sprite_index);
                }
            }
        }

        if (y2 < global.sectionTop)
        {
            cy = global.sectionTop;
        }

        if (y2 > global.sectionBottom)
        {
            cy = global.sectionBottom;
        }

        if (cy != noone)
        {
            // find the x position of the line at the given x position (bbox), and see if it's the shortest so far
            verM = (x2 - x1) / (y2 - y1); // slope of the line
            b = x1 - verM * y1; // x - my = b
            cx = verM * cy + b; // x = my + b

            if (cx > global.sectionLeft && cx < global.sectionRight)
            {
                newDist = point_distance(x1, y1, cx, cy);
                if (newDist / sprite_get_width(sprite_index) < image_xscale)
                {
                    image_xscale = newDist / sprite_get_width(sprite_index);
                }
            }
        }

        // get list of all collided objects
        if (instance_exists(objSolid))
        {
            with (objSolid)
            {
                c = collision_line(other.x1, other.y1, other.x2, other.y2, id, false, false);
                if (c != noone)
                {
                    ds_list_add(other.solidList, c);
                }
            }
        }

        if (instance_exists(objTopSolid))
        {
            with (objTopSolid)
            {
                c = collision_line(other.x1, other.y1, other.x2, other.y2, id, false, false);
                if (c != noone)
                {
                    ds_list_add(other.solidList, c);
                }
            }
        }

        if (instance_exists(prtEntity))
        {
            with (prtEntity)
            {
                if (id != other.id && !dead)
                {
                    c = collision_line(other.x1, other.y1, other.x2, other.y2, id, false, false);
                    if (c != noone && isSolid != 0) // only collide if this entity is solid
                    {
                        // don't do collisions with the spawner of this laser, or else we can get unwanted collisions
                        if (object_index != objQuickLaserSpawner)
                        {
                            ds_list_add(other.solidList, c);
                        }
                        else
                        {
                            if (ds_list_find_index(myLasers, other) == -1)
                            {
                                ds_list_add(other.solidList, c);
                            }
                        }
                    }
                }
            }
        }

        // find where the collision line first intersects each object's bbox, and use that to find the new xscale
        for (j = 0; j < ds_list_size(solidList); j++)
        {
            obj = ds_list_find_value(solidList, j);

            // topsolid check
            topSolid = false;
            if (object_is_ancestor(obj.object_index, prtEntity))
            {
                // top solid
                if (obj.isSolid == 2)
                {
                    topSolid = true;
                }
            }

            if (object_index == objTopSolid || object_is_ancestor(obj.object_index, objTopSolid))
            {
                topSolid = true;
            }

            // check x axis values of the bbox
            if (!topSolid)
            {
                cx = noone;
                cy = noone;

                if (x1 < obj.bbox_left) // don't take the collision if it's from the line coming out of the bbox
                {
                    cx = obj.bbox_left;
                }

                if (x1 > obj.bbox_right) // don't take the collision if it's from the line coming out of the bbox
                {
                    cx = obj.bbox_right;
                }

                if (cx != noone)
                {
                    // find the y position of the line at the given x position (bbox), and see if it's the shortest so far
                    b = y1 - horM * x1; // y - mx = b
                    cy = horM * cx + b; // y = mx + b

                    // if the collision point is within the range of the side, then it's valid
                    if (cy > obj.bbox_top && cy < obj.bbox_bottom)
                    {
                        if (collision_point(cx + cos(degtorad(image_angle)), cy - sin(degtorad(image_angle)), obj, true, false) != noone)
                        {
                            // if we collide a pixel into the bbox, then it's non-precise collision
                            newDist = point_distance(x1, y1, cx, cy);
                            if (newDist / sprite_get_width(sprite_index) < image_xscale)
                            {
                                image_xscale = newDist / sprite_get_width(sprite_index);
                            }
                        }
                        else
                        {
                            // if not, it's precise collision checking (resource intensive)
                            // check every point from the bbox contact until we run out of collision line, or hit something
                            foundCollision = false;
                            if (x1 < x2)
                            {
                                // laser is going right
                                for (cx = cx; cx < x2; cx++)
                                {
                                    if (collision_point(cx, cy, obj, true, false) != noone)
                                    {
                                        foundCollision = true;
                                        break;
                                    }

                                    cy += horM;
                                }
                            }
                            else
                            {
                                // laser is going left
                                for (cx = cx; cx > x2; cx--)
                                {
                                    if (collision_point(cx, cy, obj, true, false) != noone)
                                    {
                                        foundCollision = true;
                                        break;
                                    }

                                    cy -= horM;
                                }
                            }

                            if (foundCollision)
                            {
                                newDist = point_distance(x1, y1, cx, cy);
                                if (newDist / sprite_get_width(sprite_index) < image_xscale)
                                {
                                    image_xscale = newDist / sprite_get_width(sprite_index);
                                }
                            }
                        }

                        continue; // check next in the list
                    }
                }
            }

            // check y axis values of the bbox
            if (y1 < obj.bbox_top) // don't take the collision if it's from the line coming out of the bbox
            {
                cy = obj.bbox_top;
            }

            if (y1 > obj.bbox_bottom && !topSolid) // don't take the collision if it's from the line coming out of the bbox
            {
                cy = obj.bbox_bottom;
            }

            if (cy != noone)
            {
                // find the x position of the line at the given x position (bbox), and see if it's the shortest so far
                verM = (x2 - x1) / (y2 - y1); // slope of the line
                b = x1 - verM * y1; // x - my = b
                cx = verM * cy + b; // x = my + b

                // if the collision point is within the range of the side, then it's valid
                if (cx > obj.bbox_left && cx < obj.bbox_right)
                {
                    if (collision_point(cx + cos(degtorad(image_angle)), cy - sin(degtorad(image_angle)), obj, true, false) != noone)
                    {
                        // if we collide a pixel into the bbox, then it's non-precise collision
                        newDist = point_distance(x1, y1, cx, cy);
                        if (newDist / sprite_get_width(sprite_index) < image_xscale)
                        {
                            image_xscale = newDist / sprite_get_width(sprite_index);
                        }
                    }
                    else
                    {
                        // if not, it's precise collision checking (resource intensive)
                        // check every point from the bbox contact until we run out of collision line, or hit something
                        foundCollision = false;
                        if (y1 < y2)
                        {
                            // laser is going right
                            for (cy = cy; cy < y2; cy++)
                            {
                                if (collision_point(cx, cy, obj, true, false) != noone)
                                {
                                    foundCollision = true;
                                    break;
                                }

                                cx += verM;
                            }
                        }
                        else
                        {
                            // laser is going left
                            for (cy = cy; cy > y2; cy--)
                            {
                                if (collision_point(cx, cy, obj, true, false) != noone)
                                {
                                    foundCollision = true;
                                    break;
                                }

                                cx -= verM;
                            }
                        }

                        if (foundCollision)
                        {
                            // show_debug_message("found precise collision");
                            newDist = point_distance(x1, y1, cx, cy);
                            if (newDist / sprite_get_width(sprite_index) < image_xscale)
                            {
                                image_xscale = newDist / sprite_get_width(sprite_index);
                            }
                        }
                    }

                    continue; // check next in the list
                }
            }
        }

        ds_list_clear(solidList);
    }

    if (image_xscale < 0)
    {
        image_xscale = 0;
    }

    // if stuck on the same solid offscreen in the same position than disable the step code to cut down on processing
    if (image_xscale == lastXScale && (bbox_right < view_xview[0] || bbox_left > view_xview[0] + view_wview[0] || bbox_bottom < view_yview[0] || bbox_top > view_yview[0] + view_hview[0]))
    {
        pauseStep = true;
    }

    lastXScale = image_xscale;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* this is to prevent a fatal internal game maker studio error that can occur when the
image angle is set to certain diagonal up angles */
if (pauseEndStep)
{
    pauseEndStep = false;
    exit;
}

event_inherited();
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_list_destroy(solidList);
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// EV_ATTACK (Health draining)

event_inherited();

if (variation == 1)
{
    with (other)
    {
        if (object_index == objMegaman)
        {
            healthpoints = global.playerHealth[playerID];
            global.playerHealth[playerID] -= 1;
        }

        healthpoints -= 1;
        if (healthpoints <= 0)
        {
            event_user(EV_DEATH);
        }
        else
        {
            iFrames = other.drainCooldown;
            playSFX(sfxHit);
        }
    }

    global.damage = 0; // Overriding normal damage collision so there's no knockback
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// don't draw if not on screen to cut down on processing
if (bbox_right >= view_xview[0] && bbox_left <= view_xview[0] + view_wview[0] && bbox_bottom >= view_yview[0] && bbox_top <= view_yview[0] + view_hview[0])
{
    if (myPixel >= 0 || sprite_get_width(sprite_index) > 1)
    {
        var size = image_xscale * sprite_get_width(sprite_index);
        var img = size;
        var bit = 0;

        while (img > 0)
        {
            bit = min(sprite_get_width(sprite_index), img);

            if (myPixel == -1)
            {
                // entire laser
                draw_sprite_general(sprite_index, image_index, 0, 0, bit, sprite_height, x + (size - img) * cos(degtorad(image_angle)), y - (size - img) * sin(degtorad(image_angle)), 1, 1, image_angle, c_white, c_white, c_white, c_white, image_alpha);
            }
            else
            {
                // pixel high laser, as a result from having pixelPrecision turned on
                draw_sprite_general(sprite_index, image_index, 0, myPixel, bit, 1, x + (size - img) * cos(degtorad(image_angle)), y - (size - img) * sin(degtorad(image_angle)), 1, 1, image_angle, c_white, c_white, c_white, c_white, image_alpha);
            }

            img -= bit;
        }
    }
    else
    {
        // since a 1 wide laser sliver looks the same stretched, we can do this. Way less resource intensive
        draw_self();
    }
}
