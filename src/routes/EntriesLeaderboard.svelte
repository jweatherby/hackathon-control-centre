<script lang="ts">
  import { page, navigating } from '$app/stores';
  import { entities, ui } from '$lib/stores';
  import type { IEntry, IPrize } from '$lib/types';
  import { dictify } from '$lib/utils/dictify';
  import EntryVotes from './EntryVotes.svelte';
  import PrizeInfo from './PrizeInfo.svelte';

  $entities.entries = dictify<IEntry>($page.data.entries);
  export let prize: IPrize;
  export let onlyReleased: boolean = false
  let topVotes: number;
  let sortableEntries: (IEntry & { numVotes: number })[] = [];
  $: {
    if ($entities.entryVotes[prize.id]) {
      topVotes = Math.max(...Object.values($entities.entryVotes[prize.id]), 0);
      let prizeVotes: Record<string, number> =
        $entities.entryVotes[prize.id] || {};
      sortableEntries = Object.values($entities.entries).map((entry) => {
        return {
          ...entry,
          numVotes: prizeVotes[entry.id] || 0,
        };
      });
      sortableEntries.sort(
        (a, b) => b.numVotes - a.numVotes || a.title.localeCompare(b.title)
      );
    }
  }
</script>

<div class="container">
  <div class="leaderboard">
    <div class="card">
      <div class="prize">
        <figure>
          <img src={prize.imageUrl} alt="The Prize!" />
        </figure>
        <div class="prize-info">
          <h3>
            <span style={`border-color: ${prize.color}`}>{prize.name}</span>
          </h3>
          <p>{prize.description}</p>
        </div>
      </div>
      <hr />
      <ul class="entries-list">
        {#each sortableEntries.slice(0, 7) as entry}
          <li class="entry-item">
            <div class="entry-info">
              <div class="entry-title">{entry.title}</div>
              <!-- <p>{entry.description}</p> -->
              <!-- <p>{entry.members}</p> -->
            </div>
            <div class="awards-list">
              <EntryVotes {topVotes} {prize} {entry} />
            </div>
          </li>
        {/each}
      </ul>
      <hr />
      <footer>
        <a href='/vote' role='button'>Vote</a>
      </footer>
    </div>
  </div>
</div>

<style lang="scss">
  .leaderboard {
    max-width: 600px;
    margin: 32px auto;
    // max
  }
  .prize {
    display: grid;
    grid-template-columns: 125px 1fr;
    grid-column-gap: 2rem;
    figure {
      border-radius: 8px;
    }
    h3 {
      margin-bottom: calc(0.3 * var(--typography-spacing-vertical));
      span {
        border-bottom: 3px solid transparent;
      }
    }
  }
  hr {
    margin-bottom: 8px;
    padding-bottom: 8px;
  }
  footer {
    display: flex;
    justify-content: flex-end;
  }
  .entry-item {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-column-gap: 2rem;
    align-items: center;
    .entry-info {
      text-align: right;
      .entry-title {
        font-weight: 500;
      }
    }
  }
</style>
