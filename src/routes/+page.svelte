<script lang="ts">
  import { page } from '$app/stores';
  import { entities } from '$lib/stores';
  import type { AppActivity, IPrize, IVote, VotingTypeEnum } from '$lib/types';
  import { dictify } from '$lib/utils/dictify';
  import EntriesLeaderboard from './EntriesLeaderboard.svelte';
  import { pollAPI } from '$lib/utils/poll';
  import { trpc } from '$lib/trpc/client';
  import { onMount } from 'svelte';
  import { mapVotesToPrizes } from '$lib/utils/mapVotes';
  import QuestionActivity from '$lib/components/activities/QuestionActivity.svelte';
  import EmbedActivity from '$lib/components/activities/EmbedActivity.svelte';

  let prizes: IPrize[] = [];
  const filterPrizes = (votingType: VotingTypeEnum, _prizes: IPrize[]) =>
    _prizes.filter((p) => p.votingType === votingType);

  $entities.prizes = dictify<IPrize>($page.data.prizes);
  let activeActivity: AppActivity | undefined
  $: prizes = Object.values($entities.prizes) || [];
  $: {
      activeActivity = Object.values($entities.appControls).find(
      ({isActive, controlType}) => 
      !!isActive && controlType !== 'VOTING_ENABLED'
    ) as (AppActivity | undefined)
  }
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

{#if activeActivity}
  {#if activeActivity.controlType === 'EMBED'}
    <EmbedActivity activity={activeActivity} />
  {:else}
    <QuestionActivity activity={activeActivity} />
  {/if}
{:else}
  {#each filterPrizes('DISTRIBUTE_VOTES', prizes) as prize}
    <EntriesLeaderboard {prize} />
  {/each}
  {#each filterPrizes('SINGLE_VOTE', prizes) as prize}
    <EntriesLeaderboard {prize} />
  {/each}
{/if}
