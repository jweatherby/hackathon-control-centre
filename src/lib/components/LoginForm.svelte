<script lang="ts">
  import { goto } from '$app/navigation';
  import { page } from '$app/stores';
  import { trpc } from '$lib/trpc/client';
  import type { IEntry } from '$lib/types';
    import { TRPCClientError } from '@trpc/client';
  import { onMount } from 'svelte';

  const formatErrors = ({message: errors}: {message: string}) => {
    return JSON.parse(errors)
  }
  let error: string
  const createUser = (event: SubmitEvent) => {
    const formData = new FormData(event.target as HTMLFormElement);
    const payload = {
      email: formData.get('email') as string,
    };
    trpc()
      .users.createUser.mutate(payload)
      .then(() => {
        const nextPage = $page.url.searchParams.get('next');
        goto(nextPage || '/');
      }).catch((_errors) => {
        const errors = formatErrors(_errors)
        error = errors[0].message
        console.log('login errors', error)
      });
  };
</script>

<form method="POST" on:submit|preventDefault={createUser}>
  <label for="email">
    Your email
    <input
      name="email"
      id="email"
      placeholder="Please add your email"
      type="email"
    />
  </label>
  {#if !!error}
   <div class='notice error'>{error}</div>
   {/if}
  <div>
    <button type="submit">Login</button>
  </div>
</form>

<style lang='scss'>
  option {
    padding: 4px 0;
  }
  .notice.error {
    color: tomato;
    font-style: italic;
    padding: 4px 0;
    font-size: 0.9rem;
  }
</style>