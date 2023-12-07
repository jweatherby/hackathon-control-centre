<script lang="ts">
  import { page } from '$app/stores';
  import { entities } from '$lib/stores';
  import type { IPrize, IVote, VotingTypeEnum } from '$lib/types';
  import { dictify } from '$lib/utils/dictify';
  import EntriesLeaderboard from './EntriesLeaderboard.svelte';
  import { pollAPI } from '$lib/utils/poll';
  import { trpc } from '$lib/trpc/client';
  import { onMount } from 'svelte';
  import { mapVotesToPrizes } from '$lib/utils/mapVotes';

  let prizes: IPrize[] = [];
  const filterPrizes = (votingType: VotingTypeEnum, _prizes: IPrize[]) =>
    _prizes.filter((p) => p.votingType === votingType);

  $entities.prizes = dictify<IPrize>($page.data.prizes);
  $: prizes = Object.values($entities.prizes) || [];
  const fetchVotes = () => {
    return trpc()
      .entries.listVotes.query()
      .then((_votes) => {
        $entities.entryVotes = mapVotesToPrizes(_votes as IVote[], {onlyReleased: true});
      });
  };
  onMount(() => {
    pollAPI(fetchVotes, 3000);
  });
</script>

{#each filterPrizes('DISTRIBUTE_VOTES', prizes) as prize}
  <EntriesLeaderboard {prize} />
{/each}
{#each filterPrizes('SINGLE_VOTE', prizes) as prize}
  <EntriesLeaderboard {prize} />
{/each}
