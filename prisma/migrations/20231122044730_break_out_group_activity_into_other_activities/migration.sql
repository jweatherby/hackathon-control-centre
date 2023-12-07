/*
  Warnings:

  - The values [GROUP_ACTIVITY] on the enum `AdminControlType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "AdminControlType_new" AS ENUM ('VOTING_CLOSED', 'QUESTION', 'EMBED', 'IMAGE');
ALTER TABLE "AdminControl" ALTER COLUMN "controlType" TYPE "AdminControlType_new" USING ("controlType"::text::"AdminControlType_new");
ALTER TYPE "AdminControlType" RENAME TO "AdminControlType_old";
ALTER TYPE "AdminControlType_new" RENAME TO "AdminControlType";
DROP TYPE "AdminControlType_old";
COMMIT;
