<script lang="ts">
  import { entities } from '$lib/stores';
  import type { IEntry, IPrize } from '$lib/types';

  export let prize: IPrize;
  export let entry: IEntry;
  export let topVotes: number;

  let numVotes: number;
  let prizeVotes;

  $: {
    prizeVotes = $entities.entryVotes[prize.id];
    numVotes = (prizeVotes && prizeVotes[entry.id]) || 0;
  }
  const calcWidth = (topVotes: number, _numVotes: number) => {
    if (!_numVotes) {
      return 0;
    }
    return (100 * (_numVotes || 0)) / topVotes;
  };
</script>

<div class="hack-votes" title={prize.name}>
  <div
    class="vote-rating"
    style={`width: ${calcWidth(topVotes, numVotes)}%; background-color: ${
      prize.color
    }`}
  />
  <div class="num-votes">
    {numVotes}
  </div>
</div>

<style lang="scss">
  .hack-votes {
    display: flex;
    .vote-rating {
      height: 16px;
      transition: width 0.3s;
      flex-shrink: 1;
    }
    .num-votes {
      color: #aaa;
      font-size: 0.8rem;
      margin-left: 8px;
    }
  }
</style>
