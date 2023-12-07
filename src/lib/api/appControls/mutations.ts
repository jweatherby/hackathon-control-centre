import { z } from 'zod';
import { privateRoute, adminRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';
import { serializeAppControl } from './serializers';

export default {
  toggleVoting: adminRoute.input(z.object({
    id: z.string().optional(),
    votingToggled: z.boolean(),
  })).mutation(async ({ input }) => {
    let ctrl
    if (input.id) {
      ctrl = await prisma.adminControl.update({
        where: { id: input.id },
        data: { isActive: input.votingToggled }
      })
    } else {
      ctrl = await prisma.adminControl.create({
        data: {
          controlType: 'VOTING_ENABLED',
          isActive: input.votingToggled,
          details: JSON.stringify('')
        },
      })
    }
    return serializeAppControl(ctrl)
  })
};
