import type { ISettings } from '$lib/types';
import devSettings from './dev';
import prodSettings from './prod';

const env = process.env.NODE_ENV || 'development';

const settings: ISettings = Object.assign(
  {

  },
  env === 'production' ? prodSettings : devSettings
);

export default settings;