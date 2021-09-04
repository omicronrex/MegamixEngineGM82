#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 1;

contactDamage = 2;

penetrate = 2;
pierces = 2;
attackDelay = 16;

inWater = -1;

distance = 20;
velocity = 0;
total = 8;
count = 0;

isMaster = false;

cAngle = 0;
cDistance = 0;
addAngle = 3;
sourceX = -1;
sourceY = -1;
moveY = 0;
postRotate = 1;
original = false;
orgID = noone;
drainDelay = 64;

shiftVisible = 2;
despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(objSectionSwitcher)) // destroy on screen transition
{
    instance_destroy();
}

event_inherited();

if (!global.frozen)
{
    if (instance_exists(parent))
    {
        image_index += 0.325;
        drainDelay -= 1;

        image_yscale = parent.image_yscale;

        if (cDistance < 24)
        {
            cDistance += 0.5;
        }

        if (moveY == 0 || sourceX == -1)
        {
            if (global.ammo[playerID, global.weapon[playerID]] > 0 && original && drainDelay <= 0) // drain weapon energy
            {
                global.ammo[playerID, global.weapon[playerID]] -= 1 / 48 / (global.energySaver + 1);
                if (global.ammo[playerID, global.weapon[playerID]] <= 1 / 48 / (global.energySaver + 1) && drainDelay <= 0)
                {
                    global.ammo[playerID, global.weapon[playerID]] = 0;
                }
            }
            sourceX = parent.x;
            sourceY = parent.y + (4 * sign(image_yscale));
            despawnRange = 16;
            if (!parent.climbing)
            {
                cAngle += addAngle * parent.image_xscale;
                postRotate = parent.image_xscale;
            }
            else
            {
                cAngle += addAngle * postRotate;
            }


            if (global.ammo[playerID, global.weapon[playerID]] == 0 && drainDelay <= 0)
            {
                instance_create(x, y, objExplosion);
                instance_destroy();
            }
        }
        else
        {
            sourceY += moveY;
            cAngle += addAngle * postRotate;
        }

        if (!global.keyShoot[playerID] && moveY == 0)
        {
            moveY = -2 * sign(image_yscale);
        }
        x = round(sourceX + cos(degtorad(cAngle)) * cDistance);
        y = round(sourceY + sin(degtorad(cAngle)) * cDistance);
    }
    else
    {
        instance_destroy();
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
            break;
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x, y, objExplosion);
playSFX(sfxReflect);

event_user(EV_DEATH);
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("FLAME MIXER", make_color_rgb(231, 0, 99), make_color_rgb(252, 216, 168), sprWeaponIconsFlameMixer);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue("fire", 1);
specialDamageValue("nature", 4);
specialDamageValue("ice", 4);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT) && !instance_exists(objSectionSwitcher))
{
    j = fireWeapon(0, 0, objFlameMixer, 1, 2, 0, 0);
    if (j)
    {
        with (j)
        {
            original = true;
            orgID = id;
            postRotate = parent.image_xscale;
        }
        playSFX(sfxSolarBlazePop);
        for (var i = 1; i < 4; i++)
        {
            var inst = instance_create(x, y, objFlameMixer);
            inst.cAngle = 90 * i;
            inst.parent = j.parent;
            inst.orgID = j.id;
            inst.postRotate = j.parent.image_xscale;
            inst.image_yscale = j.parent.image_yscale;
        }
    }
}
