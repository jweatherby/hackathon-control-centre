<script lang="ts">
  import { entities } from '$lib/stores';
  import '$lib/styles/globals.scss';
  import { pollAPI } from '$lib/utils/poll';
  import { onMount } from 'svelte';
  import { trpc } from '$lib/trpc/client';
  import { dictify } from '$lib/utils/dictify';

  const fetchAppControls = () =>
    trpc()
      .appControls.listAllControls.query()
      .then((ctrls) => {
        $entities.appControls = dictify(ctrls);
      });
  onMount(() => {
    pollAPI(fetchAppControls, 10000);
  });
</script>

<nav class="container">
  <ul>
    <li><strong><a href="/">Voting McVoteFace</a></strong></li>
  </ul>
  <ul>
    <!-- <li><button on:click={() => goto('/vote')}>Vote</button></li> -->
    <!-- <li><a href="/vote">Vote</a></li> -->
    <!-- <li><a href="/admin">Admin</a></li>
    <li><a href="/logout">Logout</a></li> -->
  </ul>
</nav>
<main>
  <slot />
</main>

<style lang="scss">
  nav {
    a {
      font-size: 1.2rem;
      font-weight: 600;
    }
    margin-bottom: 24px;
    padding: 0.3rem 1rem;
  }
</style>
