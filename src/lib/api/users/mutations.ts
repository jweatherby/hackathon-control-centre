import { z } from 'zod';
import { privateRoute, publicRoute } from '$lib/trpc/init';
import { prisma } from '$lib/dbClient';
import { serializeUser } from './serializers';
import type { User } from '@prisma/client';
import { TRPCError } from '@trpc/server';

export default {
  /**
   * @route account.verify
   */
  createUser: publicRoute
    .input(
      z.object({
        // email: z.string(),
        email: z.coerce
          .string()
          .email({ message: 'Invalid email address provided' })
          .regex(/@(points|plusgrade).com/, {
            message: 'Please use your work email',
          }),
      }),
    )
    .mutation(async ({ input }) => {
      const email = input.email as string
      let user: User | null;
      user = await prisma.user.findUnique({ where: { email } });
      if (user) {
        return serializeUser(user);
      }
      user = await prisma.user.create({ data: { email } });
      if (!user) {
        throw new TRPCError({
          message: 'Could not create user',
          code: 'CONFLICT',
        });
      }
      return serializeUser(user);
    }),

  /**
   * @route account.logout
   */
  logout: privateRoute.mutation(() => {
    console.log('logging out');
  }),
};
