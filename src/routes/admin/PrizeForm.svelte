<script lang="ts">
  import { entities } from '$lib/stores';
  import { trpc } from '$lib/trpc/client';
  import type { AnyPrize, DistributedVotesPrize, IPrize } from '$lib/types';

  export let initialValues = {} as AnyPrize & { id?: string };
  let formVals = {
    name: initialValues?.name,
    description: initialValues?.description,
    color: initialValues?.color || '#ffd700',
    imageUrl: initialValues?.imageUrl,
    votingType: initialValues?.votingType || 'SINGLE_VOTE',
    autoRelease: initialValues?.autoRelease || true,
    numDisplayedEntries: initialValues?.numDisplayedEntries || 7,
    allowedEmails: initialValues?.allowedEmails || [],
    maxVotesPerEntry: initialValues?.maxVotesPerEntry || 5,
    totalVotes: initialValues?.totalVotes || 10,
  } as typeof initialValues;

  export let onSuccess: (prize: IPrize) => void;

  const savePrize = async (event: SubmitEvent) => {
    if (initialValues.id) {
      formVals.id = initialValues.id;
    }
    formVals = {...formVals,
      maxVotesPerEntry: parseInt(formVals.maxVotesPerEntry),
      totalVotes: parseInt(formVals.totalVotes),
      numDisplayedEntries: parseInt(formVals.numDisplayedEntries)
    }
    trpc()
      .entries.savePrize.mutate(formVals)
      .then(({ errors, prize }) => {
        if (errors?.length) {
          return;
        } else if (prize) {
          $entities.prizes[prize.id] = prize;
          if (onSuccess) {
            return onSuccess(prize);
          }
        }
      });
    return;
  };
</script>

<form method="POST" on:submit|preventDefault={savePrize}>
  <label for="name">
    Prize name
    <input
      type="text"
      id="name"
      name="name"
      bind:value={formVals.name}
      placeholder="Your prize's name"
    />
  </label>
  <label>
    Prize description
    <textarea
      placeholder="Let the people know the criteria for this prize"
      name="description"
      id="description"
      bind:value={formVals.description}
    />
  </label>
  <label>
    Prize Image
    <input
      placeholder="https://"
      name="imageUrl"
      id="imageUrl"
      bind:value={formVals.imageUrl}
    />
  </label>
  <label for="autoRelease">
    Auto-release votes
    <input
      type="checkbox"
      bind:checked={formVals.autoRelease}
      name="autoRelease"
      id="autoRelease"
    />
  </label>
  <label for="numDisplayedEntries">
    Number of displayed entries
    <input
      type="number"
      min="1"
      bind:value={formVals.numDisplayedEntries}
      name="numDisplayedEntries"
      id="numDisplayedEntries"
    />
  </label>
  <label for="color">
    Leaderbar color
    <input
      type="color"
      bind:value={formVals.color}
      name="color"
      id="color"
    />
  </label>
  <label for="voting-type">
    Voting format
    <select
      bind:value={formVals.votingType}
      name="votingType"
      id="voting-type"
    >
      <option value="SINGLE_VOTE">Single Vote</option>
      <option value="DISTRIBUTE_VOTES">Distribute Votes</option>
    </select>
  </label>
  <label for="totalVotes">
    Number of total votes
    <input
      type="number"
      min="1"
      bind:value={formVals.totalVotes}
      name="totalVotes"
      id="totalVotes"
    />
  </label>
  <label for="maxVotesPerEntry">
    Max votes per entry
    <input
      type="number"
      min="1"
      bind:value={formVals.maxVotesPerEntry}
      name="maxVotesPerEntry"
      id="maxVotesPerEntry"
    />
  </label>
  <div class="nav-actions">
    <button type="submit">Save Prize</button>
  </div>
</form>

<style lang="scss">
  .nav-actions {
    margin-top: calc(var(--spacing) * 2) 0;
  }
  label {
    margin-bottom: calc(var(--typography-spacing-vertical) / 4);
  }
  label[for='color'],
  label[for='autoRelease'] {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  input[type='color'] {
    height: 16px;
    width: 50px;
    padding: 3px;
  }
</style>
