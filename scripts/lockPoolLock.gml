/// lockPoolLock(ids[...])
// checks out a lock on each of the provided lock pools, returning the
// checkedOutLock id (always greater than 0 if at least one lock ID provided).
// This value should later be used in lockPoolRelease.
// at least one lock pool id must be provided.
// This is potentially inefficient if more than one lock pool ID
// is provided, as a common unused entry must be found in each
// lock pool.

if (argument_count <= 0)
    return 0;

// check all lock pools exist:
var lp; for (lp = 0; lp < argument_count; lp+=1)
{
    if (!lockPoolExists(argument[lp]))
    {
        printErr("Attempted to check out lock on non-existent lock pool, id: " + string(argument[lp]));
        assert(false);
        return -1;
    }
    if (global.lockPoolTombstone[argument[lp]])
    {
        printErr("Attempted to check out lock on lock pool slated for deletion (tombstoned), id: " + string(argument[lp]));
        assert(false);
        return -1;
    }
}

// find common lock value
var lv; for (lv = 0; true; lv+=1)
{
    var commonAvailability; commonAvailability = true;
    var lockPoolID; for (lockPoolID = 0; lockPoolID < global.lockPoolN; lockPoolID+=1)
    {
        // check if lock value available in this pool:
        if (lv < global.lockPoolLockCount[lockPoolID])
        {
            if (global.lockPoolLockTable[lockPoolID, lv])
            {
                commonAvailability = false;
                continue;
            }
        }
    }
    if (!commonAvailability)
        continue;

    // add lock to all pools:
    var lp; for (lp = 0; lp < argument_count; lp+=1)
    {
        var lockPoolID; lockPoolID = argument[lp];
        global.lockPoolLockTable[lockPoolID, lv] = true;
        global.lockPoolLockCount[lockPoolID] = max(global.lockPoolLockCount[lockPoolID], lv + 1);
    }
    return lv + 1;
}
