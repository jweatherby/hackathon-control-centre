import type { IUser } from '$lib/types';
import type { User } from '@prisma/client';

export const serializeUser = (user: User): IUser => {
  return {
    id: user.id,
    email: user.email,
  };
};
