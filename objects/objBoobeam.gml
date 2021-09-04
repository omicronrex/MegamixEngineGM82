#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Use enemyDamageValue from creation code to set its weaknesses
event_inherited(); // makes sure it inherits prtEntity's variables
grav = 0; // makes it not be affected by gravity
blockCollision = 0; // makes it not have collision with solid things
healthpointsStart = 99; // here to prevent being killed by piercing projectiles
healthpoints = healthpointsStart; // same as the former
contactDamage = 4; // deals 4 contact damage
respawn = true; // the boobeams can respawn if used as regular enemies.

// Enemy specific code, these variables can be defined in creation code (Ex: you can change the weakness of the Boobeam)
shooting = false; // sets shooting to be false initially
_im = 0; // required for animation loops via the script
shootWaitTimerStart = 360; // defines the initial time it waits
shootWaitTimer = shootWaitTimerStart; // sets it to the value above
shootTimerStart = 30; // defines the starting time it has while it prepares to fire
shootTimer = shootTimerStart; // sets it to the value above

despawnRange = -1; // prevents it from not spawning
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (global.frozen || dead)
{
    exit;
} // ensures that it doesn't do anything if the game is paused/frozen
if (!dead)
{
    visible = true;
}

if (!shooting)
{
    animationLoop(0, 2, 0.25); // sets the Boobeam to loop between images 0-2
    if (instance_exists(objBoobeamControl) && objBoobeamControl.isIntro)
    {
        exit;
    } // makes sure it doesn't attack before it
    shootWaitTimer -= 1; // makes the timer subtract until it reaches zero

    if (shootWaitTimer <= 0) // checks to see if the timer is less than or zero before making it start it's shooting phase
    {
        shooting = true; // sets shooting to true
        image_index = 4; // sets the image to 4 before it begins it's shooting phase
        shootWaitTimer = shootWaitTimerStart; // resets the timer to what it was originally
    }
}

// shooting phase
if (shooting) // checks for whether it is shooting or not so that it doesn't go into it's shooting phase before it's supposed to
{
    animationLoop(3, 4, 0.25); // makes it loop between images 3-4
    shootTimer -= 1; // makes the timer subtract until it reaches zero
    if (shootTimer <= 0) // checks to see if the timer is less than or zero before making it actually shoot
    {
        shootTimer = shootTimerStart; // resets the timer
        shooting = false; // sets shooting to false
        image_index = 0; // sets the image to 0
        instance_create(x, y, objBoobeamBullet); // Creates the Bullet that homes in on Mega Man
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage == 0)
{
    other.guardCancel = 3;
}
else
{
    dead = true; // kills the Boobeam
    instance_create(x, y, objExplosion); // creates explosion
    if (instance_exists(objBoobeamControl)) // checks if the Boobeam Controller exists
    {
        with (objBoobeamControl)
        {
            healthpoints -= healthpointsStart / boobeamCount; // lowers the Boobeam Controller's health by its maximum health divided by the amount of boobeams in the current section
        }
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.damage = 0;
event_inherited(); // Here is where weaknesses are set, so it must be inherited after we set global.damage to 0
