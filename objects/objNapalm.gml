#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

category = "fire";

faction = 4;

animTimer = 0;
dying = false;
dieTime = 0;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

killOverride = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    animTimer = global.gameTimer mod 16;
}

if (entityCanStep())
{
    if (!dying)
    {
        contactDamage = 28;
        image_index = animTimer div 4;

        // special interactions
        with (objWaterShield) || (objRainFlush) || (objTornadoBlow)
        {
            if (place_meeting(x, y, other))
            {
                with (other)
                {
                    dying = true;
                    dieTime = 0;
                    animTimer = 0;
                }
                playSFX(sfxEnemyHit);
                if (object_index == objWaterShield)
                {
                    instance_create(x, y, objBubblePopEffect);
                }
                if (object_index == objTornadoBlow)
                {
                    guardCancel = 2;
                }
                instance_destroy();
            }
        }

        // Tel Tel rain puts out oil
        if (global.telTelWeather == 1)
        {
            dying = true;
            dieTime = 0;
            animTimer = 0;

            playSFX(sfxEnemyHit);
        }
    }
    else
    {
        dieTime+=1;

        image_index = 4 + dieTime div 4;

        if (dieTime >= 12)
        {
            event_user(EV_DEATH);
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dying)
{
    dying = 1;

    contactDamage = 0;
}
else
{
    dead = 1;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.damage == other.contactDamage || dying)
{
    other.guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

animTimer = 0;
dying = false;
dieTime = 0;
