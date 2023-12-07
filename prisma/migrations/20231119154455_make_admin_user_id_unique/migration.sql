/*
  Warnings:

  - A unique constraint covering the columns `[user]` on the table `AdminUser` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "AdminUser_user_key" ON "AdminUser"("user");
