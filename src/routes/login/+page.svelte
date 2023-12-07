<script>
  import { goto } from '$app/navigation';
  import LoginForm from '$lib/components/LoginForm.svelte';
  import { ui } from '$lib/stores';
</script>

<dialog open>
  <article>
    <header>
      <!-- svelte-ignore a11y-missing-content -->
      <a
        href="#close"
        class="close"
        on:click={() => {
          goto('/');
        }}
      />
      Login
    </header>
    <div>
      <LoginForm />
    </div>
  </article>
</dialog>
