import { publicRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';
import { serializeAppControl } from './serializers';

export default {
  listAllControls: publicRoute.query(async () => {
    const ctrls = await prisma.appControl.findMany();
    const mappedCtrls = ctrls.map(c => serializeAppControl(c))
    console.log('mappedCtrls', mappedCtrls)
    return mappedCtrls
  })
};
