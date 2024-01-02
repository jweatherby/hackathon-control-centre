/*
  Warnings:

  - You are about to drop the `AdminControl` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "AppControlType" AS ENUM ('VOTING_ENABLED', 'QUESTION', 'EMBED', 'IMAGE');

-- DropTable
DROP TABLE "AdminControl";

-- DropEnum
DROP TYPE "AdminControlType";

-- CreateTable
CREATE TABLE "AppControl" (
    "id" TEXT NOT NULL,
    "controlType" "AppControlType" NOT NULL,
    "details" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "AppControl_pkey" PRIMARY KEY ("id")
);
