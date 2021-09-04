#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

gravitySet = 0.4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(objMegaman))
{
    /* mygrav = 0.25*0.38
    if objMegaman.grav > mygrav {
        objMegaman.grav = mygrav;
    }*/
    with (objMegaman)
    {
        gravfactor = other.gravitySet;
    }
}

if (instance_exists(objDoncatchDebris))
{
    with (objDoncatchDebris)
    {
        grav = lowGrav;
    }
}
