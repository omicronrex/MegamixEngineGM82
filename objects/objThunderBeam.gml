#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

animIndex = 0;
animSpeed = 0.4;
contactDamage = 2;

image_speed = 0.5;

penetrate = 2;
pierces = 2;

myXSpeed = 8;
myYSpeed = 0;

attackDelay = 16;

playSFX(sfxThunderBeam);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // snakey movement
    animIndex += animSpeed;
    xspeed = 0;
    yspeed = 0;
    spawnTimer = 0;

    if (floor(animIndex) != floor(animIndex + animSpeed))
    {
        // new frame
        if (floor(animIndex + animSpeed) != 5) // frame 5 does not advance
        {
            // only move on this frame
            xspeed = myXSpeed;
            yspeed = myYSpeed;
        }
    }

    if (animIndex >= image_number)
    {
        animIndex -= image_number;
    }
    if (animIndex < 0)
    {
        animIndex += image_number;
    }

    image_index = floor(animIndex);
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (other)
{
    iFrames = max(iFrames, 24);

    repeat (16)
    {
        i = instance_create(irandom_range(bbox_left, bbox_right), irandom_range(bbox_top, bbox_bottom), objSingleLoopEffect);
        i.sprite_index = sprShine;
        i.image_speed = 0.1 * irandom_range(1, 3);
    }
}

playSFX(sfxReflect);

event_user(EV_DEATH);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("THUNDER BEAM", make_color_rgb(120, 120, 120), make_color_rgb(255, 222, 132), sprWeaponIconsThunderBeam);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("flying", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    var z; for (z = 0; z <= 2; z += 1)
    {
        i = fireWeapon(16, image_yscale * (ground == false), objThunderBeam, 1 * (z == 0), 1.5 * (z == 0), 1, 0);
        if (i)
        {
            if (z != 1) // Vertical beam
            {
                i.sprite_index = sprThunderBeamVertical;
                i.y += (z - 1) * 4;
                i.myXSpeed = 0;
                i.myYSpeed = 8 * (z - 1);
                if (i.myYSpeed > 0)
                {
                    i.animSpeed *= -1;
                }
            }
            else // Horizontal beam
            {
                i.x += 16 * image_xscale;
                i.myXSpeed = 8 * image_xscale;
            }
        }
        else
        {
            break;
        }
    }
}
