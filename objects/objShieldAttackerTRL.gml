#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "shield attackers";

grav = 0;

// Enemy specific code
phase = 1;

// @cc - Change colours: 0 (default) = green, 1 = blue
col = 0;

dir = image_xscale;

moveSprite = sprite_index;
turnSprite = sprShieldAttackerTRLTurn;

moveSpeed = 2;
imgSpeed = 0.2;
turnSpeed = 0.2;

shieldDamageCount = 0;
shieldDPS = 5;
dpsTimer = 0;
timer = 0;
hasShield = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtEntity, ev_step, ev_step_normal);

if (dpsTimer > 0)
{
    dpsTimer -= 1;
    if (dpsTimer == 0)
        shieldDamageCount = 0;
}
if (entityCanStep())
{
    switch (phase)
    {
        case 1:
            if (xcoll != 0 && hasShield)
            {
                phase = 2;
                sprite_index = turnSprite;
                image_index = 0;
            }
            else
            {
                xspeed = moveSpeed * image_xscale;
                image_speed = imgSpeed;
            }
            break;
        case 2:
            xspeed = 0;
            image_speed = turnSpeed;
            if (image_index >= image_number - 1)
            {
                image_index = 0;
                phase = 1;
                sprite_index = moveSprite;
                image_xscale *= -1;
            }
            break;
        case 3:
            switch (col)
            {
                case 1:
                    sprite_index = sprShieldAttackerTRLShockBlue;
                    break;
                default:
                    sprite_index = sprShieldAttackerTRLShock;
                    break;
            }
            xspeed = 0;
            timer += 1;
            if (timer > 36)
            {
                phase = 2;
                switch (col)
                {
                    case 1:
                        sprite_index = sprShieldAttackerTRLTurnSadBlue;
                        moveSprite = sprShieldAttackerTRLSadBlue;
                        break;
                    default:
                        sprite_index = sprShieldAttackerTRLTurnSad;
                        moveSprite = sprShieldAttackerTRLSad;
                        break;
                }
                timer = 0;
                shieldDamageCount = 0;
                dpsTimer = 0;
                animFrame = 0;
                blockCollision = 0;
            }
            break;
    }

    /* if (phase == 1)
    {
        if (xcoll != 0 && hasShield)
        {
            phase = 2;
            sprite_index = turnSprite;
            image_index = 0;
        }
        else
        {
            xspeed = moveSpeed * image_xscale;
            image_speed = imgSpeed;
        }
    }
    else if (phase == 2)
    {
        xspeed = 0;
        image_speed = turnSpeed;

        if (image_index >= image_number - 1)
        {
            image_index = 0;
            phase = 1;
            sprite_index = moveSprite;
            image_xscale *= -1;
        }
    }
    else if (phase == 3)
    {
        sprite_index = sprShieldAttackerTRLShock;
        timer += 1;
        if (timer > 36)
        {
            phase = 2;
            sprite_index = sprShieldAttackerTRLTurnSad;
            moveSprite = sprShieldAttackerTRLSad;
            timer = 0;
            shieldDamageCount = 0;
            dpsTimer = 0;
            animFrame = 0;
            blockCollision = 0;
        }
    }*/
}
else if (dead)
{
    image_index = 0;
    phase = 1;
    hasShield = true;
    image_xscale = dir;
    sprite_index = moveSprite;
    shieldDamageCount = 0;
    blockCollision = 1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtEntity, ev_other, ev_user11);
if (!hasShield)
    exit;

if (phase == 1)
{
    if (sign(bboxGetXCenterObject(other.id) - bboxGetXCenter()) == image_xscale)
    {
        other.guardCancel = 1;
        if (dpsTimer == 0)
            dpsTimer = 60;
        shieldDamageCount += 1;
        if (shieldDamageCount >= shieldDPS)
        {
            phase = 3;
            hasShield = false;
            var i = instance_create(x, y, objShieldAttackerTRLShield);
            i.image_xscale = image_xscale;
            i.xspeed = -1 * image_xscale;
            i.yspeed = -4;
            i.image_index = min(1,col);
            timer = 0;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
phase = 1;
timer = 0;
shieldDamageCount = 0;
dpsTimer = 0;
hasShield = true;

switch (col)
{
    case 1:
        moveSprite = sprShieldAttackerTRLBlue;
        turnSprite = sprShieldAttackerTRLTurnBlue;
        break;
    default:
        moveSprite = sprShieldAttackerTRL;
        turnSprite = sprShieldAttackerTRLTurn;
        break;
}
blockCollision = 1;

animFrame = 0;
