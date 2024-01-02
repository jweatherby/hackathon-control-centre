<script lang="ts">
  import { navigating, page } from '$app/stores';
  import { entities, ui } from '$lib/stores';
  import { dictify } from '$lib/utils/dictify';
  import DistributedVoteForm from './DistributedVoteForm.svelte';
  import type {
    CastVote,
    CastVotesPayload,
    IEntry,
    IPrize,
    ValidationState,
    VotingTypeEnum,
  } from '$lib/types';
  import SingleVoteForm from './SingleVoteForm.svelte';
  import { trpc } from '$lib/trpc/client';

  $entities.prizes = dictify<IPrize>($page.data.prizes);
  $entities.entries = dictify<IEntry>($page.data.entries);
  let prizes = [] as IPrize[];
  let votingEnabled = true;
  let ownedEntryIds = [] as string[]
  let entries = [] as IEntry[]
  let notOnTeamChecked = false
  let votingFormState = 'selecting-teams'
  const resetValidations = () => prizes.reduce(
    (all, p) => ({
      ...all,
      [p.id]: {dirty: false, ok: false, message: 'Pending'},
    }),
    {}
  );
  const resetForms = () => prizes.reduce(
    (all, p) => ({
      ...all,
      [p.id]: {} as CastVotesPayload,
    }),
    {}
  );
  $: {
    prizes = $navigating
      ? $page.data.prizes
      : Object.values($entities.prizes || {});

    prizes.sort((p1, p2) => p1.name.localeCompare(p2.name));
    votingEnabled = !!$entities.appControls.VOTING_ENABLED?.isActive;
    entries = Object.values($entities.entries)
    if((!!ownedEntryIds.length || notOnTeamChecked) && votingFormState === 'selecting-teams'){
      votingFormState = 'can-vote'
    } else if(votingFormState === 'can-vote' && (!ownedEntryIds.length && !notOnTeamChecked)){
      votingFormState = 'selecting-teams'
    }
  }
  const filterPrizes = (votingType: VotingTypeEnum) =>
    prizes.filter((p) => p.votingType === votingType);

  let payloads: Record<string, CastVote[]> = resetForms()
  let validations: Record<string, ValidationState> = resetValidations()
  
  let votesCast = !!$page.data.userVotes.length;
  const castVotes = () => {
    const apiPayload: CastVotesPayload[] = Object.entries(payloads).map(
      ([prizeId, votes]) => ({
        prizeId,
        votes,
      })
    );
    const apiCalls = [
      trpc().entries.setOwnedEntries.mutate({entryIds: ownedEntryIds as string[]}),
      ...apiPayload.map((votesPayload) => (
        trpc().entries.addVotes.mutate(votesPayload)
      )
    )];
    Promise.all(apiCalls).then(responses => {
      let hasError = false
      responses.forEach((resp) => {
        if(resp){
          const {prizeId, errors} = resp
          if(!!errors.length && prizeId){
            hasError = true
            validations[prizeId] = {
              dirty: true, 
              ok: false, 
              message: errors[0].message as string
            }
          }
        }
      })
      if(hasError){
        setTimeout(() => {
          validations= resetValidations()
        }, 5000)
      } else {
        votesCast = true
      }
    });
  };
  const toggleNotOnTeam = (event: Event) => {
    notOnTeamChecked = !!(<HTMLInputElement>event.target).checked
  } 
  const gotoTeamSelect = () => {
    notOnTeamChecked = false
    ownedEntryIds = []
    votingFormState = 'selecting-teams'
  }
  const gotoVote = () => {
    votingFormState = 'voting'
  }

</script>

{#if votesCast}
  <div class="container">
    <div class="votes-already-cast">
      <h2>Your vote has been cast!</h2>
      <p style="margin-bottom: 32px;">It may take a bit to show up ;)</p>
      <p><a href="/">Check out the leaderboard</a></p>
    </div>
  </div>
{:else if !votingEnabled}
  <div class="container">
    <div class="votes-already-cast">
      <h2>Voting is closed!</h2>
      <p><a href="/">Check out the leaderboard</a></p>
    </div>
  </div>
{:else}
  <div class="container vote-intro">
    <h2>Vote for your favorite hack!</h2>
    <!-- <div class="aside">Be sure to cast all your votes - no take-backsies!</div> -->
  </div>
  
  {#if ['selecting-teams', 'can-vote'].includes(votingFormState)}
  <div class='container select-teams'>
    <div class='card'>
      <h3>Before you get to voting</h3>
      <fieldset>
        <label>
          <p><strong>Which team(s) were you part of?</strong></p>
          <select name='entryIds' bind:value={ownedEntryIds} disabled={notOnTeamChecked} multiple>
            {#each entries as entry}
              <option value={entry.id}>{entry.title}</option>
            {/each}
          </select>
        </label>
      </fieldset>
      <fieldset>
        <label>
          Was not on a team
          <input disabled={!!ownedEntryIds.length} type='checkbox' on:change={toggleNotOnTeam} />
        </label>
      </fieldset>
      {#if votingFormState === 'can-vote'}

      <aside><button type='button' class='secondary' on:click={gotoVote}>Go Vote</button></aside>
      {:else}
        <aside>Please complete this section before voting.</aside>
      {/if}
    </div>
  </div>
  {:else}
    <div class='container goto-team-select'>
      <p>
        Listed below are the available prizes.
        <br/>Go through each section, assign all your votes.
        <br /><strong>You will not be able to recast your votes.</strong>
      </p>
      <aside>
        <button on:click={gotoTeamSelect} class='secondary'>Update your team</button>
      </aside>
    </div>
    {#each filterPrizes('SINGLE_VOTE') as prize}
      <SingleVoteForm bind:payload={payloads[prize.id]} bind:validation={validations[prize.id]} {prize} {ownedEntryIds} />
    {/each}

    {#each filterPrizes('DISTRIBUTE_VOTES') as prize}
      <DistributedVoteForm bind:payload={payloads[prize.id]}  bind:validation={validations[prize.id]} {prize} {ownedEntryIds} />
    {/each}
    <div class="container">
      <footer>
        <button class='cast-votes' on:click={castVotes}>Cast Votes</button>
      </footer>
    </div>
  {/if} 
{/if}

<style lang="scss">
  .vote-intro {
    p {
      font-size: 1.2rem;
    }
  }
  .votes-already-cast {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 100px 0;
  }
  button {
    width: auto;
    // font-size: 1.3rem;
  }
  .select-teams, .goto-team-select {
    aside {
      display: flex;
      justify-content: flex-end;
      font-style: italic;
      font-size: 0.8rem;
      // background-color: var(--secondary);
      // color: var(--secondary-inverse);
    }
  }
  .goto-team-select {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
  }
  footer {
    margin: 24px 0 50px;
    display: flex;
    justify-content: flex-end;
    text-align: center;
  }
  .cast-votes {
    font-size: 1.3rem;
  }
</style>
