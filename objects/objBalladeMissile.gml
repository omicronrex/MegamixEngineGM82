#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpoints = 1;
healthpointsStart = healthpoints;

image_speed = 0.2;

isSolid = 1;
blockCollision = 0;
grav = 0;
bubbleTimer = -1;

itemDrop = -1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

instance_create(spriteGetXCenter() + 1, spriteGetYCenter(),
    objHarmfulExplosion);
playSFX(sfxMM9Explosion);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

with (other)
{
    if (object_index == objTripleBlade)
    {
        pierces = 0;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (place_meeting(bbox_right, bbox_bottom, objSolid))
{
    sprite_index = sprBalladeMissileGrounded;
}
