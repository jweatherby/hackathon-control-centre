import { createContext } from '$lib/trpc/init';
import type { PageServerLoadEvent } from './$types';
import { router } from '$lib/trpc/router';
import { redirect } from '@sveltejs/kit';

export const load = async (event: PageServerLoadEvent) => {
  const context = await createContext(event);
  if (!context.user) {
    throw redirect(301, '/login?next=/vote');
  }
  const caller = router.createCaller(context);
  return {
    userVotes: caller.users.listVotes(),
    userEntries: caller.users.listEntries(),
    prizes: caller.entries.listPrizes(),
    entries: caller.entries.listEntries(),
  };
};
