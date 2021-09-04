#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
canDamage = false;
blockCollision = false;
grav = 0;
visible = 0;

// Creation code
interval = 120;
activationDistance = 46;
dir = -1; //- 1: Up

// 1: Down

// timer
spawnTimer = -interval;

// @cc - Change Detarnayappa colour: 0 (default) = green, 1 = red
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
    if (instance_exists(target))
    {
        if (abs(target.x - x) <= activationDistance)
        {
            if (spawnTimer <= -interval)
                spawnTimer = interval;
            else if (spawnTimer >= 0)
                spawnTimer += 1;
            else
                spawnTimer = max(-interval, spawnTimer - 1);
        }
        else
        {
            if (spawnTimer > 0)
                spawnTimer = 0;
            spawnTimer = max(-interval, spawnTimer - 1);
        }
    }
    if (spawnTimer >= interval)
    {
        spawnTimer = 0;
        var sy; sy = bbox_bottom;
        if (dir == 1)
            sy = bbox_top - abs(bbox_bottom - bbox_top);
        with (instance_create(x, sy, objDetarnayappa))
        {
            target = other.target;
            dir = other.dir;
            depth=other.depth;
            col = other.col;
        }
    }
}
