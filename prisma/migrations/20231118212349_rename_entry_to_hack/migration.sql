/*
  Warnings:

  - You are about to drop the column `entryId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Entry` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_entryId_fkey";

-- DropForeignKey
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_entry_fkey";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "entryId";

-- DropTable
DROP TABLE "Entry";

-- CreateTable
CREATE TABLE "Entry" (
    "id" TEXT NOT NULL,
    "title" VARCHAR NOT NULL,
    "description" VARCHAR NOT NULL,
    "members" TEXT NOT NULL,

    CONSTRAINT "Entry_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_entry_fkey" FOREIGN KEY ("entry") REFERENCES "Entry"("id") ON DELETE CASCADE ON UPDATE CASCADE;
