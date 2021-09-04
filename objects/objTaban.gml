#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = green (default); 1 = pink;)

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying";

blockCollision = 0;
grav = 0;

// Enemy specific code
imageOffset = 0;

// changePhase = 64;
changePhase = 160;
changePhaseStart = changePhase;

animTimer = 0;

cooldownTimer = 0;
cooldownMax = 110;

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
    // determine whether taban is about to open up.
    if (changePhase)
    {
        changePhase -= 1;
    }
    if (changePhase == 40 || changePhase == 36 || changePhase == 32
        || changePhase == 28)
    {
        imageOffset += 1;
        if (changePhase == 40)
            playSFX(sfxTaban);
    }

    // move taban towards mega man.
    if (changePhase == 0 && instance_exists(target))
    {
        // move_towards_point(target.x, target.y, 0.5);
        mp_linear_step(target.x, target.y, 0.5, false);
    }

    // determine animation.
    if (changePhase < 24)
    {
        animTimer += 1;
        if (animTimer == 8)
        {
            animTimer = 0;
            imageOffset += 1;
        }
        if (imageOffset == 5)
        {
            imageOffset = 3;
        }
    }

    // shooting code:
    if (imageOffset >= 3)
    {
        cooldownTimer += 1;
    }

    if (cooldownTimer >= cooldownMax)
    {
        instance_create(x * image_xscale, y, objCannonjoeBullet);
        cooldownTimer = 0;
    }
}

image_index = (6 * col) + imageOffset;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (imageOffset == 0)
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
changePhase = changePhaseStart;
animTimer = 0;
imageOffset = 0;
