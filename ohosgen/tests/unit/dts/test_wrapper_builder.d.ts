declare interface CustomComponentShape {
  shapeStyle: number
}

declare interface CustomComponentConfiguration extends CommonConfiguration {

  name: string;
  selected: boolean;
  triggerChange: Callback<boolean>;
}

declare class CustomComponentSample {

  contentModifier(modifier: ContentModifier): CustomComponentSample;
  // getContentModifier(): ContentModifier;

  // getSample(val: any): any
}
