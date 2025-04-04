declare class WrappedBuilder<Args extends Object[]> {

  builder: (...args: Args) => void;
  constructor(builder: (...args: Args) => void);
}

declare function wrapBuilder<Args extends Object[]>(builder: (...args: Args) => void): WrappedBuilder<Args>;

declare interface ContentModifier<T> {

  applyContent(): WrappedBuilder<[T]>
}

declare interface CommonConfiguration<T> {

  enabled: boolean,
  contentModifier: ContentModifier<T>
}

declare interface CustomComponentShape {
  shapeStyle: number
}

declare interface CustomComponentConfiguration extends CommonConfiguration<CustomComponentConfiguration> {

  name: string;
  selected: boolean;
  triggerChange: Callback<boolean>;
}

declare class CustomComponentSample {

  contentModifier(modifier: ContentModifier<CustomComponentConfiguration>): CustomComponentSample;
}
