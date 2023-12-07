// eslint-disable-next-line @typescript-eslint/no-explicit-any
export const dictify = <T>(items: any[], id = 'id'): Record<string, T> =>
  items.reduce((all, item) => Object.assign(all, { [item[id]]: item }), {});
