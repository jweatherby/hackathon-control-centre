-- CreateEnum
CREATE TYPE "VotingType" AS ENUM ('DISTRIBUTE_VOTES', 'SINGLE_VOTE');

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "isReleased" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "prize" TEXT;

-- CreateTable
CREATE TABLE "Prize" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "votingType" "VotingType" NOT NULL,

    CONSTRAINT "Prize_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_prize_fkey" FOREIGN KEY ("prize") REFERENCES "Prize"("id") ON DELETE SET NULL ON UPDATE CASCADE;
