#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// creation code (all optional)
// maxSpeed = <positive number> (sets how fast the sled goes)
image_speed = 0;
active = 0;
dead = false;
init = 1;

maxSpeed = 3;
xspeed = 0;
yspeed = 0;
viewX = view_xview[0];
roundAlt = false;
playerProjectiles = ds_list_create(); // to keep track of which projecitles have been speed increased

// vehicle vars
rider = noone;
weaponsAllowed = true;
riderPhysicsAllowed = true;
shootYOffset = 5;
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ds_list_destroy(playerProjectiles);
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen && (insideView() || active))
{
    if (init)
    {
        init = 0;
        if (!place_meeting(x, y, object_index)) // co-op: spawn additional
        {
            for (var i = 1; i < global.playerCount; i += 1)
            {
                with (instance_create(x + 4 * i * dir, y, object_index))
                {
                    init = 0;
                    image_xscale = other.image_xscale;
                    maxSpeed = other.maxSpeed;
                }
            }
        }
    }

    // activate stuff
    if (!active)
    {
        with (objMegaman)
        {
            with (other)
            {
                // deactivate again since it's unused
                if (!insideSection(x, y))
                {
                    instance_deactivate_object(id);
                    exit;
                }

                // if on the middle of the sled
                if (!instance_exists(other.vehicle))
                {
                    if (place_meeting(x, y, other)
                        && round(other.x / 2) * 2 == round(x))
                    {
                        other.viewPlayer = 0;
                        if (image_xscale != 0)
                        {
                            other.image_xscale = image_xscale;
                        }

                        rider = other.id;
                        active = true;
                        image_speed = 1;
                        viewX = view_xview[0];
                    }
                    else
                    {
                        if (abs(x - (view_xview[0] + view_wview[0] * 0.5)) < 3)
                        {
                            with (other)
                            {
                                viewPlayer = 0;
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        if (!dead)
        {
            var accel = 0.05;

            // change speeds
            if (abs(xspeed) < maxSpeed)
            {
                xspeed += accel * image_xscale;
            }
            else if (abs(xspeed) > maxSpeed)
            {
                xspeed -= accel * image_xscale;
            }

            // speed up new player projectiles
            if (insideView())
            {
                var i;
                for (i = 0; i < instance_number(prtPlayerProjectile); i += 1)
                {
                    proj = instance_find(prtPlayerProjectile, i);
                    exception = false;
                    if (proj.object_index == objJewelSatellite)
                    {
                        if (proj.followPlayer)
                        {
                            exception = true; // because any speed would be immediately overwritten if still following the player
                        }
                    }
                    if (ds_list_find_index(playerProjectiles, proj) == -1
                        && !exception)
                    {
                        proj.xspeed += xspeed;
                        added = false;
                        var j;
                        for (j = 0; j < ds_list_size(playerProjectiles); j += 1)
                        {
                            if (!instance_exists(ds_list_find_value(playerProjectiles, j)))
                            {
                                ds_list_replace(playerProjectiles, j, proj);
                                added = true;
                            }
                        }
                        if (!added)
                        {
                            ds_list_add(playerProjectiles, proj);
                        }
                    }
                }
            }
            if (instance_exists(rider)) // sled controls
            {
                if (image_xscale == 1)
                {
                    x = ceil(rider.x - accel);
                }
                else
                {
                    x = floor(rider.x - accel);
                }

                y = rider.y + 15 * rider.image_yscale; // automatically place itself under Mega Man
                image_yscale = rider.image_yscale;

                // animation
                if (rider.isSlide)
                {
                    // slide
                    rider.spriteX = 11;
                    rider.spriteY = 0;
                }
                else
                {
                    // idle / shoot (mega man should not go into the jump animation when jumping since he's still standing on the sled)
                    rider.spriteX = 0;
                    rider.spriteY = rider.isShoot;
                }

                // movement
                with (rider)
                {
                    vehicle = other.id;
                    shiftObject(other.xspeed, 0, true);
                    if (xDir != 0)
                    {
                        image_xscale = xDir;
                    }
                }

                // Stop the sled
                if (instance_exists(objMegaman8SledStopper))
                {
                    with (objMegaman8SledStopper)
                    {
                        if ((other.bbox_left > bbox_left && other.image_xscale == 1)
                            || (other.bbox_right > bbox_right && other.image_xscale == -1))
                        {
                            with (other)
                            {
                                dead = true;
                                with (rider)
                                {
                                    if (yspeed >= 0)
                                    {
                                        yspeed = -3;
                                    }

                                    viewPlayer = 1;
                                }
                            }
                        }
                    }
                }

                // scroll screen (since the view can't have decimal positions, we have to keep track of sub pixels ourself)
                // viewX = clamp(viewX + xspeed, global.sectionLeft, global.sectionRight - view_wview[0]);
                // view_xview[0] = round(viewX);

                // global.prevXView = round(clamp(global.prevXView + xspeed, global.sectionLeft, global.sectionRight - view_wview));
                global.cachedXView = round(clamp(global.cachedXView + xspeed, global.sectionLeft, global.sectionRight - view_wview));
            }
            else
            {
                dead = true;
            }
        }
        else
        {
            // fly off the screen after Mega Man gets off
            yspeed += 0.05;
            visible = !visible;
            x += xspeed;
            y += yspeed;
        }
    }
}
else if (dead)
{
    instance_destroy();
}
