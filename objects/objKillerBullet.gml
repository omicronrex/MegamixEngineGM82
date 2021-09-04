#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A classic enemy that definitely isn't a Bullet Bill. Will move in a wave towards Mega Man,
// and on death, will explode.

// Creation code (all optional):

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "floating";

blockCollision = 0;
grav = 0;

// Enemy specific code
sinCounter = 0;

//@cc 0 = red (default); 1 = blue; 2 = orange
col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// set color on spawn
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprKillerBullet;
            break;
        case 1:
            sprite_index = sprKillerBulletBlue;
            break;
        case 2:
            sprite_index = sprKillerBulletOrange;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    // Set direction and xspeed on spawn. xspeed starts as 0 in create and is set here.
    if (xspeed == 0)
    {
        calibrateDirection();
        xspeed = image_xscale;
    }

    // sinCounter is a bit of a misnomer since this uses cosine, not sine, but whatever.
    sinCounter += .035;
    yspeed = -(cos(sinCounter) * 1.3);

    // These numbers are basically just guesswork on my part. Sorry. No real rhyme or reason to them.
}
else if (dead)
{
    sinCounter = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion))
{
    sprite_index = sprBombManBlast;
    image_speed = 1;
    image_index = 0;
    playSFX(sfxClassicExplosion);
}
