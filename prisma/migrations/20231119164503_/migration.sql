/*
  Warnings:

  - A unique constraint covering the columns `[user,entry]` on the table `Vote` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Vote_user_entry_key" ON "Vote"("user", "entry");
