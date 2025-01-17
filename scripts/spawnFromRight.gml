/// spawnFromRight([cameraMovingLeft])
// Spawns only if the object is on the right side of the screen
// despawnType must be 1 for this to work correclty
with (other)
{
    var canContinue; canContinue = true;
    if (argument_count == 0 || (argument_count > 0 && argument[0]))
        canContinue = global.prevXView > view_xview;
    if (canContinue && bbox_left > (view_xview + view_wview - 2 - abs(global.prevXView - view_xview)))
    {
        other.allowSpawn = true;
    }
}
