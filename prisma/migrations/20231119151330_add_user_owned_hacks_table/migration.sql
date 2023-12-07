/*
  Warnings:

  - You are about to drop the column `entry` on the `Vote` table. All the data in the column will be lost.
  - Added the required column `entry` to the `Vote` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_entry_fkey";

-- AlterTable
ALTER TABLE "Vote" DROP COLUMN "entry",
ADD COLUMN     "entry" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "UserEntries" (
    "id" TEXT NOT NULL,
    "user" TEXT NOT NULL,
    "entry" TEXT NOT NULL,

    CONSTRAINT "UserEntries_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "UserEntries" ADD CONSTRAINT "UserEntries_user_fkey" FOREIGN KEY ("user") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserEntries" ADD CONSTRAINT "UserEntries_entry_fkey" FOREIGN KEY ("entry") REFERENCES "Entry"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_entry_fkey" FOREIGN KEY ("entry") REFERENCES "Entry"("id") ON DELETE CASCADE ON UPDATE CASCADE;
