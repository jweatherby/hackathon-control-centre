# create-svelte

Everything you need to build a Svelte project, powered by [`create-svelte`](https://github.com/sveltejs/kit/tree/master/packages/create-svelte).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```bash
# create a new project in the current directory
npm create svelte@latest

# create a new project in my-app
npm create svelte@latest my-app
```

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

To create a production version of your app:

```bash
npm run build
```

You can preview the production build with `npm run preview`.

> To deploy your app, you may need to install an [adapter](https://kit.svelte.dev/docs/adapters) for your target environment.

## Helpful SQL queries

### If hosting on fly.io
```sh
flyctl proxy 54321:5432 -a hackathon-command-centre-db
# connect to db
DATABASE_URL=postgresql://{pg_user}:{pw}@localhost:54321/hackathon_command_centre?statusColor=F8F8F8&enviroment=production&name=HCC%20Prod&tLSMode=0&usePrivateKey=false&safeModeLevel=0&advancedSafeModeLevel=0
```

### View the votes
```sql
SELECT "Vote".* FROM "Vote", "User" WHERE "User"."id" = "Vote"."user" and "User"."email" = '{email}';
```

### View the entries for a given user
```sql
SELECT "UserEntries".* from  "UserEntries", "User" WHERE "user" = "User"."id" and "email"='{email}';
```

### Dashboard Stats

```sql
SELECT 
  "Prize"."name", "Entry"."title", SUM("Vote"."numVotes") as totalVotes 
FROM 
  "Vote", "Entry", "Prize" 
WHERE 
  "Vote"."entry" = "Entry"."id" 
  and "Prize"."id" = "Vote"."prize" 
GROUP BY 
  "Entry"."id", "Prize"."name" 
ORDER BY 
  "Prize"."name" ASC, totalVotes ASC;
```
