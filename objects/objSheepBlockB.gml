#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

respawnRange = -1;
despawnRange = -1;

shiftVisible = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

spawn = objSolidIndependent;
spawnID = -1;
timer = 0;

colourBlock = objSheepBlockB;
disappearTimer = 96;
active = true;

recurseDepth = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (timer > 0)
    {
        timer += 1;
        image_index += (timer / disappearTimer);
        if (timer > disappearTimer)
        {
            timer = 0;
            active = false;
        }
    }


    if (active)
    {
        if (!spawnID)
        {
            spawnID = instance_create(x, y, spawn);
        }
    }
    else if (spawnID)
    {
        instance_activate_object(spawnID);
        with (spawnID)
        {
            instance_destroy();
        }
        spawnID = -1;
    }
    visible = active;
}
else if (dead)
{
    image_index = 0;
    active = true;
    timer = 0;
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (entityCanStep())
{
    if (timer == 0)
    {
        if (active && spawn == objSolidIndependent)
        {
            with (objMegaman)
            {
                if (ground)
                {
                    if (place_meeting(x, y + gravDir, other.id))
                    {
                        with (other)
                        {
                            playSFX(sfxSheepBlock);
                            global.sheepBlockStack_n = 1;
                            global.sheepBlockStack[0] = id;
                            while (global.sheepBlockStack_n > 0)
                            {
                                global.sheepBlockStack_n -= 1;
                                with
                                    (global.sheepBlockStack[global.sheepBlockStack_n])
                                    event_user(0);
                            }
                        }
                    }
                }
            }
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (timer != 0)
    exit;

timer = 1;

var i;
i = 1;
for (i = 1; i < 5; i += 1)
{
    if (i == 1)
    {
        X = 1;
        Y = 0;
    }
    if (i == 2)
    {
        X = -1;
        Y = 0;
    }
    if (i == 3)
    {
        X = 0;
        Y = 1;
    }
    if (i == 4)
    {
        X = 0;
        Y = -1;
    }
    b = instance_position(x + X * 16 + 8, y + Y * 16 + 8, colourBlock);
    if (instance_exists(b))
    {
        if (b != id && b.colourBlock == colourBlock)
        {
            if (b.timer == 0 && b.active)
            {
                with (b)
                {
                    recurseDepth = other.recurseDepth + 1;
                    global.sheepBlockStack[global.sheepBlockStack_n] = id; global.sheepBlockStack_n+=1
                }
            }
        }
    }
}
