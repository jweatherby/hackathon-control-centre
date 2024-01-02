import { writable, type Writable } from 'svelte/store';
import type {
  IEntry, IEntryVotes, IPrize,
  AnyAppControl
} from './types';


export interface EntityTypes {
  entries: Record<string, IEntry>;
  entryVotes: IEntryVotes;
  prizes: Record<string, IPrize>;
  appControls: Record<string, AnyAppControl>
}

interface UIType {
  popup: {
    id: null | string;
    attrs?: Record<string, any>;
  };
}


export const entities: Writable<EntityTypes> = writable({
  entries: {},
  entryVotes: {},
  prizes: {},
  appControls: {}
});

export const ui: Writable<UIType> = writable({
  popup: {
    id: null,
    attrs: {},
  },
});
