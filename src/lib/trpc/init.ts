import { prisma } from '$lib/dbClient';
import { redirect, type RequestEvent } from '@sveltejs/kit';
import { initTRPC, type inferAsyncReturnType } from '@trpc/server';
import { TRPCError } from '@trpc/server';
import { ZodError } from 'zod';

/**
 * This is called in 'src/hooks.server.ts' where it injects the user into every request.
 * The 'auth' middleware below throws an error if the user is not found
 */
const errorFormatter = (opts) => {

  const { shape, error } = opts;
  return {
    ...shape,
    data: {
      ...shape.data,
      zodError:
        error.code === 'BAD_REQUEST' && error.cause instanceof ZodError
          ? error.cause.flatten()
          : null,
    },
  };
}

export async function createContext(event: RequestEvent) {
  const _user = event.cookies.get('User');
  const ctx = { errorFormatter };
  if (_user) {
    const user = JSON.parse(_user);
    return {
      ...ctx,
      user: user,
      params: event.params,
    };
  } else {
    return {
      ...ctx,
      user: null,
      params: event.params,
    };
  }
  // return { ...ctx }
}

/**
 * Initiate TRPC
 */
export type Context = inferAsyncReturnType<typeof createContext>;
export const t = initTRPC.context<Context>().create();

/**
 * Keep it simple, the middleware will be defined here.
 * Eventually, it can move into src/lib/trpc/middleware
 */
export const logger = t.middleware(async ({ path, type, next }) => {
  const start = Date.now();
  const result = await next();
  const ms = Date.now() - start;
  console.log(`${result.ok ? 'OK' : 'ERR'} ${type} ${path} - ${ms}ms`);
  return result;
});

export const auth = t.middleware(async ({ next, ctx, path }) => {
  if (!ctx.user) throw redirect(301, '/login?next=' + path);
  return next();
});

export const checkAdmin = t.middleware(async ({ next, ctx }) => {
  const adminUser = await prisma.adminUser.findUnique({
    where: {
      userId: ctx.user.id,
    },
  });
  if (!adminUser) {
    throw new TRPCError({
      message: 'You are not allowed here',
      code: 'UNAUTHORIZED',
    });
  }
  return next();
});

/**
 * Public and Private Routes
 *
 * Private route will throw an error if a user is not found
 */
export const publicRoute = t.procedure.use(logger);
export const privateRoute = publicRoute.use(auth);
export const adminRoute = privateRoute.use(checkAdmin);
