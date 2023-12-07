import type { IPrize, IUser, IVote } from '$lib/types';

export interface IPrizeVote {
  user: IUser,
  votes: IVote[],
  dateCreated: string
  isReleased: boolean
}

export const filterVotesByPrize = (_votes: IVote[], prize: IPrize): IPrizeVote[] => {
  return Object.values(_votes
    .filter((v) => prize.id === v.prizeId)
    .reduce((all: Record<string, { user: IUser; votes: IVote[] }>, _vote) => {
      const foundVote = all[_vote.userId];
      return {
        ...all,
        [_vote.user.id]: {
          user: _vote.user,
          votes: [...(foundVote?.votes || []), _vote],
          dateCreated: _vote.dateCreated,
          isReleased: _vote.isReleased,
        },
      };
    }, {}))
};
