#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A wall turret that is invincible when it is closed. When it opens up, it will shoot four shots at a reasonable
// speed sweeping downwards in a sort of arc, before it closes and rests. It's only normally defeatable when it's opened up.
// Set its direction by flipping its xscale.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

category = "shielded";

grav = 0;

// Enemy specific code

//@cc 0 = red (default); 1 = orange; 2 = blue)
col = 0;
init = 1;

timer = 0;
phase = 1;
bullet = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;

    // Set the correct color
    switch (col)
    {
        case 0:
            sprite_index = sprBeakRed;
            break;
        case 1:
            sprite_index = sprBeakOrange;
            break;
        case 2:
            sprite_index = sprBeakBlue;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    if (phase == 1)
    {
        switch (timer - 90)
        {
            case 0:
                image_index = 1;
                break;
            case 7:
                image_index = 2;
                break;
            case 14:
                image_index = 3;
                break;
            case 17:
                timer = 0;
                phase = 2;
                break;
        }
    }
    else
    {
        switch (timer)
        {
            case 1:
                if (bullet < 4)
                {
                    var i; i = instance_create(x + image_xscale * 16, y + 8, objBeakBullet);
                    i.image_index = col;
                    i.dir = 45 - (bullet * 30);
                    i.xscale = image_xscale;

                    playSFX(sfxEnemyShootClassic);
                    bullet+=1;
                    timer -= 30;
                }
                break;
            case 8:
                image_index = 1;
                break;
            case 15:
                timer = 0;
                phase = 1;
                image_index = 0;
                bullet = 0;
                break;
        }
    }

    timer += 1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_index == 0)
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();

timer = 0;
phase = 1;
bullet = 0;
image_index = 0;
