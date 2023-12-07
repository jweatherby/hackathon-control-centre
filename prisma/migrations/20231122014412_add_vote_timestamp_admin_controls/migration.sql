-- CreateEnum
CREATE TYPE "AdminControlType" AS ENUM ('VOTING_CLOSED', 'GROUP_ACTIVITY');

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "dateCreated" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP;

-- CreateTable
CREATE TABLE "AdminControls" (
    "id" TEXT NOT NULL,
    "controlType" "AdminControlType" NOT NULL,
    "details" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "AdminControls_pkey" PRIMARY KEY ("id")
);
