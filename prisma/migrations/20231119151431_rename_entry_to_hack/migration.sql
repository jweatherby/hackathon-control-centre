/*
  Warnings:

  - You are about to drop the column `entry` on the `UserEntries` table. All the data in the column will be lost.
  - Added the required column `entry` to the `UserEntries` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "UserEntries" DROP CONSTRAINT "UserEntries_entry_fkey";

-- AlterTable
ALTER TABLE "UserEntries" DROP COLUMN "entry",
ADD COLUMN     "entry" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "UserEntries" ADD CONSTRAINT "UserEntries_entry_fkey" FOREIGN KEY ("entry") REFERENCES "Entry"("id") ON DELETE CASCADE ON UPDATE CASCADE;
