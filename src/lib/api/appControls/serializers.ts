import type { AppControlEmbed, AppControlQuestion, AppControlVotingEnabled } from "$lib/types";
import type { AdminControl } from "@prisma/client";

export const serializeAppControl = (ctrl: AdminControl) => {
  const ctrlBase = {
    id: ctrl.id,
    isActive: ctrl.isActive,
    controlType: ctrl.controlType,
  }
  if (ctrl.controlType === 'VOTING_ENABLED') {
    return Object.assign(ctrlBase, {
      votingEnabled: ctrl.isActive,
    }) as AppControlVotingEnabled
  }
  if (ctrl.controlType === 'QUESTION') {
    const { question, imageUrl } = ctrl.details as AppControlQuestion
    return Object.assign(ctrlBase, {
      question, imageUrl
    }) as AppControlQuestion
  }
  if (ctrl.controlType === 'EMBED') {
    const { embedUrl } = ctrl.details as AppControlEmbed
    return Object.assign(ctrlBase, { embedUrl }) as AppControlEmbed
  }
  return ctrlBase
}