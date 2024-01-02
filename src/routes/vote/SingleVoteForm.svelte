<script lang="ts">
  import { navigating, page } from '$app/stores';
  import { entities } from '$lib/stores';
  import type { CastVote, IEntry, IPrize, ValidationState } from '$lib/types';
  export let payload: CastVote[];
  export let prize: IPrize;
  let entries: IEntry[] = [];
  export let ownedEntryIds = [] as string[]
  export let validation =  {} as ValidationState

  $: {
    entries = $navigating
      ? $page.data.entries
      : Object.values($entities.entries);
  }
  let entryIdVal: string;
  $: {
    payload = entryIdVal ? [{ entryId: entryIdVal, numVotes: 1 }] as CastVote[] : [];
  }
  console.log('validation', validation)
</script>

<div class="container vote-form">
  <div class='card'>
  <label for="entryId" class="prize">
    <figure>
      <img src={prize.imageUrl} alt="The Big Prize" />
    </figure>
    <div class="prize-info">
      <h3>
        <span
          data-tooltip="Assign a single vote to this hack"
          style={`border-bottom: 3px solid ${prize.color}`}>{prize.name}</span
        >
      </h3>
      <p>{prize.description}</p>
    </div>
    <div>
      <select bind:value={entryIdVal} name="entryId" id="entryId">
        <option value=''>-</option>
        {#each entries as entry}
          <option value={entry.id} disabled={ownedEntryIds.includes(entry.id)}
            >{entry.title}</option
          >
        {/each}
      </select>
    </div>
  </label>
  {#if validation && !validation.ok && validation.dirty}
   <aside>{validation.message}</aside>
  {/if}
</div>
</div>

<style lang="scss">
  .vote-form {
    margin: 24px auto;
  }
  .prize {
    display: grid;
    grid-template-columns: 50px 1fr auto;
    grid-column-gap: 2rem;
    h3 {
      margin-bottom: calc(0.3 * var(--typography-spacing-vertical));
    }
    // border: 2px solid transparent;
    border-radius: 1rem;
    padding: 16px;
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
  label {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    h2 {
      margin-bottom: calc(0.3 * var(--typography-spacing-vertical));
    }
  }
    aside {
      color: tomato;
    }
</style>
