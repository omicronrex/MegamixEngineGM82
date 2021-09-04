#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
contactDamage = 3;
healthpointsStart = 4;
healthpoints = 4;
category = "flying, shielded";
canHit = false;
canDamage = false;
grav = 0;
blockCollision = false;
despawnRange = 4;

timer = 0;
phase = 0;
subPhase = 0;
myPiledan = noone;
animFrame = 0;

sinCounter = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // wait for Piledan to come
            var refs;
            refs[0] = noone;
            refs[1] = noone;
            var k = 0;
            with (objPiledan)
            {
                if (place_meeting(x, y, other))
                {
                    refs[k] = id;
                    k += 1;
                }
            }
            for (var j = 0; j < k; j++)
            {
                var i = refs[j];
                if (i != noone && sign(i.yspeed) == image_yscale && i.foundMachine && i.image_yscale == image_yscale)
                {
                    myPiledan = i;
                    with (i)
                    {
                        dead = true;
                        healthpoints = 0;
                    }
                    phase = 1;
                    animFrame = 1;
                    playSFX(sfxPiledan);
                    break;
                }
            }
            break;
        case 1: // Transform
            animFrame += 0.2;
            canHit = true;
            canDamage = true;
            canIce = true;
            if (floor(animFrame) > 8)
            {
                animFrame = 9;
                phase = 2;
            }
            break;
        case 2: // Handle active phase, it's an user event so it's easy to override
            event_user(0);
            break;
    }
    if (instance_exists(myPiledan))
    {
        myPiledan.beenOutsideView = false;
        myPiledan.x = x;
        myPiledan.y = y;
        myPiledan.dead = true;
    }
    image_index = floor(animFrame);
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Active phase
switch (subPhase)
{
    case 0:
        timer += 1;
        yspeed = 0;
        shootTimer = 0;
        if (timer > 24)
        {
            subPhase = 1;
            timer = 0;
            shootTimer = pi;
        }
        break;
    case 1:
        timer += 0.05;
        shootTimer += 0.05;
        if (shootTimer > 2 * pi)
        {
            shootTimer = 0;
            with (instance_create(x, y + image_yscale * 7, objEnemyBullet))
            {
                sprite_index = sprPiledanBomb;
                image_yscale = other.image_yscale;
                grav = 0.25 * other.image_yscale;
                blockCollision = false;
                explodeOnContact = true;
                contactDamage = 4;
            }
        }
        yspeed = -sin(timer) * 2.35 * image_yscale;
        xspeed = abs(cos(timer)) * 1.35 * image_xscale;
        if (abs(sin(timer)) > 0.85 || timer < 2)
            xspeed = 0;
}
animFrame += 0.18;
if (floor(animFrame) > 10)
{
    animFrame = 9;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
myPiledan = noone;
instance_create(bboxGetXCenter(),bboxGetYCenter(),objBigExplosion);
playSFX(sfxMM9Explosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var _y = bbox_top;
var _y2 = bbox_bottom;
if (image_yscale == -1)
{
    _y = bbox_bottom;
    _y2 = bbox_top;
}
if (collision_rectangle(x + 16 * image_xscale, _y + 6 * image_yscale, x, _y2, other, true, true))
    other.guardCancel = 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    image_index = 0;
    animFrame = 0;
    phase = 0;
    timer = 0;
    subPhase = 0;
    sinCounter = 0;
    canHit = false;
    canDamage = false;
    canIce = false;
}
myPiledan = noone;
