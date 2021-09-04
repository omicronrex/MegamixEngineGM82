#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 5;
canHit = false;
grav = 0;
image_speed = 0.5;
shotsLeft = 4;
stopOnFlash = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    if (image_index == 2)
    {
        if (shotsLeft > 0)
        {
            // If I am a ground explosion...
            if ((sprite_index == sprCommandoExplosionHor) && (!positionCollision(x + 9 * image_xscale, y)))
            {
                var i; i = instance_create(x + 9 * image_xscale, y, objCommandoBombExplosion);
                i.image_xscale = image_xscale;
                i.sprite_index = sprCommandoExplosionHor;
                i.shotsLeft = shotsLeft - 1;
            } // If I'm on a wall...
            else if ((sprite_index == sprCommandoExplosionVer) && (!positionCollision(x - (image_xscale == 1) * 2, y + 9 * image_yscale)))
            {
                var i; i = instance_create(x, y + 9 * image_yscale, objCommandoBombExplosion);
                i.image_xscale = image_xscale;
                i.image_yscale = image_yscale;
                i.shotsLeft = shotsLeft - 1;
            }
        }
    }
    else if (image_index > 3)
    {
        instance_destroy();
    }
}
