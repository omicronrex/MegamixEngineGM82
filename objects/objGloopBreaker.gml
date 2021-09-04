#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// this projectile is created in order to destroy objGloop and nothing else. do not create it otherwise.
event_inherited();

bulletLimitCost = 0;

contactDamage = 0;

penetrate = 0;
pierces = 0;

playSFX(sfxBuster);

timer = 5;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    timer-=1;

    if (!timer)
    {
        instance_destroy();
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    i = fireWeapon(16, 0, objGloopBreaker, 0, 0, 2, 0);
}
