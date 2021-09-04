#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = orange(default); 1 = green; 2 = game gear colouration; 3 = manga colouration;)

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;

category = "cluster, flying";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
getAngle = 0;
shootAngle = 45;
imageOffset = 0;

explode = false;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Hit wall
    if (checkSolid(0, 0, 1, 1))
    {
        explode = true;
    }
    if (explode)
    {
        var ID;
        ID = instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objExplosion);
        ID.xscale = image_xscale;
        playSFX(sfxMinorExplosion);

        // If megaman exists, grab his angle, otherwise grab some random different angle.
        if (instance_exists(target))
            getAngle = point_direction(spriteGetXCenter(),
                spriteGetYCenter(), target.x, target.y);
        else
            getAngle = point_direction(spriteGetXCenter(),
                spriteGetYCenter(), x + (45 * (xspeed)), 45 * (xspeed));

        ID = instance_create(x + image_xscale, spriteGetYCenter(),
            objMM5AimedBullet);
        {
            ID.dir = getAngle;
            ID.xscale = image_xscale;
            ID.sprite_index = sprJetBombDebry;
            ID.image_index = (col * 4) + 2;
            ID.image_speed = 0;
            ID.moveAtSpeed = 2;
        }
        ID = instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objMM5AimedBullet);
        {
            ID.dir = getAngle + shootAngle;
            ID.xscale = image_xscale;
            ID.sprite_index = sprJetBombDebry;
            ID.image_index = (col * 4) + 3;
            ID.image_speed = 0;
            ID.moveAtSpeed = 2;
        }
        ID = instance_create(spriteGetXCenter(), spriteGetYCenter(),
            objMM5AimedBullet);
        {
            ID.dir = getAngle - shootAngle;
            ID.xscale = image_xscale;
            ID.sprite_index = sprJetBombDebry;
            ID.image_index = (col * 4) + 0;
            ID.image_speed = 0;
            ID.moveAtSpeed = 2;
        }
        dead = true;
    }
    imageOffset += 0.20;

    if (imageOffset == 2)
        imageOffset = 0;
}
image_index = (3 * col) + (imageOffset);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=create debry upon death
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

for (var i = 0; i < 4; i++)
{
    ID = instance_create(x + image_xscale, spriteGetYCenter(), objMM5AimedBullet);
    ID.dir = 45 + (90 * i);
    ID.xscale = image_xscale;
    ID.sprite_index = sprJetBombDebry;
    ID.image_index = (col * 4) + i;
    ID.image_speed = 0;
    ID.moveAtSpeed = 2;
}
stopSFX(sfxEnemyHit);
playSFX(sfxExplosion);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xspeed = 2 * image_xscale;

// resetting
image_index = 0;
explode = false;
imageOffset = 0;
visible = true;
