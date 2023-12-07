-- AlterTable
ALTER TABLE "Prize" ADD COLUMN     "autoRelease" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "color" TEXT NOT NULL DEFAULT 'gold';
