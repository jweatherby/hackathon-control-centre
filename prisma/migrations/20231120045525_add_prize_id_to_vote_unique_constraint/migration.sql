/*
  Warnings:

  - A unique constraint covering the columns `[user,entry,prize]` on the table `Vote` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "Vote_user_entry_key";

-- CreateIndex
CREATE UNIQUE INDEX "Vote_user_entry_prize_key" ON "Vote"("user", "entry", "prize");
