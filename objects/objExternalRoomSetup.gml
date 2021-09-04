#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// the depth is intended to make this object's create event
/// run before that of all other instances.

// (hack to prevent running multiple times)
if (image_xscale > 0)
{
    image_xscale = -1;
    roomExternalSetupPre();
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(id))
{
    print("External setup post");
    roomExternalSetupPost();

    instance_destroy();
}
