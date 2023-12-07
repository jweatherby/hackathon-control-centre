import { createContext } from '$lib/trpc/init';
import type { PageServerLoadEvent } from './$types';
import { router } from '$lib/trpc/router';
import { error, redirect } from '@sveltejs/kit';

export const load = async (event: PageServerLoadEvent) => {
  const context = await createContext(event);
  if (!context.user) {
    throw redirect(301, '/login?next=/admin');
  }
  const caller = router.createCaller(context);
  return {
    user: caller.users.checkAdmin().catch(() => {
      throw error(403, { message: 'You are not a recognized admin' });
    }),
    appControls: caller.appControls.listAllControls(),
    prizes: caller.entries.listPrizes(),
    entries: caller.entries.listEntries(),
  };
};
