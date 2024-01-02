import { prisma } from "$lib/dbClient"
import type { AnyAppControl, AppActivity, AppControlEmbed, AppControlQuestion } from "$lib/types"
import type { AppControl, AppControlPayload, AppControlType } from "@prisma/client"


export const saveAppControl = async (
  controlType: AppControlType,
  { isActive, ...details }: Partial<AnyAppControl>,
  obj: AppControl,
) => {
  const payload = { isActive, controlType, details: JSON.stringify(details) };
  if (obj) {
    return await prisma.appControl.update({
      where: { id: obj.id },
      data: payload,
    });
  } else {
    return await prisma.appControl.create({
      data: payload,
    });
  }
};

export const unpublisAppActivities = async () => {
  await prisma.appControl.updateMany({
    where: { controlType: { notIn: ['VOTING_ENABLED'] } },
    data: { isActive: false },
  });
}