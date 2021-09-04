#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 2;
despawnRange = 32;
healthpoints = healthpointsStart;
category = "grounded";
blockCollision = true;
contactDamage = 4;
throwRange = 6 * 16;
kaonaSize = 1;
waitTimer = 0;
throwTimer = 0;
respawn = true;
phase = -1;
myKaona = noone;
canHit = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    // growing komae
    if (phase == 0 || phase == -1)
    {
        if (kaonaSize == 0 || (!instance_exists(objKaonaGeeno) && phase == 0))
        {
            waitTimer = 63;
            kaonaSize = 0;
        }
        phase = 0;
        waitTimer-=1;
        kaonaSize = min(kaonaSize + 1 / 30, 1);

        // shake:
        if (waitTimer > 30)
        {
            switch (waitTimer mod 8)
            {
                case 0:
                    xspeed = 1;
                    break;
                case 4:
                    xspeed = xstart - x;
                    break;
                default:
                    xspeed = 0;
            }
        }
        else
        {
            xspeed = 0;
        }

        // create kaona:
        if (!instance_exists(myKaona))
        {
            myKaona = instance_create(x, y, objKaona);
            myKaona.respawn = false;
            myKaona.attached = id;
            myKaona.x = x;
            myKaona.y = y;
            myKaona.grav = 0;
            myKaona.blockCollision = false;
        }
        myKaona.image_index = floor(kaonaSize * 2);
    }
    with (myKaona)
        image_xscale = other.image_xscale;

    // phase logic:
    switch (phase)
    {
        case 0: // grow komae
            if (waitTimer <= 20)
                image_index = 1;
            else if (waitTimer <= 30)
                image_index = 6;
            else
                image_index = 5;
            if (waitTimer <= 0 && instance_exists(target))
            {
                calibrateDirection();
                if (abs(x - target.x) < throwRange)
                {
                    phase = 1;
                    throwTimer = 0;
                }
            }
            break;
        case 1: // throwing kaona
            kaonaSize = 0;
            if (!instance_exists(myKaona))
            {
                // no kaona -=1 grow a new one
                phase = 0;
                exit;
            }
            if (!instance_exists(target))
            {
                // no target -=1 wait for target to arrive
                exit;
            }

            // throwing animation
            if (throwTimer < 20)
            {
                image_index = 2;
                with (myKaona)
                {
                    x = other.x - 4 * other.image_xscale;
                    y = other.y - 4 * other.image_yscale;
                }
            }
            else if (throwTimer < 30)
            {
                image_index = 3;

                // at this point in the animation, the kaona is detached and thrown
                if (throwTimer == 20)
                {
                    calibrateDirection();
                    with (myKaona)
                    {
                        yspeed = -3;
                        target = other.target;
                        var prevy; prevy = target.y;
                        target.y = max(y, target.y);
                        grav = other.grav;
                        blockCollision = true;
                        image_index = 3;
                        xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav, other.throwRange / (2 * abs(yspeed) / abs(grav)));
                        target.y = prevy;
                    }
                    playSFX(sfxKaonaToss);
                }
            }
            else if (throwTimer < 40)
            {
                image_index = 4;
            }
            else
            {
                image_index = 5;
            }
            throwTimer+=1;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// destroy kaona if still attached to head
with (myKaona)
    if (grav == 0)
        event_user(EV_DEATH);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
kaonaSize = 1;
waitTimer = 0;
throwTimer = 0;
phase = -1;
with (myKaona)
    if (grav == 0)
        instance_destroy();
myKaona = noone;
