﻿CREATE FUNCTION T4SQL.ENGINE_GET_POLL_INTERVAL
(
)
RETURNS TINYINT
AS
BEGIN
	DECLARE	@Poll_Interval	TINYINT;

	SELECT	@Poll_Interval = NUMBER_VALUE
	FROM	T4SQL.ENGINE_CONFIG
	WHERE	ELEMENT_NAME = N'POLL_INTERVAL';

	RETURN	@Poll_Interval;
END;

----------------------------------------------------------------------------------------------------
--
--	Copyright 2013 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		March 24, 2013, 6:27:45 PM
--	Primary Host:		http://t4sql.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep code clean rather than complicated code plus long comments.)
--
----------------------------------------------------------------------------------------------------
