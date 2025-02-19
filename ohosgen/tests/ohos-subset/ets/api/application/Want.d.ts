export default class Want {
  bundleName?: string;
  abilityName?: string;
  deviceId?: string;
  uri?: string;
  type?: string;
  flags?: number;
  action?: string;
  parameters?: Record<string, Object>;
  entities?: Array<string>;
  moduleName?: string;
}