/*
  Warnings:

  - You are about to drop the `AdminControls` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "AdminControls";

-- CreateTable
CREATE TABLE "AdminControl" (
    "id" TEXT NOT NULL,
    "controlType" "AdminControlType" NOT NULL,
    "details" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "AdminControl_pkey" PRIMARY KEY ("id")
);
