#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

blockCollision = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    with (instance_place(x, y, objMegaman))
    {
        if (iFrames == 0 && canHit)
        {
            with (other)
            {
                entityEntityCollision();
            }
        }

        inked = true;
        global.outlineCol[playerID] = global.nesPalette[39];
        global.primaryCol[playerID] = c_black;
        global.secondaryCol[playerID] = c_black;
        with (other)
        {
            instance_create(x, y, objExplosion);
            instance_destroy();
        }
    }

    if (checkSolid(0, 1, 1, 1) || ycoll)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }
}
