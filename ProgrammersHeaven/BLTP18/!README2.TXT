Read me too (shareware release)
BULLET v1.08 (BLTQ18.ZIP)

--Status value return code with transaction-based routines

The transaction-based routines, InsertXB, UpdateXB, ReindexXB, and all LockXB
routines, do not return the completion status. The return value is the
pack index number that failed. The following example assumes that you are
using multiple index files. If you're not, replace AP(x).y with AP.y.

   AP(1).Func = InsertXB
   pid = BULLET(AP(1))
   IF pid = 0 THEN
      IF AP(1).stat = 0 THEN
         'all okay
      ELSE                      'error while adding the data record is returned
         stat = AP(1).stat      'in AP(1).stat if and only if pid=0
         DoErrorWithDataRecord stat
      ENDIF
   ELSE
      stat = AP(pid).stat
      DoErrorWithIndexFile pid, stat
   ENDIF

For complete information consult the above named routines in CZ. Note that
ReindexXB does not operate on a data file separately so if its return
code=0 (pid=0) then all operations succeeded. However, with the LockXB
routines, if pid > number_of_packs then the lock on the data file failed.
The following example assumes that a single index file and data file are
to be locked.

   packs = 1                    '1 pack (single index file per data file)
   AP.Func = LockXB
   pid = BULLET(AP)
   IF pid = 0 THEN
      'all okay
   ELSEIF pid <= packs          'error while locking index file and error code
      stat = AP.stat            'in AP.stat
      DoErrorWithIndexFile stat
   ELSE                         'error while locking data file and error code
      stat = AP.stat            'also in AP.stat
      DoErrorWithDataFile stat
   ENDIF


