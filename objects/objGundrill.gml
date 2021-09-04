#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_yscale: -1 // set in editor! - if image_yscale is set to -1, then gundrill will come out of the cieling when you first encounter him rather than the floor.

event_inherited();
respawn = true;
doesIntro = false;
healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 6;
blockCollision = 0;
grav = 0;
facePlayerOnSpawn = true;
category = "bulky, flying, rocky";

despawnRange = -1;
delayDisplay = 2;
child = noone;
startMoving = false;


realX = x;
realY = y;
offsetX = 0;
prepareCollision = false;

// Enemy specific code
image_speed = 0;
image_index = 0;
phase = -1;
attackTimer = 0;
attackTimerMax = 8;
animTimer = 0;
setY = 0;
shotsFired = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (delayDisplay > 0)
    {
        delayDisplay-=1;
    }
    dir = image_xscale; // since mini bosses have weird direction code, force the direction here.
    image_index += 0.25;

    // these two variables are used temporarily later.
    var offYU;
    var offYD;
    if (image_yscale == 1) // this determines the collision box for gundrill later.
    {
        offYU = 16;
        offYD = 0;
    }
    else
    {
        offYU = 0;
        offYD = 16;
    }

    switch (phase)
    {
        case -1: // initalization
            var i; for ( i = 0; i < view_hview; i+=1) // find the nearest floor or cieling
            {
                y += sign(image_yscale);
                delayDisplay = 2;
                if (collision_rectangle(x - 16, y - 16, x + 16, y + 16, objSolid, false, true))
                {
                    y += 32 * image_yscale; // embed self into floor or cieling.
                    var cover; cover = instance_create(x - 16, y - 16, objGundrillCover); // create coverup - this coverup uses the graphics from the tiles beneath it.
                    cover.parent = id;
                    child = cover.id;
                    attackTimer = 0;
                    shotsFired = 0;
                    facePlayer = true;
                    phase = 0;

                    if (image_yscale == -1)
                    {
                        child.ceilOrFloor = 1;
                    }
                    break;
                }
            }
            break;
        case 0: // drill from rocks
            facePlayer = false;
            var upDown;
            if (instance_exists(child)) // since the coverup object's y position is at its 0 point, to make things easier we store whether or not we need to offset things by 32 pixels or not.
            {
                if (child.ceilOrFloor == 0)
                {
                    upDown = 0;
                }
                else
                {
                    upDown = 32;
                }
            }
            attackTimer+=1;
            if (place_meeting(x, y, child) && attackTimer mod 4 == 0 && (shotsFired < 2)) // create tell
            {
                instance_create(x - 3 + irandom(6), child.y + (upDown) - (3 + irandom(3)), objExplosion);
            }
            if (attackTimer mod 32 == 31 && (shotsFired < 2)) // create debry
            {
                playSFX(sfxCompactor);
                var i; for ( i = 0; i < 5; i+=1)
                {
                    if (i != 2) // gundrill does not create a "middle" projectile
                    {
                        var inst; inst = instance_create(x, child.y + upDown, objGundrillRock);
                        inst.xspeed = -1.5 + i * 0.75;
                        if (child.ceilOrFloor == 1) // if creating from the cieling, there should be no initial vertical momentum
                        {
                            inst.yspeed = 0;
                        }
                    }
                }
                shotsFired+=1;
            }
            if (shotsFired == 2)
            {
                startMoving = true;
            }
            if (startMoving && attackTimer >= 80)
            {
                if (instance_exists(child))
                {
                    if (collision_rectangle(x - 16, y - 16, x + 16, y + 16, child, false, true))
                    {
                        offsetX = -2 + irandom(4);
                        x = realX + offsetX;
                        if (startMoving)
                            yspeed = -image_yscale * 0.5;
                    }
                    else
                    {
                        yspeed = -image_yscale * 1;
                        x = realX;
                        offsetX = 0;
                        if (prepareCollision == 0)
                        {
                            prepareCollision = 1;
                        }
                        with (child) // delay the death of child object to prevent it from being destroyed too early
                        {
                            if (deathTimer <= 0)
                            {
                                instance_destroy();
                            }
                        }
                    }
                }

                if (collision_rectangle(x - 16, y - offYU, x + 16, y + offYD, objSolid, false, true) && prepareCollision == 1) // create coverup object when gundrill hits the opposite side
                {
                    prepareCollision = 2;
                    shotsFired = 0; // reset shots fired so gundrill can create more projectiles after its crossed the screen.

                    var cover; cover = instance_create(x - 16, y - 16 + (-32 * image_yscale), objGundrillCover);
                    cover.parent = id;
                    child = cover.id;
                    if (image_yscale == 1)
                    {
                        child.ceilOrFloor = 1;
                    }
                }
                if (instance_exists(child)) // when gundrill is in place, change phase
                {
                    if (prepareCollision >= 2 && ((y <= child.y + 16 && image_yscale == 1) || y >= child.y + 16 && image_yscale == -1))
                    {
                        prepareCollision = 0;
                        yspeed = 0;
                        setY = child.y + 16;
                        y = setY;
                        phase = 1;
                    }
                }
            }
            break;
        case 1: // change places!! - randomise the location of gundrill
            delayDisplay = 99999; // renders gundrill invisible and invincible during this entire time
            canHit = false;
            contactDamage = 0;
            var oldMask; oldMask = mask_index;
            mask_index = mskGunDrillBox; // since gundrill's actual mask is smaller than the collisiion block, temporarily change it.

            // we find how far away the left side of the screen is, and how far away the right side of the screen is.
            var left; left = 0;
            var right; right = 0;
            var i; for ( i = 0; i < view_wview / 16; i+=1)
            {
                y = setY + 40 * image_yscale;
                x = realX - i * 16;
                if (collision_rectangle(x - 16, y - 8, x + 16, y + 8, objSolid, false, true))
                {
                    left = ceil(i / 2) - 1;
                    break;
                }
            }
            var i; for ( i = 0; i < view_wview / 16; i+=1)
            {
                y = setY + 40 * image_yscale;
                x = realX + i * 16;
                if (collision_rectangle(x - 16, y - 8, x + 16, y + 8, objSolid, false, true))
                {
                    right = floor(i / 2) - 1;
                    break;
                }
            }
            x = realX;
            y = setY;

            // randomise location
            var nextPos; nextPos = 0;
            var i; for ( i = 0; i < 256; i+=1) // we do a for loop rather than a while loop as a sort of idiot proofing.
            {
                if (nextPos == 0) // make sure gundrill has actually moved
                {
                    nextPos = -left;
                    nextPos += irandom(left + right);
                }
                else
                {
                    break;
                }
            }

            // set gundrill to its new position and flip its graphics
            realX += nextPos * 32;
            x = realX;
            image_yscale *= -1;
            mask_index = oldMask;
            phase = 2;
            break;
        case 2: // setup code for changed direction
            with (child) // destroy old coverup and create a new coverup at the gundrill's latest location
            {
                instance_destroy();
            }
            var cover; cover = instance_create(x - 16, y - 16, objGundrillCover);
            cover.parent = id;
            child = cover.id;
            if (image_yscale == -1)
            {
                child.ceilOrFloor = 1;
            }
            shotsFired = 0;
            attackTimer = -64;
            delayDisplay = 2;
            phase = 3;
            break;
        case 3: // wait before moving
            facePlayer = true;
            attackTimer+=1;
            if (attackTimer >= 0) // reset variables and continue fight!
            {
                canHit = true;
                contactDamage = 6;
                phase = 0;
            }
            break;
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    canHit = true;
    contactDamage = 6;
    attackTimer = 0;
    phase = -1;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
facePlayerOnSpawn = false;
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((image_yscale == 1 && (bboxGetYCenterObject(other.id) < y - 8))
    ||
    (image_yscale == -1 && (bboxGetYCenterObject(other.id) > y + 8)))
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase != -1 && delayDisplay == 0)
    event_inherited();
