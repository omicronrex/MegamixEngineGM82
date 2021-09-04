/// playerLockLocalInit()
// initializes local player control lock pools

assert(object_index == objMegaman, "player locks should only belong to objMegaman instances");

var i; for (i = 0; i < PL_LOCK_MAX; i+=1)
{
    localPlayerLock[i] = lockPoolNew();

    // clean up when mega man is destroyed or the room ends
    defer(ev_destroy, ev_room_end, -10000, lockPoolDestroy, makeArray(localPlayerLock[i], true));
}
