#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 1;

pierces = 0;

inWater = -1;

distance = 20;
velocity = 0;
total = 8;
count = 0;

isMaster = false;

rotationSpeed = 360 / 60;

spawnOffset = 360 / total;
angle = spawnOffset;
spawnAfter = 360 + spawnOffset;

shiftVisible = 2;
despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen || instance_exists(objSectionSwitcher))
{
    if (instance_exists(parent))
    {
        image_yscale = parent.image_yscale;

        angle += rotationSpeed;

        x = min(view_xview + view_wview + 4, max(view_xview - 4, parent.x + lengthdir_x(distance, angle) * image_xscale));
        y = min(view_yview + view_hview + 4, max(view_yview - 4, parent.y - lengthdir_y(distance, angle) * -image_yscale + 4 * parent.image_yscale));

        if (isMaster) // Master bubble code, spawn other bubbles
        {
            if (angle >= spawnOffset)
            {
                angle -= spawnOffset;
                count += 1;

                var i; i = instance_create(x, y, object_index);
                i.parent = parent;

                i.angle = angle;
                i.spawnAfter = spawnAfter - spawnOffset;
                spawnAfter = i.spawnAfter;
                i.image_xscale = image_xscale;
                i.image_yscale = image_yscale;

                if (count >= total)
                {
                    instance_destroy();
                }
            }
        }
        else
        {
            visible = true;

            if (!global.frozen)
            {
                if (velocity == 0) // Spread out
                {
                    if (angle >= spawnAfter + 45 && global.keyShootPressed[parent.playerID])
                    {
                        with (parent)
                        {
                            if (!playerIsLocked(PL_LOCK_SHOOT))
                            {
                                playSFX(sfxWaterShield2);
                                with (objWaterShield)
                                {
                                    if (parent == other.id)
                                    {
                                        velocity = 0.1;
                                        despawnRange = 0;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    velocity += 0.1;
                }

                distance += velocity;

                if (distance > max(view_wview, view_hview))
                {
                    instance_destroy();
                    exit;
                }
            }
        }
    }
    else
    {
        event_user(EV_DEATH);
    }
}
#define Collision_prtEnemyProjectile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (canDamage)
{
    switch (other.reflectable)
    {
        case -1:
        case 1:
            playSFX(sfxEnemyHit);
            with (other)
            {
                instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
                instance_destroy();
            }
            instance_create(x, y, objBubblePopEffect);
            instance_destroy();
            break;
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
audio_stop_sound(sfxReflect);

instance_create(x, y, objBubblePopEffect);

event_user(EV_DEATH);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("WATER SHIELD", make_color_rgb(0, 112, 232), make_color_rgb(168, 224, 248), sprWeaponIconsWaterShield);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("fire", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, 0, objWaterShield, 1, 4, 1, 0);
    if (i)
    {
        playSFX(sfxWaterShield);
        i.isMaster = true;
        i.canHit = false;
        i.canDamage = false;
    }
}
