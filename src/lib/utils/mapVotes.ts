import { get } from 'svelte/store';
import { entities } from '$lib/stores';
import type { IPrize, IVote } from '$lib/types';

type PrizeVotesOpts = {
  onlyReleased: boolean
}

export const mapVotesToPrizes = (_votes: IVote[], opts: PrizeVotesOpts) => {
  const prizes = Object.values(get(entities).prizes);
  const mapVotes = (prize: IPrize): Record<string, number> =>
    _votes
      .filter(
        (v) => v.prizeId === prize.id && (opts?.onlyReleased ? v.isReleased : true),
      )
      .reduce(
        (all: Record<string, number>, vote) =>
          Object.assign(all, {
            [vote.entryId]: (all[vote.entryId] || 0) + vote.numVotes,
          }),
        {},
      );
  return prizes.reduce(
    (all, prize) => ({
      ...all,
      [prize.id]: mapVotes(prize),
    }),
    {},
  );
};