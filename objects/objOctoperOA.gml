#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = true;
doesIntro = false;

healthpointsStart = 20;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "aquatic, bulky";

blockCollision = 0;
grav = 0;

// Enemy specific code
dir = image_xscale;
xspeed = 0;
moveDelay = 0;
yOffset = 80;
yOffsetMax = 80;

// AI and animation variables
turnRoundLeft = 0;
turnRoundRight = 0;
delay = 0;
xscaleStorage = 0;
imageTimer = 1;

leftStuck = false;
rightStuck = true;

turnerTimerL = 0;
turnerTimerR = 0;
detectorL = noone;
detectorR = noone;
detectorM = noone;

//store variable differences between octoper and octoboss, and any custom octoper parented off this one
detectorXOffset = 56;
detectorYOffset = 56;
detectorMOffset = 72;
detectorMXOffset = 56;
spdY = 1;
detectorMXScale = 7;
detectorMYScale = 8;
turnRoundLong = 128;
turnRoundShort = 64;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // move y.
    if (healthpoints > 10 || object_index != objOctoboss)
        yOffset += yspeed;
    else if (healthpoints <= 10)
        yOffset += yspeed * 2;
    y = ystart + yOffset;

    if (!instance_exists(detectorL)) // since octoper likes to spend its time embedded in the ground, standard collision detection won't work, so we create a batch of other objects to go with it.
    {
        detectorL = instance_create(x-56,y+64-yOffset,objOctoperDetector);
        detectorL.parent = id;
    }
    else
    {
        detectorL.x = x-detectorXOffset;
        detectorL.y = y+detectorYOffset-yOffset;

    }
    if (!instance_exists(detectorR))
    {
        detectorR = instance_create(x+40,y+64-yOffset,objOctoperDetector);
        detectorR.parent = id;
    }
    else
    {
        detectorR.x = x+(detectorXOffset-16);
        detectorR.y = y+detectorYOffset-yOffset;
    }
    if (!instance_exists(detectorM))
    {
        detectorM = instance_create(x-56,ystart,objOctoperDetector);
        detectorM.parent = id;
        detectorM.image_xscale = detectorMXScale;
        detectorM.image_yscale = detectorMYScale;
    }
    else
    {
        detectorM.x = x-detectorMXOffset;
        detectorM.y = ystart-detectorMOffset;
    }


    // activate octoper.
    if (xscaleStorage == 0)
    {
        xspeed = 0;
        if (instance_exists(target))
        {
            xscaleStorage = target.x - x;

        }
        if (xscaleStorage != 0)
            xspeed = image_xscale;
    }


    // set reflection properties.
    if (xscaleStorage < 0)
    {
        turnRoundLeft = turnRoundLong;
        turnRoundRight = turnRoundShort;
    }
    else
    {
        turnRoundLeft = turnRoundShort;
        turnRoundRight = turnRoundLong;
    }

    // if boss hits a background block, turn around.
    with (detectorM)
    {
        if (checkSolid(other.xspeed,0))
        {
            var midD; midD = true;
        }
        else
            var midD; midD = false;
    }
    if (midD && xspeed != 0)
    {
        /*if (xspeed < 0)
            x = mySolid.x + (16 * mySolid.image_xscale) + (x - (bbox_left - 1));
        else
            x = mySolid.x - (bbox_right + 1 - x) - 1;*/

        xspeed = -xspeed;
    }

    // check whether or not octoper would move off a platform. if so turn around.
    with (detectorR)
    {
        if (!checkSolid(0,0)  && !place_meeting(x,y,objWater))
        {
            var rightD; rightD = true;
        }
        else
            var rightD; rightD = false;
    }

    if ((rightD && xspeed > 0))
    {
        xspeed = -1;
        delay = 2;
        rightStuck = true;

    }

    with (detectorL)
    {
        if (!checkSolid(0,0)  && !place_meeting(x,y,objWater))
        {
            var leftD; leftD = true;
        }
        else
            var leftD; leftD = false;
    }

    if ((leftD && xspeed < 0))
    {
        xspeed = 1;
        delay = 2;
        leftStuck = true;

    }

    // if octoper reaches a screen edge, turn round.
    if (x >= view_xview + view_wview - turnRoundRight && delay == 0 && xscaleStorage != 0)
    {
        xspeed = -1;
        delay = 1;
        rightStuck = true;
    } // see above
    else if (x <= view_xview + turnRoundLeft && delay == 0 && xscaleStorage != 0)
    {
        xspeed = 1;
        delay = 1;
        leftStuck = true;
    }
    else
        delay = 0;

    // bob up and down
    if (yOffset >= yOffsetMax)
        yspeed = -spdY;

    if (yOffset <= 0)
    {
        yspeed = spdY;
        if (instance_exists(target))
        {
            if (object_index != objOctoboss)
                instance_create(x + 37 * image_xscale, y + 40, objOctoperOABullet1);
            else
                instance_create(x + 16 * image_xscale, y + 20, objOctobossBullet);
        }
    }

    // move timer.
    if (xspeed != 0)
        moveDelay += 1;

    // in mega man 5, octoper moves 1 pxiel every 3 frames. this replicates that.
    if (moveDelay != 0)
    {
        x -= xspeed;
    }


    if (object_index != objOctoboss)
    {
        if (moveDelay == 3)
            moveDelay = -1;
    }
    else
    {
        if (moveDelay == 3 && healthpoints > 10)
            moveDelay = -1;
        if (moveDelay >= 1 && healthpoints <= 10)
            moveDelay = -1;
    }
}
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.y <= y + 64 - yOffset)
{
    event_inherited();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
b = bboxGetYCenterObject(other.id);
if (!collision_rectangle(x, y,
    x + ((bbox_right - bbox_left) / 2) * image_xscale, y - 16, other.id,
    false, false))
{
    other.guardCancel = 3;
}

if (b >= bbox_bottom - yOffset)
{
    guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn/Despawn
event_inherited();
if(spawned)
{
    xscaleStorage = 0;
    image_index = 0;
    xspeed = 0;
    yspeed = -1;
    yOffset = yOffsetMax;
    imageTimer = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(!spawned)
    exit;
if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

// makes octoper face its spawned direction, regardless of other scripts.
if (xscaleStorage <= 0)
{
    image_xscale = 1;
    draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width,
        sprite_height - yOffset, round(x - 56) + sprite_width,
        round(y - 64), -image_xscale, image_yscale, image_blend,
        image_alpha);
    image_xscale = -1;
}
else
{
    image_xscale = 1;
    draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width,
        sprite_height - yOffset, round(x - 56), round(y - 64),
        image_xscale, image_yscale, image_blend, image_alpha);
}

if (imageTimer == 1)
{
    y = ystart + yOffset;
    imageTimer = 0;
}

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
