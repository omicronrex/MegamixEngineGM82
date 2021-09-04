#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
frozen = 0;

// status effect options
// statusWalkSpeed = how fast Mega Man walks
// statusChangedWalk = used in conjunction with above
// statusJumpSpeed = how far Mega Man jumps
// statusChangedJump = used in conjunction with above
// statusOnIce = if true Mega Man will have ice physics when he's walking
// statusCanJump = can Mega Man jump?
// statusCanClimb = can Mega Man climb?
// statusCanShoot = can Mega Man shoot?
// statusCanSlide = can Mega Man slide?
statusWalkSpeed = 1.3;
statusChangedWalk = false;
statusJumpSpeed = 4.75;
statusChangedJump = false;
statusOnIce = false;
statusCanJump = true;
statusCanClimb = true;
statusCanShoot = true;
statusCanSlide = true;
storeWalkSpeed = 1.3;
storeJumpSpeed = 4.75;
singleTrigger = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((!global.frozen && !frozen) && instance_exists(objMegaman))
{
    // this iterates between each copy of mega man until it finds the right one.
    // change walkspeed of mega man
    if (statusChangedWalk == false)
    {
        for (var i = 0; i < instance_number(objMegaman); i += 1)
        {
            with (objMegaman)
            {
                if (statusObject == other.id)
                {
                    walkSpeed = other.storeWalkSpeed;
                }
            }
        }
    }
    else
    {
        for (var i = 0; i < instance_number(objMegaman); i += 1)
        {
            with (objMegaman)
            {
                if (statusObject == other.id)
                {
                    walkSpeed = other.statusWalkSpeed;
                }
            }
        }
    }

    // change jump speed of mega man
    if (statusChangedJump == false)
    {
        for (var i = 0; i < instance_number(objMegaman); i += 1)
        {
            with (objMegaman)
            {
                if (statusObject == other.id)
                {
                    jumpSpeed = other.storeJumpSpeed + grav * 2;
                }
            }
        }
    }
    else
    {
        for (var i = 0; i < instance_number(objMegaman); i += 1)
        {
            with (objMegaman)
            {
                if (statusObject == other.id)
                {
                    jumpSpeed = other.statusJumpSpeed + grav * 2;
                }
            }
        }
    }
}
else if (!instance_exists(objMegaman))
    instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// nope
