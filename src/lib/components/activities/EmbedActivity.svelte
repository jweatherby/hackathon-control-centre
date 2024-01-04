<script lang='ts'>
  import type { AppControlEmbed } from "$lib/types";

  export let activity: AppControlEmbed
</script>
<div class='container'>
  <div class='card'>
    <h2>Let's take a moment</h2>
    <p>{activity.instructions}</p>
    <div class='iframe-wrapper'>
      {@html activity.embedUrl}
    </div>
  </div>
</div>
<style lang='scss'>

  .iframe-wrapper {
    display: flex;
    justify-content: center;
  }
  p {
    font-weight: 700;
    font-size: 1.2rem;
    margin: 2rem 0;
    text-align: center;
  }
  h2 {
    text-align: center;
  }

</style>