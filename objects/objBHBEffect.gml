#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

targetX = x;
targetY = y;

timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    move_towards_point(targetX, targetY, 0.75);

    // destroy with quickswitch
    if (!instance_exists(objBlackHoleBomb))
    {
        instance_destroy();
    }

    if (distance_to_point(targetX, targetY) <= 2 || timer >= 120)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
        playSFX(sfxEnemyHit);
    }

    // if this object somehow cannot find its way to the void after 2 seconds...mercy kill
    timer += 1;
}
