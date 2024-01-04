export type VotingTypeEnum = 'SINGLE_VOTE' | 'DISTRIBUTE_VOTES' | 'COMMITTEE_VOTES';
export interface IEntry {
  id: string;
  title: string;
  description: string;
  imageUrl: string;
  members: string;
}

export type IEntryVotes = Record<string, Record<string, number>>;

export type IVote = {
  id: string;
  entryId: string;
  userId: string;
  numVotes: number;
  prizeId: string;
  isReleased: boolean;
  dateCreated: string
  user?: IUser
};

export interface IPrize {
  id: string;
  name: string;
  description: string;
  autoRelease: boolean;
  numDisplayedEntries: number;
  color: string;
  imageUrl: string;
  votingType: VotingTypeEnum;
}

export type SingleVotePrize = IPrize

export interface DistributedVotesPrize extends IPrize {
  totalVotes: number
  maxVotesPerEntry: number
}

export interface CommitteeVotePrize extends IPrize {
  allowedEmails: string[]
}

export type AnyPrize = SingleVotePrize & DistributedVotesPrize & CommitteeVotePrize

export interface IUser {
  id: string;
  email: string;
}
export type CastVote = { entryId: string; numVotes: number }
export type CastVotesPayload = {
  prizeId: string;
  votes: CastVote[];
};

export type ValidationState = { dirty: boolean, ok: boolean, message: string }

export type AnyAppControl = AppControlVotingEnabled | AppControlQuestion | AppControlEmbed
export type AppActivity = AppControlQuestion | AppControlEmbed

export type AppControlVotingEnabled = {
  id: string,
  isActive: boolean
  controlType: 'VOTING_ENABLED'
}

export type AppControlQuestion = {
  id: string,
  question: string
  imageUrl?: string
  isActive: boolean
  controlType: 'QUESTION'
}

export type AppControlEmbed = {
  id: string,
  embedUrl: string
  instructions: string
  isActive: boolean
  controlType: 'EMBED'
}

// eslint-disable-next-line @typescript-eslint/no-empty-interface
export interface ISettings {
  rootDomain: string;
  pollingEnabled: boolean,
}

