#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 5;
grav = 0;
image_speed = 0.1;
itemDrop = -1;
stopOnFlash = false;

// Unique variables
canTurn = false;
hasTurned = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if ((canTurn == true) && (hasTurned == false))
    {
        if (instance_exists(target))
        {
            // Only turn when directly under target
            if ((x <= target.bbox_right) && (x >= target.bbox_left))
            {
                xspeed = 0;
                yspeed = 3;
                sprite_index = sprCommandoManBombVer;
                playSFX(sfxCommandoBombTurn);
                hasTurned = true;
            }
        }
    }

    if (instance_exists(objMegaman))
    {
        if (place_meeting(x, y, objMegaman))
        {
            with (objMegaman)
            {
                if ((canHit) && (iFrames == 0))
                {
                    instance_create(x, y, objHarmfulExplosion);
                    playSFX(sfxMM9Explosion);
                    with (other)
                        instance_destroy();
                }
            }
        }
    }

    if ((xcoll != 0) || (ycoll != 0))
    {
        // Create wall explosions
        if (sprite_index == sprCommandoManBombHor)
        {
            var i = instance_create(x + 7 * image_xscale, y - 7, objCommandoBombExplosion);
            i.image_xscale = image_xscale;
            i.image_yscale = -1;
            var i = instance_create(x + 7 * image_xscale, y + 7, objCommandoBombExplosion);
            i.image_xscale = image_xscale;
            i.image_yscale = 1;
        }

        // Create ground explosions
        if (sprite_index == sprCommandoManBombVer)
        {
            var i = instance_create(x + 7, y + 7, objCommandoBombExplosion);
            i.sprite_index = sprCommandoExplosionHor;
            i.image_xscale = 1;
            var i = instance_create(x - 7, y + 7, objCommandoBombExplosion);
            i.sprite_index = sprCommandoExplosionHor;
            i.image_xscale = -1;
        }

        playSFX(sfxCommandoBombExplode);
        instance_destroy();
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index != objBreakDash) && (other.object_index != objTenguDash)
&& (other.object_index != objSaltWater) && (other.object_index != objWheelCutter)
&& (other.object_index != objMetalBlade)
{
    with (other)
    {
        guardCancel = 1;
        if ((penetrate >= 2) && (pierces >= 2))
        {
            guardCancel = 2;
        }
    }
}
