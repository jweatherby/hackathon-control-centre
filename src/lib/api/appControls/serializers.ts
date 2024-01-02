import type { AppControlEmbed, AppControlQuestion, AppControlVotingEnabled } from "$lib/types";
import type { AppControl } from "@prisma/client";

export const serializeAppControl = (ctrl: AppControl) => {
  const ctrlBase = {
    id: ctrl.id,
    isActive: ctrl.isActive,
    controlType: ctrl.controlType,
  }
  console.log('ctrl details', ctrl.details)
  if (ctrl.controlType === 'VOTING_ENABLED') {
    return Object.assign(ctrlBase, {
      votingEnabled: ctrl.isActive,
    }) as AppControlVotingEnabled
  }
  if (ctrl.controlType === 'QUESTION') {
    const { question, imageUrl } = JSON.parse(ctrl.details) as AppControlQuestion
    return Object.assign(ctrlBase, {
      question, imageUrl
    }) as AppControlQuestion
  }
  if (ctrl.controlType === 'EMBED') {
    const { embedUrl, instructions } = JSON.parse(ctrl.details) as AppControlEmbed
    return Object.assign(ctrlBase, { embedUrl, instructions }) as AppControlEmbed
  }
  return ctrlBase
}