import { z } from 'zod';
import { privateRoute, adminRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';
import { serializeEntry, serializePrize } from './serializers';
import { validatePrize } from './utils/validateVotes';
import { AppControlType } from '@prisma/client';
import { serializePrizeInput, validatePrizePayload } from './utils/validateInput';

export default {
  /**
   * @route account.verify
   */
  saveEntry: adminRoute
    .input(
      z.object({
        id: z.string().optional(),
        title: z.string(),
        description: z.string(),
        imageUrl: z.string(),
        members: z.string(),
      }),
    )
    .mutation(async ({ input: { id, ...entryVals } }) => {
      let entry;
      if (!id) {
        entry = await prisma.entry.create({ data: entryVals });
      } else {
        entry = await prisma.entry.update({ where: { id }, data: entryVals });
      }

      return serializeEntry(entry);
    }),

  setOwnedEntries: privateRoute
    .input(
      z.object({
        entryIds: z.array(z.string()),
      }),
    )
    .mutation(async ({ input: { entryIds }, ctx: { user } }) => {
      if (entryIds.length) {
        await prisma.userEntries.createMany({
          data: entryIds.map((entryId) => ({ entryId, userId: user.id })),
        });
      }
    }),
  addVotes: privateRoute
    .input(
      z.object({
        prizeId: z.string(),
        votes: z.array(
          z.object({
            entryId: z.string(),
            numVotes: z.number(),
          }),
        ),
      }),
    )
    .mutation(async ({ input: { votes, prizeId }, ctx: { user } }) => {
      const votingEnabled = await prisma.appControl.findFirst({
        where: {
          controlType: AppControlType.VOTING_ENABLED,
        },
      });
      if (!votingEnabled?.isActive) {
        return {
          errors: [{ message: 'Voting is disabled', code: 'BAD_REQUEST' }],
        };
      }
      const prize = await prisma.prize.findUniqueOrThrow({
        where: { id: prizeId },
      });
      const { ok, error } = validatePrize(prize, votes);
      if (!ok) {
        return { prizeId, errors: [{ message: error, code: 'BAD_REQUEST' }] };
      }
      await prisma.vote.deleteMany({ where: { userId: user.id } });
      await prisma.vote.createMany({
        data: votes.map(({ entryId, numVotes }) => ({
          entryId,
          numVotes,
          userId: user.id,
          prizeId,
        })),
      });
    }),

  savePrize: adminRoute
    .input(
      z.object({
        id: z.string().optional(),
        name: z.string(),
        description: z.string(),
        autoRelease: z.boolean(),
        numDisplayedEntries: z.number(),
        color: z.string(),
        imageUrl: z.string(),
        votingType: z.enum(['SINGLE_VOTE', 'DISTRIBUTE_VOTES', 'COMMITTEE_VOTES']),
        allowedEmails: z.string().array().optional(),
        totalVotes: z.number().optional(),
        maxVotesPerEntry: z.number().optional(),
      }),
    )
    .mutation(async ({ input: { id, ...prizePayload } }) => {
      let prize;
      const { ok, errors } = validatePrizePayload(prizePayload)
      if (!ok) {
        return { errors, prize: null }
      }

      const payload = serializePrizeInput(prizePayload)

      if (id) {
        prize = await prisma.prize.update({
          where: { id },
          data: payload,
        });
      } else {
        prize = await prisma.prize.create({
          data: payload,
        });
      }
      return { prize: serializePrize(prize), errors: [] };
    }),

  releaseVotes: adminRoute
    .input(
      z.object({
        voteIds: z.array(z.string()),
      }),
    )
    .mutation(async ({ input: { voteIds } }) => {
      const votes = await prisma.vote.updateMany({
        where: { id: { in: voteIds } },
        data: { isReleased: true },
      });
      return votes;
    }),
};
