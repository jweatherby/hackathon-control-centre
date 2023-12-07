import { adminRoute, privateRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';

export default {
  checkAdmin: adminRoute.query(async ({ ctx: { user } }) => {
    return user;
  }),
  listEntries: privateRoute.query(async ({ ctx: { user } }) => {
    return (
      (await prisma.userEntries.findMany({ where: { userId: user.id } })) || []
    );
  }),
  listVotes: privateRoute.query(async ({ ctx: { user } }) => {
    return (await prisma.vote.findMany({ where: { userId: user.id } })) || [];
  }),
};
