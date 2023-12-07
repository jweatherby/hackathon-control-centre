import { t } from '$lib/trpc/init';
import userRoutes from '$lib/api/users';
import entryRoutes from '$lib/api/entries';
import appControls from '$lib/api/appControls';

export const router = t.router({
  users: t.router({ ...userRoutes }),
  entries: t.router({ ...entryRoutes }),
  appControls: t.router({ ...appControls })
});

export type Router = typeof router;
