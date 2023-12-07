import { createContext } from '$lib/trpc/init';
import type { PageServerLoadEvent } from './$types';
import { router } from '$lib/trpc/router';

export const load = async (event: PageServerLoadEvent) => {
  const context = await createContext(event);
  const caller = router.createCaller(context);
  return {
    entries: caller.entries.listEntries(),
    prizes: caller.entries.listPrizes(),
  };
};
