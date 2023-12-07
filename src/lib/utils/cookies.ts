import settings from '$lib/settings';

const oneMonth = 60 * 60 * 24 * 30;

export const buildCookie = (
  cookieName: string,
  cookieVal: string,
  maxAge = oneMonth
) => {
  console.log('this rootDomain', settings.rootDomain);
  const cookieArgs = [
    `${cookieName}=${cookieVal}`,
    `Domain=${settings.rootDomain}`,
    `Path=/`,
    'HttpOnly',
    `Max-Age=${maxAge}`,
  ];
  return cookieArgs.join('; ');
};
