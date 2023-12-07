-- DropForeignKey
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_prize_fkey";

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_prize_fkey" FOREIGN KEY ("prize") REFERENCES "Prize"("id") ON DELETE CASCADE ON UPDATE CASCADE;
