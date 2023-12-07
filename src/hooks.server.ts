import { sequence } from '@sveltejs/kit/hooks';
import type { Handle } from '@sveltejs/kit';
import { createTRPCHandle } from 'trpc-sveltekit';
import { createContext } from '$lib/trpc/init';
import { router } from '$lib/trpc/router';
import { buildCookie } from '$lib/utils/cookies';
import type { AnyRouter, inferRouterError } from '@trpc/server';

interface ResultEnvelope {
  result: {
    data: Record<string, unknown>;
  };
  error: inferRouterError<AnyRouter>;
}

const trpcHandle = createTRPCHandle({
  router,
  createContext,
  responseMeta: (ctx) => {
    const { data: [routerResult], paths, } = ctx;
    const { result, error } = routerResult as ResultEnvelope;
    let headers;
    // console.log('paths found', paths)
    if (paths?.includes('users.createUser') && !error) {
      const user = result.data;
      headers = {
        'Set-Cookie': buildCookie('User', JSON.stringify(user)),
      };
    } else if (paths?.includes('users.logout') && !error) {
      console.log('logging user out');
      headers = {
        'Set-Cookie': buildCookie('User', '', -1),
      };
    }
    return { headers };
  },
});

export const handle: Handle = sequence(trpcHandle);
