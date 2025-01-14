#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Boulder dropper for [objStoneHead](objStoneHead.html), it can drop any object but its recomended to stick to the default,
// if changed please also change its sprite_index.
// Note: These rocks are connected, use the templates to not worry about creation code,
// follow the guides and the names, the directions in the name indicate first where the previous rock
// should be and at last where the next boulder should be, if any.
// To invert the direction in which the templates connect change its image_xscale or image_yscale in the editor
// Note: be careful not to make an infinite loop between the boulders, that would crash the game
event_inherited();
init = 0;
blockCollision = 0;
canHit = false;
isEnd = false;
isStart = false;
endRef = noone;
startRef = noone;
grav = 0;
boulderCount = 0;
sprite_index = sprStoneHead;

//@cc custom sprite
customSprite = noone;

//@cc particle used to mark stone head's position
particleSprite = sprStoneHeadParticle;

//@cc this indicates if this boulder connects from left to right (1)or from right to left (-1)
dir = 1;

//@cc indicates exaclty where the other boulders are, use the templates instead of this object to not
// worry about this
nextYdir = 0;
nextXdir = 1;
prevXdir = -1;
prevYdir = 0;

//@cc object_index of the object to drop
customDrop = -1;

//@cc initial xspeed of the dropped object
dropXspeed = 0;

//@cc initial yspeed of the dropped object
dropYspeed = 0;

//@cc gravity of the dropped object
dropGrav = 0.15;

//@cc collision of the dropped object
dropBlockCollision = false;

//@cc code to execute on the dropped object
code = "";

//@cc script to execute on the dropped object
script = noone;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (init)
{
    if (customSprite != noone)
        sprite_index = customSprite;
    init = 0;

    if (!isStart)
    {
        event_user(0);
    }

    if (!isEnd)
    {
        event_user(1);
    }

    if (isStart)
    {
        var i; i = 0;
        var ref; ref = self;
        while (ref != noone)
        {
            i += 1;
            ref = ref.nextBoulder;
        }
        boulderCount = i;
        ref = self.nextBoulder;
        while (ref != noone)
        {
            ref.boulderCount = i;
            ref.startRef = self;
            ref = ref.nextBoulder;
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (dir == 1)
{
    prevBoulder = instance_place(x + 5 * prevXdir, y + 5 * prevYdir, objSHBoulder);
    nextBoulder = instance_place(x + 5 * nextXdir, y + 5 * nextYdir, objSHBoulder);
}
else
{
    prevBoulder = instance_place(x + 5 * nextXdir, y + 5 * nextYdir, objSHBoulder);
    nextBoulder = instance_place(x + 5 * prevXdir, y + 5 * prevYdir, objSHBoulder);
}

if (nextBoulder == noone)
{
    endRef = self;
    isEnd = true;
}
if (prevBoulder == noone)
{
    startRef = self;
    isStart = true;
}
init = 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Get Start


if (!isStart)
{
    if (prevBoulder.prevBoulder == noone)
        startRef = prevBoulder;
    else
    {
        with (prevBoulder)
            event_user(0);
        startRef = prevBoulder.startRef;
    }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// GetEnd


if (!isEnd)
{
    if (nextBoulder.nextBoulder == noone)
        endRef = nextBoulder;
    else
    {
        with (nextBoulder)
            event_user(1);
        endRef = nextBoulder.endRef;
    }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// SpawnBoulderProjectile
if (customDrop <= 0)
    customDrop = objSHFallingBoulder;
var i; i = instance_create(x, y, customDrop);
i.xspeed = dropXspeed;
i.yspeed = dropYspeed;
i.grav = dropGrav;
i.respawn = false;
i.blockCollision = dropBlockCollision;
with (i)
{
    if (other.script != noone)
        script_execute(other.script);
    if (other.code != "")
        stringExecutePartial(other.code);
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// spawnParticle
var i; i = instance_create(x, y, objStoneHeadParticle);
i.sprite_index = particleSprite;
