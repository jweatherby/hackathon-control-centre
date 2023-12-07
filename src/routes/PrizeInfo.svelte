<script lang="ts">
  import type { IPrize } from '$lib/types';

  export let prize: IPrize;
</script>

<div>
  <h3>{prize.name}</h3>
  <p>{prize.description}</p>
</div>
