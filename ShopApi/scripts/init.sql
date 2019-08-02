CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);


DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE TABLE "Lists" (
        "listID" bigserial NOT NULL,
        name text NULL,
        description text NULL,
        "familyID" bigint NULL,
        CONSTRAINT "PK_Lists" PRIMARY KEY ("listID")
    );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE TABLE "Users" (
        "userID" bigserial NOT NULL,
        username text NULL,
        email text NULL,
        "passwordHash" text NULL,
        "passwordSalt" bytea NULL,
        "familyID" bigint NULL,
        CONSTRAINT "PK_Users" PRIMARY KEY ("userID")
    );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE TABLE "Families" (
        "familyID" bigserial NOT NULL,
        name text NULL,
        "adminID" bigint NULL,
        CONSTRAINT "PK_Families" PRIMARY KEY ("familyID"),
        CONSTRAINT "FK_Families_Users_adminID" FOREIGN KEY ("adminID") REFERENCES "Users" ("userID") ON DELETE RESTRICT
    );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE TABLE "ListItems" (
        "itemID" bigserial NOT NULL,
        title text NULL,
        description text NULL,
        "listID" bigint NULL,
        "userID" bigint NOT NULL,
        CONSTRAINT "PK_ListItems" PRIMARY KEY ("itemID"),
        CONSTRAINT "FK_ListItems_Lists_listID" FOREIGN KEY ("listID") REFERENCES "Lists" ("listID") ON DELETE RESTRICT,
        CONSTRAINT "FK_ListItems_Users_userID" FOREIGN KEY ("userID") REFERENCES "Users" ("userID") ON DELETE CASCADE
    );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE INDEX "IX_Families_adminID" ON "Families" ("adminID");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE INDEX "IX_ListItems_listID" ON "ListItems" ("listID");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE INDEX "IX_ListItems_userID" ON "ListItems" ("userID");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE INDEX "IX_Lists_familyID" ON "Lists" ("familyID");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    CREATE INDEX "IX_Users_familyID" ON "Users" ("familyID");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    ALTER TABLE "Lists" ADD CONSTRAINT "FK_Lists_Families_familyID" FOREIGN KEY ("familyID") REFERENCES "Families" ("familyID") ON DELETE RESTRICT;
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    ALTER TABLE "Users" ADD CONSTRAINT "FK_Users_Families_familyID" FOREIGN KEY ("familyID") REFERENCES "Families" ("familyID") ON DELETE RESTRICT;
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190731191914_init') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20190731191914_init', '2.2.6-servicing-10079');
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    ALTER TABLE "Families" DROP CONSTRAINT "FK_Families_Users_adminID";
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    ALTER TABLE "Users" DROP CONSTRAINT "FK_Users_Families_familyID";
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    DROP INDEX "IX_Users_familyID";
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    DROP INDEX "IX_Families_adminID";
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    ALTER TABLE "Families" DROP COLUMN "adminID";
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    ALTER TABLE "Users" ALTER COLUMN "familyID" TYPE bigint;
    ALTER TABLE "Users" ALTER COLUMN "familyID" SET NOT NULL;
    ALTER TABLE "Users" ALTER COLUMN "familyID" DROP DEFAULT;
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    ALTER TABLE "Users" ADD "updateTest" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    CREATE UNIQUE INDEX "IX_Users_familyID" ON "Users" ("familyID");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    ALTER TABLE "Users" ADD CONSTRAINT "FK_Users_Families_familyID" FOREIGN KEY ("familyID") REFERENCES "Families" ("familyID") ON DELETE CASCADE;
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023434_update1') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20190802023434_update1', '2.2.6-servicing-10079');
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023534_update2') THEN
    ALTER TABLE "Users" DROP COLUMN "updateTest";
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20190802023534_update2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20190802023534_update2', '2.2.6-servicing-10079');
    END IF;
END $$;
