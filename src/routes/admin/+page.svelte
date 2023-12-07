<script lang="ts">
  import ListEntries from './ListEntries.svelte';
  import ListPrizes from './ListPrizes.svelte';
  import NavActions from './NavActions.svelte';
  import { entities, ui } from '$lib/stores';
  import { pollAPI } from '$lib/utils/poll';
  import { onMount } from 'svelte';
  import { trpc } from '$lib/trpc/client';
  import type { IVote } from '$lib/types';
  import { mapVotesToPrizes } from '$lib/utils/mapVotes';

  let votes: IVote[] = [];

  const fetchVotes = () =>
    trpc()
      .entries.listAllVotes.query()
      .then((_votes) => {
        votes = _votes as IVote[];
        $entities.entryVotes = mapVotesToPrizes(_votes as IVote[], {onlyReleased: false});
      });

  onMount(() => {
    pollAPI(fetchVotes, 5000);
  });
</script>

<!-- <EntryForm /> -->
<NavActions bind:votes />
<ListPrizes bind:votes />
<ListEntries />

<footer />

<style lang="scss">
  footer {
    margin-bottom: 50px;
  }
</style>
