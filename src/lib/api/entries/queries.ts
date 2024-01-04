import { publicRoute, adminRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';
import { serializeEntry, serializePrize } from './serializers';

export default {
  listEntries: publicRoute.query(async () => {
    const entries = await prisma.entry.findMany();
    return (entries || []).map((h) => serializeEntry(h));
  }),
  listVotes: publicRoute.query(async () => {
    return (await prisma.vote.findMany({ where: { isReleased: true } })) || [];
  }),
  listPrizes: publicRoute.query(async () => {
    return (await prisma.prize.findMany() || []).map(p => serializePrize(p));
  }),
  listAllVotes: adminRoute.query(async () => {
    return (await prisma.vote.findMany({ include: { user: true } })) || [];
  }),
};
