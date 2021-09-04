#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Like Pipi, but it drops a big rock. The rock behaves like MM4 Drill Man rocks.
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, bird";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy-specific variables
sinCounter = 0; // for wave movement
animTimer = 0;
hasRock = true;
init = 1;

//@cc - Change colour: 0 (default) = brown rock, 1 = white rock
col = 0;
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
            sprite_index = sprHoohooWhite;
            break;
        default:
            sprite_index = sprHoohoo;
            break;
    }
    init = 0;
}

if (entityCanStep())
{
    // Animation
    animTimer+=1;

    // wing flap
    if (animTimer == 10 && image_index != 2)
    {
        if (image_index == 0 || image_index == 1)
        {
            image_index = !image_index;
        }

        if (image_index == 3 || image_index == 4)
        {
            if (image_index == 3)
            {
                image_index = 4;
            }
            else
            {
                image_index = 3;
            }
        }
        animTimer = 0;
    }

    // rock release anim
    if (animTimer == 22 && image_index == 2)
    {
        image_index = 3;
        animTimer = 0;
    }

    // Wave movement
    sinCounter += .15;
    yspeed = -((sin(sinCounter) / (hasRock + 1)) * 1.7);

    // release Dwayne
    if (collision_rectangle(x - 40, y - 512, x + 40, y + 512, target, false, true) && hasRock)
    {
        image_index = 2;
        hasRock = false;
        var ID; ID = instance_create(x, y + 8, objHoohooRock);
        ID.image_xscale = image_xscale;
        ID.col = col;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// if the slot is low enough, set that it'll split.
if (bboxGetYCenterObject(other.id) >= bboxGetYCenter() && other.object_index != objBlackHoleBomb && other.object_index != objTornadoBlow && other.object_index != objSlashClaw)
{
    healthpoints += 1;

    hasRock = false;
    image_index = 2;

    instance_create(x, y + 8, objExplosion);
}
else
{
    global.damage = healthpoints; // otherwise, instantly kill.
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xspeed = 2 * image_xscale;
hasRock = true;
image_index = 0;
animTimer = 0;
sinCounter = 0;
