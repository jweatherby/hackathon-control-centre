import { publicRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';
import { serializeAppControl } from './serializers';

export default {
  listAllControls: publicRoute.query(async () => {
    const ctrls = await prisma.adminControl.findMany();
    return ctrls.map(c => serializeAppControl(c))
  })
};
