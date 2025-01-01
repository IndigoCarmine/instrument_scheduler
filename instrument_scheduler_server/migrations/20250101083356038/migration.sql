BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "schedule" (
    "id" bigserial PRIMARY KEY,
    "instrumentId" bigint NOT NULL,
    "startTime" timestamp without time zone NOT NULL,
    "endTime" timestamp without time zone NOT NULL,
    "userName" text NOT NULL,
    "note" text NOT NULL
);


--
-- MIGRATION VERSION FOR instrument_scheduler
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('instrument_scheduler', '20250101083356038', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250101083356038', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
