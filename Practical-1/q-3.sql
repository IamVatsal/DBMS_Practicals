-- DCL

CREATE USER 'librarian'@'localhost' IDENTIFIED BY 'lib123';

GRANT SELECT, INSERT, UPDATE ON LibraryDB_142.LibraryBooks TO 'librarian'@'localhost';

REVOKE UPDATE ON LibraryDB_142.LibraryBooks FROM 'librarian'@'localhost';
