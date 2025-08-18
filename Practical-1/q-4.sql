-- TCL

COMMIT;
-- Purpose: To save all changes made during the transaction

ROLLBACK;
-- Purpose: To undo all changes made during the transaction

SAVEPOINT sp1;
-- Purpose: To set a point in the transaction to which you can later roll back