/*
  Warnings:

  - Made the column `prize` on table `Vote` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_prize_fkey";

-- AlterTable
ALTER TABLE "Vote" ALTER COLUMN "prize" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_prize_fkey" FOREIGN KEY ("prize") REFERENCES "Prize"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
