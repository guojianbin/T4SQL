INSERT INTO T4SQL.UTL_ORDINAL_NUMBER (ORDINAL_NUMBER)
SELECT
	LEVEL	AS ORDINAL_NUMBER
FROM
	DUAL
CONNECT BY
	LEVEL	<= 65536;

COMMIT;
