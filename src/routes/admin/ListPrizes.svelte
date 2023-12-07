<script lang="ts">
  import { navigating, page } from '$app/stores';
  import { entities, ui } from '$lib/stores';
  import { dictify } from '$lib/utils/dictify';
  import type { IPrize, IVote } from '$lib/types';

  import { filterVotesByPrize, type IPrizeVote } from './utils';
  export let votes: IVote[];

  $entities.prizes = dictify<IPrize>($page.data.prizes);
  let prizes: IPrize[];
  $: {
    prizes = $navigating ? $page.data.prizes : Object.values($entities.prizes);
    prizes.sort((p1, p2) => p1.name.localeCompare(p2.name));
  }
</script>

<h3 class="container">Available Prizes</h3>
<ul class="container">
  {#each prizes as prize}
    <li class="card">
      <figure>
        <img src={prize.imageUrl} />
      </figure>
      <div class="prize-info">
        <h4>
          <span style={`border-bottom: 3px solid ${prize.color}`}
            >{prize.name}</span
          >
        </h4>
        <p>{prize.description}</p>
      </div>
      <div class="prize-cta">
        <div>
          <!-- svelte-ignore a11y-no-redundant-roles -->
          <button
            class="secondary"
            role="button"
            on:click={() => {
              $ui.popup = {
                id: 'edit-prize',
                attrs: {
                  prize,
                },
              };
            }}>Edit</button
          >

          <!-- svelte-ignore a11y-no-redundant-roles -->
          <button
            role="button"
            on:click={() => {
              $ui.popup = {
                id: 'list-votes',
                attrs: { prize },
              };
            }}
            >Release votes - {filterVotesByPrize(votes, prize).filter(
              (vp) => !vp.isReleased,
            ).length}</button
          >
        </div>

        <div>
          <!-- svelte-ignore a11y-no-redundant-roles -->
          <button
            role="button"
            on:click={() => {
              $ui.popup = {
                id: 'tally-votes',
                attrs: { prize },
              };
            }}
            >Leaderboard - {filterVotesByPrize(votes, prize).length}</button
          >
        </div>
      </div>
    </li>
  {/each}
</ul>

<style lang="scss">
  li {
    display: grid;
    grid-template-columns: 100px 1fr 200px auto;
    grid-column-gap: 1rem;
    align-items: flex-start;

    .prize-cta {
      justify-self: flex-end;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      align-items: flex-end;
      button {
        width: auto;
      }
    }
  }
</style>
