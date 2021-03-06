INSERT INTO T4SQL.ENGINE_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
VALUES ('POLL_INTERVAL', 5, null, '', 'Engine Polling Interval (Seconds).');

INSERT INTO T4SQL.ENGINE_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
VALUES ('STANDBY_BEAT', null, to_date('2013-01-01', 'yyyy-mm-dd'), '', 'Heartbeat of Standby Pump Service.');

INSERT INTO T4SQL.ENGINE_CONFIG (ELEMENT_NAME, NUMBER_VALUE, DATE_VALUE, STRING_VALUE, DESCRIPTION_)
VALUES ('PRIMARY_BEAT', null, to_date('2013-01-01', 'yyyy-mm-dd'), '', 'Heartbeat of Primary Pump Service.');

COMMIT;
