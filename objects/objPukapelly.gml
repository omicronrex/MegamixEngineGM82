#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = teal (default); 1 = purple; 2 = red; 3 = blue; 4 = orange; 5 = green;)

event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "cluster, floating";

blockCollision = 0;
grav = 0;

// Enemy specific code
col = 0;


phase = 0;
chgPhases = 0;
lockMovement = 0;
xLock = 0;
yLock = 0;
xCont = 0;
yCont = 0;
toggle = 0;

// cos and sine movement
cY = y;
cDistance = 2;
cAngle = 0;
addAngle = 0.5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // timer
    chgPhases += 1;
    if (chgPhases >= 31) //-( phase*16)
    {
        chgPhases = 0;
        phase += 1;
    }

    // phase 0 - bob up and down in place
    if (phase == 0)
    {
        image_index = (col * 2);
        y = ceil(cY + cos(cAngle) * cDistance);
        cAngle += addAngle;
    }

    // lock movement
    if (phase == 1 && lockMovement == 0)
    {
        y = cY;
        lockMovement = 1;
        if (instance_exists(target))
        {
            xLock = ceil(target.x / 16) * 16;
            yLock = ceil(target.y / 16) * 16;

            // Set whether or not xContinue is set or not. This means that Pukapelly will continue moving if he reaches Mega Man's x co-ordinate.
            if (x >= target.x - 3 && x <= target.x + 3)
                xCont = 0;
            else
                xCont = target.x - x;

            // Set whether or not yContinue is set or not. This means that Pukapelly will continue moving if he reaches Mega Man's y co-ordinate.
            if (y >= target.y - 3 && y <= target.y + 3)
                yCont = 0;
            else
                yCont = target.y - y;
        }

        // Set direction of sprite
        if (xLock < x)
        {
            image_xscale = -1;
        }
        else
        {
            image_xscale = 1;
        }
    }

    // phase 1 - follow mega man
    if (phase == 1)
    {
        image_index = (col * 2) + 1;
        cAngle = 0;

        // if pukapelly reaches xLock or yLock, add to xLock and yLock so he keeps moving.
        if (x <= xLock && xCont <= -1)
            xLock = x - 16;
        if (x >= xLock && xCont >= 1)
            xLock = x + 16;
        if (y <= yLock && yCont <= -1)
            yLock = y - 16;
        if (y >= yLock && yCont >= 1)
            yLock = y + 16;

        // lock onto xLock and yLock.
        mp_linear_step(xLock, yLock, 2, false);
        cY = y;
    }

    // otherwise reset to phase 1
    if (phase == 2)
    {
        phase = 0;
        lockMovement = 0;
    }
}
else if (dead)
{
    chgPhases = 0;
    cY = ystart;
    phase = 0;
    cAngle = 0;
    xLock = 0;
    yLock = 0;
    yCont = 0;
    lockMovement = 0;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objJewelSatellite, 2);
specialDamageValue(objGrabBuster, 2);
specialDamageValue(objTripleBlade, 2);
specialDamageValue(objWheelCutter, 2);
specialDamageValue(objSlashClaw, 2);
