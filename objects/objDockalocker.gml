#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Code borrowed from yoku blocks
// Creation code(all optional since gm:studio executes creation code after the create event):
// startup = <number> (the amount of frames it takes for the Yoku block to first appear)
// active = <number> (the amount of frames the Yoku block is active before disappearing)
// wait = <number> (the amount of frames the Yoku block needs to reappear after disappearing

// Creation code (optional):
// sprite = <sprite name> (to set the enemy to have a custom graphics)
// spriteBack = <sprite name> (what would be seen behind him once it's open or it's dead)
// neverDespawn = <boolean> (true = will reappear after disappearing for the first time (default); false = only appears once) (setting this to false will eliminate the need to set the wait variable)
// col = Change colours: 0 (default) = blue, 1 = purple

// Note: Dockalocker appear and disappear regardless of whether they are on-screen or off-screen

event_inherited();
blockCollision = 0;
canHit = false;
canDamage = false;

contactDamage = 2;
noFlicker = true;

if (sprite_index != sprDockaLocker)
    sprite_index = sprDockaLocker;

grav = 0;

// creation code setup stuff
back = noone;
startup = 0;
active = 120;
neverDespawn = true;
wait = 120;
sprite = noone;
col = 0;
spriteBack = sprDockalockerBack;
doSFX = true;

timer = 0;
phase = 0; // 0 = waiting to appear; 1 = active; 2 = waiting to reappear after disappearing; 3 = inactive;

respawnRange = -1;
despawnRange = -1;

alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!neverDespawn)
{
    wait = -1;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    switch (phase)
    {
        case 0: // Waiting to appear
        // timer
            canHit = false;
            canDamage = false;
            timer += 1;
            if (timer >= startup)
            {
                timer = 0;
                phase = 1;
                image_index = 0;
            }
            break;
        case 1: // active
        // have solid
            var canShoot = false;
            if (insideView())
            {
                canHit = true;
                canDamage = true;
                canShoot = true;
            }

            // Animation
            if (image_index < image_number - 1)
            {
                image_speed = 0.25;
            }
            else
            {
                if (image_speed != 0 && timer > active * 0.5 && canShoot)
                {
                    event_user(0);
                    image_speed = 0;
                }
                image_index = image_number - 1;
            }

            // timer
            timer += 1;
            if (timer >= active)
            {
                timer = 0;
                image_speed = -0.25;

                if (neverDespawn)
                {
                    phase = 2;
                }
                else
                {
                    phase = 3; // set to inactive phase
                }
            }
            break;
        case 2: // Waiting to reappear after disappearing
        // timer
            timer += 1;
            canDamage = false;
            canHit = false;
            if (timer >= wait)
            {
                timer = 0;
                phase = 1;
                image_index = 0;
            }
            break;
        case 3: // inactive
            canDamage = false;
            canHit = false;
            break;
    }
}
else if (dead)
{
    phase = 0;
    timer = 0;
    if (instance_exists(back))
    {
        back.visible = false;
    }
    image_speed = 0;
    image_index = 0;
    canDamage = false;
    canHit = false;
}

if (phase != 1)
{
    if (image_index == 0)
        image_speed = 0;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// custom sprite using sprite variable

if (sprite != noone)
{
    sprite_index = sprite;
}
else
{
    switch (col)
    {
        case 1:
            sprite_index = sprDockaLockerPurple;
            break;
        default:
            sprite_index = sprDockaLocker;
            break;
    }
}
back = instance_create(x + 16, y, prtAlwaysActive);
back.depth = 3;
back.sprite_index = spriteBack;
back.image_speed = 0;
back.visible = false;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var bullet = instance_create(x + 8, y + 11, objEnemyBullet);
bullet.target = self.target;
bullet.contactDamage = 2;
with (bullet)
    aimAtTarget(3);
playSFX(sfxEnemyShootClassic);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
back.visible = true;
instance_destroy();
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (instance_exists(back))
{
    if (spawned)
    {
        back.visible = true;
    }
    else
    {
        back.visible = false;
    }
}
