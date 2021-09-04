#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;

penetrate = 0;
pierces = 0;

isController = 0;

for (var i = 0; i < 6; i++)
{
    controllerTargets[i] = noone;
    crosshairFrame[i] = 0;
}

// Movement
timer = 0;
newAngle = 0;
angle = 0;
animFrame = 0;
spd = 3;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
event_inherited();

if (!global.frozen && !global.switchingSections)
{
    if (!isController) // Code for the missiles
    {
        // behaviourType = 4;

        target = controllerTargets[0];

        if (!instance_exists(target))
        {
            event_user(0);
        }
        else if (target.dead || !target.canHit)
        {
            event_user(0);
        }

        if (target != controllerTargets[0])
        {
            controllerTargets[0] = target;
            crosshairFrame[0] = 0;
        }

        timer++;

        if (instance_exists(target)) // Aiming
        {
            var newAngle = point_direction(x, y, bboxGetXCenterObject(target), bboxGetYCenterObject(target));
            newAngle = wrapAngle(floor(newAngle / 30) * 30);

            if (!(timer mod 4))
            {
                if (angle != newAngle)
                {
                    var delta = 360 - angle;
                    var nangl = (newAngle + delta) % 360;
                    var rotDir = 1 - ((nangl >= 180) * 2);

                    angle = wrapAngle(angle + 30 * rotDir);
                }
            }
        }

        xspeed = cos(degtorad(angle)) * spd;
        yspeed = -sin(degtorad(angle)) * spd;

        animFrame = (animFrame + 0.25) mod 2;

        image_index = floor(animFrame) * 8 + floor(((angle div 45) * 45) / 45);
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_xscale == -1)
{
    image_xscale = 1;
    angle = 180;
}

image_yscale = 1;

event_inherited();

if (isController) // Code for the controller
{
    if (instance_exists(parent))
    {
        x = parent.x;
        y = parent.y;
    }
    else
    {
        instance_destroy();
        exit;
    }

    if (!global.frozen)
    {
        // Amount of targets - based on the chargeTimer
        var n = array_length_1d(controllerTargets);
        var maxTarget = min(parent.chargeTimer div 10, global.ammo[parent.playerID, global.weapon[parent.playerID]]);
        var removed = false;
        for (var i = 0; i < n; i++)
        {
            if (instance_exists(controllerTargets[i]))
            {
                if (!controllerTargets[i].dead && controllerTargets[i].canHit)
                    continue;
            }
            controllerTargets[i] = noone;
        }

        // Clean up spots in the array that contain IDs of dead/unhittable targets
        // And refill them with new targets
        var j = 0;
        for (var i = 0; j < maxTarget && i < array_length_1d(controllerTargets); i++)
        {
            if (!controllerTargets[i])
            {
                event_user(0);
                controllerTargets[i] = target;
                crosshairFrame[i] = 0;
                if (target != noone)
                    j += 1;
            }
            else
                j += 1;
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Targeting
target = noone;

var targetsToIgnore;
targetsToIgnore[0] = -1;

with (object_index)
{
    if (!isController)
    {
        if (instance_exists(controllerTargets[0]) && !controllerTargets[0].dead && controllerTargets[0].canHit)
        {
            controllerTargets[0].canHit *= -1;
            if (targetsToIgnore[0] != -1)
                targetsToIgnore[array_length_1d(targetsToIgnore)] = controllerTargets[0];
            else
                targetsToIgnore[0] = controllerTargets[0];
        }
    }
}

with (objDestroyableBlock)
{
    if (weakness != other.object_index)
        canHit *= -1;
}

if (isController)
{
    for (var i = 0; i < array_length_1d(controllerTargets); i++)
    {
        if (instance_exists(controllerTargets[i]))
        {
            controllerTargets[i].canHit *= -1;
            if (targetsToIgnore[0] != -1)
                targetsToIgnore[array_length_1d(targetsToIgnore)] = controllerTargets[i];
            else
                targetsToIgnore[0] = controllerTargets[i];
        }
        else
        {
            controllerTargets[i] = noone;
        }
    }
}

setTargetStep();

for (var i = 0; i < array_length_1d(targetsToIgnore); i++)
{
    with (targetsToIgnore[i])
    {
        canHit *= -1;
    }
}

if (!instance_exists(target) && targetsToIgnore[0] != -1) // Find the least frequent target
{
    var n = array_length_1d(targetsToIgnore);
    if (n > 0)
    {
        quickSort(targetsToIgnore);
        var min_count = 100;
        var curr_count = 1;
        for (var i = 1; i < n; i++)
        {
            if (targetsToIgnore[i] == targetsToIgnore[i - 1])
                curr_count++;
            else
            {
                if (curr_count < min_count)
                {
                    min_count = curr_count;
                    target = targetsToIgnore[i - 1];
                }
                curr_count = 1;
            }
        }

        // If last element is least frequent
        if (curr_count < min_count)
        {
            min_count = curr_count;
            target = targetsToIgnore[n - 1];
        }
        if (!instance_exists(target))
        {
            if (!targetsToIgnore[n - 1].dead)
                target = targetsToIgnore[n - 1];
        }
        else if (target.dead)
        {
            if (!targetsToIgnore[n - 1].dead)
                target = targetsToIgnore[n - 1];
        }
    }
}

with (objDestroyableBlock)
{
    if (weakness != other.object_index)
        canHit *= -1;
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(EV_DEATH);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

instance_create(x, y, objExplosion);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("HOMING SNIPER", make_color_rgb(172, 124, 0), make_color_rgb(0, 232, 216), sprWeaponIconsHomingSniper);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.ammo[playerID, global.weapon[playerID]] <= 0)
{
    with (objHomingSniper)
    {
        if (isController)
        {
            instance_destroy();
        }
    }
    exit;
}

var bulletLimit = 6;
var weaponCost = 1;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw
var willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

var chargeTime = 60; // Set charge time for this weapon
var initChargeTime = 20;

if (global.enableCharge && !playerIsLocked(PL_LOCK_CHARGE))
{
    var hasController = false;
    with (objHomingSniper)
    {
        if (isController && parent == other.id)
        {
            hasController = true;
            break;
        }
    }

    if (!hasController && (global.keyShoot[playerID]))
    {
        i = fireWeapon(16, 0, objHomingSniper, 1, 0, 0, willStop);
        if (i)
        {
            i.isController = true;
            i.canHit = false;
            i.canDamage = false;
            i.respawnRange = -1;
            i.despawnRange = -1;
        }
    }
}

if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, 0, objHomingSniper, bulletLimit, weaponCost, action, willStop);
    if (i)
    {
        i.xspeed = 1.5 * image_xscale;
        playSFX(sfxMissileLaunch);

        // playSFX(choose(sfxHomingSniper,sfxHomingSniper2,sfxHomingSniper3));
    }
}

//////////////
// Charging //
//////////////

if (global.enableCharge)
{
    if ((global.keyShoot[playerID] || (isSlide && chargeTimer > 0))
        && !playerIsLocked(PL_LOCK_CHARGE))
    {
        if (!isShoot)
        {
            isCharge = true;

            if (!isSlide)
            {
                initChargeTimer += 1;
            }

            if (initChargeTimer >= initChargeTime)
            {
                if (!chargeTimer)
                {
                    playSFX(sfxCharging);
                }

                chargeTimer++;

                if (chargeTimer < chargeTime)
                {
                    var chargeTimeDiv, chargeCol;
                    chargeTimeDiv = round(chargeTime / 3);

                    if (chargeTimer < chargeTimeDiv)
                    {
                        chargeCol = make_color_rgb(168, 0, 32); // Dark red
                    }
                    else if (chargeTimer < chargeTimeDiv * 2)
                    {
                        chargeCol = make_color_rgb(228, 0, 88); // Red (dark pink)
                    }
                    else
                    {
                        chargeCol = make_color_rgb(248, 88, 152); // Light red (pink)
                    }

                    if (chargeTimer mod 6 >= 0 && chargeTimer mod 6 < 3)
                    {
                        global.outlineCol[playerID] = chargeCol;
                    }
                    else
                    {
                        global.outlineCol[playerID] = c_black;
                    }
                }
                else
                {
                    if (chargeTimer == chargeTime)
                    {
                        audio_stop_sound(sfxCharging);
                        playSFX(sfxCharged);
                    }
                    if (!inked)
                    {
                        switch (floor(chargeTimer / 3 mod 3))
                        {
                            case 0: // Light blue helmet, black shirt, blue outline
                                global.primaryCol[playerID] = make_color_rgb(0, 232, 216);
                                global.secondaryCol[playerID] = c_black;
                                global.outlineCol[playerID] = make_color_rgb(172, 124, 0);
                                break;
                            case 1: // Black helmet, blue shirt, light blue outline
                                global.primaryCol[playerID] = c_black;
                                global.secondaryCol[playerID] = make_color_rgb(172, 124, 0);
                                global.outlineCol[playerID] = make_color_rgb(0, 232, 216);
                                break;
                            case 2: // Blue helmet, light blue shirt, blue outline
                                global.primaryCol[playerID] = make_color_rgb(172, 124, 0);
                                global.secondaryCol[playerID] = make_color_rgb(0, 232, 216);
                                global.outlineCol[playerID] = c_black;
                                break;
                        }
                    }
                }
            }
        }
    }
    else // Release the charge shot
    {
        if (!playerIsLocked(PL_LOCK_SHOOT) && chargeTimer != 0 && !isSlide)
        {
            /////////////////////
            // ACTUAL SHOOTING //
            /////////////////////
            var controller = noone;
            with (objHomingSniper)
            {
                if (isController && parent == other.id)
                {
                    controller = id;
                    break;
                }
            }

            if (controller)
            {
                for (var z = 0; z < array_length_1d(controller.controllerTargets); z++)
                {
                    if (instance_exists(controller.controllerTargets[z]))
                    {
                        i = fireWeapon(16, 0, objHomingSniper, bulletLimit + 1, weaponCost, action, willStop);
                        if (i)
                        {
                            if (!z)
                            {
                                playSFX(sfxMissileLaunch);

                                // playSFX(choose(sfxHomingSniper,sfxHomingSniper2,sfxHomingSniper3));
                            }
                            i.controllerTargets[0] = controller.controllerTargets[z];
                            i.crosshairFrame[0] = 2;
                        }
                        else
                        {
                            break;
                        }
                    }
                }
                with (controller)
                {
                    instance_destroy();
                }
            }

            // Reset all charging stuff
            chargeTimer = 0;
            initChargeTimer = 0;
            audio_stop_sound(sfxCharged);
            audio_stop_sound(sfxCharging);
            playerPalette(); // Reset the colors
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!isController)
{
    event_inherited();
}

var img = sprite_get_number(sprHomingSniperCrosshair) - 1;

for (var i = 0; i < array_length_1d(controllerTargets); i++)
{
    if (instance_exists(controllerTargets[i]))
    {
        var stop = 0;

        for (var z = (i - 1); z >= 0; z--)
        {
            if (instance_exists(controllerTargets[i]))
            {
                if (controllerTargets[i] == controllerTargets[z])
                {
                    if (crosshairFrame[z] < img)
                    {
                        stop = 1;
                        break;
                    }
                }
            }
        }

        if (stop && isController)
        {
            continue;
        }

        var lastFrame = crosshairFrame[i];
        crosshairFrame[i] = min(img, crosshairFrame[i] + 0.4);

        draw_sprite(sprHomingSniperCrosshair, floor(crosshairFrame[i]),
            bboxGetXCenterObject(controllerTargets[i]),
            bboxGetYCenterObject(controllerTargets[i]));

        if (crosshairFrame[i] == img && crosshairFrame[i] != lastFrame)
        {
            playSFX(sfxHomingSniperLock);
        }
    }
}
