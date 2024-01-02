import { z } from 'zod';
import { adminRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';
import { serializeAppControl } from './serializers';
import { saveAppControl, unpublisAppActivities } from './operations';
import type { AppControl } from '@prisma/client';
import type { AppActivity } from '$lib/types';

export default {
  toggleVoting: adminRoute.input(z.object({
    votingToggled: z.boolean(),
  })).mutation(async ({ input }) => {
    const _ctrls = await prisma.appControl.findMany()
    const ctrls: Record<string, AppControl> = _ctrls.reduce(
      (all, ctrl) => ({ ...all, [ctrl.controlType]: ctrl }),
      {},
    );
    const newCtrl = await saveAppControl(
      'VOTING_ENABLED',
      { isActive: input.votingToggled },
      ctrls.VOTING_ENABLED,
    );
    return serializeAppControl(newCtrl)
  }),
  setActivity: adminRoute.input(z.object({
    liveQuestion: z.object({
      imageUrl: z.string(),
      question: z.string(),
      isActive: z.boolean(),
    }).optional(),
    embed: z.object({
      embedUrl: z.string(),
      instructions: z.string(),
      isActive: z.boolean(),
    }).optional()
  })).mutation(async ({input}) => {
    const _ctrls = await prisma.appControl.findMany()
    const ctrls: Record<string, AppControl> = _ctrls.reduce(
      (all, ctrl) => ({ ...all, [ctrl.controlType]: ctrl }),
      {},
    );
    await unpublisAppActivities()
    if(input.embed?.isActive){
      await saveAppControl('EMBED', input.embed as AppActivity, ctrls.EMBED as AppControl);
    }
    if(input.liveQuestion?.isActive){
      await saveAppControl('QUESTION', input.liveQuestion as AppActivity, ctrls.QUESTION as AppControl);
    }
    const _newCtrls = await prisma.appControl.findMany()
    return _newCtrls.map((ctrl) => serializeAppControl(ctrl));
  })
};
