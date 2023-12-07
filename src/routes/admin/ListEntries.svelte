<script lang="ts">
  import { navigating, page } from '$app/stores';
  import { entities, ui } from '$lib/stores';
  import type { IEntry } from '$lib/types';
  import { dictify } from '$lib/utils/dictify';

  let entries: IEntry[] = [];
  $entities.entries = dictify($page.data.entries);
  $: {
    entries = $navigating
      ? $page.data.entries
      : Object.values($entities.entries);
    entries.sort((e1, e2) => e1.title.localeCompare(e2.title));
  }
</script>

<h3 class="container">Hacks</h3>
<div class="entries-list">
  <ul class="container">
    {#each entries as entry}
      <li class="entry-item card">
        <!-- <figure class="entry-image">
          <img src={entry.imageUrl} />
        </figure> -->
        <div class="entry-info">
          <h5>{entry.title}</h5>
          <p class="entry-description">{entry.description}</p>
          <p class="entry-members">{entry.members}</p>
        </div>
        <div class="entry-cta">
          <button
            role="button"
            class="secondary"
            on:click={() => {
              $ui.popup = {
                id: 'edit-entry',
                attrs: { entry },
              };
            }}>Edit</button
          >
        </div>
      </li>
    {/each}
  </ul>
</div>

<style lang="scss">
  .entries-list {
    .entry-item {
      display: grid;
      grid-template-columns: 1fr 200px auto;
      grid-column-gap: 1rem;
      align-items: flex-start;
      .vote-actions {
        max-width: 100px;
      }
      .entry-cta {
        justify-self: flex-end;
        button {
          width: auto;
        }
      }
      .entry-description,
      .entry-members {
        white-space: pre-line;
        overflow-wrap: anywhere;
      }
      .entry-members {
        font-size: 1rem;
        font-style: italic;
      }
    }
  }
</style>
