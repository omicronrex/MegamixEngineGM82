#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_xscale = 1 or -1 //(Use editor for this!!) determines starting direction of mini boss.

event_inherited();
respawn = true;
introSprite = sprCombiloidTeleport;
healthpointsStart = 35;
healthpoints = healthpointsStart;
contactDamage = 4;
blockCollision = 1;
grav = 0.15 * image_yscale;
facePlayerOnSpawn = true;
category = "bulky, shielded";

// Enemy specific code
image_speed = 0;
image_index = 0;
storeXScale = 0;
phase = 0;

attackTimer = 0;
attackTimerMax = 40;
findPartner = false;

wireY = 0;
xMin = x - 256;
xMax = x + 256;

partner = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!findPartner)
{
    partner = instance_nearest(x, y, objCombiloidBuddy);
    with (partner)
    {
        partner = other.id;
    }
    findPartner = true;
}


event_inherited();
if (entityCanStep()
    && introTimer <= 0)
{
    dir = image_xscale;

    if (storeXScale == 0)
    {
        if (instance_exists(target)) // since minibosses usually only face one direction, here we set the direction of Combiloid
            image_xscale = sign(x - target.x) * -1;
        storeXScale = image_xscale;
    }

    attackTimer += 1;
    switch (phase)
    {
        case 0: // wait for refill
            if (instance_exists(partner))
            {
                xMax = partner.xMax;
                xMin = partner.xMin;
                with (partner)
                {
                    phase = 3;
                    if (x >= other.x - 2 && x <= other.x + 2)
                    {
                        xspeed = 0;
                        other.phase = 1;
                        playSFX(sfxAbsorb);
                    }
                    else if (x > other.x)
                    {
                        xspeed = -1;
                    }
                    else if (x < other.x)
                    {
                        xspeed = 1;
                    }
                }
            }
            else
            {
                if (attackTimer >= 64)
                {
                    attackTimer = 0;
                    phase = 3;
                }
            }
            break;
        case 1: // refill
            if (attackTimer >= 4 && wireY < (abs((round(y - partner.y)) / 8)))
            {
                attackTimer = 0;
                wireY++;
            }
            if (attackTimer >= 32)
            {
                attackTimer = 0;
                phase = 2;
            }
            break;
        case 2: // refill lower
            if (attackTimer >= 4 && wireY > 0)
            {
                attackTimer = 0;
                wireY--;
            }
            if (wireY == 0)
            {
                attackTimer = 0;
                phase = 3;
            }
            break;
        case 3: // move across screen
            with (partner)
            {
                phase = 0;
                attackTimer = 0;
            }
            if (image_index < 2)
            {
                if (xspeed == 0)
                {
                    attackTimer = 0;
                }
                image_index += 0.05;
            }
            if (image_index >= 2)
            {
                image_index = 2 + (attackTimer / 6) mod 2;
                xspeed = 1.25 * image_xscale;
            }
            if (attackTimer >= 48)
            {
                playSFX(sfxEnemyShoot);
                var inst = instance_create(x + 8, y, objCombiloidProjectile);
                inst.sprite_index = sprCombiloidBullet2;
                inst.dir = 0;
                inst.image_xscale = 1;
                inst.spd = 2.5;
                inst = instance_create(x - 8, y, objCombiloidProjectile);
                inst.sprite_index = sprCombiloidBullet2;
                inst.dir = 0;
                inst.image_xscale = -1;
                inst.spd = 2.5;
                attackTimer = 0;
            }
            var foundSolid = true;
            mask_index = mskCombiDetector;
            if (!checkSolid((32 * image_xscale), 16 * image_yscale))
            {
                foundSolid = false;
            }
            mask_index = sprite_index;
            if (xcoll != 0 || image_xscale == 1 && (x >= view_xview + view_wview - 36 || x >= xMax)
                || image_xscale == -1 && (x <= view_xview + 36 || x <= xMin)
                || !foundSolid) // detect wall, maximum boundary, of it theres a floor.
            {
                image_xscale *= -1;
                image_index = 3;
                xspeed = 0;
                phase = 4;
            }
            break;
        case 4: // wait for partner
            if (image_index > 0)
            {
                image_index -= 0.05;
            }
            else
            {
                if (!instance_exists(partner))
                {
                    phase = 0;
                }
            }
            break;
    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    if (instance_exists(target) && !dead)
    {
        image_xscale = sign(x - target.x) * -1;
    }
    attackTimer = 0;
    phase = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
facePlayerOnSpawn = false;
with (partner)
{
    event_user(EV_DEATH);
}
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index >= 2 || (image_yscale == 1 && !(bboxGetYCenterObject(other.id) < y - 12))
    ||
    (image_yscale == -1 && !(bboxGetYCenterObject(other.id) > y + 12)))
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(partner))
{
    var ySeRe = sign(y - partner.y);

    for (var i = 0; i < wireY; i++)
    {
        draw_sprite(sprCombiloidWire, 0, x, y - (i * 8) * ySeRe);
    }
}
event_inherited();
