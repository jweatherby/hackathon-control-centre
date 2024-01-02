<script lang='ts'>
  import type { AppControlQuestion } from "$lib/types";

  export let activity: AppControlQuestion
</script>

<div class='container'>
  <div class='card'>
    <h2>Question time!</h2>
  <figure>
    <img src={activity.imageUrl} />
  </figure>
  <h3>{activity.question}</h3>
  </div>
</div>
<style lang='scss'>
  figure {
    display: flex;
    justify-content: center;
    align-items: center;
    img {
      max-width: 400px;
      object-fit: contain;
    }
  }
  h3 {
    text-align: center;
  }
  h2 {
    text-align: center;
  }
</style>