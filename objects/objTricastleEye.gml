#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = false;
canHit = true;
contactDamage = 3;
grav = 0;
respawn = false;
hasCannon = false;
cannon = noone;
category = "bulky, rocky";

phase = 3;
timer = -1;

anim = 0;
animFrame = 0;
animTimer = 0;
animSpeed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var prevAnim; prevAnim = anim;
    if (hasCannon && !instance_exists(cannon))
    {
        cannon = instance_create(bbox_left - 3, bbox_top - 16, objTricastleCannon);
    }
    switch (phase)
    {
        case 0:
            if (timer == -1)
            {
                anim = 0;
                timer = 0;
                animSpeed = 0.15;
            }
            break;
        case 1:
            if (timer == -1)
            {
                if (cannon.newAngle == 90)
                    phase = 0;
            }
            break;
        case 2:
            timer += 1;
            if (timer > 20)
            {
                event_user(1);
            }
            break;
        case 3:
            timer += 1;
            if (timer > 20)
            {
                phase = 0;
                timer = -1;
            }
            break;
    }


    if (prevAnim != anim)
    {
        animTimer = -1;
        animFrame = -1;
    }
    animTimer += animSpeed;
    if (animTimer == -1 || animTimer > 1)
    {
        animTimer = 0;
        animFrame += 1;
        switch (anim)
        {
            case 0:
                if (animFrame > 3)
                {
                    animFrame = 0;
                    animSpeed = 0;
                }
                image_index = animFrame;
                break;
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Look at the center and shoot
if (instance_exists(owner.center))
{
    with (owner.center)
    {
        if (x > other.x)
        {
            image_index = 4;
            other.image_index = 7;
        }
        else
        {
            image_index = 5;
            other.image_index = 6;
        }
        phase = 3;
        timer = 0;
    }
}
phase = 2;
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shoot
if (hasCannon)
{
    with (cannon)
        event_user(0);
    if (instance_exists(target))
    {
        if (target.x < bbox_left)
            image_index = 6;
        else if (target.x > bbox_right)
            image_index = 7;
        else
            image_index = 8;
        anim = -1;
    }
    phase = 1;
    timer = -1;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSFX(sfxMM3Explode);
instance_create(bbox_left + sprite_width / 2, bbox_top + sprite_height / 2, objBigExplosion);
if (hasCannon)
{
    with (cannon)
    {
        instance_create(bbox_left + sprite_width / 2, bbox_top + sprite_height / 2, objBigExplosion);
        instance_destroy();
    }
}
instance_destroy();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (other.object_index == objTornadoBlow)
    other.guardCancel = 2;
