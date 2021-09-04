#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// The classic met. It also appears in MM9. It simply shoots 3 shots out when Mega Man is within 4 blocks of it -
// nothing else special with it. Set xscale manually.
event_inherited();

respawn = true;
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

facePlayer = true;
category = "mets";

// Enemy specific code
radius = 4
    * 16; // Four blocks; the radius that MM needs to enter to trigger the shooting of the met
cooldownTimer = 0;
canShoot = true;
player_costume_id = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
sprite_index = sprCamouflametall;
if (entityCanStep())
{
    // check if its target exists (nearest player object)
    if (instance_exists(target))
    {
        // check if target is in range; if it is, trigger shooting code
        if (distance_to_object(target) <= radius)
        {
            if (canShoot)
            {
                canShoot = false;
                image_index = 1;
                canHit = true;
            }
        }
    }

    // shooting code
    if (!canShoot)
    {
        cooldownTimer += 1; // action timer
        if (cooldownTimer == 17)
        {
            // for loop used to make more efficent code
            for (i = -1; i <= 1; i += 1)
            {
                ID = instance_create(x + image_xscale * 8,
                    spriteGetYCenter(), objMM1MetBullet);
                ID.dir = 45 * i;
                ID.xscale = image_xscale;
                ID.sprite_index = sprEnemyBullet;
            }
            playSFX(sfxEnemyShootClassic);
        }
        else if (cooldownTimer == 30)
        {
            image_index = 0;
        }
        else if (cooldownTimer
            >= 80) // return to helmet down after 80 frames (roughly a little over a second)
        {
            canShoot = true;
            cooldownTimer = 0;
        }
    }
    if (image_index == 0 && dead == false)
    {
        canHit = false;
    }
    else if (image_index == 1 && dead == false)
    {
        canHit = true;
    }

    // Camouflametalls don't move on the ground. Why?
    // So you can make Eddie throw them out and they won't slide on the ground
    if ground
    {
        xspeed = 0;
    }
}
else if (dead)
{
    cooldownTimer = 0;
    canShoot = true;
    image_index = 0;
    canHit = false;
}

// set sprite
if (instance_exists(objMegaman))
{
    with (objMegaman)
    {
        if (playerID == 0)
        {
            other.player_costume_id = costumeID;
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
    other.guardCancel = 3;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (dead)
{
    exit;
}

squareSize = 48;
col[0] = c_white;
col[1] = global.primaryCol[0];
col[2] = global.secondaryCol[0];
col[3] = global.outlineCol[0];

// make sure the target player is set the same way as a 1-up's is if that ever changes!
if (image_index == 0)
    drawPlayer(0, player_costume_id, 16, 12, x, y - 16 * image_yscale, image_xscale, image_yscale);
else if (image_index == 1)
    drawPlayer(0, player_costume_id, 16, 12, x - image_xscale, y - 22 * image_yscale, image_xscale, image_yscale);
