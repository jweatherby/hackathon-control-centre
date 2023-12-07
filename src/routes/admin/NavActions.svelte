<script lang="ts">
  import { entities, ui } from '$lib/stores';
  import EntryForm from './EntryForm.svelte';
  import ListVotes from './ReleaseVotes.svelte';
  import PrizeForm from './PrizeForm.svelte';
  import type { AppControl, AppControlVotingEnabled, IVote } from '$lib/types';
  import { navigating, page } from '$app/stores';
  import { trpc } from '$lib/trpc/client';
  import { dictify } from '$lib/utils/dictify';
    import EntriesLeaderboard from '../EntriesLeaderboard.svelte';
  export let votes: IVote[];
  $entities.appControls = dictify($page.data.appControls);
  let appControls;
  let votingEnabled = false;
  let voteControl: AppControlVotingEnabled | null;
  $: {
    appControls = $navigating
      ? $page.data.appControls
      : Object.values($entities.appControls);
    voteControl = appControls.find(
      (c: AppControl) => c.controlType === 'VOTING_ENABLED'
    );
    console.log('votingClosed', appControls, voteControl);
    votingEnabled = !voteControl || voteControl.isActive;
  }
  const toggleVoting = () => {
    trpc()
      .appControls.toggleVoting.mutate({
        id: voteControl?.id,
        votingToggled: !votingEnabled,
      })
      .then((ctrl) => {
        $entities.appControls[ctrl.id] = ctrl as AppControlVotingEnabled;
      });
  };
</script>

{#if $ui.popup.id === 'edit-entry'}
  <dialog open>
    <article>
      <header>
        <!-- svelte-ignore a11y-missing-content -->
        <a
          href="#close"
          class="close"
          on:click={() => {
            $ui.popup = { id: null };
          }}
        />
        {$ui.popup.attrs?.entry?.title || 'Add an entry'}
      </header>
      <div>
        <EntryForm
          initialValues={$ui.popup.attrs?.entry}
          onSuccess={() => {
            $ui.popup = { id: null };
          }}
        />
      </div>
    </article>
  </dialog>
{/if}

{#if $ui.popup.id === 'edit-prize'}
  <dialog open>
    <article>
      <header>
        <!-- svelte-ignore a11y-missing-content -->
        <a
          href="#close"
          class="close"
          on:click={() => {
            $ui.popup = { id: null };
          }}
        />
        {$ui.popup.attrs?.prize?.name || 'Add a prize'}
      </header>
      <div>
        <PrizeForm
          initialValues={$ui.popup.attrs?.prize}
          onSuccess={() => {
            $ui.popup = { id: null };
          }}
        />
      </div>
    </article>
  </dialog>
{/if}

{#if $ui.popup.id === 'list-votes' && $ui.popup?.attrs?.prize}
  <dialog open>
    <article style="flex-grow:1; max-width: 90vw">
      <header>
        <!-- svelte-ignore a11y-missing-content -->
        <a
          href="#close"
          class="close"
          on:click={() => {
            $ui.popup = { id: null };
          }}
        />
        Votes - {$ui.popup.attrs.prize.name}
      </header>
      <div>
        <ListVotes bind:votes prize={$ui.popup.attrs.prize} />
      </div>
    </article>
  </dialog>
{/if}

{#if $ui.popup.id === 'tally-votes' && $ui.popup?.attrs?.prize}
<dialog open>
  <article>
    <header>
      <!-- svelte-ignore a11y-missing-content -->
      <a
        href="#close"
        class="close"
        on:click={() => {
          $ui.popup = { id: null };
        }}
      />
      Votes - {$ui.popup.attrs.prize.name}
    </header>
    <div>
      <EntriesLeaderboard prize={$ui.popup.attrs.prize} />
    </div>
  </article>
</dialog>
{/if}

<div class="container">
  <div class="nav-actions">
    <button role="button" on:click={toggleVoting}
      >Voting - {votingEnabled ? 'on' : 'off'}</button
    >
    <!-- svelte-ignore a11y-no-redundant-roles -->
    <button
      role="button"
      on:click={() => {
        $ui.popup.id = 'edit-entry';
      }}>Add an entry</button
    >
    <!-- svelte-ignore a11y-no-redundant-roles -->
    <button
      role="button"
      on:click={() => {
        $ui.popup.id = 'edit-prize';
      }}>Add a prize</button
    >
  </div>
</div>

<style lang="scss">
  .nav-actions {
    display: flex;
    justify-content: flex-end;
    button {
      width: auto;
      margin-left: 8px;
    }
  }
</style>
