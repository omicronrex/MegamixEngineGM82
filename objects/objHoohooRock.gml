#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

yspeed = 0;
xspeed = 0;

respawn = false;

image_speed = 0;

// @cc - Change colour: 0 (default) = brown, 1 = white
col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

//Change colours
if (init)
{
    switch(col)
    {
        case 1:
            sprite_index = sprHoohooRockWhite;
            break;
        default:
            sprite_index = sprHoohooRock;
            break;
    }
    init = 0;
}

if (entityCanStep())
{
    if (ground)
    {
        instance_destroy();
        playSFX(sfxHoohooRock);

        for (i = 1; i <= 4; i+=1)
        {
            debris = instance_create(x, y, objEnemyBullet);
            debris.sprite_index = sprHoohooRock;
            debris.image_speed = 0;
            debris.contactDamage = 3;
            debris.canHit = true;
            debris.grav = gravAccel;

            switch (i)
            {
                // leftmost rock
                case 1:
                    debris.image_index = 1;
                    debris.xspeed = 1 * image_xscale;
                    debris.yspeed = -4;
                    break;
                // middle left
                case 2:
                    debris.image_index = 2;
                    debris.xspeed = .25 * image_xscale;
                    debris.yspeed = -4.25;
                    break;
                // middle right
                case 3:
                    debris.image_index = 1;
                    debris.xspeed = -.5 * image_xscale;
                    debris.yspeed = -5.25;
                    break;
                // rightmost rock
                case 4:
                    debris.image_index = 2;
                    debris.xspeed = -.75 * image_xscale;
                    debris.yspeed = -3.75;
                    break;
            }
        }
    }
}
