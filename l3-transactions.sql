1. Open two WORKING sessions (A and B) in SQL Developer

2. Using session A create a table:
CREATE TABLE XX_ISO_TEST(account VARCHAR2(75), balance NUMBER); 

3. Using session B insert a new record to XX_ISO_TEST
INSERT INTO XX_ISO_TEST
VALUES('Account 1', 500);
-- 1 row inserted

4. Using session A check that record is not visible and create a new record to XX_ISO_TEST
INSERT INTO XX_ISO_TEST
VALUES ('Account 2', 800);
-- 1 row inserted

5. commit transaction in session A.

6. Check visible transactions in session B.

7. commit transaction in session B.

8. Check visible transactions in session A.

9. Set session isolation level to SERIALIZABLE in session A
ALTER SESSION SET ISOLATION_LEVEL = SERIALIZABLE;

10. update account 2, set balance = balance * 1000 in session A
UPDATE XX_ISO_TEST
SET balance = balance * 1000
WHERE account = 'Account 2';

11. commit transaction is session A.

12. Check how data looks in session B.

13. update accont 1, set balance = balance * 1000 in session B
UPDATE XX_ISO_TEST
SET balance = balance * 1000
WHERE account = 'Account 1';

14. commit transaction in session B

15. Check how data looks in session A
-- Account 1 is updated

16. update accont 1, set balance = balance * 1000 in session B
UPDATE XX_ISO_TEST
SET balance = balance * 1000
WHERE account = 'Account 1';

17. commit transaction is session B

18. Check how data looks in session A
-- Account is not updated

19. Press commit in session A

20. Check how data looks in session A
-- Accoubnt 1 is updated