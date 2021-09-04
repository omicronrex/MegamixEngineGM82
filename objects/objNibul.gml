#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, nature";
grav = 0;

blockCollision = 0;
facePlayerOnSpawn = true;

// Enemy Specific Code
moveTimer = 120;
phase = 0;
init = 1;

// @cc - Sets Nibul's sprite: 0 = Nibul, 1 = Jupibul
col = 0;

targX = 0;
targY = 0;
toxin = false;
imgIndex = 0;
imgSpd = 0.5;
toxinTimer = 0;
drawTimer = 4;
animBack = false;
cosCounter = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init)
{
    init = 0;
    switch (col)
    {
        case 1:
            sprite_index = sprJupibul;
            break;
        default:
            sprite_index = sprNibul;
            break;
    }
}

if (entityCanStep())
{
    // Animation
    if (animBack == false)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 3)
        {
            imgIndex = 1;
            animBack = true;
        }
    }
    else
    {
        imgIndex -= imgSpd;
        if (imgIndex < 0)
        {
            imgIndex = 1;
            animBack = false;
        }
    }

    // Movement
    if (instance_exists(target))
    {
        switch (phase)
        {
            case 0:
                moveTimer-=1;
                if (moveTimer > 0)
                {
                    calibrateDirection();

                    cosCounter += .135;
                    yspeed = -(cos(cosCounter) * 0.5);
                }

                if (moveTimer <= 0)
                {
                    if (moveTimer == 0)
                    {
                        targX = target.x;
                        targY = target.y;
                    }

                    moveTowardPoint(targX, targY, 3);

                    if (distance_to_point(targX, targY) < 3) // else
                    {
                        yspeed = -2;
                        xspeed = 0;
                        phase = 1;
                    }

                    if (place_meeting(x, y, target))
                    {
                        if (!target.canHit)
                        {
                            yspeed = -2;
                            xspeed = 0;
                            phase = 1;
                        }
                        toxin = true;
                    }
                }
                break;
            case 1:
                if (bbox_top <= view_yview)
                {
                    calibrateDirection();

                    yspeed = 0;
                    moveTimer = 120;
                    phase = 0;
                    targX = 0;
                    targY = 0;
                }
                break;
        }

        // Toxin effects
        if (toxin == true)
        {
            with (target)
            {
                // if there is no status effect object for current player, create one.
                if (!instance_exists(statusObject))
                {
                    statusObject = instance_create(x, y, objStatusEffect);
                }
                else
                {
                    statusObject.statusWalkSpeed = 1.3 / 2;
                    statusObject.statusChangedWalk = true;
                    statusObject.statusJumpSpeed = 4.75 / 2;
                    statusObject.statusChangedJump = true;
                    gravfactor = 0.25;
                    if (isHit)
                    {
                        gravfactor = 1;
                    }
                }
            }

            drawTimer-=1;
            if (drawTimer == 0)
            {
                if (target.inked == false)
                {
                    target.inked = true;
                }
                else
                {
                    target.inked = false;
                }
                drawTimer = 4;
            }

            toxinTimer+=1;
            if (toxinTimer == 360)
            {
                toxinTimer = 0;
                toxin = false;
                with (target)
                {
                    if (instance_exists(statusObject))
                    {
                        statusObject.statusChangedWalk = false;
                        statusObject.statusChangedJump = false;
                        gravfactor = 1;
                    }
                }
                target.inked = false;
                drawTimer = 4;
            }
        }
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    image_index = 0;
    phase = 0;
    moveTimer = 120;
    targX = 0;
    targY = 0;
    if (instance_exists(target))
    {
        with (target)
        {
            inked = false;

            if (instance_exists(statusObject))
            {
                statusObject.statusChangedWalk = false;
                statusObject.statusChangedJump = false;
                gravfactor = 1;
            }
        }
    }
    toxin = false;
    toxinTimer = 0;
    animBack = false;
    drawTimer = 4;
    cosCounter = 0;
}
image_index = imgIndex div 1;
