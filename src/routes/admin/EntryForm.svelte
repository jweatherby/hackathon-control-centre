<script lang="ts">
  import { entities } from '$lib/stores';
  import { trpc } from '$lib/trpc/client';
  import type { IEntry } from '$lib/types';

  type FormVals = {
    id?: string;
    title: string;
    description: string;
    imageUrl: string;
    members: string;
  };
  export let initialValues: FormVals = {} as FormVals;
  export let onSuccess: (entry: IEntry) => void;

  const saveEntry = async (event: SubmitEvent) => {
    const formData = new FormData(event.target as HTMLFormElement);
    const payload: FormVals = {
      title: formData.get('title') as string,
      description: formData.get('description') as string,
      imageUrl: formData.get('imageUrl') as string,
      members: formData.get('members') as string,
    };
    if (initialValues.id) {
      payload.id = initialValues.id;
    }
    console.log('sending this payload', payload);
    trpc()
      .entries.saveEntry.mutate(payload as FormVals)
      .then((entry) => {
        $entities.entries[entry.id] = entry;
        if (onSuccess) {
          return onSuccess(entry);
        }
      });
    return;
  };
</script>

<form method="POST" on:submit|preventDefault={saveEntry}>
  <label for="title">
    Entry name
    <input
      type="text"
      id="title"
      name="title"
      value={initialValues?.title || ''}
      placeholder="Your entry's name"
    />
  </label>
  <label for="description">
    Description
    <textarea
      name="description"
      value={initialValues?.description || ''}
      id="description"
      placeholder="What does it do?"
    />
  </label>
  <label for="members">
    Members
    <textarea
      id="members"
      name="members"
      value={initialValues?.members || ''}
      placeholder="Who was on the team"
    />
  </label>
  <label for="imageUrl">
    Add an image
    <input
      id="imageUrl"
      name="imageUrl"
      value={initialValues?.imageUrl || ''}
      placeholder="https://"
    />
  </label>
  <div>
    <button type="submit">Save Entry</button>
  </div>
</form>
