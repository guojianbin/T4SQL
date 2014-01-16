﻿USE T4SQLDB;
GO

------------------ Build started workitem: testVTimePointsToRanges ------------------
IF OBJECT_ID(N'test.vw_timepoints_ranges', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_timepoints_ranges AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_timepoints_ranges AS
-- This code was generated by T4SQL.Date.VTimePointsToRanges @ 12/8/2013 12:16:25 AM
WITH TR AS
(
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY catalog_id, position_id ORDER BY DATE_) AS ROW$NUMBER
	FROM
		test.date_time_points
)
SELECT
	t1.catalog_id, t1.position_id, t1.value_, t1.other_col, 
	t1.DATE_		AS START_DATE,
	ISNULL(DATEADD(day, -1, t2.DATE_), CAST('2999-12-31' AS DATE))			AS END_DATE
FROM
	TR t1 LEFT OUTER JOIN
	TR t2 ON (t1.catalog_id = t2.catalog_id AND t1.position_id = t2.position_id
		AND t1.ROW$NUMBER + 1 = t2.ROW$NUMBER)
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		May 20, 2013, 12:00:44 AM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVTimePointsToRanges ------------------

------------------ Build started workitem: testVTimeRangesToSeries ------------------
IF OBJECT_ID(N'test.vw_timeranges_series', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_timeranges_series AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_timeranges_series AS
-- This code was generated by T4SQL.Date.VTimeRangesToSeries @ 12/8/2013 12:16:26 AM
SELECT
	D.DATE_, S.catalog_id, S.position_id, S.value_, S.other_col
FROM
	test.vw_timepoints_ranges	S,
	T4SQL.VW_ORDINAL_DATE	D
WHERE
	(
		S.END_DATE >= D.DATE_
		OR S.END_DATE IS NULL
	)
	AND S.START_DATE <= D.DATE_
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		May 15, 2013, 11:27:30 PM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVTimeRangesToSeries ------------------

------------------ Build started workitem: testVTimePointsToSeries ------------------
IF OBJECT_ID(N'test.vw_timepoints_series', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_timepoints_series AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_timepoints_series AS
-- This code was generated by T4SQL.Date.VTimePointsToSeries @ 12/8/2013 12:16:26 AM
WITH TR AS
(
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY catalog_id, position_id ORDER BY DATE_) AS ROW$NUMBER
	FROM
		test.date_time_points
)
SELECT
	D.DATE_, S.catalog_id, S.position_id, S.value_, S.other_col
FROM
	(
		SELECT
			t1.catalog_id, t1.position_id, t1.value_, t1.other_col, 
			t1.DATE_											AS START$DATE,
			ISNULL(t2.DATE_, CAST('2999-12-31' AS DATE))		AS EXPIRE$DATE
		FROM
			TR t1 LEFT OUTER JOIN
			TR t2 ON (t1.catalog_id = t2.catalog_id AND t1.position_id = t2.position_id
				AND t1.ROW$NUMBER + 1 = t2.ROW$NUMBER)
	)	S,
	T4SQL.VW_ORDINAL_DATE	D
WHERE
		S.EXPIRE$DATE > D.DATE_
	AND S.START$DATE <= D.DATE_
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		May 15, 2013, 11:25:04 PM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVTimePointsToSeries ------------------

------------------ Build started workitem: testVTimeSeriesToRanges ------------------
IF OBJECT_ID(N'test.vw_timeseries_ranges', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_timeseries_ranges AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_timeseries_ranges AS
-- This code was generated by T4SQL.Date.VTimeSeriesToRanges @ 12/8/2013 12:16:26 AM
SELECT
	catalog_id, position_id, value_, other_col, 
	MIN(DATE_)		AS START_DATE,
	MAX(DATE_)		AS END_DATE
FROM
	test.vw_timepoints_series
GROUP BY
	catalog_id, position_id, value_, other_col
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		May 19, 2013, 11:59:23 PM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVTimeSeriesToRanges ------------------

------------------ Build started workitem: testVTimeRangesCheckSum ------------------
IF OBJECT_ID(N'test.vw_timeranges_chksum', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_timeranges_chksum AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_timeranges_chksum AS
-- This code was generated by T4SQL.Date.VTimeRangesCheckSum @ 12/8/2013 12:16:26 AM
SELECT
	catalog_id, position_id,
	MIN(START_DATE)									AS START_DATE,
	MAX(ISNULL(END_DATE, CONVERT(date, GETDATE())))	AS END_DATE,
	DATEDIFF(day, MIN(START_DATE), MAX(ISNULL(END_DATE, CONVERT(date, GETDATE())))) + 1	AS INSCOPE_DAYS,
	SUM(DATEDIFF(day, START_DATE, ISNULL(END_DATE, CONVERT(date, GETDATE()))) + 1)		AS CHECK_SUM
FROM
	test.vw_timepoints_ranges
GROUP BY
	catalog_id, position_id
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		June 02, 2013, 11:00:30 AM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVTimeRangesCheckSum ------------------

------------------ Build started workitem: testVPivot ------------------
IF OBJECT_ID(N'test.vw_pivot', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_pivot AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_pivot AS
-- This code was generated by T4SQL.Pivot.VPivot @ 12/8/2013 12:16:26 AM
SELECT
	product_id, [FIELD_A] AS V_A, [FIELD_B] AS V_B, FIELD_C AS V_C, FIELD_D as V_D, FIELD_E, FIELD_F, FIELD_G, FIELD_H
FROM
(
	SELECT
		product_id, value_, attrib_code
	FROM
		test.pivot_discrete_attrib
	
)	S
PIVOT
(
	MAX(value_)
	FOR attrib_code IN ([FIELD_A], [FIELD_B], FIELD_C, FIELD_D, FIELD_E, FIELD_F, FIELD_G, FIELD_H)
)	P
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		June 02, 2013, 11:06:09 AM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVPivot ------------------

------------------ Build started workitem: testVUnpivot ------------------
IF OBJECT_ID(N'test.vw_unpivot', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_unpivot AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_unpivot AS
-- This code was generated by T4SQL.Pivot.VUnpivot @ 12/8/2013 12:16:26 AM
SELECT
	product_id, attrib_code, value_
FROM
	test.vw_pivot
UNPIVOT
(
	value_ FOR attrib_code IN
	(
		V_A, V_B, V_C, V_D, FIELD_E, FIELD_F, FIELD_G, FIELD_H
	)
)	U
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		June 02, 2013, 11:06:37 AM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVUnpivot ------------------

------------------ Build started workitem: testVGroupingSets ------------------
IF OBJECT_ID(N'test.vw_grouping_sets', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_grouping_sets AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_grouping_sets AS
-- This code was generated by T4SQL.Grouping.VGroupingSets @ 12/8/2013 12:16:27 AM
SELECT
	simulation_id, 
	CASE GROUPING_ID(is_cash, prod_code, grp1_type, grp2_code, grp3_class)
		WHEN 31	THEN 'TOTAL_FUND'
		WHEN 15	THEN 'AGG_CASH'
		WHEN 7	THEN 'AGG_PROD'
		WHEN 25	THEN 'agg_grp12'
		WHEN 28	THEN 'agg_grp23'
	END		AS AGG_TYPE,
	is_cash, prod_code, grp1_type, grp2_code, grp3_class,
	SUM(value1) AS SUM_V1, SUM(value2) AS SUM_V2, SUM(value3) AS SUM_V3, SUM(value4) AS SUM_V4
FROM
	test.grouping_flat_values

GROUP BY
	simulation_id, 
	GROUPING SETS
	(
		(), (is_cash), (is_cash, prod_code), (grp1_type, grp2_code), (grp2_code, grp3_class)
	)
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		June 14, 2013, 12:24:41 AM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVGroupingSets ------------------

------------------ Build started workitem: testVNaviForeignKey ------------------
IF OBJECT_ID(N'test.vw_navi_grp_flat', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_navi_grp_flat AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_navi_grp_flat AS
-- This code was generated by T4SQL.Assoc.VNaviForeignKey @ 12/8/2013 12:16:27 AM
SELECT
	A.simulation_id,
	A.position_id,
	A.is_cash,
	A.prod_code,
	A.grp1_type,
	A.grp2_code,
	A.grp3_class,
	A.value1,
	A.value2,
	A.value3,
	A.value4,
	AA.sim_desc,
	AA.sim_type,
	AA.created_time,
	AA.creator,
	AAA.sim_type_desc,
	AB.prod_name,
	AC.description_
FROM
	[test].[grouping_flat_values] A
	INNER JOIN (
		[test].[simulation] AA
		INNER JOIN
			[test].[sim_type] AAA
		ON (AA.sim_type = AAA.sim_type_id)
	) ON (A.simulation_id = AA.id)
	INNER JOIN
		[test].[prod_type] AB
	ON (A.prod_code = AB.prod_code)
	LEFT JOIN
		[test].[grp3_class] AC
	ON (A.grp3_class = AC.grp3_class)
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		July 03, 2013, 12:56:08 AM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVNaviForeignKey ------------------

------------------ Build started workitem: testVFullPivot ------------------
IF OBJECT_ID(N'test.vw_full_pivot', N'V') IS NULL
	EXECUTE ('CREATE VIEW test.vw_full_pivot AS SELECT NULL AS CREATE_OR_REPLACE');
GO

ALTER VIEW test.vw_full_pivot AS
-- This code was generated by T4SQL.Pivot.VFullPivot @ 12/8/2013 12:16:27 AM
WITH
	CTE_MAIN AS
	(
		SELECT
			product_id,
			attrib_code,
			value_
		FROM
			test.pivot_discrete_attrib
		WHERE
			attrib_code	IN ('FIELD_A', 'FIELD_B', 'FIELD_C', 'FIELD_D', 'FIELD_E', 'FIELD_F', 'FIELD_G', 'FIELD_H')
			
	),
	JOIN_ON AS
	(
		SELECT DISTINCT
			product_id
		FROM
			CTE_MAIN
	)
	,
	CTE_0	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_A'
	)
	,
	CTE_1	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_B'
	)
	,
	CTE_2	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_C'
	)
	,
	CTE_3	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_D'
	)
	,
	CTE_4	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_E'
	)
	,
	CTE_5	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_F'
	)
	,
	CTE_6	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_G'
	)
	,
	CTE_7	AS
	(
		SELECT
			product_id,
			value_
		FROM
			CTE_MAIN
		WHERE
			attrib_code	= 'FIELD_H'
	)
SELECT
	J.product_id
	, C0.value_		AS V_A
	, C1.value_		AS V_B
	, C2.value_		AS V_C
	, C3.value_		AS V_D
	, C4.value_		AS V_E
	, C5.value_		AS V_F
	, C6.value_		AS V_G
	, C7.value_		AS V_H
FROM
	JOIN_ON		J
	LEFT JOIN
	CTE_0		C0
	ON	(J.product_id = C0.product_id)
	LEFT JOIN
	CTE_1		C1
	ON	(J.product_id = C1.product_id)
	LEFT JOIN
	CTE_2		C2
	ON	(J.product_id = C2.product_id)
	LEFT JOIN
	CTE_3		C3
	ON	(J.product_id = C3.product_id)
	LEFT JOIN
	CTE_4		C4
	ON	(J.product_id = C4.product_id)
	LEFT JOIN
	CTE_5		C5
	ON	(J.product_id = C5.product_id)
	LEFT JOIN
	CTE_6		C6
	ON	(J.product_id = C6.product_id)
	LEFT JOIN
	CTE_7		C7
	ON	(J.product_id = C7.product_id)
;
GO

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		November 26, 2013, 10:06:19 PM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean)
--
----------------------------------------------------------------------------------------------------


------------------ Build ended workitem: testVFullPivot ------------------

------------------ Build Total: 10 Workitems ------------------