<script lang="ts">
  import { navigating, page } from '$app/stores';
  import { entities } from '$lib/stores';
  import type { CastVote, IEntry, IPrize, ValidationState } from '$lib/types';

  export let payload: CastVote[];
  export let prize: IPrize;
  export let ownedEntryIds = [] as string[] 
  let entries: IEntry[] = [];
  export let validation = {} as ValidationState

  $: {
    entries = $navigating
      ? $page.data.entries
      : Object.values($entities.entries);
    entries.sort((e1, e2) => e1.title.localeCompare(e2.title));
  }

  const votesTotal = 10;

  type IVote = Record<string, number>;
  let votedEntries: IVote = {};
  let votesAvailable = votesTotal;
  $: {
    votesAvailable =
      votesTotal -
      Object.values(votedEntries).reduce(
        (total, numVotes) => numVotes + total,
        0
      );
    payload = Object.entries(votedEntries)
      .map(([entryId, numVotes]) => ({
        entryId,
        numVotes,
      }))
      .filter(({ numVotes }) => numVotes > 0);
  }
  const addVote = (entryId: string) => () => {
    votedEntries = Object.assign(votedEntries, {
      [entryId]: (votedEntries[entryId] || 0) + 1,
    });
  };
  const rmVote = (entryId: string) => () => {
    votedEntries = Object.assign(votedEntries, {
      [entryId]: (votedEntries[entryId] || 0) - 1,
    });
  };
</script>

<div class="vote-form">
  <div class="container">
    <div class="card">
      <div class='card sub-card'>
        <div class="prize">
          <figure>
            <img src={prize.imageUrl} />
          </figure>
          <div class="prize-info" style={`border-color: ${prize.color}`}>
            <h2>
              <span
                data-tooltip="You can distribute your votes across the hacks"
                style={`border-bottom: 5px solid ${prize.color}`}
                >{prize.name}</span
              >
            </h2>
            <p>{prize.description}</p>
          </div>
          <div class="votes-assignable">
            <div class="votes-available">
              <span>Votes left:</span>
              {#if votesAvailable}
                <ul class="vote-icons">
                  {#each [...Array(votesAvailable).keys()] as idx}
                    <li />
                  {/each}
                </ul>
              {:else}
                <div class="no-votes">All your votes have been cast</div>
              {/if}
            </div>
            <div class="votes-info">You have {votesTotal} votes total</div>
          </div>
        </div>
        {#if validation && !validation.ok && validation.dirty}
         <aside>{validation.message}</aside>
        {/if}
      </div>
      <hr />
      <ul class="entries-list">
        {#each entries as entry}
          <li class="entry-item">
            <nav>
              <h5>{entry.title}</h5>
              {#if !ownedEntryIds.includes(entry.id)}
                <div class="vote-actions">
                  <!-- svelte-ignore a11y-no-redundant-roles -->
                  <button
                    class="rm-vote secondary"
                    role="button"
                    disabled={!votedEntries[entry.id]}
                    on:click|preventDefault={rmVote(entry.id)}>-</button
                  >
                  <!-- svelte-ignore a11y-no-redundant-roles -->
                  <button
                    class="add-vote secondary"
                    role="button"
                    disabled={!votesAvailable}
                    on:click|preventDefault={addVote(entry.id)}>+</button
                  >
                </div>
              {:else}
                <div class="vote-actions">Cannot vote for your own</div>
              {/if}
            </nav>
            <p class="entry-description">{entry.description}</p>
            <p class="entry-members">{entry.members}</p>
            <ul class="vote-icons">
              {#each [...Array(votedEntries[entry.id] ?? 0).keys()] as vote}
                <li />
              {/each}
            </ul>
          </li>
        {/each}
      </ul>
    </div>
  </div>
</div>

<style lang="scss">
  .sub-card {

    border-radius: 1rem;
    padding: 16px;
  }
  .prize {
    display: grid;
    grid-template-columns: 100px 1fr;
    grid-column-gap: 2rem;
    h2 {
      margin-bottom: calc(0.3 * var(--typography-spacing-vertical));
    }
    // border: 2px solid transparent;
    // background-color: var(--contrast);
    // color: var(--contrast-inverse);
    // p, h4, h5, select, option {
    //   color: var(--contrast-inverse);
    // }
    .votes-assignable {
      grid-column: span 2;
      margin-top: 24px;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap-reverse;
      flex-grow: 1;
      font-weight: 700;
      .vote-icons {
        margin-left: 8px;
      }
      .votes-available {
        display: flex;
      }
    }
  }
  .vote-actions {
    display: flex;
    button {
      margin: 8px 4px;
      padding: 0px 8px;
    }
  }
  nav {
    align-items: center;
    h5 {
      margin-bottom: 0;
    }
    margin-bottom: 8px;
  }
  .entries-list {
    max-height: 100%;
    overflow: auto;
    .entry-item {
      display: grid;
      // grid-template-columns: 1fr 200px auto;
      align-items: flex-start;
      margin: 8px 0;
      &:not(:last-child) {
        border-bottom: 1px solid #888;
      }
      .vote-actions {
        max-width: 100px;
      }
      .vote-icons {
        li {
          font-size: 1.5rem;
        }
      }
      .entry-description,
      .entry-members {
        white-space: pre-line;
        overflow-wrap: anywhere;
        max-width: 500px;
      }
      .entry-members {
        font-size: 1rem;
        font-style: italic;
      }
    }
  }
  .no-votes {
    margin-left: 8px;
    font-weight: 400;
  }
  .vote-icons {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-end;
    &,
    li {
      list-style: none;
    }
    li {
      font-size: 1rem;
      // padding: 0 4px;
      color: gold;
      &:before {
        content: '★';
      }
    }
  }
    aside {
      color: tomato;
    }
</style>
