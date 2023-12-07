import type { IEntry, IVote, IPrize } from '$lib/types';
import type { Entry, Prize, Vote } from '@prisma/client';

export const serializeEntry = (entry: Entry): IEntry => {
  return {
    id: entry.id,
    title: entry.title,
    description: entry.description,
    imageUrl: entry.imageUrl,
    members: entry.members,
  };
};

export const serializePrize = (prize: Prize): IPrize => {
  return {
    id: prize.id,
    name: prize.name,
    description: prize.description,
    autoRelease: prize.autoRelease,
    color: prize.color,
    imageUrl: prize.imageUrl,
    votingType: prize.votingType,
  };
};

export const serializeVote = (vote: Vote): IVote => {
  return {
    id: vote.id,
    entryId: vote.entryId,
    numVotes: vote.numVotes,
    prizeId: vote.prizeId,
    isReleased: vote.isReleased,
    dateCreated: vote.dateCreated,
  };
};
