<script lang="ts">
  import { goto } from '$app/navigation';
  import { trpc } from '$lib/trpc/client';
  import { onMount } from 'svelte';

  onMount(() => {
    trpc()
      .users.logout.mutate()
      .then(() => {
        goto('/', { invalidateAll: true });
      });
  });
</script>
