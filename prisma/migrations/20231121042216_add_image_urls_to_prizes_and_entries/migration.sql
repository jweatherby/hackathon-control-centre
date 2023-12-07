-- AlterTable
ALTER TABLE "Entry" ADD COLUMN     "imageUrl" TEXT NOT NULL DEFAULT '';

-- AlterTable
ALTER TABLE "Prize" ADD COLUMN     "imageUrl" TEXT NOT NULL DEFAULT '',
ALTER COLUMN "color" SET DEFAULT '#ffd800';
