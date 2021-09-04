/// lockPoolRelease([lock IDs], checkedOutLock)
// releases the given lock on all lock pools.
// If a list of lock IDs is provided, the lookup is strict
// and will throw an error if the lock set provided doesn't match what pools are actually locked.
// otherwise, error checking still occurs but only is caught if releasing the lock changes no values.

if (argument_count == 0)
    return false;
var lv; lv = argument[argument_count - 1] - 1;
var strict; strict = argument_count > 1;
if (lv < 0)
    return false;
var anyRelease; anyRelease = false;
var lockPoolID; for (lockPoolID = 0; lockPoolID < global.lockPoolN; lockPoolID+=1)
{
    if (!lockPoolExists(lockPoolID))
        continue;

    // determine whether this lock pool has the given lock checked out
    var poolHasLock; poolHasLock = lv < global.lockPoolLockCount[lockPoolID];
    if (poolHasLock)
        poolHasLock = global.lockPoolLockTable[lockPoolID, lv];

    // strict error-checking
    if (strict)
    {
        var strictPoolCheck; strictPoolCheck = false;
        var i;for ( i = 0; i < argument_count - 1; i+=1)
            if (argument[i] == lockPoolID)
                strictPoolCheck = true;
        if (poolHasLock && !strictPoolCheck)
        {
            printErr("Given lock index is locked in a lock pool which was not listed in the strict check, pool id: " + string(lockPoolID) + ", lock ID: " + string(lv));
            assert(false);
            return -1;
        }
        if (!poolHasLock && strictPoolCheck)
        {
            printErr("Given lock index is already released (or never obtained) in a lock pool which was listed in the strict check, pool id: " + string(lockPoolID) + ", lock ID: " + string(lv));
            assert(false);
            return -1;
        }
    }

    // release lock
    if (poolHasLock)
    {
        global.lockPoolLockTable[lockPoolID, lv] = false;
        anyRelease = true;

        // If this is the rightmost lock in this lock pool, recalculate number of locks
        if (lv == global.lockPoolLockCount[lockPoolID] - 1)
        {
            var lvi; for (lvi = lv; lvi >= 0; lvi-=1)
            {
                if (global.lockPoolLockTable[lockPoolID, lvi])
                {
                    global.lockPoolLockCount[lockPoolID] = lvi + 1;
                    break;
                }
                if (lvi == 0)
                {
                    global.lockPoolLockCount[lockPoolID] = 0;
                }
            }
        }
    }

    // clear tombstoned pool
    if (global.lockPoolLockCount[lockPoolID] == 0 && global.lockPoolTombstone[lockPoolID])
    {
        global.lockPoolTombstone[lockPoolID] = false;
        global.lockAvailable[lockPoolID] = true;
    }
}

assert(anyRelease, "Released lock, but no lock pools had lock ID " + string(lv + 1) + " checked out!");

return 0;
