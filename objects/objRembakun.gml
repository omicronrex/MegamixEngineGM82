#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 5;

category = "flying";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
missileDrop = -1;
moveDelay = 0;

// shooting variables
cooldownTimer = 0;
cooldownMax = 10;
canShoot = false;
direct = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    moveDelay += 1;
    if (missileDrop > 0)
        image_index = (2 * missileDrop) + (moveDelay * 0.25);

    // Rembakun moves an additional pixel extra every few frames. this replicates that.
    if (moveDelay == 0)
    {
        xspeed = 1 * image_xscale;
    }
    if (moveDelay == 3)
    {
        xspeed = 2 * image_xscale;
        moveDelay = -1;
    }
    cooldownTimer += 1;
    if (cooldownTimer >= cooldownMax && missileDrop < 6)
    {
        // Change missile number, and flag on the fact the enemy can shoot.
        canShoot = true;
        cooldownTimer = 0;
        missileDrop += 1;
    }

    // generate missile depending on what number missile drop is.
    if (canShoot == true)
    {
        var inst;
        var scaleX;
        scaleX = image_xscale;
        switch (missileDrop)
        {
            case 2:
                inst = instance_create(x + (image_xscale * 4), y + 8,
                    objRembakunMissile);
                with (inst)
                    image_xscale = scaleX;
                break;
            case 4:
                inst = instance_create(x + (image_xscale * 4), y + 8,
                    objRembakunMissile);
                with (inst)
                    image_xscale = scaleX;
                break;
            case 6:
                inst = instance_create(x + (image_xscale * 4), y + 8,
                    objRembakunMissile);
                with (inst)
                    image_xscale = scaleX;
                break;
        }
        canShoot = false;
    }
}
else
{
    if (dead == true)
    {
        direct = 1 * image_xscale;
        cooldownTimer = 0;
        missileDrop = -1;
        moveDelay = 0;
        image_index = 0;
    }
}
