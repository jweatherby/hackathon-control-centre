<script lang='ts'>
    import { entities } from "$lib/stores";
    import { trpc } from "$lib/trpc/client";
    import type { AppControlQuestion, AppControlEmbed } from "$lib/types";

  let formVals = {
    votingEnabled: !!$entities.appControls.VOTING_ENABLED?.isActive,
    liveQuestion: $entities.appControls.QUESTION || {
      controlType: 'QUESTION',
      imageUrl: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/1-single-blue-question-mark-jesper-klausenscience-photo-library.jpg",
      question: 'Spoons or forks?',
      isActive: false,
    } as AppControlQuestion,
    embed: $entities.appControls.EMBED || {
      embedUrl: '',
      instructions: '',
      isActive: false,
      controlType: 'EMBED',
    } as AppControlEmbed
  }
  console.log('these appControls', $entities.appControls)
  type ActivityType = 'QUESTION' | 'EMBED' | null
  const setActivity = (activityType: ActivityType) => () => {
    formVals.embed.isActive = activityType === 'EMBED'
    formVals.liveQuestion.isActive = activityType === 'QUESTION'
  }
  const toggleVoting = () => {
    formVals.votingEnabled = !formVals.votingEnabled
  }
  const updateSettings = async () => {
    console.log('updateSettings', formVals)
    const results = await Promise.all([
      trpc().appControls.toggleVoting.mutate({
        votingToggled: formVals.votingEnabled
      }),
      trpc().appControls.setActivity.mutate({
        liveQuestion: formVals.liveQuestion as AppControlQuestion, 
        embed: formVals.embed as AppControlEmbed
      })
    ])
    console.log('updateSettings payload', formVals)
    console.log('updateSettings results', results)
  }
</script>

<form on:submit|preventDefault={updateSettings}>

  <label class='voting-checkbox'>
    Voting Enabled
    <input 
      name='votingEnabled' 
      type='checkbox' 
      role='switch'
      checked={formVals.votingEnabled} 
      on:change={toggleVoting} 
    />
  </label>


  <div>
    <div>
      <strong>
        Get the audience involved. 
      </strong>
    </div>
    <div  class='activity-ctas'>
    <button class='secondary' type='button' on:click={setActivity('QUESTION')}>Ask a question</button>
    <button class='secondary' type='button' on:click={setActivity('EMBED')}>Embed an activity</button>
    {#if !!(formVals.liveQuestion.isActive || formVals.embed.isActive)}
      <button class='secondary' type='button' on:click={setActivity(null)}>Show voting</button>
    {/if}
    </div>
  </div>

  {#if formVals.liveQuestion.isActive}
    <label>
      <figure class='question-image'><img src={formVals.liveQuestion.imageUrl} /></figure>
      Add an image
      <input type='text' name='imageUrl' bind:value={formVals.liveQuestion.imageUrl} />
    </label>
    <label>
      What is your question
      <input type='text' name='question' bind:value={formVals.liveQuestion.question} />
    </label>
  {/if}

  {#if formVals.embed.isActive}
  <label>
    Add instructions
    <textarea name='instructions' bind:value={formVals.embed.instructions} />
  </label>
  <label>
    Embed an activity
    <input name='embedUrl' bind:value={formVals.embed.embedUrl} />
  </label>
  <div class='iframe-wrapper'>
    {#if formVals.embed.embedUrl}
      {@html formVals.embed.embedUrl}
    {/if}
  </div>
  {/if}

  <div class='form-actions'>
    <span class='notice'></span>
    <button type='submit'>Save</button>
  </div>
  

</form>

<style lang="scss">
  label {
    margin: 1rem 0;
  }
  .voting-checkbox {
    display: flex;
    justify-content: space-between;
  }
  .activity-ctas {
    display: flex;
    // justify-content: center;
    button {
      width: auto; 
      margin-top: 1rem;
      margin-right: 16px;
      font-size: 1rem;
    }
  }
  .question-image {
    display: flex;
    justify-content: center;
    img {
    max-width: 200px;
    object-fit: contain;
    }
  }
  .iframe-wrapper {
    display: flex;
    justify-content: center;
    padding: 16px 0;
  }
  .form-actions {
    margin-top: 2rem;
    display: flex;
    justify-content: space-between;
    button {
      width: auto;
    }
  }
</style>