#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = true;
isTargetable = false;
healthpointsStart = 0;
itemDrop = -1;
contactDamage = 3;
xspeed = 0;
yspeed = 0;

animFrame = 0;
imgSpd = 0.16;
moveTimer = -1;
tackleFire = false; // Is it a Tackle Fire?
fireExists = false; // Has the fire made a Tackle Fire upon landing?
burnOut = false; // Does the fire burn out now?
canFlip = true;
blockCollision = false;
grav = 0;
isOnGround = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Step
event_inherited();

if (entityCanStep())
{
    if (tackleFire == false && !isOnGround)
    {
        if (checkSolid(0, yspeed) && !checkSolid(0, 0))
        {
            shiftObject(0, yspeed, true);
            yspeed = 0;
            isOnGround = true;
            ycoll = 1;
            animFrame = 4;
            calibrateDirection();
        }
    }
    else if (tackleFire == false)
    {
        ycoll = 0;
    }
    else
    {
        isOnGround = true;
    }
    if (tackleFire == false)
    {
        if (moveTimer == -1)
        {
            moveTimer = 60;
            animFrame = 0;
        }

        // Hit floor
        if (isOnGround)
        {
            imgSpd = 0.2;
            xspeed = 0;
            yspeed = 0;
            if (moveTimer > 0)
            {
                moveTimer -= 1;
            }

            // Animation
            if (!burnOut && moveTimer > 0)
            {
                animFrame += imgSpd;
                if (floor(animFrame) < 4 || floor(animFrame) > 5)
                {
                    animFrame = 4;
                }
            }
            else
            {
                burnOut = true;
            }

            // Create Tackle Fire on impact
            if (fireExists == false)
            {
                i = instance_create(x, y, objChangkeyDragonFire);
                i.image_xscale = image_xscale;
                i.tackleFire = true;
                i.isOnGround = true;
                fireExists = true;
                i.moveTimer = -1;
            }
        }
        else
        {
            imgSpd = yspeed / 30;
            animFrame += imgSpd;
            if (floor(animFrame) > 3)
                animFrame = 2;
        }
    } // Tackle Fire code
    else
    {
        if (moveTimer == -1)
        {
            moveTimer = 60;
            animFrame = 6;
        }
        if (moveTimer > 0)
            moveTimer -= 1;

        if (!burnOut)
        {
            animFrame += imgSpd;
            if (floor(animFrame) > 7)
                animFrame = 6;
        }

        // Move
        if (moveTimer <= 30)
        {
            xspeed = 4 * image_xscale;
        }
        if (checkSolid(xspeed, 0))
            burnOut = true;
    }

    // Burn out
    if (burnOut == true)
    {
        imgSpd = 0.2;
        animFrame += imgSpd;
        if (floor(animFrame) < 8)
        {
            animFrame = 8;
        }
        if (floor(animFrame) > 9)
        {
            instance_destroy();
        }
    }
    image_index = floor(animFrame);
}
else if (!insideView())
{
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if ((other.object_index == objBlackHoleBomb) || (other.object_index == objWaterShield)
    || (other.object_index == objTornadoBlow) || (other.object_index == objRainFlush))
{
    other.guardCancel = 0;
}
else
{
    other.guardCancel = 2;
}
