<script lang="ts">
  import { entities } from '$lib/stores';
  import { trpc } from '$lib/trpc/client';
  import type { IPrize, IVote } from '$lib/types';
  import { filterVotesByPrize, type IPrizeVote } from './utils';
  import { format } from 'date-fns';
  export let prize: IPrize;
  export let votes: IVote[];
  let toRelease: string[] = [];
  let prizeVotes: IPrizeVote[];
  $: {
    prizeVotes = filterVotesByPrize(votes, prize);
    prizeVotes.sort((p1, p2) => (p1.dateCreated < p2.dateCreated) ? 1 : -1);
    prizeVotes = prizeVotes.filter(p => !p.isReleased).concat(prizeVotes.filter(p => p.isReleased)); 
  }
  const addToSelected = (event: Event) => {
    const { checked, value } = <HTMLInputElement>event.target;
    const voteIds = value.split(',');
    if (checked) {
      toRelease = toRelease.concat(voteIds);
    } else {
      toRelease = toRelease.filter((voteId) => !voteIds.includes(voteId));
    }
  };
  const releaseVotes = () => {
    trpc().entries.releaseVotes.mutate({ voteIds: toRelease });
  };

  const selectMultiple = (event: Event) => {
    const value = (<HTMLSelectElement>event.target)?.value as string;
    if (value === '-') {
      return (toRelease = []);
    }
    const allVotes = prizeVotes.flatMap(({ votes: _votes }) => _votes);
    if (value === 'all') {
      return (toRelease = allVotes
        .filter((v) => !v.isReleased)
        .map((v) => v.id));
    }
    const numVotesToSelect = parseInt(value);
    if (typeof numVotesToSelect === 'number') {
      return (toRelease = prizeVotes
        .slice(0, numVotesToSelect)
        .flatMap(({ votes: _votes }) => _votes)
        .map((v) => v.id));
    }
  };

  const formatTime = (timestamp: string) => {
    return format(new Date(timestamp), 'h:mm a');
  };
</script>

{#if !Object.values(prizeVotes).length}
  <div>All votes have been released</div>
{:else}
  <label>
    <div />
    <div>
      Select multiple
      <select on:change={selectMultiple}>
        <option value="-">-</option>
        <option value="2">2</option>
        <option value="5">5</option>
        <option value="10">10</option>
        <option value="50">50</option>
        <option value="all">all</option>
      </select>
    </div>
  </label>
  <ul class="list-users">
    {#each prizeVotes as { user, votes: _votes, dateCreated, isReleased }}
      <li>
        <div class="card">
          <label for={`vote-${user.email}`}>
            <strong>{user.email.replace(/@.*$/, '')}</strong>
            <div>
              {#if isReleased}
                Released
              {:else}
                Release
                <input
                  type="checkbox"
                  on:change={addToSelected}
                  id={`vote-${user.email}`}
                  checked={_votes.every((v) => toRelease.includes(v.id))}
                  disabled={isReleased}
                  value={_votes.map((v) => v.id)}
                />
              {/if}
            </div>
          </label>
          <ul class="list-votes">
            {#each _votes as _vote}
              <li>
                <strong>{_vote.numVotes}</strong>
                <em>{$entities.entries[_vote.entryId].title}</em>
              </li>
            {/each}
          </ul>
          <div class="vote-time">Voted at {formatTime(dateCreated)}</div>
        </div>
      </li>
    {/each}
  </ul>
  <footer>
    <button role="button" on:click={releaseVotes}>Release Votes</button>
  </footer>
{/if}

<style lang="scss">
  .card {
    padding: 8px 24px;
    display: flex;
    flex-direction: column;
  }
  .list-users {
    padding: 0 1rem;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    grid-column-gap: 1rem;
    justify-content: center;
    max-height: 70vh;
    overflow: auto;
    li {
      display: grid;
      padding: 4px 0;
      margin: 4px 0;
      label {
        display: flex;
        justify-content: space-between;
        margin-right: -15px;
      }
      .vote-time {
        align-self: flex-end;
        font-size: 0.8rem;
        font-style: italic;
        margin-right: -15px;
      }
    }
  }
  label {
    display: flex;
    justify-content: space-between;
    select {
      width: 100px;
    }
  }
  .list-votes {
    padding: 0;
    margin: 8px 0;
    flex-grow: 1;
    li {
      display: flex;
      align-items: center;
      font-size: 0.8rem;
      padding: 2px 0;
      margin: 0px 0;
      strong {
        margin-right: 8px;
        color: var(--primary);
        font-weight: 700;
        font-size: 0.85rem;
      }
    }
  }
  footer {
    display: flex;
    justify-content: flex-end;
    button {
      width: auto;
    }
  }
</style>
