#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 9999;
contactDamage = 3;
canHit = false;
playSFX(sfxBombPotton);
grav = 0;
blockCollision = 0;
remaining = 2;
onlyDamageMines = true;

var j = 0;
shiftObject(0, 2, true);
checkGround();
if (ground)
    exit;
while (j < (232 / 4) && !checkSolid(0, 1,1,1))
{
    shiftObject(0, 4, true);
    j += 1;
}
if(checkSolid(0,0,1,1))
{
    event_user(EV_DEATH);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_index += 0.25;
    if (floor(image_index) > 3)
    {
        instance_destroy();
        exit;
    }
    if (floor(image_index) == 1)
    {
        if (remaining > 0)
        {
            var i = instance_create(x + 8 * image_xscale, y, objBombPottonExplosion);
            i.remaining = remaining - 1;
            i.image_xscale = image_xscale;
            remaining = 0;
            if (sprite_index == sprBombPottonExplosionBlue)
            {
                i.sprite_index = sprBombPottonExplosionBlue
            }
        }
    }
    var obj;
    if(onlyDamageMines)
        obj=objCommandoMine;
    else
        obj=prtEntity;

    with (obj)
    {
        if (id == other.id || faction != 3 || !canHit || hitTimer < other.attackDelay || iFrames != 0 || dead)
            continue;
        if (place_meeting(x, y, other))
        {
            with (other)
            {
                guardCancel = 0;
                penetrate = 2;
                with (other)
                    event_user(EV_GUARD);
                if (guardCancel > 0)
                    global.damage = 0;
                else
                    global.damage = contactDamage;
            }
            if (global.damage > 0)
            {
                hitTimer = 0;
                healthpoints -= global.damage;
                event_user(EV_HURT);
                if (healthpoints <= 0)
                    event_user(EV_DEATH);
            }
            global.damage = 0;
        }
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Nope
