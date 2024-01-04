import type { AnyPrize, CommitteeVotePrize, DistributedVotesPrize } from "$lib/types";

export const validatePrizePayload = (payload: Omit<AnyPrize, 'id'>) => {
  let errors = []
  console.log('validatePrizePayload', payload)
  if (payload.votingType === 'DISTRIBUTE_VOTES') {

    const { totalVotes, maxVotesPerEntry } = payload as Omit<DistributedVotesPrize, 'id'>

    if (totalVotes <= 0) {
      errors.push('Total Votes must be greater than 0')
    }

    if (maxVotesPerEntry <= 0) {
      errors.push('Votes per Entry must be greater than 0')
    }

    if (maxVotesPerEntry > totalVotes) {
      errors.push('Votes per entry cannot be greater than Total Votes')
    }
  }

  else if (payload.votingType === 'COMMITTEE_VOTES') {

    const { allowedEmails } = payload as Omit<CommitteeVotePrize, 'id'>

    if (allowedEmails?.length === 0) {
      errors.push('Must include at least one email for the committee')
    }

  }

  return { ok: !errors.length, errors }
}

export const serializePrizeInput = (payload: Omit<AnyPrize, 'id'>) => {
  const { name, description, autoRelease, numDisplayedEntries, color, imageUrl, votingType } = payload
  const newPayload = { name, description, autoRelease, numDisplayedEntries, color, imageUrl, votingType }

  if (payload.votingType === 'DISTRIBUTE_VOTES') {
    const { totalVotes, maxVotesPerEntry } = payload
    return Object.assign(newPayload, { details: JSON.stringify({ totalVotes, maxVotesPerEntry }) })
  } else if (payload.votingType === 'COMMITTEE_VOTES') {
    const { allowedEmails } = payload
    return Object.assign(newPayload, { details: JSON.stringify({ allowedEmails }) })
  }
  return newPayload
}