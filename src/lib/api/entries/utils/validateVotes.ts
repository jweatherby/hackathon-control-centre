import type { CastVote } from "$lib/types";
import { VotingType, type Prize, type Vote } from "@prisma/client";

type PrizeValidator = (prize: Prize, votes: CastVote[]) => {ok: boolean, error?: string}

export const validatePrize: PrizeValidator = (prize: Prize, votes) => {
  return validators[prize.votingType](prize, votes)
}

const calcSumOfVotes = (votes: CastVote[]) =>
  votes.reduce((total, { numVotes }) => total + numVotes, 0);


const validators: Record<string, PrizeValidator> = {
  [VotingType.DISTRIBUTE_VOTES]: (prize: Prize, votes: CastVote[]) => {

    const totalVotes = 10
    const maxVotesPerEntry = 7

    if(!votes.length){
      return {ok: false, error: 'No votes were cast'}
    }

    if(votes.find(({numVotes}) => numVotes > maxVotesPerEntry)){
      return {
        ok: false,
        error: `No more than ${maxVotesPerEntry} votes per entry`,
      };
    }

    if(calcSumOfVotes(votes) !== totalVotes){
      return {ok: false, error: 'Not all votes were cast'}
    }

    return { ok: true };
  },
  [VotingType.SINGLE_VOTE]: (prize: Prize, votes: CastVote[]) => {

    if(!votes.length){
      return {ok: false, error: 'No vote was cast'}
    }

    if(votes.length !== 1 || calcSumOfVotes(votes) !== 1){
      return {ok: false, error: 'Only 1 vote can be cast'}
    }

    return { ok: true };
  }
}