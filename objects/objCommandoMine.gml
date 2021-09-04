#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 1 / 6;
image_index = 0;

despawnRange = 48;
respawnRange = 48;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

tile_layer = 1000000;

// deactivate instance:
inst_restore_n = 0;
inst_restore[0] = noone;
obj_embed[0] = prtEntity;
obj_embed[1] = prtPickup;
obj_embed_n = 2;

// order for nested commando mines.
depth -= y / 100000;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!dead)
{
    var i; for ( i = 0; i < inst_restore_n; i+=1)
    {
        with (inst_restore[i])
        {
            dead = false;
            instance_deactivate_object(id);
        }
    }

    // triggered by explosions, projectiles
    if (place_meeting(x, y, objExplosion))
    {
        event_user(EV_DEATH);
    }
    if (place_meeting(x, y, objMegaman))
    {
        event_user(EV_DEATH);
    }
    else
    {
        with (instance_place(x, y, prtEnemyProjectile))
        {
            with (other)
            {
                event_user(EV_DEATH);
                with (other)
                {
                    instance_destroy();
                }
                exit;
            }
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    var i; for ( i = 0; i < inst_restore_n; i+=1)
    {
        with (inst_restore[i])
        {
            dead = false;
            visible = false;
            instance_deactivate_object(id);
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// find objects to restore
depth = 0;
var i; for ( i = -1; i < 2; i += 0.1)
{
    var j; for ( j = 0; j < 2; j += 0.1)
    {
        var k; for (k = 0; k < obj_embed_n; k+=1)
        {
            with (instance_position(x + i * 16, y + j * 16, obj_embed[k]))
            {
                if (indexOf(other.inst_restore, id) == -1)
                {
                    other.inst_restore[other.inst_restore_n] = id; other.inst_restore_n+=1
                    visible = false;
                    dead = true;
                }
            }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;
instance_create(x + 8, y, objHarmfulExplosion);

playSFX(sfxMM9Explosion);

with (instance_create(round(x / 16) * 16, round(y / 16) * 16, objCommandoMineTiler))
{
    tile_layer = other.tile_layer;
    inst_restore = other.inst_restore;
    inst_restore_n = other.inst_restore_n;
    parent = other.id;
}

refX = spriteGetXCenter();
refY = spriteGetYCenter();
alarm[2] = 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    var i; for ( i = 0; i < inst_restore_n; i+=1)
    {
        with (inst_restore[i])
        {
            dead = true;
            visible = false;
            beenOutsideView = false;
            instance_deactivate_object(id);
        }
    }
}
