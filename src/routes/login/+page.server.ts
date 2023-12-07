import { createContext } from '$lib/trpc/init';
import type { PageServerLoadEvent } from './$types';
import { redirect } from '@sveltejs/kit';

export const load = async (event: PageServerLoadEvent) => {
  const context = await createContext(event);
  if (context.user) {
    throw redirect(301, '/');
  }
};
