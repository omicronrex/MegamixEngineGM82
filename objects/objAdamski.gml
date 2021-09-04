#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy from Galaxy Man's stage. It's a mini UFO that moves in a wave pattern, starting by moving
// downwards.

event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;
category = "cluster, flying";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.15;
sinCounter = 0;

imageOffset = 0;

// @cc color of adamski. (0 = green (default); 1 = yellow; 2 = pink )
col = 0;

// @cc if false, the Wily UFO sound will not play
playUFOSounds = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    imageOffset += 0.15;
    if (imageOffset >= 4)
    {
        imageOffset = 0;
    }

    // now do the trig arc thing
    sinCounter += .02;
    yspeed = (cos(sinCounter) * .7);

    if (!audio_is_playing(sfxWilyUFO) && playUFOSounds)
    {
        playSFX(sfxWilyUFO);
    }
}
else if (dead)
{
    sinCounter = 0;
}

image_index = (4 * col) + imageOffset; // Modify sprite based on set flower
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = image_xscale * 1.35;
}
