<script lang="ts">
  import { entities } from '$lib/stores';
  import { trpc } from '$lib/trpc/client';
  import type { IPrize, VotingTypeEnum } from '$lib/types';
  import { init } from 'svelte/internal';

  type FormVals = {
    id?: string;
    name: string;
    description: string;
    autoRelease: boolean;
    color: string;
    imageUrl: string;
    votingType: VotingTypeEnum;
  };
  export let initialValues: FormVals = {} as FormVals;
  export let onSuccess: (prize: IPrize) => void;

  const savePrize = async (event: SubmitEvent) => {
    const formData = new FormData(event.target as HTMLFormElement);
    const payload: FormVals = {
      name: formData.get('name') as string,
      description: formData.get('description') as string,
      autoRelease: (formData.get('autoRelease') as string) === 'true',
      color: formData.get('color') as string,
      imageUrl: formData.get('imageUrl') as string,
      votingType: formData.get('votingType') as VotingTypeEnum,
    };
    if (initialValues.id) {
      payload.id = initialValues.id;
    }
    console.log('sending this payload', payload);
    trpc()
      .entries.savePrize.mutate(payload as FormVals)
      .then((prize) => {
        $entities.prizes[prize.id] = prize;
        if (onSuccess) {
          return onSuccess(prize);
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
      value={initialValues?.name || ''}
      placeholder="Your prize's name"
    />
  </label>
  <label>
    Prize description
    <textarea
      placeholder="Let the people know the criteria for this prize"
      name="description"
      id="description"
      value={initialValues?.description || ''}
    />
  </label>
  <label>
    Prize Image
    <input
      placeholder="https://"
      name="imageUrl"
      id="imageUrl"
      value={initialValues?.imageUrl || ''}
    />
  </label>
  <label for="autoRelease">
    Auto-release votes
    <input
      type="checkbox"
      value={initialValues?.autoRelease || true}
      name="autoRelease"
      id="autoRelease"
    />
  </label>
  <label for="color">
    Leaderbar color
    <input
      type="color"
      value={initialValues?.color || '#ffd700'}
      name="color"
      id="color"
    />
  </label>
  <label for="voting-type">
    Voting format
    <select
      value={initialValues?.votingType || ''}
      name="votingType"
      id="voting-type"
    >
      <option value="SINGLE_VOTE">Single Vote</option>
      <option value="DISTRIBUTE_VOTES">Distribute Votes</option>
    </select>
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
