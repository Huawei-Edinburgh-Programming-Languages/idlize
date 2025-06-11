| Component | Function | Owner | Status (done=merged **with** UT, testskipped=merged **without** UT, blocked=blocked by IDL)| verification status |issue/comment|
| --------- | -------- | ----- | ------ |------|------|
|*AlphabetIndexer*| *Component* |Ekaterina Stepanova| done | tested partially |  |
|`construct`| Function |Ekaterina Stepanova| done | pass |  |
|`setAlphabetIndexerOptions`| Function |Ekaterina Stepanova| done | pass | deprecated |
|`color`| Function |Ekaterina Stepanova| done | pass |  |
|`selectedColor`| Function |Ekaterina Stepanova| done | pass |  |
|`popupColor`| Function |Ekaterina Stepanova| done | pass |  |
|`selectedBackgroundColor`| Function |Ekaterina Stepanova| done | pass |  |
|`popupBackground`| Function |Ekaterina Stepanova| done | pass |  |
|`popupSelectedColor`| Function |Ekaterina Stepanova| done | pass |  |
|`popupUnselectedColor`| Function |Ekaterina Stepanova| done | pass |  |
|`popupItemBackgroundColor`| Function |Ekaterina Stepanova| done | pass |  |
|`usingPopup`| Function |Ekaterina Stepanova| done | pass |  |
|`selectedFont`| Function |Ekaterina Stepanova| done | pass |  |
|`popupFont`| Function |Ekaterina Stepanova| done | pass |  |
|`popupItemFont`| Function |Ekaterina Stepanova| done | pass |  |
|`itemSize`| Function |Ekaterina Stepanova| done | pass |  |
|`font`| Function |Ekaterina Stepanova| done | pass |  |
|`onSelect`| Function |Ekaterina Stepanova| done | failed | OHOSUI-2172 |
|`onRequestPopupData`| Function |Skroba Gleb| done | failed | OHOSUI-2172 |
|`onPopupSelect`| Function |Ekaterina Stepanova| done | failed | OHOSUI-2172 |
|`selected`| Function |Ekaterina Stepanova| done | pass |  |
|`popupPosition`| Function |Ekaterina Stepanova| done |  |  |
|`autoCollapse`| Function |Ekaterina Stepanova| done | pass |  |
|`popupItemBorderRadius`| Function |Ekaterina Stepanova| done | pass |  |
|`itemBorderRadius`| Function |Ekaterina Stepanova| done | pass |  |
|`popupBackgroundBlurStyle`| Function |Ekaterina Stepanova| done | pass |  |
|`popupTitleBackground`| Function |Ekaterina Stepanova| done | pass |  |
|`enableHapticFeedback`| Function |Ekaterina Stepanova| done |  | not supported by dayu200; need to test on mobile device |
|`alignStyle`| Function |Ekaterina Stepanova| done | pass |  |
|*Animator*| *Component* |  managed side | managed side |  |  |
|`construct`| Function |  managed side | managed side |  |  |
|`setAnimatorOptions`| Function | managed side | managed side |  |
|`state`| Function |  managed side | managed side |  |  |
|`duration`| Function |  managed side | managed side |  |  |
|`curve`| Function |  managed side | managed side |  |  |
|`delay`| Function |  managed side | managed side |  |  |
|`fillMode`| Function |  managed side | managed side |  |  |
|`iterations`| Function |  managed side | managed side |  |  |
|`playMode`| Function |  managed side | managed side |  |  |
|`motion`| Function |  managed side | managed side |  |  |
|`onStart`| Function |  managed side | managed side |  |  |
|`onPause`| Function |  managed side | managed side |  |  |
|`onRepeat`| Function |  managed side | managed side |  |  |
|`onCancel`| Function |  managed side | managed side |  |  |
|`onFinish`| Function |  managed side | managed side |  | deprecated since 12  |
|`onFrame`| Function |  managed side | managed side |  | deprecated since 12  |
|*Badge*| *Component* |Vadim Voronov | done | test blocked |  |
|`construct`| Function |Vadim Voronov | done | test blocked | test blocked by incorrect SDK.|
|`setBadgeOptions0`| Function |Vadim Voronov | done | test blocked | test blocked by incorrect SDK.|
|`setBadgeOptions1`| Function |Vadim Voronov | done | test blocked | test blocked by incorrect SDK.|
|*Blank*| *Component* | Skroba Gleb | done | pass |  |
|`construct`| Function | Skroba Gleb | done | pass |  |
|`setBlankOptions`| Function | Skroba Gleb | done | pass |  |
|`color`| Function | Skroba Gleb | done | pass |  |
|*Button*| *Component* | Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function | Evstigneev Roman | done |  pass |  |
|`setButtonOptions0`| Function | Evstigneev Roman | done | pass |  |
|`setButtonOptions1`| Function | Evstigneev Roman | done | pass |  |
|`setButtonOptions2`| Function | Evstigneev Roman | done | pass |  |
|`type`| Function | Evstigneev Roman | done | pass |  |
|`stateEffect`| Function |Evstigneev Roman | done | pass |  |
|`buttonStyle`| Function |Evstigneev Roman | done | pass |  |
|`controlSize`| Function |Evstigneev Roman | done | pass |  |
|`role`| Function | Evstigneev Roman | done | Tuzhilkin Ivan |  |
|`fontColor`| Function | Evstigneev Roman | testskipped | pass | Ace issue fixed, test in progress Evstigneev Roman |
|`fontSize`| Function | Evstigneev Roman | testskipped | pass | Ace issue fixed, test in progress Evstigneev Roman |
|`fontWeight`| Function |Evstigneev Roman | testskipped | pass | Ace issue fixed, test in progress Evstigneev Roman |
|`fontStyle`| Function |Evstigneev Roman | done | pass |  |
|`fontFamily`| Function |Evstigneev Roman | done | pass |  |
|`contentModifier`| Function |Evstigneev Roman | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG (+) & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|`labelStyle`| Function |Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`minFontScale`| Function | Kovalev Sergey | done |  | |
|`maxFontScale`| Function | Kovalev Sergey | done |  | |
|*CalendarPicker*| *Component* |Politov Mikhail | done |  |  |
|`construct`| Function |Politov Mikhail | done |  |  |
|`setCalendarPickerOptions`| Function |Politov Mikhail | testskipped | failed | UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IB7RNZ, test failed OHOSUI-2244 |
|`textStyle`| Function |Politov Mikhail | done | pass |  |
|`onChange`| Function |Politov Mikhail | done | pass |  |
|`markToday`| Function | Samarin Sergey | done | pass | same as in arkui, false is not applied |
|`edgeAlign`| Function |Politov Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Canvas*| *Component* |Vadim Voronov | blocked AceEngine |  |
|`construct`| Function |Vadim Voronov | done | pass |
|`setCanvasOptions0`| Function |Vadim Voronov | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setCanvasOptions1`| Function |Vadim Voronov | blocked AceEngine | test blocked | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onReady`| Function |Vadim Voronov | done |  |  |
|`enableAnalyzer`| Function |Vadim Voronov | done |  |  |
|*Checkbox*| *Component* | Andrey Khudenkikh | blocked IDL | failed |  |
|`construct`| Function |Samarin Sergey | done | pass | |
|`setCheckboxOptions`| Function | Samarin Sergey | done | pass | |
|`select`| Function | Andrey Khudenkikh | done | pass |  |
|`selectedColor`| Function | Andrey Khudenkikh | done | pass |  |
|`shape`| Function | Andrey Khudenkikh | done | pass |  |
|`unselectedColor`| Function | Andrey Khudenkikh | done | failed | OHOSUI-2401 |
|`mark`| Function | Andrey Khudenkikh | done | failed | OHOSUI-2401 |
|`onChange`| Function | Andrey Khudenkikh | done | pass |  |
|`contentModifier`| Function | Andrey Khudenkikh | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*CheckboxGroup*| *Component* | Dudkin Sergey| done |  |  |
|`construct`| Function |Dudkin Sergey| done | pass |  |
|`setCheckboxGroupOptions`| Function | Dudkin Sergey| done | pass |  |
|`selectAll`| Function | Dudkin Sergey | done | pass |  |
|`selectedColor`| Function | Dudkin Sergey | done | failed | OHOSUI-2181 |
|`unselectedColor`| Function | Dudkin Sergey | done | failed | OHOSUI-2181 |
|`mark`| Function | Dudkin Sergey | done | failed | test failed info: strokeColor doesn`t work, OHOSUI-2181 |
|`onChange`| Function | Dudkin Sergey | done | pass |  |
|`checkboxShape`| Function | Dudkin Sergey | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Circle*|*Component*| Erokhin Ilya | done | pass |  |
|`construct`| Function |Erokhin Ilya | done | pass |  |
|`setCircleOptions`|Function| Erokhin Ilya | done | pass |  |
|*Column*| *Component* | Politov Mikhail | done |  |  |
|`construct`| Function | Politov Mikhail | done | pass |  |
|`setColumnOptions0`| Function | Politov Mikhail | done | | |
|`setColumnOptions1`| Function | Dudkin Sergey | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IC3NZW |
|`alignItems`| Function | Politov Mikhail | done | pass |  |
|`justifyContent`| Function | Politov Mikhail | done | pass |  |
|`pointLight`| Function | Evstigneev Roman | done | pass | UT by Evstigneev Roman |
|`reverse`| Function | Politov Mikhail | done | pass |  |
|*ColumnSplit*| *Component* | Dmitry A Smirnov| done |  | |
|`construct`| Function |Dmitry A Smirnov| done | pass | |
|`setColumnSplitOptions`| Function | Dmitry A Smirnov| done | pass |  |
|`resizeable`| Function | Dmitry A Smirnov| done | pass |  |
|`divider`| Function | Dmitry A Smirnov| done | test blocked IDL | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*CommonMethod*|*Component*|Skroba Gleb,Erokhin Ilya | in progress |  |  |
|`construct`| Function |Skroba Gleb |done | pass | empty implementation, functional is supported by managed side |
|`width`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`height`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`drawModifier`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`responseRegion`| Function | Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`mouseResponseRegion`| Function | Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`size`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`constraintSize`| Function | Roman Sedaikin | done | pass | |
|`hitTestBehavior`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`onChildTouchTest`| Function | Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`layoutWeight`| Function | Roman Sedaikin | done | pass | |
|`chainWeight`| Function | Politov Mikhail | testskipped | test blocked | https://gitee.com/openharmony/arkui_ace_engine/issues/IBJW6H, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA
|`padding`| Function | Skroba Gleb | done | pass | |
|`safeAreaPadding`| Function |Dmitry A Smirnov | done | failed | commented ViewAbstract static methods code |
|`margin`| Function | Skroba Gleb | done | pass | |
|`backgroundColor`| Function |Skroba Gleb| done | failed | commented ViewAbstract static methods code |
|`pixelRound`| Function | Skroba Gleb | done | pass |  |
|`backgroundImageSize`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`backgroundImagePosition`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`backgroundEffect0`| Function |Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`backgroundEffect1`| Function | Evstigneev Roman | testskipped | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`backgroundImageResizable`| Function | Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`foregroundEffect`| Function | Skroba Gleb | done | pass |  |
|`visualEffect`| Function | Skroba Gleb | blocked IDL | failed | napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code | |
|`backgroundFilter`| Function | Skroba Gleb | blocked IDL | failed  | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY & napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code |
|`foregroundFilter`| Function | Skroba Gleb |  blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY & napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code |
|`compositingFilter`| Function | Skroba Gleb | blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY & napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code |
|`opacity`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`border`| Function | Roman Sedaikin | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`borderStyle`| Function | Roman Sedaikin | done | pass | |
|`borderWidth`| Function | Roman Sedaikin | done | pass | |
|`borderColor`| Function | Roman Sedaikin | done | pass | |
|`borderRadius`| Function | Roman Sedaikin | done | pass | |
|`borderImage`| Function | Roman Sedaikin | done | failed | |
|`outline`| Function |Skroba Gleb | done | pass | |
|`outlineStyle`| Function | Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`outlineWidth`| Function |Skroba Gleb | done | failed | bug hos2403, commented ViewAbstract static methods code, demo test by Vadim Voronov |
|`outlineColor`| Function | Skroba Gleb | done | failed | bug hos2403, commented ViewAbstract static methods code, demo test by Vadim Voronov |
|`outlineRadius`| Function |Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`foregroundColor`| Function | Erokhin Ilya | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onClick0`| Function |Roman Sedaikin | done | pass | EVENT |
|`onClick1`| Function |Roman Sedaikin | done | pass | EVENT |
|`onHover`| Function | Andrey Khudenkikh | done | pass | EVENT |
|`onHoverMove`| Function | Tuzhilkin Ivan | done | failed | need cherry-pick to feature_branch, commented ViewAbstract static methods code |
|`onAccessibilityHover`| Function | Andrey Khudenkikh | done | test blocked | UT by Vadim Voronov EVENT, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`hoverEffect`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`onMouse`| Function | Kovalev Sergey | done | pass | EVENT |
|`onTouch`| Function | Roman Sedaikin | testskipped | pass | EVENT |
|`onKeyEvent0`| Function | Pavelyev Ivan | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`onKeyEvent1`| Function |Pavelyev Ivan | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`onDigitalCrown`| Function | Evstigneev Roman | done | test blocked | feature: API not present, test blocked since wearable, commented ViewAbstract static methods code |
|`onKeyPreIme`| Function | Pavelyev Ivan | done | failed | unit tests failed, commented ViewAbstractModelNG static methods code |
|`onKeyEventDispatch`| Function | Lobah Mikhail| done| failed  | Not exists on FB, commented ViewAbstract static methods code|
|`onFocusAxisEvent`| Function | Evstigneev Roman | done | test blocked | feature: API not present, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onAxisEvent`| Function | Tuzhilkin Ivan | done | failed | need cherry-pick to feature_branch, need to submit issue |
|`focusable`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`nextFocus`| Function | Politov Mikhail | done | test blocked | done on upstream, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`tabStop`| Function | Lobah Mikhail| done| failed | Not exists on FB, commented ViewAbstract static methods code |
|`onFocus`| Function | Roman Sedaikin | done | pass | |
|`onBlur`| Function | Roman Sedaikin | done | pass | |
|`tabIndex`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`defaultFocus`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`groupDefaultFocus`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`focusOnTouch`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`focusBox`| Function | Dudkin Sergey | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA info: LinkerUnresolvedClassError arkui.Graphics.ColorMetrics |
|`animation`| Function | managed side | managed side | test blocked | test blocked by ICurve |
|`transition0`| Function |Dmitry A Smirnov| done | test blocked | test is blocked due to ArkTS 1.2 Compilation Issue, transition(Ark_TransitionOptions) - deprecated, this case tesskipped|
|`transition1`| Function |Dmitry A Smirnov| done | test blocked | test is blocked due to ArkTS 1.2 Compilation Issue, transition(Ark_TransitionOptions) - deprecated, this case tesskipped, commented ViewAbstract static methods code |
|`motionBlur`| Function |Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`brightness`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`contrast`| Function |Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`grayscale`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`colorBlend`| Function |Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`saturate`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`sepia`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`invert`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`hueRotate`| Function |Lobah Mikhail | done | pass | |
|`useShadowBatching`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`useEffect0`| Function |Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`useEffect1`| Function | Evstigneev Roman | in progress | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`renderGroup`| Function |Lobah Mikhail | done  | failed | same as arkui, but looks like there is an issue in ace_engine, commented ViewAbstract static methods code |
|`freeze`| Function | Lobah Mikhail | done | failed | method does not work https://gitee.com/openharmony/arkui_ace_engine/issues/IC851K, commented ViewAbstract static methods code |
|`translate`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`scale`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`rotate`| Function | Dmitry A Smirnov | done | pass | Dmitry A Smirnov|
|`transform`| Function |Lobah Mikhail | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBUR61 Type `object` is converted to `ArkCustomObject`|
|`onAppear`| Function | Roman Sedaikin | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onDisAppear`| Function | Roman Sedaikin | done |  | |
|`onAttach`| Function | Andrey Khudenkikh | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onDetach`| Function | Andrey Khudenkikh | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onAreaChange`| Function | Roman Sedaikin | done | pass | |
|`visibility`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`flexGrow`| Function | Dmitry A Smirnov| done | pass | |
|`flexShrink`| Function | Dmitry A Smirnov| done | pass | |
|`flexBasis`| Function | Dmitry A Smirnov| done | pass | |
|`alignSelf`| Function | Roman Sedaikin | done | pass | |
|`displayPriority`| Function | Roman Sedaikin | done | pass | |
|`zIndex`| Function | Roman Sedaikin | done | pass | |
|`direction`| Function | Roman Sedaikin | done | pass | |
|`align`| Function | Roman Sedaikin | done | pass | |
|`position`| Function | Roman Sedaikin | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`markAnchor`| Function | Dmitry A Smirnov| done | pass | |
|`offset`| Function | Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`enabled`| Function | Roman Sedaikin | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`alignRules0`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`alignRules1`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`aspectRatio`| Function | Roman Sedaikin | done | pass | |
|`clickEffect`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`onDragStart`| Function | Skroba Gleb | done | failed | It needs DragEventAccessor implemented to complete Unit tests, but it is empty C-API now, commented ViewAbstract static methods code |
|`onDragEnter`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`onDragMove`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`onDragLeave`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`onDrop0`| Function |Lobah Mikhail | done | test blocked | runtime linker issue, commented ViewAbstract static methods code |
|`onDrop1`| Function | Lobah Mikhail | in progress | failed | not implemented |
|`onDragEnd`| Function | Lobah Mikhail | done | failed | won't work because of guozejun changes, commented ViewAbstract static methods code |
|`allowDrop`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`draggable`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`dragPreview0`| Function |Lobah Mikhail | done | test blocked | UT done Lobah Mikhail CustomBuilder, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`dragPreview1`| Function | Lobah Mikhail | done | test blocked | UT done Lobah Mikhail CustomBuilder, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, not implemented |
|`onPreDrag`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`linearGradient`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`sweepGradient0`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`radialGradient`| Function |Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`motionPath`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`shadow`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`clip`| Function | Dudkin Sergey | done |  | clip1, clip2 not implemented |
|`clipShape`| Function | Tuzhilkin Ivan | testskipped | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`mask`| Function | Maksimov Nikita | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`maskShape`| Function |Tuzhilkin Ivan| done | test blocked | need cherry-pick to feature_branch, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`key`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`id`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`geometryTransition0`| Function | Lobah Mikhail | testskipped | test blocked | no method found test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IC3EHG |
|`geometryTransition1`| Function | Lobah Mikhail | testskipped | failed | OHOSUI-2375, UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IC3EHG, commented ViewAbstract static methods code |
|`stateStyles`| Function | managed side | managed side | test blocked | managed side https://gitee.com/rri_opensource/koala_projects/issues/IBOSCF |
|`restoreId`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`sphericalEffect`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`lightUpEffect`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`pixelStretchEffect`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`accessibilityGroup0`| Function |Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityGroup1`| Function | Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityText0`| Function | Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityText1`| Function |Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityNextFocusId`| Function | Lobah Mikhail| done| test blocked | Not exists on FB, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`accessibilityDefaultFocus`| Function | Lobah Mikhail| blocked IDL | test blocked IDL | managed side https://gitee.com/openharmony/arkui_ace_engine/issues/IBYL00, commented ViewAbstractModelNG static methods code |
|`accessibilityUseSamePage`| Function | Lobah Mikhail| done| test blocked | Not exists on FB, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`accessibilityScrollTriggerable`| Function | Tuzhilkin Ivan | done | test blocked | WRONG_GENERATION: parameter should be Opt, need cherry-pick to feature_branch, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`accessibilityRole`| Function | Lobah Mikhail| done| test blocked | Not exists on FB, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`onAccessibilityFocus`| Function | Evstigneev Roman | done | test blocked | feature: API not present, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`accessibilityTextHint`| Function | Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityDescription0`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityDescription1`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityLevel`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityVirtualNode`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilityChecked`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`accessibilitySelected`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`obscured`| Function |Dmitry A Smirnov | done | failed | commented ViewAbstract static methods code |
|`reuseId`| Function |managed side | managed side | | not implemented in ace_engine |
|`reuse`| Function |managed side | managed side | | to be removed from CAPI generation |
|`renderFit`| Function | Dmitry A Smirnov| done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`gestureModifier`| Function | Erokhin Ilya | blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7, failed | commented ViewAbstract static methods code |
|`backgroundBrightness`| Function | Skroba Gleb | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`onGestureJudgeBegin`| Function | Skroba Gleb | done |  | UT by Vadim Voronov  |
|`onGestureRecognizerJudgeBegin0`| Function | Skroba Gleb | done | Samarin Sergey | UT by Vadim Voronov  |
|`onGestureRecognizerJudgeBegin1`| Function | Skroba Gleb | done | Samarin Sergey | UT by Vadim Voronov  |
|`shouldBuiltInRecognizerParallelWith`| Function | Skroba Gleb | done | Samarin Sergey |  |
|`monopolizeEvents`| Function | Erokhin Ilya | done | pass | UT by Vadim Voronov |
|`onTouchIntercept`| Function | Andrey Khudenkikh | done | pass | EVENT |
|`onSizeChange`| Function | Dmitry A Smirnov| done | failed | issue OHOSUI-2216, commented ViewAbstract static methods code |
|`accessibilityFocusDrawLevel`| Function | Tuzhilkin Ivan | done | test blocked | need cherry-pick to feature_branch, test blocked since no accessibility service on FB, commented ViewAbstract static methods code |
|`customProperty`| Function | Dmitry A Smirnov| in progress | test blocked | need clarify bridge implementation, test blocked by FrameNode.getCustomProperty, commented ViewAbstract static methods code |
|`expandSafeArea`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`background`| Function | Lobah Mikhail | done | test blocked | UT done Lobah Mikhail, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`backgroundImage0`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`backgroundImage1`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`backgroundBlurStyle`| Function | Skroba Gleb | done | test blocked |  test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`foregroundBlurStyle`| Function | Evstigneev Roman | in progress | | |
|`focusScopeId`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`focusScopePriority`| Function | Dmitry A Smirnov| done | pass | |
|`gesture`| Function | Erokhin Ilya | testskipped | pass |  |
|`priorityGesture`| Function | Erokhin Ilya | testskipped |  |  |
|`parallelGesture`| Function | Erokhin Ilya | testskipped | Samarin Sergey |  |
|`blur`| Function | Erokhin Ilya | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`linearGradientBlur`| Function |Lobah Mikhail | done | failed | linearGradientBlur1 not implemented |
|`systemBarEffect`| Function | Lobah Mikhail | blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBUQXK The common method must have two parameters specified|
|`backdropBlur`| Function | Berezin Kirill | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`sharedTransition`|Function|Skroba Gleb | done | test blocked | navigation between pages does not work to check transition, commented ViewAbstract static methods code |
|`chainMode`| Function | Berezin Kirill | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`dragPreviewOptions`| Function | Erokhin Ilya | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`overlay`| Function | Lobah Mikhail | blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBUXWQ Correct generation of the 'Ark_ComponentContent' class without stubs is required, commented ViewAbstract static methods code |
|`blendMode`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`advancedBlendMode`| Function | Erokhin Ilya |in progress | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`bindTips`| Function | Tuzhilkin Ivan | in progress | | only for generation > 125|
|`bindPopup`| Function | Erokhin Ilya | done | test blocked | fixes of issues were provided by our team, https://gitee.com/openharmony/arkui_ace_engine/issues/IBYL2K, https://gitee.com/openharmony/arkui_ace_engine/issues/IBY31B, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`bindMenu0`| Function | Erokhin Ilya | blocked IDL | test blocked | SymbolGlyphModifier https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG  & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`bindMenu1`| Function | Erokhin Ilya | blocked IDL | test blocked | SymbolGlyphModifier https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`bindContextMenu0`| Function | Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`bindContextMenu1`| Function | Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`bindContentCover0`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov, commented ViewAbstractModelNG static methods code |
|`bindContentCover1`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov, commented ViewAbstractModelNG static methods code |
|`bindSheet`| Function | Erokhin Ilya | testskipped | test blocked | UT in progress Vadim Voronov, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`onVisibleAreaChange`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`onVisibleAreaApproximateChange`| Function | Tuzhilkin Ivan | done | failed | need cherry-pick to feature_branch, commented ViewAbstract static methods code |
|`keyboardShortcut`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|*CommonShapeMethod*|*Component*|Skroba Gleb| done |  |  |
|`construct`| Function |Skroba Gleb| done |  | empty implementation, functional is supported by managed side |
|`stroke`|Function| Skroba Gleb | done | pass |  |
|`fill`|Function| Skroba Gleb | done | pass |  |
|`strokeDashOffset`| Function | Evstigneev Roman | done | test blocked |  |
|`strokeLineCap`| Function | Evstigneev Roman | done | test blocked |  |
|`strokeLineJoin`| Function | Evstigneev Roman | done | test blocked |  |
|`strokeMiterLimit`| Function | Evstigneev Roman | done | test blocked |  |
|`strokeOpacity`| Function | Evstigneev Roman | done | pass |  |
|`fillOpacity`| Function | Evstigneev Roman | done | pass |  |
|`strokeWidth`| Function | Evstigneev Roman | done | pass |  |
|`antiAlias`| Function | Evstigneev Roman | done | pass |  |
|`strokeDashArray`| Function | Erokhin Ilya| done| failed | to submit internal issue |
|*ScrollableCommonMethod*| *Component* | Samarin Sergey | blocked IDL |  |  |
|`construct`| Function |Samarin Sergey | done | pass | empty implementation, functional is supported by managed side |
|`scrollBar`| Function | Samarin Sergey | done | pass |  |
|`scrollBarColor`| Function | Samarin Sergey | done | pass |  |
|`scrollBarWidth`| Function | Samarin Sergey | done | pass |  |
|`nestedScroll`| Function | Samarin Sergey | done |  | pass |
|`enableScrollInteraction`| Function | Samarin Sergey | done | pass |  |
|`friction`| Function | Samarin Sergey | done | pass |  |
|`onReachStart`| Function | Samarin Sergey | done | pass | |
|`onReachEnd`| Function | Samarin Sergey | done | pass | |
|`onScrollStart`| Function | Samarin Sergey | done | pass | |
|`onScrollStop`| Function | Samarin Sergey | done | pass | |
|`flingSpeedLimit`| Function | Samarin Sergey | done | pass |  |
|`clipContent`| Function | Evstigneev Roman | done |  |  |
|`digitalCrownSensitivity`| Function | Kovalev Sergey | done | test blocked | test blocked since wearable feature |
|`backToTop`| Function | Kovalev Sergey | done |  | |
|`edgeEffect`| Function | Samarin Sergey | done | pass | |
|`fadingEdge`| Function | Samarin Sergey | done | test blocked | |
|*ContainerSpan*| *Component* | Tuzhilkin Ivan| done | pass |  |
|`construct`| Function | Tuzhilkin Ivan| done | pass |  |
|`setContainerSpanOptions`| Function |Tuzhilkin Ivan| done | pass |  |
|`textBackgroundStyle`| Function |Tuzhilkin Ivan| done | pass |  |
|*Counter*| *Component* | Erokhin Ilya | done | pass |  |
|`construct`| Function |Erokhin Ilya | done | pass |  |
|`setCounterOptions`| Function | Erokhin Ilya | done | pass |  |
|`onInc`| Function | Erokhin Ilya | done | pass |  |
|`onDec`| Function | Erokhin Ilya | done | pass |  |
|`enableDec`| Function | Erokhin Ilya | done | pass |  |
|`enableInc`| Function | Erokhin Ilya | done | pass |  |
|*DataPanel*| *Component* | Morozov Sergey | blocked IDL |  |  |
|`construct`| Function |Morozov Sergey | done | pass |  |
|`setDataPanelOptions`| Function | Morozov Sergey | done | pass |  |
|`closeEffect`| Function | Morozov Sergey | done | pass |  |
|`valueColors`| Function |Morozov Sergey | done | failed | 2068 |
|`trackBackgroundColor`| Function |Morozov Sergey | done | pass |  |
|`strokeWidth`| Function | Morozov Sergey | done | pass |  |
|`trackShadow`| Function |Morozov Sergey | testskipped | test blocked | https://gitee.com/openharmony/arkui_ace_engine/issues/IBVDFV , demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`contentModifier`| Function | Morozov Sergey | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|*DatePicker*| *Component* | Vadim Voronov | done |  |  |
|`construct`| Function |Vadim Voronov | done | pass |  |
|`setDatePickerOptions`| Function | Vadim Voronov| done | pass | |
|`lunar`| Function |Vadim Voronov | done | pass |  |
|`disappearTextStyle`| Function | Vadim Voronov| done | pass |  |
|`textStyle`| Function |Vadim Voronov | done | pass |  |
|`selectedTextStyle`| Function |Vadim Voronov | done | pass |  |
|`onDateChange`| Function |Vadim Voronov | done | pass | |
|`digitalCrownSensitivity`| Function | Vadim Voronov | done |  | |
|`enableHapticFeedback`| Function | Vadim Voronov | done |  | not supported by dayu200; need to test on mobile device |
|*Divider*| *Component* | Tuzhilkin Ivan | done | pass |  |
|`construct`| Function | Tuzhilkin Ivan |done | pass | |
|`setDividerOptions`| Function | Tuzhilkin Ivan| done | pass |  |
|`vertical`| Function | Tuzhilkin Ivan | done | pass |  |
|`color`| Function | Tuzhilkin Ivan | done | pass |  |
|`strokeWidth`| Function | Tuzhilkin Ivan | done | pass |  |
|`lineCap`| Function | Tuzhilkin Ivan | done | pass |  |
|*EffectComponent*| *Component* | Ekaterina Stepanova | done | out of scope | |
|`construct`| Function |Ekaterina Stepanova | done | out of scope | |
|`setEffectComponentOptions`| Function | Ekaterina Stepanova | done | out of scope | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Ellipse*| *Component* | Ekaterina Stepanova | done | pass | |
|`construct`| Function |Ekaterina Stepanova | done | pass | |
|`setEllipseOptions`| Function | Ekaterina Stepanova | done | pass | |
|*EmbeddedComponent*| *Component* | Ekaterina Stepanova | blocked IDL |  | |
|`construct`| Function | Ekaterina Stepanova | in progress |  |  |
|`setEmbeddedComponentOptions`| Function | Ekaterina Stepanova | in progress |  |  |
|`onTerminated`| Function | Ekaterina Stepanova | in progress |  |  |
|`onError`| Function |Skroba Gleb | testskipped |  |  |
|*Flex*| *Component* | Kovalev Sergey | done | |  |
|`construct`| Function | Kovalev Sergey | done | pass |  |
|`setFlexOptions`| Function | Kovalev Sergey | done | pass |  |
|`pointLight`| Function | Evstigneev Roman | done | pass | UT by Evstigneev Roman |
|*FlowItem*| *Component* | Evstigneev Roman | done | pass |  |
|`construct`| Function | Evstigneev Roman | done | pass |  |
|`setFlowItemOptions`| Function | Evstigneev Roman | done |  |  |
|*FolderStack*| *Component* | Politov Mikhail | done |  |  |
|`construct`| Function | Politov Mikhail | done | pass |  |
|`setFolderStackOptions`| Function | Politov Mikhail | done | pass |  |
|`alignContent`| Function | Politov Mikhail | done | pass |  |
|`onFolderStateChange`| Function | Politov Mikhail | done | pass |  |
|`onHoverStatusChange`| Function | Politov Mikhail | done | pass |  |
|`enableAnimation`| Function | Politov Mikhail | done | test blocked | no screen rotation supported by dayu200 |
|`autoHalfFold`| Function | Politov Mikhail | done | test blocked | no screen rotation supported by dayu200 |
|*FormComponent*| *Component* | Vadim Voronov | blocked IDL |  | whole component out of scope, no need to develop |
|`construct`| Function | Vadim Voronov | done | out of scope |  |
|`setFormComponentOptions`| Function | Vadim Voronov |skip | out of scope |  |
|`size`| Function | Vadim Voronov | in progress | out of scope | empty method https://gitee.com/openharmony/arkui_ace_engine/issues/IB78HF |
|`moduleName`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`dimension`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`allowUpdate`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`visibility`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onAcquired`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onError`| Function | Vadim Voronov | done | out of scope | on FB testskipped, test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onRouter`| Function | Vadim Voronov | skip | out of scope | https://gitee.com/nikolay-igotti/idlize/issues/ICAZXO |
|`onUninstall`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onLoad`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*FormLink*| *Component* | Dmitry A Smirnov| done | out of scope | whole component out of scope, no need to develop |
|`construct`| Function |Dmitry A Smirnov| done | out of scope |  |
|`setFormLinkOptions`| Function | Dmitry A Smirnov| done | out of scope |  |
|*Gauge*| *Component* | Maksimov Nikita | blocked IDL |  |  |
|`construct`| Function | Maksimov Nikita | done | pass | |
|`setGaugeOptions`| Function | Maksimov Nikita | done | pass | |
|`value`| Function | Maksimov Nikita | done | pass | |
|`startAngle`| Function | Maksimov Nikita | done | pass | |
|`endAngle`| Function | Maksimov Nikita | done | pass | |
|`colors`| Function | Maksimov Nikita | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`strokeWidth`| Function | Maksimov Nikita | done | pass | |
|`description`| Function | Lobah Mikhail | done | test blocked | UT done Lobah Mikhail, demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`trackShadow`| Function | Maksimov Nikita | done | pass |  |
|`indicator`| Function | Maksimov Nikita | done | pass |  |
|`privacySensitive`| Function | Maksimov Nikita | done | pass ||
|`contentModifier`| Function | Maksimov Nikita | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*Grid*|*Component*| Erokhin Ilya | done |  |  |
|`construct`| Function |Erokhin Ilya | done | pass | |
|`setGridOptions`|Function| Erokhin Ilya | done | pass | |
|`columnsTemplate`|Function| Erokhin Ilya | done |  |  |
|`rowsTemplate`|Function| Erokhin Ilya | done | pass |  |
|`columnsGap`|Function| Erokhin Ilya | done | pass |  |
|`rowsGap`|Function| Erokhin Ilya | done | pass |  |
|`onScrollBarUpdate`|Function| Skroba Gleb | done |  | |
|`onScrollIndex`|Function| Erokhin Ilya | done |  |  |
|`cachedCount0`| Function |Erokhin Ilya | done | test blocked |  |
|`cachedCount1`|Function| Erokhin Ilya | done | test blocked |  |
|`editMode`|Function| Erokhin Ilya | done | pass |  |
|`multiSelectable`|Function| Erokhin Ilya | done | pass |  |
|`maxCount`|Function| Erokhin Ilya | done | pass |  |
|`minCount`|Function| Erokhin Ilya | done | pass |  |
|`cellLength`|Function| Erokhin Ilya | done | pass |  |
|`layoutDirection`|Function| Erokhin Ilya | done | pass |  |
|`supportAnimation`|Function| Erokhin Ilya | done | pass |  |
|`onItemDragStart`|Function| Skroba Gleb | done |  |  |
|`onItemDragEnter`|Function| Erokhin Ilya | done |  |  |
|`onItemDragMove`|Function| Erokhin Ilya | done |  |  |
|`onItemDragLeave`|Function| Erokhin Ilya | done |  |  |
|`onItemDrop`|Function| Erokhin Ilya | done |  |  |
|`alignItems`| Function | Erokhin Ilya | done | pass |  |
|`onScrollFrameBegin`|Function| Skroba Gleb | done |  |   |
|`onWillScroll`| Function | | | | |
|`onDidScroll`| Function | | | | |
|*GridCol*| *Component* | Lobah Mikhail| done |  |  |
|`construct`| Function |Lobah Mikhail| done | pass |  |
|`setGridColOptions`| Function |Lobah Mikhail| done | pass |  |
|`span`| Function |Lobah Mikhail| done | pass |  |
|`gridColOffset`| Function |Lobah Mikhail| done | pass |  |
|`order`| Function |Lobah Mikhail| done | pass |  |
|*GridItem*|*Component*| Erokhin Ilya | done | test blocked |  |
|`construct`| Function |Erokhin Ilya | done | test blocked |  |
|`setGridItemOptions`|Function| Erokhin Ilya | done | test blocked |  |
|`rowStart`|Function| Erokhin Ilya | done | test blocked  |  |
|`rowEnd`|Function| Erokhin Ilya | done | test blocked  |  |
|`columnStart`|Function| Erokhin Ilya | done | test blocked  |  |
|`columnEnd`|Function| Erokhin Ilya | done | test blocked |  |
|`selectable`|Function| Erokhin Ilya | done | test blocked  |  |
|`selected`|Function| Erokhin Ilya | done | test blocked  |  |
|`onSelect`|Function| Erokhin Ilya | done |  |  |
|*GridRow*| *Component* |Lobah Mikhail| done | |  |
|`construct`| Function |Lobah Mikhail| done | pass |  |
|`setGridRowOptions`| Function |Lobah Mikhail| done | pass |  |
|`onBreakpointChange`| Function |Lobah Mikhail| done |  |  |
|`alignItems`| Function |Lobah Mikhail| done | pass |  |
|*Hyperlink*| *Component* | Morozov Sergey | done |  |   |
|`construct`| Function | Morozov Sergey | done |  |   |
|`setHyperlinkOptions`| Function | Morozov Sergey | done | pass | |
|`color`| Function | Morozov Sergey | done | pass | |
|*Image*| *Component* | Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function |Berezin Kirill | done |  |  |
|`setImageOptions0`| Function | Berezin Kirill | done | pass |  |
|`setImageOptions1`| Function | |  |  | blocked by DrawableDescriptor  |
|`setImageOptions2`| Function |Berezin Kirill | blocked IDL |  | SetImageOptions2 unavailable https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`alt`| Function | Evstigneev Roman | done | pass | UT done Lobah Mikhail   |
|`matchTextDirection`| Function | Evstigneev Roman | done | pass | |
|`fitOriginalSize`| Function | Evstigneev Roman | done | pass | |
|`fillColor`| Function | Evstigneev Roman | done | pass | |
|`objectFit`| Function |Berezin Kirill| done | pass | |
|`imageMatrix`| Function | Samarin Sergey | done | failed | no effect, to submit |
|`objectRepeat`| Function | Evstigneev Roman | done | pass | |
|`autoResize`| Function | Evstigneev Roman | done | pass |   |
|`renderMode`| Function | Evstigneev Roman | done | pass | |
|`dynamicRangeMode`| Function | Evstigneev Roman | testskipped | pass | test blocked by aceEngine https://gitee.com/openharmony/arkui_ace_engine/issues/IB1IEY, test in progress Evstgneev Roman |
|`interpolation`| Function | Evstigneev Roman | done | pass | |
|`sourceSize`| Function | Evstigneev Roman | done | pass | |
|`syncLoad`| Function | Evstigneev Roman | done | pass | |
|`copyOption`| Function | Evstigneev Roman | testskipped | pass |  tests blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IBEEFF (+) |
|`draggable`| Function | Evstigneev Roman | done | pass |   |
|`pointLight`| Function | Evstigneev Roman | done | pass |    |
|`edgeAntialiasing`| Function | Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onComplete`| Function | Evstigneev Roman | done | failed | OHOSUI-2409 |
|`onError`| Function | Evstigneev Roman | done | pass | |
|`onFinish`| Function | Evstigneev Roman | done | failed | same in urkui |
|`enableAnalyzer`| Function | Evstigneev Roman | done | pass | |
|`analyzerConfig`| Function | Evstigneev Roman | blocked AceEngine | test blocked | methods is not implemented, https://gitee.com/openharmony/arkui_ace_engine/issues/IB0Y51 (+) |
|`resizable`| Function | Evstigneev Roman | blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|`privacySensitive`| Function | Evstigneev Roman | done | pass | |
|`orientation`| Function | Samarin Sergey | done | pass | |
|*ImageAnimator*| *Component* | Pavelyev Ivan | done |  | |
|`construct`| Function | Pavelyev Ivan | done | pass | |
|`setImageAnimatorOptions`| Function | Pavelyev Ivan | done | pass | |
|`images`| Function | Pavelyev Ivan | done | pass |  |
|`state`| Function | Pavelyev Ivan | done | pass | |
|`duration`| Function | Pavelyev Ivan | done | pass | |
|`reverse`| Function | Pavelyev Ivan | done | pass | |
|`fixedSize`| Function | Pavelyev Ivan | done |  | |
|`fillMode`| Function | Pavelyev Ivan | done | pass | |
|`iterations`| Function | Pavelyev Ivan | done | pass | |
|`monitorInvisibleArea`| Function | Samarin Sergey | done | failed | |
|`onStart`| Function | Pavelyev Ivan | done | pass | |
|`onPause`| Function | Pavelyev Ivan | done | pass | |
|`onRepeat`| Function | Pavelyev Ivan | done | pass | |
|`onCancel`| Function | Pavelyev Ivan | done |  | |
|`onFinish`| Function | Pavelyev Ivan | done | pass | |
|*ImageSpan*| *Component* | Politov Mikhail | blocked IDL |  |  |
|`construct`| Function | Politov Mikhail | done | pass | |
|`setImageSpanOptions`| Function | Politov Mikhail | done | pass | |
|`verticalAlign`| Function | Politov Mikhail | done | pass |  |
|`objectFit`| Function | Politov Mikhail | done | pass |  |
|`onComplete`| Function | Politov Mikhail | done | pass |  |
|`onError`| Function | Politov Mikhail | done |  |  |
|`alt`| Function | Politov Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*IndicatorComponent*| *Component* | Skroba Gleb | done | |  |
|`construct`| Function | Skroba Gleb | done | failed | "Can't have nullptr ptr ${}" probably no the component code |
|`setIndicatorComponentOptions`| Function | Skroba Gleb | done |  |  |
|`initialIndex`| Function | Skroba Gleb | done |  |  |
|`count`| Function | Skroba Gleb | done |  |  |
|`style`| Function | Skroba Gleb | done |  |  |
|`loop`| Function | Skroba Gleb | done |  |  |
|`vertical`| Function | Skroba Gleb | done |  |  |
|`onChange`| Function | Skroba Gleb | done |  |  |
|*Line*|*Component*|Dudkin Sergey| done |  |  |
|`construct`| Function |Dudkin Sergey| done |  |  |
|`setLineOptions`|Function|Dudkin Sergey| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`startPoint`|Function|Dudkin Sergey| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`endPoint`|Function|Dudkin Sergey| done | pass |  |
|*LinearIndicator*| *Component* | Kovalev Sergey | done |  | depricated |
|`construct`| Function |Kovalev Sergey | done |  | depricated |
|`setLinearIndicatorOptions`| Function | Kovalev Sergey | done |  | depricated |
|`indicatorStyle`| Function | Kovalev Sergey | done |  | depricated |
|`indicatorLoop`| Function | Kovalev Sergey | done |  | depricated |
|`onChange`| Function | Kovalev Sergey | done |  | depricated |
|*List*|*Component*|Morozov Sergey| done |  |  |
|`construct`| Function |Morozov Sergey| done |  |  |
|`setListOptions`|Function|Morozov Sergey| done |  |  |
|`alignListItem`|Function|Morozov Sergey| done |  |  |
|`listDirection`|Function|Morozov Sergey| done |  |  |
|`contentStartOffset`|Function|Morozov Sergey| done |  |  |
|`contentEndOffset`|Function|Morozov Sergey| done |  |  |
|`divider`|Function|Morozov Sergey| done | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`multiSelectable`|Function|Morozov Sergey| done |  |  |
|`cachedCount0`|Function|Morozov Sergey| done |  |  |
|`cachedCount1`| Function |Morozov Sergey| done |  |  |
|`chainAnimation`|Function|Morozov Sergey| done |  |  |
|`chainAnimationOptions`|Function|Morozov Sergey| done |  |  |
|`sticky`|Function|Morozov Sergey| done |  |  |
|`scrollSnapAlign`|Function|Morozov Sergey| done |  |  |
|`childrenMainSize`|Function|Morozov Sergey| done |  |  |
|`maintainVisibleContentPosition`|Function|Morozov Sergey| done |  |  |
|`stackFromEnd`| Function | Samarin Sergey | done | | |
|`onScrollIndex`|Function|Morozov Sergey| done |  |  |
|`onScrollVisibleContentChange`|Function|Morozov Sergey| done |  |  |
|`onItemMove`|Function| Skroba Gleb | done |  |   |
|`onItemDragStart`|Function| Skroba Gleb | done |  |   |
|`onItemDragEnter`|Function|Morozov Sergey| done |  |  |
|`onItemDragMove`|Function|Morozov Sergey| done |  |  |
|`onItemDragLeave`|Function|Morozov Sergey| done |  |  |
|`onItemDrop`|Function|Morozov Sergey| done |  |  |
|`onScrollFrameBegin`|Function| Skroba Gleb | done |  |   |
|`onWillScroll`| Function | | | | |
|`onDidScroll`| Function | | | | |
|`lanes`|Function|Morozov Sergey| done |  |  |
|*ListItem*|*Component*|Morozov Sergey| done | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Morozov Sergey| done |  |  |
|`setListItemOptions`| Function | Morozov Sergey| done |  | deprecated for SetListItemOptions1Impl |
|`selectable`|Function|Morozov Sergey| done |  |  |
|`selected`|Function|Morozov Sergey| done |  |  |
|`swipeAction`|Function|Samarin Sergey| done |  |  |
|`onSelect`|Function|Morozov Sergey| done |  |  |
|*ListItemGroup*|*Component*|Morozov Sergey| done | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Morozov Sergey| done |  |  |
|`setListItemGroupOptions`|Function|Dmitry A Smirnov | done |  |   |
|`divider`|Function|Morozov Sergey| done |  |  |
|`childrenMainSize`|Function|Morozov Sergey| done |  |  |
|*LoadingProgress*|*Component*| Samarin Sergey | done | Samarin Sergey |  |
|`construct`| Function | Samarin Sergey | done | pass |  |
|`setLoadingProgressOptions`|Function| Samarin Sergey | done | pass |  |
|`color`|Function| Samarin Sergey | done | pass |  |
|`enableLoading`|Function| Samarin Sergey | done | pass |  |
|`contentModifier`|Function| Samarin Sergey| blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*Marquee*| *Component* | Andrey Khudenkikh| done |  |  |
|`construct`| Function |Andrey Khudenkikh| done |  |  |
|`setMarqueeOptions`| Function | Andrey Khudenkikh| done | failed | loop is not applied |
|`fontColor`| Function |Andrey Khudenkikh | done | pass |  |
|`fontSize`| Function |Andrey Khudenkikh | done | pass |  |
|`allowScale`| Function |Andrey Khudenkikh | done | pass |  |
|`fontWeight`| Function | Andrey Khudenkikh| done | failed | FontWeight.Bolder does not work |
|`fontFamily`| Function | Andrey Khudenkikh| done |  |  |
|`marqueeUpdateStrategy`| Function |Andrey Khudenkikh | done | pass |  |
|`onStart`| Function | Andrey Khudenkikh| done | failed | wrong timing for "on" events |
|`onBounce`| Function |Andrey Khudenkikh | done | failed | wrong timing for "on" events |
|`onFinish`| Function |Andrey Khudenkikh | done | failed | wrong timing for "on" events |
|*MediaCachedImage*| *Component* | Skroba Gleb | done |  | |
|`construct`| Function | Skroba Gleb | done |  |  |
|`setMediaCachedImageOptions`| Function | Skroba Gleb | done |  |   |
|*Menu*|*Component*|Morozov Sergey| done |  |  |
|`construct`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMenuOptions`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`font`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`fontColor`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`radius`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`menuItemDivider`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`menuItemGroupDivider`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`subMenuExpandingMode`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*MenuItem*| *Component* |Morozov Sergey| blocked IDL |  |  |
|`construct`| Function |Kovalev Sergey| blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD + |
|`setMenuItemOptions`| Function |Kovalev Sergey| blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD + |
|`selected`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`selectIcon`| Function |Morozov Sergey| blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB |
|`onChange`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`contentFont`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`contentFontColor`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`labelFont`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`labelFontColor`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*MenuItemGroup*| *Component* |Morozov Sergey | done |  |  |
|`construct`| Function |Morozov Sergey | done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMenuItemGroupOptions`| Function | Dmitry A Smirnov | done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|*NavDestination*| *Component* | managed side | managed side | test blocked | OHOSUI-2171 |
|`construct`| Function |Kovalev Sergey | done | test blocked | OHOSUI-2171 |
|`setNavDestinationOptions`| Function |Kovalev Sergey | done | test blocked |  |
|`hideTitleBar0`| Function |Kovalev Sergey | done | test blocked |   |
|`hideTitleBar`| Function |Kovalev Sergey | done | test blocked |   |
|`hideBackButton`| Function | managed side | managed side | test blocked| |
|`onShown`| Function |Kovalev Sergey | done | test blocked |  |
|`onHidden`| Function |Kovalev Sergey | done | test blocked |   |
|`onBackPressed`| Function |Dudkin Sergey | done | test blocked |  |
|`mode`| Function |Kovalev Sergey | done | test blocked |   |
|`backButtonIcon0`| Function | managed side | managed side | test blocked | |
|`backButtonIcon1`| Function | managed side | managed side | test blocked |  |
|`menus0`| Function | managed side | managed side | test blocked |  |
|`menus1`| Function | managed side | managed side | test blocked |  |
|`onReady`| Function | managed side | managed side | test blocked |  |
|`onWillAppear`| Function |Kovalev Sergey | done |  | test blocked |
|`onWillDisappear`| Function |Kovalev Sergey | done | test blocked |  |
|`onWillShow`| Function |Kovalev Sergey | done | test blocked |   |
|`onWillHide`| Function | Kovalev Sergey | done | test blocked |   |
|`systemBarStyle`| Function |Kovalev Sergey | blocked IDL | test blocked |  https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`recoverable`| Function |Kovalev Sergey | done | test blocked |   |
|`systemTransition`| Function | managed side | managed side | test blocked |  |
|`bindToScrollable`| Function | managed side|managed side | test blocked| |
|`bindToNestedScrollable`| Function | managed side| managed side| test blocked| |
|`onActive`| Function |managed side |managed side | test blocked| |
|`onInactive`| Function | managed side|managed side | test blocked| |
|`customTransition`| Function | managed side|managed side | test blocked| |
|`onNewParam`| Function |managed side |managed side | test blocked| |
|`preferredOrientation`| Function |managed side |managed side | test blocked| |
|`enableNavigationIndicator`| Function |managed side |managed side |test blocked | |
|`title`| Function | managed side | managed side | test blocked |  |
|`toolbarConfiguration`| Function | managed side | managed side | test blocked |  |
|`hideToolBar`| Function | managed side | managed side | test blocked |  |
|`ignoreLayoutSafeArea`| Function |Kovalev Sergey | done | test blocked |   |
|`enableStatusBar`| Function |managed side |managed side |test blocked | |
|*Navigation*| *Component* | | | | |
|`construct`| Function | | | | |
|`setNavigationOptions0`| Function | | | | |
|`setNavigationOptions1`| Function | | | | |
|`navBarWidth`| Function | | | | |
|`navBarPosition`| Function | | | | |
|`navBarWidthRange`| Function | | | | |
|`minContentWidth`| Function | | | | |
|`mode`| Function | | | | |
|`backButtonIcon0`| Function | | | | |
|`backButtonIcon1`| Function | | | | |
|`hideNavBar`| Function | | | | |
|`hideTitleBar0`| Function | | | | |
|`hideTitleBar1`| Function | | | | |
|`hideBackButton`| Function | | | | |
|`titleMode`| Function | | | | |
|`menus0`| Function | | | | |
|`menus1`| Function | | | | |
|`hideToolBar0`| Function | | | | |
|`hideToolBar1`| Function | | | | |
|`enableToolBarAdaptation`| Function | | | | |
|`onTitleModeChange`| Function | | | | |
|`onNavBarStateChange`| Function | | | | |
|`onNavigationModeChange`| Function | | | | |
|`navDestination`| Function | | | | |
|`customNavContentTransition`| Function | | | | |
|`systemBarStyle`| Function | | | | |
|`recoverable`| Function | | | | |
|`enableDragBar`| Function | | | | |
|`enableModeChangeAnimation`| Function | | | | |
|`title`| Function | | | | |
|`toolbarConfiguration`| Function | | | | |
|`ignoreLayoutSafeArea`| Function | | | | |
|*NodeContainer*| *Component* | Skroba Gleb | blocked IDL |  | |
|`construct`| Function | managed side | managed side | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setNodeContainerOptions`| Function |  managed side | managed side | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|*PasteButton*| *Component* | Samarin Sergey| done | Samarin Sergey | whole component out of scope, no need to develop  |
|`construct`| Function | Samarin Sergey| done | pass |  |
|`setPasteButtonOptions0`| Function | Samarin Sergey| done | not covered | Compilation issue |
|`setPasteButtonOptions1`| Function | Samarin Sergey| done | pass |  |
|`onClick`| Function | Samarin Sergey | testskipped | not covered |  |
|*Path*| *Component* | Skroba Gleb | done |  |  |
|`construct`| Function |Skroba Gleb | done |  |  |
|`setPathOptions`| Function | Skroba Gleb | done | pass |  |
|`commands`| Function | Skroba Gleb | done | pass |  |
|*PatternLock*| *Component* | Dmitry A Smirnov| in progress |  |  |
|`construct`| Function | Dmitry A Smirnov| done | pass |  |
|`setPatternLockOptions`| Function | Dmitry A Smirnov| done | pass |  |
|`sideLength`| Function | Dmitry A Smirnov| done | pass |  |
|`circleRadius`| Function | Dmitry A Smirnov| done | pass |  |
|`backgroundColor`| Function | Dmitry A Smirnov| done |  |common method |
|`regularColor`| Function | Dmitry A Smirnov| done | pass |  |
|`selectedColor`| Function | Dmitry A Smirnov| done | pass |  |
|`activeColor`| Function | Dmitry A Smirnov| done | pass |  |
|`pathColor`| Function | Dmitry A Smirnov| done | pass |  |
|`pathStrokeWidth`| Function | Dmitry A Smirnov| done | pass |  |
|`onPatternComplete`| Function | Dmitry A Smirnov| done |  |  |
|`autoReset`| Function | Dmitry A Smirnov| done | pass |  |
|`onDotConnect`| Function | Dmitry A Smirnov| done |  |  |
|`activateCircleStyle`| Function | Dmitry A Smirnov| done |  | |
|`skipUnselectedPoint`| Function | Dmitry A Smirnov | done| | need merge to fb|
|*PluginComponent*| *Component* | Evstigneev Roman | done | blocked | Not compilable on SDK from 06.06.2025|
|`construct`| Function |Evstigneev Roman | done | blocked | E2E by Dudkin Sergey |
|`setPluginComponentOptions`| Function | Evstigneev Roman | done | blocked |  need merge to fb |
|`onComplete`| Function | Evstigneev Roman | done | blocked | E2E by Dudkin Sergey |
|`onError`| Function | Evstigneev Roman | done | blocked | E2E by Dudkin Sergey |
|*Polygon*| *Component* |Politov Mikhail | done |  | |
|`construct`| Function |Politov Mikhail | done | pass | |
|`setPolygonOptions`| Function | Politov Mikhail | done | pass | |
|`points`| Function | Politov Mikhail | done | pass | |
|*Polyline*| *Component* | Politov Mikhail | done |  |  |
|`construct`| Function |Politov Mikhail | done | pass |  |
|`setPolylineOptions`| Function | Politov Mikhail | done | pass |  |
|`points`| Function | Politov Mikhail | done | pass |  |
|*Progress*| *Component* | Erokhin Ilya | blocked IDL |  | |
|`construct`| Function | Erokhin Ilya | done | pass | deprecated for `style` property |
|`setProgressOptions`| Function | Erokhin Ilya | done | test blocked | deprecated for `style` property, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`value`| Function | Erokhin Ilya | done | test blocked | test blocked by runtime error in Koala part during setProgressOptions |
|`color`| Function | Erokhin Ilya | done | test blocked | test blocked by runtime error in Koala part during setProgressOptions |
|`style`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov linearStyle.strokeRadius need to be tested, test blocked by runtime error in Koala part during setProgressOptions |
|`privacySensitive`| Function | Erokhin Ilya | done | test blocked | test blocked by runtime error in Koala part during setProgressOptions |
|`contentModifier`| Function | Erokhin Ilya | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|*QRCode*| *Component* | Evstigneev Roman | done | pass  |  |
|`construct`| Function |Evstigneev Roman | done | pass |  |
|`setQRCodeOptions`| Function |Evstigneev Roman | done | pass |  |
|`color`| Function |Evstigneev Roman | testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZVOQ (+) or https://gitee.com/openharmony/arkui_ace_engine/issues/IBJUC2 |
|`backgroundColor`| Function |Evstigneev Roman | testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZVOQ (+) or https://gitee.com/openharmony/arkui_ace_engine/issues/IBJUC2 |
|`contentOpacity`| Function |Evstigneev Roman | testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZVOQ (+) or https://gitee.com/openharmony/arkui_ace_engine/issues/IBJUC2 |
|*Radio*| *Component* | Evstigneev Roman | done |  |  |
|`construct`| Function |Evstigneev Roman | done | pass |  |
|`setRadioOptions`| Function | Dmitry A Smirnov | done | pass | CustomBuilder, test passed but differs with ArkUI behavior |
|`checked`| Function | Evstigneev Roman | done | pass |  |
|`onChange`| Function |  Evstigneev Roman | done | pass |  |
|`radioStyle`| Function | Evstigneev Roman | done | pass |  |
|`contentModifier`| Function | Evstigneev Roman | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|*Rating*| *Component* | Lobah Mikhail| done |  |  |
|`construct`| Function | Lobah Mikhail| done |  |  |
|`setRatingOptions`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`stars`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`stepSize`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`starStyle`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`onChange`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`contentModifier`| Function | Lobah Mikhail| blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*Rect*|*Component*|Dudkin Sergey| done |  |  |
|`construct`| Function |Dudkin Sergey| done |  |  |
|`setRectOptions`|Function|Dudkin Sergey| done | pass |  |
|`radiusWidth`|Function|Dudkin Sergey| done | pass |  |
|`radiusHeight`|Function|Dudkin Sergey| done | pass |  |
|`radius`|Function|Dudkin Sergey| done | pass |   |
|*Refresh*| *Component* |Politov Mikhail | blocked IDL | failed | OHOSUI-2196 |
|`construct`| Function |Samarin Sergey | blocked IDL | failed | is not called in demo; https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD ; offset, friction - deprecated + |
|`setRefreshOptions`| Function | Samarin Sergey | blocked IDL | failed | is not called in demo; https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD ; offset, friction - deprecated + |
|`onStateChange`| Function |Politov Mikhail | done | failed | is not called in demo |
|`onRefreshing`| Function |Politov Mikhail | done | failed | is not called in demo |
|`refreshOffset`| Function |Politov Mikhail | done | failed | is not called in demo |
|`pullToRefresh`| Function |Politov Mikhail | done | failed | is not called in demo |
|`onOffsetChange`| Function |Politov Mikhail | done | failed | Ois not called in demo |
|`pullDownRatio`| Function |Politov Mikhail | done | failed | is not called in demo |
|*RelativeContainer*| *Component* | Dmitry A Smirnov | done | blocked |  https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Dmitry A Smirnov | done |  |  |
|`setRelativeContainerOptions`| Function | Dmitry A Smirnov | done | | |
|`guideLine`| Function | Dmitry A Smirnov | done | blocked | LinkerUnresolvedClassError message: arkui.component.common.arkui$component$common$AlignRuleParam|
|`barrier0`| Function |Dmitry A Smirnov | done | blocked | LinkerUnresolvedClassError message: arkui.component.common.arkui$component$common$AlignRuleParam|
|`barrier1`| Function | Dmitry A Smirnov | done | blocked | LinkerUnresolvedClassError message: arkui.component.common.arkui$component$common$AlignRuleParam|
|*RemoteWindow*| *Component* | Spirin Andrey | done |  | |
|`construct`| Function |Spirin Andrey | done |  | |
|`setRemoteWindowOptions`| Function | Spirin Andrey | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 (+) |
|*RichEditor*| *Component* | Dudkin Sergey| in progress | Alexander Porodin |  |
|`construct`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setRichEditorOptions`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setRichEditorOptions1`| Function | Dudkin Sergey| done |  |  |
|`onReady`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`onSelect`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import  |
|`onSelectionChange`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`aboutToIMEInput`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`onIMEInputComplete`| Function | Dudkin Sergey | testskipped | test blocked | reopened after refactoring methods, Compilation issue on RichEditor import |
|`onDidIMEInput`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`aboutToDelete`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`onDeleteComplete`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`copyOptions`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`onPaste`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`enableDataDetector`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`enablePreviewText`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`dataDetectorConfig`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`caretColor`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`selectedBackgroundColor`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`onEditingChange`| Function | Dudkin Sergey| done |  |  |
|`enterKeyType`| Function | Dudkin Sergey| done |  |  |
|`onSubmit`| Function | Dudkin Sergey | done |  |  |
|`onWillChange`| Function | Dudkin Sergey| done |  |  |
|`onDidChange`| Function | Dudkin Sergey| done |  |  |
|`onCut`| Function | Dudkin Sergey | testskipped |  | reopened after refactoring methods |
|`onCopy`| Function | Dudkin Sergey | testskipped |  | reopened after refactoring methods |
|`editMenuOptions`| Function | Pavelyev Ivan | done |  |  |
|`enableKeyboardOnFocus`| Function | Dudkin Sergey| done |  |  |
|`enableHapticFeedback`| Function | Dudkin Sergey| done |  | not supported by dayu200; need to test on mobile device |
|`barState`| Function | Dudkin Sergey| done |  |  |
|`maxLength`| Function | Lobah Mikhail| done| | not exists on FB|
|`maxLines`| Function | Lobah Mikhail| done| | not exists on FB|
|`keyboardAppearance`| Function | Dudkin Sergey|done | | needs merging to FB|
|`stopBackPress`| Function | Dudkin Sergey| done | | needs merging to FB|
|`bindSelectionMenu`| Function | Dmitry A Smirnov| done |  |  |
|`customKeyboard`| Function | Dmitry A Smirnov| done |  |  |
|`placeholder`| Function | Dudkin Sergey| done |  |  |
|*RichText*| *Component* | Dudkin Sergey| done | pass |  |
|`construct`| Function | Dudkin Sergey| done | pass |  |
|`setRichTextOptions`| Function | Dudkin Sergey| done | pass |  |
|`onStart`| Function | Dudkin Sergey| done | pass |  |
|`onComplete`| Function | Dudkin Sergey| done | pass |  |
|*RootScene*| *Component* | Spirin Andrey | done |  | |
|`construct`| Function |Spirin Andrey | done |  | |
|`setRootSceneOptions`| Function | Spirin Andrey | done |  | |
|*Row*| *Component* | Andrey Khudenkikh | done |  |  |
|`construct`| Function |Andrey Khudenkikh | done |  |  |
|`setRowOptions0`| Function | Andrey Khudenkikh | done | pass |  |
|`setRowOptions1`| Function | Andrey Khudenkikh | done |  |  |
|`alignItems`| Function | Andrey Khudenkikh | done | pass |  |
|`justifyContent`| Function | Andrey Khudenkikh | done | pass |  |
|`pointLight`| Function | Evstigneev Roman | done | failed | UT by Evstigneev Roman, method does not work |
|`reverse`| Function | Andrey Khudenkikh | done | pass |  |
|*RowSplit*| *Component* | Dmitry A Smirnov| done |  | |
|`construct`| Function | Dmitry A Smirnov| done |  | |
|`setRowSplitOptions`| Function | Dmitry A Smirnov| done | failed | OHOSUI-2201 Text in rowSplit does not appear |
|`resizeable`| Function | Dmitry A Smirnov| done | failed | OHOSUI-2202 resizeable does not work |
|*SaveButton*| *Component* | Samarin Sergey| done |  |  |
|`construct`| Function |Samarin Sergey| done |  |  |
|`setSaveButtonOptions0`| Function | Samarin Sergey| done | pass |  |
|`setSaveButtonOptions`| Function | Samarin Sergey| done | pass |  |
|`onClick`| Function | Samarin Sergey | testskipped | pass |  |
|*Screen*| *Component* | Dudkin Sergey | done |  | |
|`construct`| Function | Dudkin Sergey | done |  | |
|`setScreenOptions`| Function | Dudkin Sergey | done |  | |
|*Scroll*| *Component* | Berezin Kirill | done |  |  |
|`construct`| Function |Berezin Kirill | done |  |  |
|`setScrollOptions`| Function | Berezin Kirill | done |  |  |
|`scrollable`| Function | Berezin Kirill | done |  |  |
|`onWillScroll`| Function | Berezin Kirill | done |  |   |
|`onDidScroll`| Function | Berezin Kirill | done |  |    |
|`onScrollEdge`| Function | Berezin Kirill | done |  |  |
|`onScrollStart`| Function | Berezin Kirill | done |  |  |
|`onScrollStop`| Function | Berezin Kirill | done |  |  |
|`scrollBar`| Function | Berezin Kirill | done |  |  |
|`scrollBarColor`| Function | Berezin Kirill | done |  |  |
|`scrollBarWidth`| Function | Berezin Kirill | done |  |  |
|`onScrollFrameBegin`| Function | Dudkin Sergey | done | failed | |
|`nestedScroll`| Function | Berezin Kirill | done |  |  |
|`enableScrollInteraction`| Function | Berezin Kirill | done |  |  |
|`friction`| Function | Berezin Kirill | done | pass |  |
|`scrollSnap`| Function | Berezin Kirill | done |  |  |
|`enablePaging`| Function | Berezin Kirill | done |  |  |
|`initialOffset`| Function | Berezin Kirill | done |  |  |
|`edgeEffect`| Function | Berezin Kirill | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*ScrollBar*| *Component* | Maksimov Nikita | done |  | |
|`construct`| Function | Maksimov Nikita | done | pass | |
|`setScrollBarOptions`| Function | Maksimov Nikita | done | pass | |
|`enableNestedScroll`| Function | Maksimov Nikita | done |  | |
|*Search*|*Component*| Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function |Evstigneev Roman | done | pass |   |
|`setSearchOptions`|Function| Evstigneev Roman | done | pass |   |
|`fontColor`|Function| Evstigneev Roman | done |  |  |
|`searchIcon`|Function| Evstigneev Roman | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAYXQ8 (+)|
|`cancelButton`|Function| Evstigneev Roman | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB |
|`textIndent`|Function| Evstigneev Roman | done |  |  |
|`onEditChange`|Function| Evstigneev Roman | done |  |  |
|`selectedBackgroundColor`|Function| Evstigneev Roman | done |  |  |
|`caretStyle`|Function| Evstigneev Roman | done |  |  |
|`placeholderColor`|Function| Evstigneev Roman | done |  |  |
|`placeholderFont`|Function| Evstigneev Roman | done |  |  |
|`textFont`|Function| Evstigneev Roman | done |  |  |
|`enterKeyType`|Function| Evstigneev Roman | done |  |  |
|`onSubmit`| Function |Evstigneev Roman | done |  |  |
|`onChange`|Function| Evstigneev Roman | done |  |  |
|`onTextSelectionChange`|Function| Evstigneev Roman | done |  |  |
|`onContentScroll`|Function| Evstigneev Roman | done |  |  |
|`onCopy`|Function| Evstigneev Roman | done |  |  |
|`onCut`|Function| Evstigneev Roman | done |  |  |
|`onPaste`|Function| Evstigneev Roman | done |  |  |
|`copyOption`|Function| Evstigneev Roman | done |  |  |
|`maxLength`|Function| Evstigneev Roman | done |  |  |
|`textAlign`|Function| Evstigneev Roman | done |  |  |
|`enableKeyboardOnFocus`|Function| Evstigneev Roman | done |  |  |
|`selectionMenuHidden`|Function| Evstigneev Roman | done |  |  |
|`minFontSize`|Function| Evstigneev Roman | done |  |  |
|`maxFontSize`|Function| Evstigneev Roman | done |  |  |
|`minFontScale`| Function | Kovalev Sergey | done |  | |
|`maxFontScale`| Function | Kovalev Sergey | done |  | |
|`decoration`|Function| Evstigneev Roman | done | pass |  |
|`letterSpacing`|Function| Evstigneev Roman | done | pass |  |
|`lineHeight`|Function| Evstigneev Roman | done | pass |  |
|`type`|Function| Evstigneev Roman | done |  |  |
|`fontFeature`|Function| Evstigneev Roman | done |  |  |
|`onWillInsert`|Function| Skroba Gleb | done |  |   |
|`onDidInsert`|Function| Evstigneev Roman | done |  |  |
|`onWillDelete`|Function| Skroba Gleb | done |  |   |
|`onDidDelete`|Function| Evstigneev Roman | done |  |  |
|`editMenuOptions`|Function| Pavelyev Ivan | done |  |  |
|`enablePreviewText`|Function| Evstigneev Roman | done |  |  |
|`enableHapticFeedback`|Function|Evstigneev Roman| done |  | not supported by dayu200; need to test on mobile device |
|`autoCapitalizationMode`| Function | | | | no such API in generation 125 |
|`halfLeading`| Function | Kovalev Sergey | done |  | |
|`stopBackPress`| Function | Kovalev Sergey | done |  | |
|`onWillChange`| Function | Kovalev Sergey| done | | |
|`keyboardAppearance`| Function | Kovalev Sergey|done | | |
|`searchButton`|Function| Evstigneev Roman | done |  |  |
|`inputFilter`|Function| Evstigneev Roman | done |  |  |
|`customKeyboard`|Function| Lobah Mikhail | done |  |   |
|*SecurityComponentMethod*| *Component* | Samarin Sergey| done |  |  |
|`construct`| Function |Samarin Sergey| done |  |  |
|`iconSize`| Function |Samarin Sergey| done |  |  |
|`layoutDirection`| Function |Samarin Sergey| done |  |  |
|`position`| Function |Samarin Sergey| done |  |  |
|`markAnchor`| Function |Samarin Sergey| done |  |  |
|`offset`| Function |Samarin Sergey| done |  |  |
|`fontSize`| Function |Samarin Sergey| done |  |  |
|`fontStyle`| Function |Samarin Sergey| done |  |  |
|`fontWeight`| Function |Samarin Sergey| done |  |  |
|`fontFamily`| Function |Samarin Sergey| done |  |  |
|`fontColor`| Function |Samarin Sergey| done |  |  |
|`iconColor`| Function |Samarin Sergey| done |  |  |
|`backgroundColor`| Function |Samarin Sergey| done |  |  |
|`borderStyle`| Function |Samarin Sergey| done |  |  |
|`borderWidth`| Function |Samarin Sergey| done |  |  |
|`borderColor`| Function |Samarin Sergey| done |  |  |
|`borderRadius`| Function |Samarin Sergey| done |  | API is present on Upstream only |
|`padding`| Function |Samarin Sergey| done |  |  |
|`textIconSpace`| Function |Samarin Sergey| done |  |  |
|`key`| Function |Samarin Sergey| done |  |  |
|`width`| Function |Samarin Sergey| done |  |  |
|`height`| Function |Samarin Sergey| done |  |  |
|`size`| Function |Samarin Sergey| done |  |  |
|`constraintSize`| Function |Samarin Sergey| done |  |  |
|`align`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`alignRules0`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`alignRules1`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`id`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`chainMode`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`minFontScale`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`maxFontScale`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`maxLines`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`minFontSize`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`maxFontSize`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`heightAdaptivePolicy`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|`enabled`| Function | Samarin Sergey | done |  | API is present on Upstream only |
|*Select*| *Component* | Samarin Sergey | blocked IDL | test blocked | runtime error in Koala part during setSelectOptions |
|`construct`| Function | Samarin Sergey | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD + |
|`setSelectOptions` | Function | Samarin Sergey | blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD +; runtime error in Arkoala part, issue https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`selected`| Function | Samarin Sergey | done | test blocked |  |
|`value`| Function |Samarin Sergey | done | test blocked |  |
|`font`| Function |Samarin Sergey | done | test blocked |  |
|`fontColor` | Function | Samarin Sergey | done | test blocked |  |
|`selectedOptionBgColor`| Function | Samarin Sergey | done | test blocked |  |
|`selectedOptionFont` | Function | Samarin Sergey | done | test blocked |  |
|`selectedOptionFontColor`| Function | Samarin Sergey | done | test blocked |  |
|`optionBgColor` | Function | Samarin Sergey | done | test blocked |  |
|`optionFont`| Function | Samarin Sergey | done | test blocked |  |
|`optionFontColor` | Function | Samarin Sergey | done | test blocked |  |
|`onSelect`| Function | Samarin Sergey | done | test blocked |  |
|`space` | Function | Samarin Sergey | done | test blocked |  |
|`arrowPosition`| Function | Samarin Sergey | done | test blocked |  |
|`optionWidth` | Function | Samarin Sergey | done | test blocked |  |
|`optionHeight`| Function | Dmitry A Smirnov | done | test blocked | |
|`menuBackgroundColor` | Function | Samarin Sergey | done | test blocked |  |
|`menuBackgroundBlurStyle` | Function | Samarin Sergey | done | test blocked |  |
|`controlSize` | Function | Samarin Sergey | done | test blocked |  |
|`menuItemContentModifier` | Function | Samarin Sergey | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`divider` | Function | Samarin Sergey | done | test blocked |  |
|`textModifier`| Function | managed side | managed side |  | |
|`arrowModifier`| Function | managed side | managed side | | https://gitee.com/nikolay-igotti/idlize/issues/IBREFA, https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB  |
|`optionTextModifier`| Function | managed side | managed side | | https://gitee.com/nikolay-igotti/idlize/issues/IBREFA, https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB  |
|`selectedOptionTextModifier`| Function | managed side | managed side | | https://gitee.com/nikolay-igotti/idlize/issues/IBREFA, https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB  |
|`dividerStyle`| Function | Evstigneev Roman, Samarin Sergey | testskipped | | |
|`avoidance`| Function | Evstigneev Roman, Samarin Sergey | testskipped | | |
|`menuOutline`| Function | Evstigneev Roman, Samarin Sergey | testskipped | | |
|`menuAlign` | Function | Samarin Sergey | done | test blocked |  |
|*Shape*|*Component*|Dudkin Sergey| in progress |  |  |
|`construct`| Function |Samarin Sergey| testskipped | test blocked | method Shape() not found demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setShapeOptions`| Function |Samarin Sergey| testskipped | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`viewPort`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`stroke`|Function|Dudkin Sergey| done | pass |  |
|`fill`|Function|Dudkin Sergey| done | pass |  |
|`strokeDashOffset`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`strokeDashArray`|Function|Erokhin Ilya| done | pass |  |
|`strokeLineCap`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`strokeLineJoin`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`strokeMiterLimit`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`strokeOpacity`|Function|Dudkin Sergey| done | pass |  |
|`fillOpacity`|Function|Dudkin Sergey| done | pass |  |
|`strokeWidth`|Function|Dudkin Sergey| done | pass |  |
|`antiAlias`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`mesh`|Function|Erokhin Ilya| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*SideBarContainer*| *Component* |Dmitry A Smirnov|in progress|  |
|`construct`| Function |Dmitry A Smirnov| done |  |  |
|`setSideBarContainerOptions`| Function |Dmitry A Smirnov| done |  |  |
|`showSideBar`| Function |Dmitry A Smirnov| done | pass |  |
|`controlButton`| Function |Dmitry A Smirnov| done |  | need submit to FB |
|`showControlButton`| Function |Dmitry A Smirnov| done | pass |  |
|`onChange`| Function |Dmitry A Smirnov| done |  |  |
|`sideBarWidth0`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`sideBarWidth1`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`minSideBarWidth`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`minSideBarWidth1`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`maxSideBarWidth0`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`maxSideBarWidth1`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`autoHide`| Function |Dmitry A Smirnov| done | pass |  |
|`sideBarPosition`| Function |Dmitry A Smirnov| done | pass |  |
|`divider`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2170 |
|`minContentWidth`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2170 |
|*Slider*| *Component* |Morozov Sergey | blocked IDL |  |  |
|`construct`| Function |Morozov Sergey | done | pass |  |
|`setSliderOptions`| Function |Morozov Sergey | done | pass |  |
|`blockColor`| Function |Morozov Sergey | done | pass |  |
|`trackColor`| Function |Morozov Sergey | testskipped | pass | AceEngine won't fix, https://gitee.com/openharmony/arkui_ace_engine/issues/IBPH6O |
|`selectedColor`| Function |Morozov Sergey |done  | pass |
|`showSteps`| Function |Morozov Sergey | done | pass |  |
|`trackThickness`| Function |Morozov Sergey | done | pass |  |
|`onChange`| Function |Morozov Sergey | done | pass |  |
|`blockBorderColor`| Function |Morozov Sergey | done | pass |  |
|`blockBorderWidth`| Function |Morozov Sergey | done | pass |  |
|`stepColor`| Function |Morozov Sergey | done | pass |  |
|`trackBorderRadius`| Function |Morozov Sergey | done | pass |  |
|`selectedBorderRadius`| Function |Morozov Sergey | done | pass |  |
|`blockSize`| Function |Morozov Sergey | done | pass |  |
|`blockStyle`| Function |Morozov Sergey | blocked IDL | test blocked | TBD |
|`stepSize`| Function |Morozov Sergey | done | pass |  |
|`sliderInteractionMode`| Function |Morozov Sergey | done | pass |  |
|`minResponsiveDistance`| Function |Morozov Sergey | done | pass |  |
|`contentModifier`| Function |Morozov Sergey | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`slideRange`| Function | Morozov Sergey | done | pass |  |
|`digitalCrownSensitivity`| Function | Kovalev Sergey | done | | |
|`enableHapticFeedback`| Function | Kovalev Sergey | done |  | not supported by dayu200; need to test on mobile device |
|`showTips`| Function |Morozov Sergey | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*BaseSpan*| *Component* |Politov Mikhail | done |  |  |
|`construct`| Function |Politov Mikhail | done | pass |  |
|`textBackgroundStyle`| Function | Politov Mikhail | done | pass |  |
|`baselineOffset`| Function | Politov Mikhail | done |  |  |
|*Span*| *Component* | Politov Mikhail | done | pass |  |
|`construct`| Function |Politov Mikhail | done | pass |  |
|`setSpanOptions`| Function |Politov Mikhail | done | pass |  |
|`font`| Function | Politov Mikhail | done | pass |  |
|`fontColor`| Function |Politov Mikhail | done | pass |  |
|`fontSize`| Function |Politov Mikhail | done | pass |  |
|`fontStyle`| Function |Politov Mikhail | done | pass |  |
|`fontWeight`| Function |Politov Mikhail | done | pass |  |
|`fontFamily`| Function |Politov Mikhail | done | pass |  |
|`decoration`| Function | Politov Mikhail | done | pass |  |
|`letterSpacing`| Function |Politov Mikhail | done | pass |  |
|`textCase`| Function | Politov Mikhail | done | pass |  |
|`lineHeight`| Function | Politov Mikhail | done | pass |  |
|`textShadow`| Function | Politov Mikhail | testskipped | pass | test blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IB1K3Z |
|*Stack*| *Component* | Korobeinikov Evgeny | done | pass |  |
|`construct`| Function |Korobeinikov Evgeny | done | pass |  |
|`setStackOptions` | Function | Korobeinikov Evgeny | done | pass |  |
|`alignContent` | Function | Korobeinikov Evgeny | done | pass |  |
|`pointLight` | Function | Evstigneev Roman | done |  |  UT by Evstigneev Roman |
|*Stepper*| *Component* | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Morozov Sergey | done | |  |
|`setStepperOptions`| Function | Morozov Sergey | done |  |  |
|`onFinish`| Function | Morozov Sergey | done |  |  |
|`onSkip`| Function | Morozov Sergey | done |  |  |
|`onChange`| Function | Morozov Sergey | done |  |  |
|`onNext`| Function | Morozov Sergey | done |  |  |
|`onPrevious`| Function | Morozov Sergey | done |  |  |
|*StepperItem*| *Component* | Morozov Sergey | done |  | |
|`construct`| Function |Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStepperItemOptions`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`prevLabel`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`nextLabel`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`status`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Swiper*| *Component* | Skroba Gleb | done |  |  |
|`construct`| Function |Skroba Gleb | done | pass  |  |
|`setSwiperOptions`| Function | Skroba Gleb | done | pass  |  |
|`index`| Function | Skroba Gleb| done | pass |  |
|`interval`| Function | Skroba Gleb| done | pass |  |
|`indicator`| Function |  Skroba Gleb| done | pass |  |
|`loop`| Function | Skroba Gleb| done | pass |  |
|`duration`| Function | Skroba Gleb | done | pass |  |
|`vertical`| Function | Skroba Gleb | done | pass |  |
|`itemSpace`| Function | Skroba Gleb | done | pass |  |
|`displayMode`| Function | Skroba Gleb| done | pass |  |
|`cachedCount0`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`cachedCount1`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`effectMode`| Function | Skroba Gleb | done | pass |  |
|`disableSwipe`| Function | Skroba Gleb| done | pass |  |
|`curve`| Function | Skroba Gleb| done | pass |  |
|`onChange`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onSelected`| Function | Pavelyev Ivan | done | test blocked | |
|`onUnselected`| Function | Pavelyev Ivan | done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onAnimationStart`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onAnimationEnd`| Function | Skroba Gleb | done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onGestureSwipe`| Function | Skroba Gleb | done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`nestedScroll`| Function | Skroba Gleb| testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IB3ULZ |
|`customContentTransition`| Function | Skroba Gleb | done |  | |
|`onContentDidScroll`| Function | Skroba Gleb| done |  | |
|`indicatorInteractive`| Function | Skroba Gleb| done | pass  |  |
|`pageFlipMode`| Function | Lobah Mikhail| done | | Not exists on FB|
|`onContentWillScroll`| Function | Pavelyev Ivan | done | | |
|`autoPlay`| Function | Skroba Gleb| done | pass |  |
|`displayArrow`| Function | Skroba Gleb| done | pass |  |
|`displayCount`| Function |Skroba Gleb | done | pass |  |
|`prevMargin`| Function | Skroba Gleb| done | pass |  |
|`nextMargin`| Function | Skroba Gleb | done | pass |  |
|*SymbolGlyph*| *Component* |Andrey Khudenkikh | blocked IDL |  |  |
|`construct`| Function |Andrey Khudenkikh | done |  |  |
|`setSymbolGlyphOptions`| Function |Andrey Khudenkikh | done | pass |  |
|`fontSize`| Function |Andrey Khudenkikh | done | pass |  |
|`fontColor`| Function |Andrey Khudenkikh | done | pass |  |
|`fontWeight`| Function |Andrey Khudenkikh | done | pass |  |
|`effectStrategy`| Function |Andrey Khudenkikh | done |  |  |
|`renderingStrategy`| Function |Andrey Khudenkikh | done |  |  |
|`minFontScale`| Function | Kovalev Sergey | done  | |
|`maxFontScale`| Function | Kovalev Sergey | done  | |
|`symbolEffect`| Function |Andrey Khudenkikh | done |  |  |
|*SymbolSpan*| *Component* |Dmitry A Smirnov| done |  |  |
|`construct`| Function |Dmitry A Smirnov| done |  |  |
|`setSymbolSpanOptions`| Function |Dmitry A Smirnov| done | pass |   |
|`fontSize`| Function |Dmitry A Smirnov| done | pass |  |
|`fontColor`| Function |Dmitry A Smirnov| done | pass |  |
|`fontWeight`| Function |Dmitry A Smirnov| done | pass |  |
|`effectStrategy`| Function |Dmitry A Smirnov| done |  |  |
|`renderingStrategy`| Function |Dmitry A Smirnov| done |  |  |
|*TabContent*| *Component* | Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function | Evstigneev Roman | done | pass |  |
|`setTabContentOptions`| Function | Evstigneev Roman | done |  |  |
|`tabBar`| Function | Evstigneev Roman | done | pass |  |
|`onWillShow`| Function |Evstigneev Roman | done |  |  |
|`onWillHide`| Function |Evstigneev Roman | done |  |  |
|*Tabs*| *Component* | Tuzhilkin Ivan | done |  |  |
|`construct`| Function |Tuzhilkin Ivan | done | pass |  |
|`setTabsOptions`| Function | Skroba Gleb | done | Andrey Khudenkikh |  |
|`vertical`| Function | Tuzhilkin Ivan | done | pass |  |
|`barPosition`| Function | Tuzhilkin Ivan | done | pass |  |
|`scrollable`| Function | Tuzhilkin Ivan | done | pass |  |
|`barWidth`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`barHeight`| Function | Tuzhilkin Ivan | done  | Andrey Khudenkikh |
|`animationDuration`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh | |
|`animationMode`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`edgeEffect`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`onChange`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`onSelected`| Function |Erokhin Ilya | done | Andrey Khudenkikh| |
|`onTabBarClick`| Function | Tuzhilkin Ivan | done |  |  |
|`onUnselected`| Function |Erokhin Ilya | done |Andrey Khudenkikh | |
|`onAnimationStart`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`onAnimationEnd`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`onGestureSwipe`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`fadingEdge`| Function | Tuzhilkin Ivan | done | pass |  |
|`divider`| Function | Tuzhilkin Ivan | done | failed |  |
|`barOverlap`| Function | Tuzhilkin Ivan | done | pass |  |
|`barBackgroundColor`| Function | Tuzhilkin Ivan | done | pass |  |
|`barGridAlign`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`customContentTransition`| Function | Dudkin Sergey | done | Andrey Khudenkikh |  |
|`barBackgroundBlurStyle0`|  Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`barBackgroundBlurStyle1`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`barBackgroundEffect`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh | |
|`pageFlipMode`| Function | Lobah Mikhail| done| | Not exists on FB|
|`onContentWillChange`| Function | Dudkin Sergey | done | Andrey Khudenkikh | |
|`barMode`| Function |Tuzhilkin Ivan | done | failed |  |
|`cachedMaxCount`| Function | Erokhin Ilya| done | Andrey Khudenkikh | |
|*Text*| *Component* | Samarin Sergey | blocked IDL |  | |
|`construct`| Function |  Kirill Kirichenko | done | pass |  |
|`setTextOptions`| Function | Kirill Kirichenko | done | pass  |  |
|`fontColor`| Function |Samarin Sergey | done | pass |  |
|`fontSize`| Function |Samarin Sergey | done | pass |  |
|`minFontSize`| Function |Samarin Sergey | done | pass |  |
|`maxFontSize`| Function |Samarin Sergey | done | pass |  |
|`minFontScale`| Function |Samarin Sergey | done | pass |  |
|`maxFontScale`| Function |Samarin Sergey | done | pass |  |
|`fontStyle`| Function |Samarin Sergey | done | pass |  |
|`lineSpacing`| Function |Samarin Sergey | done | pass |  |
|`textAlign`| Function |Samarin Sergey | done | pass |  |
|`lineHeight`| Function |Samarin Sergey | done | pass |  |
|`textOverflow`| Function |Samarin Sergey | done | pass |  |
|`fontFamily`| Function |Samarin Sergey | done | failed | OHOSUI-2187 |
|`maxLines`| Function |Samarin Sergey | done | pass |  |
|`decoration`| Function |Samarin Sergey | done | pass |  |
|`letterSpacing`| Function |Samarin Sergey | done | pass |  |
|`textCase`| Function |Samarin Sergey | done | pass |  |
|`baselineOffset`| Function |Samarin Sergey | done | pass |  |
|`copyOption`| Function |Samarin Sergey | done | pass |  |
|`draggable`| Function |Samarin Sergey | done | pass |  |
|`textShadow`| Function |Samarin Sergey | done | pass |  |
|`heightAdaptivePolicy`| Function |Samarin Sergey | done | pass |  |
|`textIndent`| Function |Samarin Sergey | done | pass |  |
|`wordBreak`| Function | Samarin Sergey | done | pass |  |
|`lineBreakStrategy`| Function |Samarin Sergey | done | pass |  |
|`onCopy`| Function | Kirill Kirichenko | done | pass |  |
|`caretColor`| Function |Samarin Sergey | done | pass |  |
|`selectedBackgroundColor`| Function |Samarin Sergey | done | pass |  |
|`ellipsisMode`| Function |Samarin Sergey | done | pass |  |
|`enableDataDetector`| Function | Kirill Kirichenko | done | pass |  |
|`dataDetectorConfig`| Function | Samarin Sergey | done | pass |  |
|`onTextSelectionChange`| Function | Kirill Kirichenko | done | pass |  |
|`fontFeature`| Function |Samarin Sergey | done | pass |  |
|`marqueeOptions`| Function | Samarin Sergey | done |  | |
|`onMarqueeStateChange`| Function | Samarin Sergey | done |  | |
|`privacySensitive`| Function |Samarin Sergey | done | pass |  |
|`textSelectable`| Function |Samarin Sergey | done | pass |  |
|`editMenuOptions`| Function | Pavelyev Ivan | done |  |  |
|`halfLeading`| Function |Samarin Sergey | done | pass |  |
|`enableHapticFeedback`| Function |Samarin Sergey | done |  | not supported by dayu200; need to test on mobile device |
|`font`| Function |Samarin Sergey | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`fontWeight`| Function | Samarin Sergey | done | failed |  |
|`selection`| Function |Samarin Sergey | done | pass | |
|`bindSelectionMenu`| Function | Lobah Mikhail | done |  |  |
|*TextArea*|*Component*|Tuzhilkin Ivan| blocked IDL |  |  |
|`construct`| Function | Tuzhilkin Ivan| done | pass | |
|`setTextAreaOptions`|Function|Tuzhilkin Ivan| done | pass | |
|`placeholderColor`|Function|Tuzhilkin Ivan| done | pass | |
|`placeholderFont`|Function|Tuzhilkin Ivan| done | pass | |
|`enterKeyType`|Function|Tuzhilkin Ivan| done | pass |  |
|`textAlign`|Function|Tuzhilkin Ivan| done | pass |  |
|`caretColor`|Function|Tuzhilkin Ivan| done | pass |  |
|`fontColor`|Function|Tuzhilkin Ivan| done | pass |  |
|`fontSize`|Function|Tuzhilkin Ivan| done | pass |  |
|`fontStyle`|Function|Tuzhilkin Ivan| done | pass |  |
|`fontWeight`|Function|Tuzhilkin Ivan| done | pass |  |
|`fontFamily`|Function|Tuzhilkin Ivan| done | pass |  |
|`textOverflow`|Function|Tuzhilkin Ivan| done | failed |  |
|`textIndent`|Function|Tuzhilkin Ivan| done | pass |  |
|`caretStyle`|Function|Tuzhilkin Ivan| done | pass |  |
|`selectedBackgroundColor`|Function|Tuzhilkin Ivan| done | pass | |
|`onSubmit`| Function | Tuzhilkin Ivan| done | not covered |  |
|`onChange`|Function|Tuzhilkin Ivan| done | pass | not covered |
|`onTextSelectionChange`|Function|Tuzhilkin Ivan| done | not covered | |
|`onContentScroll`|Function|Tuzhilkin Ivan| done | not covered |  |
|`onEditChange`|Function|Tuzhilkin Ivan| done | not covered |  |
|`onCopy`|Function|Tuzhilkin Ivan| done | not covered |  |
|`onCut`|Function|Tuzhilkin Ivan| done | not covered |  |
|`onPaste`|Function|Tuzhilkin Ivan| done | not covered | |
|`copyOption`|Function|Tuzhilkin Ivan| done | pass |  |
|`enableKeyboardOnFocus`|Function|Tuzhilkin Ivan| done | pass |  |
|`maxLength`|Function|Tuzhilkin Ivan| done | pass |  |
|`style`|Function|Tuzhilkin Ivan| done | not covered |  |
|`barState`|Function|Tuzhilkin Ivan| done | pass |  |
|`selectionMenuHidden`|Function|Tuzhilkin Ivan| done | pass |  |
|`minFontSize`|Function|Tuzhilkin Ivan| done | pass |  |
|`maxFontSize`|Function|Tuzhilkin Ivan| done | pass |  |
|`minFontScale`| Function | Kovalev Sergey | done | not covered | |
|`maxFontScale`| Function | Kovalev Sergey | done | not covered | |
|`heightAdaptivePolicy`|Function|Tuzhilkin Ivan| done | pass |  |
|`maxLines`|Function|Tuzhilkin Ivan| done | pass |  |
|`wordBreak`|Function|Tuzhilkin Ivan| done | pass |  |
|`lineBreakStrategy`|Function|Tuzhilkin Ivan| done | pass |  |
|`decoration`|Function|Tuzhilkin Ivan| done | pass |  |
|`letterSpacing`|Function|Tuzhilkin Ivan| done | pass |  |
|`lineSpacing`|Function|Tuzhilkin Ivan| done | pass | |
|`lineHeight`|Function|Tuzhilkin Ivan| done | pass | |
|`type`|Function|Tuzhilkin Ivan| done | not covered |  |
|`enableAutoFill`|Function|Tuzhilkin Ivan| done | pass |  |
|`contentType`|Function|Tuzhilkin Ivan| done | failed |  |
|`fontFeature`|Function|Tuzhilkin Ivan| done | pass |  |
|`onWillInsert`|Function| Skroba Gleb | done | not covered |   |
|`onDidInsert`|Function|Tuzhilkin Ivan| done | not covered |  |
|`onWillDelete`|Function| Skroba Gleb | done | not covered |   |
|`onDidDelete`|Function|Tuzhilkin Ivan| done | not covered |  |
|`editMenuOptions`|Function| Pavelyev Ivan | done | not covered |  |
|`enablePreviewText`|Function|Tuzhilkin Ivan| done | not covered |  |
|`enableHapticFeedback`|Function|Tuzhilkin Ivan| done |  | not supported by dayu200; need to test on mobile device |
|`autoCapitalizationMode`| Function | | | not covered | no such API in generation 125 |
|`halfLeading`| Function | Kovalev Sergey | done | not covered | |
|`ellipsisMode`| Function | Kovalev Sergey | done | not covered | |
|`stopBackPress`| Function | Kovalev Sergey | done | not covered | |
|`onWillChange`| Function | Erokhin Ilya | done | not covered | |
|`keyboardAppearance`| Function | Erokhin Ilya | done | not covered | |
|`inputFilter`|Function|Tuzhilkin Ivan| done | test blocked  | blocked IDL |
|`showCounter`|Function|Tuzhilkin Ivan| done | pass |   |
|`customKeyboard`|Function| Erokhin Ilya | done | not covered | UT by Vadim Voronov  |
|*TextClock*| *Component* |Pavelyev Ivan| blocked IDL |  |  |
|`construct`| Function |Pavelyev Ivan| done | pass |  |
|`setTextClockOptions`| Function |Pavelyev Ivan| done | pass |  |
|`format`| Function |Pavelyev Ivan| done | pass |  |
|`onDateChange`| Function |Pavelyev Ivan| done | not covered |  |
|`fontColor`| Function |Pavelyev Ivan| done | pass |  |
|`fontSize`| Function |Pavelyev Ivan| done | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IBT6PK |
|`fontStyle`| Function |Pavelyev Ivan| done | pass |  |
|`fontWeight`| Function |Pavelyev Ivan| done | pass |  |
|`fontFamily`| Function |Pavelyev Ivan| done | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IBT6QC |
|`textShadow`| Function |Pavelyev Ivan| done | failed | https://gitee.com/openharmony/arkui_ace_engine/issues/IBT6PK, when ShadowOptions is empty cpp crash happen |
|`fontFeature`| Function |Pavelyev Ivan| done |  |  |
|`contentModifier`| Function |Pavelyev Ivan| blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|`dateTimeOptions`| Function |Politov Mikhail| testskipped |  |  |
|*TextInput*| *Component* | Spirin Andrey | in progress |  |  |
|`construct`| Function | Spirin Andrey | done | pass | |
|`setTextInputOptions`| Function | Spirin Andrey | done | pass | |
|`type`| Function | Spirin Andrey | done | pass |  |
|`contentType`| Function | Spirin Andrey | done |  |  |
|`placeholderColor`| Function | Spirin Andrey | done | failed | info: placeholder is not displayed without any log error |
|`textOverflow`| Function | Lobah Mikhail| done|  |https://gitee.com/openharmony/arkui_ace_engine/issues/IB57XU|
|`textIndent`| Function | Spirin Andrey | done |  |  |
|`placeholderFont`| Function | Spirin Andrey | testskipped | failed | info: placeholder is not displayed without any log error |
|`enterKeyType`| Function | Spirin Andrey | done | pass |  |
|`caretColor`| Function | Spirin Andrey | done | pass |  |
|`onEditChange`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`onSubmit`| Function | Spirin Andrey | done |  | EVENT |
|`onChange`| Function | Lobah Mikhail | done | pass | UT done Lobah Mikhail  |
|`onTextSelectionChange`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`onContentScroll`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`maxLength`| Function | Spirin Andrey | done |  |  |
|`fontColor`| Function | Spirin Andrey | done |  |  |
|`fontSize`| Function | Spirin Andrey | done |  |  |
|`fontStyle`| Function | Spirin Andrey | done |  |  |
|`fontWeight`| Function | Spirin Andrey | done |  |  |
|`fontFamily`| Function | Spirin Andrey | done |  |  |
|`onCopy`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`onCut`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`onPaste`| Function | Lobah Mikhail | done |  | UT done Lobah Mikhail |
|`copyOption`| Function | Spirin Andrey | done |  |  |
|`showPasswordIcon`| Function | Spirin Andrey | done |  |  |
|`textAlign`| Function | Spirin Andrey | done |  |  |
|`style`| Function | Spirin Andrey | done |  |  |
|`caretStyle`| Function | Spirin Andrey | done |  |  |
|`selectedBackgroundColor`| Function | Spirin Andrey | done |  |  |
|`caretPosition`| Function | Spirin Andrey | done |  |  |
|`enableKeyboardOnFocus`| Function | Spirin Andrey | done |  |  |
|`passwordIcon`| Function | Spirin Andrey | done |  |  |
|`showError`| Function | Spirin Andrey | done |  |  |
|`showUnit`| Function | Erokhin Ilya | done |  | |
|`showUnderline`| Function | Spirin Andrey | done |  |  |
|`underlineColor`| Function | Spirin Andrey | done |  |  |
|`selectionMenuHidden`| Function | Spirin Andrey | done |  |  |
|`barState`| Function | Spirin Andrey | done |  |  |
|`maxLines`| Function | Lobah Mikhail| done| |
|`wordBreak`| Function | Spirin Andrey | done |  |  |
|`lineBreakStrategy`| Function | Spirin Andrey | done |  |  |
|`cancelButton`| Function | Spirin Andrey | done |  |  |
|`selectAll`| Function | Spirin Andrey | done |  |  |
|`minFontSize`| Function | Spirin Andrey | done  |  |
|`maxFontSize`| Function | Spirin Andrey | done  |  |
|`minFontScale`| Function | Kovalev Sergey | done |  | |
|`maxFontScale`| Function | Kovalev Sergey | done |  | |
|`heightAdaptivePolicy`| Function | Spirin Andrey | done |  |  |
|`enableAutoFill`| Function | Spirin Andrey | done |  |  |
|`decoration`| Function | Spirin Andrey | done |  | |
|`letterSpacing`| Function | Spirin Andrey | done |  | |
|`lineHeight`| Function | Spirin Andrey | done |  | |
|`passwordRules`| Function | Spirin Andrey | done |  |  |
|`fontFeature`| Function | Spirin Andrey | done |  | |
|`showPassword`| Function | Spirin Andrey | done |  |  |
|`onSecurityStateChange`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`onWillInsert`| Function | Skroba Gleb | done |  |   |
|`onDidInsert`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`onWillDelete`| Function | Skroba Gleb | done |  |   |
|`onDidDelete`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`editMenuOptions`| Function | Pavelyev Ivan| done|  |  |
|`enablePreviewText`| Function | Spirin Andrey | done |  |  |
|`enableHapticFeedback`| Function | Spirin Andrey | done |  | not supported by dayu200; need to test on mobile device |
|`autoCapitalizationMode`| Function | | | | no such API in generation 125 |
|`halfLeading`| Function | Kovalev Sergey | done |  | |
|`ellipsisMode`| Function |  Kovalev Sergey| done |  | |
|`stopBackPress`| Function | Kovalev Sergey | done |  | |
|`onWillChange`| Function | Lobah Mikhail| done| | |
|`keyboardAppearance`| Function | Erokhin Ilya | done | | |
|`inputFilter`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`customKeyboard`| Function | Lobah Mikhail | done |  |   |
|`showCounter`| Function | Lobah Mikhail| done| | https://gitee.com/openharmony/arkui_ace_engine/issues/IB3V0N |
|*TextPicker*| *Component* | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`construct`| Function | Tuzhilkin Ivan | done | pass |  |
|`setTextPickerOptions`| Function | Tuzhilkin Ivan | done | failed | OHOSUI-2386 multi column picker not working |
|`defaultPickerItemHeight`| Function | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`canLoop`| Function | Ekaterina Stepanova | done | pass |  |
|`disappearTextStyle`| Function | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`textStyle`| Function | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`selectedTextStyle`| Function | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`disableTextStyleAnimation`| Function | Kovalev Sergey | done | Ekaterina Stepanova | API is present on Upstream only |
|`defaultTextStyle`| Function | Kovalev Sergey | done | Ekaterina Stepanova | API is present on Upstream only |
|`onChange`| Function | Tuzhilkin Ivan | done | Ekaterina Stepanova |  |
|`onScrollStop`| Function | Kovalev Sergey | done | Ekaterina Stepanova | API is present on Upstream only |
|`onEnterSelectedArea`| Function | Kovalev Sergey | done | Ekaterina Stepanova | API is present on Upstream only |
|`selectedIndex`| Function | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`divider`| Function | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`gradientHeight`| Function | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`enableHapticFeedback`| Function | Kovalev Sergey | done | Ekaterina Stepanova | API is present on Upstream only |
|`digitalCrownSensitivity`| Function | Kovalev Sergey | done | Ekaterina Stepanova | API is present on Upstream only |
|*TextTimer*| *Component* |Ekaterina Stepanova| blocked IDL |  |  |
|`construct`| Function | Ekaterina Stepanova| done | pass |  |
|`setTextTimerOptions`| Function |Ekaterina Stepanova| done | pass |  |
|`format`| Function |Ekaterina Stepanova| done | pass |  |
|`fontColor`| Function |Ekaterina Stepanova| done | pass |  |
|`fontSize`| Function |Ekaterina Stepanova| done | pass |  |
|`fontStyle`| Function | Ekaterina Stepanova| done | pass |  |
|`fontWeight`| Function |Ekaterina Stepanova| done | pass |  |
|`fontFamily`| Function |Ekaterina Stepanova| done | pass  |  |
|`onTimer`| Function |Ekaterina Stepanova| blocked IDL | not covered | https://gitee.com/nikolay-igotti/idlize/issues/IB3V0H |
|`textShadow`| Function |Ekaterina Stepanova| testskipped | pass | UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IB2SZK |
|`contentModifier`| Function |Ekaterina Stepanova| blocked IDL | not covered | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*TimePicker*| *Component* | Ekaterina Stepanova| blocked IDL |  |  |
|`construct`| Function |Politov Mikhail| done |  |  |
|`setTimePickerOptions`| Function |Politov Mikhail| done |  |  |
|`useMilitaryTime`| Function |Ekaterina Stepanova| done | pass |  |
|`loop`| Function |Ekaterina Stepanova| done | pass |  |
|`disappearTextStyle0`| Function |Ekaterina Stepanova| done | pass |  |
|`textStyle`| Function |Ekaterina Stepanova| done | pass |  |
|`selectedTextStyle`| Function |Ekaterina Stepanova| done | pass |  |
|`dateTimeOptions`| Function |Politov Mikhail| done |  | |
|`onChange`| Function |Ekaterina Stepanova| done | pass |  |
|`onEnterSelectedArea`| Function | Kovalev Sergey | done | pass | API is present on Upstream only |
|`enableHapticFeedback`| Function |Ekaterina Stepanova| done |  | not supported by dayu200; need to test on mobile device |
|`digitalCrownSensitivity`| Function | Kovalev Sergey | done | | API is present on Upstream only |
|`enableCascade`| Function | Kovalev Sergey | done | pass | API is present on Upstream only |
|*Toggle*| *Component* |Morozov Sergey |blocked IDL |  |
|`construct`| Function |Morozov Sergey | done | | unblocked since AceEngine won't fix it |
|`setToggleOptions`| Function |Morozov Sergey | done |  | unblocked since AceEngine won't fix it |
|`onChange`| Function | Morozov Sergey| done | pass |  |
|`contentModifier`| Function |Morozov Sergey | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|`selectedColor`| Function | Morozov Sergey| done | pass |  |
|`switchPointColor`| Function | Morozov Sergey| done | pass |  |
|`switchStyle`| Function | Morozov Sergey| done | pass |  |
|*UIExtensionComponent*| *Component* | Tuzhilkin Ivan | blocked IDL |  | |
|`construct`| Function | Tuzhilkin Ivan | testskipped |  | |
|`setUIExtensionComponentOptions`| Function | Tuzhilkin Ivan |  |  | |
|`onRemoteReady`| Function | Tuzhilkin Ivan | testskipped |  | |
|`onReceive`| Function | Tuzhilkin Ivan |  |  | |
|`onError`| Function | Skroba Gleb | testskipped |  | |
|`onTerminated`| Function | Tuzhilkin Ivan | testskipped |  | |
|*Video*| *Component* | Erokhin Ilya | blocked AceEngine|  |  |
|`construct`| Function |Erokhin Ilya | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`setVideoOptions`| Function | Erokhin Ilya | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`muted`| Function | Erokhin Ilya | done |  |  |
|`autoPlay`| Function | Erokhin Ilya | done |  |  |
|`controls`| Function | Erokhin Ilya | done |  |  |
|`loop`| Function | Erokhin Ilya | done |  |  |
|`objectFit`| Function | Erokhin Ilya | done |  |  |
|`onStart`| Function | Erokhin Ilya | done | pass |  |
|`onPause`| Function | Erokhin Ilya | done | pass |  |
|`onFinish`| Function | Erokhin Ilya | done |  |  |
|`onFullscreenChange`| Function | Erokhin Ilya | done |  |  |
|`onPrepared`| Function | Erokhin Ilya | done | pass |  |
|`onSeeking`| Function | Erokhin Ilya | done |  |  |
|`onSeeked`| Function | Erokhin Ilya | done |  |  |
|`onUpdate`| Function | Erokhin Ilya | done |  |  |
|`onError`| Function | Erokhin Ilya | done | pass |  |
|`onStop`| Function | Erokhin Ilya | done |  |  |
|`enableAnalyzer`| Function | Erokhin Ilya | done | pass |  |
|`analyzerConfig`| Function | Erokhin Ilya | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`surfaceBackgroundColor`| Function | Kovalev Sergey | done | | |
|`enableShortcutKey`| Function | Kovalev Sergey | done | | |
|*WaterFlow*| *Component* | Kovalev Sergey | done |  |  |
|`construct`| Function | Kovalev Sergey | done | pass | |
|`setWaterFlowOptions`| Function | Kovalev Sergey | done | pass | |
|`columnsTemplate`| Function | Kovalev Sergey | done | pass | |
|`itemConstraintSize`| Function | Kovalev Sergey | done | | |
|`rowsTemplate`| Function | Kovalev Sergey | done | | |
|`columnsGap`| Function | Kovalev Sergey | done | pass | |
|`rowsGap`| Function |Kovalev Sergey | done | pass | |
|`layoutDirection`| Function |Kovalev Sergey | done | | |
|`cachedCount0`| Function |Kovalev Sergey | done | | |
|`cachedCount1`| Function | Kovalev Sergey | done | | |
|`onScrollFrameBegin`| Function | Dudkin Sergey | in progress | |
|`onScrollIndex`| Function | Kovalev Sergey | done | | |
|`onWillScroll`| Function | | | | |
|`onDidScroll`| Function | | | | |
|*WindowScene*| *Component* | Dudkin Sergey | done |  | |
|`construct`| Function |Dudkin Sergey | done |  | |
|`setWindowSceneOptions`| Function | Dudkin Sergey | done |  | |
|`attractionEffect`| Function | Dudkin Sergey  | done |  |  |
|*XComponent*| *Component* | Tuzhilkin Ivan | blocked IDL |  | |
|`construct`| Function |Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setXComponentOptions0`| Function | Tuzhilkin Ivan | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IB8FFO, https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 (+), demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setXComponentOptions1`| Function | Tuzhilkin Ivan | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IB8FFO, https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 (+), demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setXComponentOptions2`| Function | Tuzhilkin Ivan | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IB8FFO, https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 (+), demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`onLoad`| Function | Tuzhilkin Ivan | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IB7RSS (+), demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`onDestroy`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`enableAnalyzer`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`enableSecure`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`hdrBrightness`| Function | Tuzhilkin Ivan | testskipped | test blocked | supported only on UPSTREAM now, demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`enableTransparentLayer`| Function | Tuzhilkin Ivan | testskipped | test blocked | supported only on UPSTREAM now, demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|*Root*| *Component* | Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|`construct`| Function | Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|*ComponentRoot*| *Component* | Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|`construct`| Function |Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|*CustomLayoutRoot*| *Component* | Erokhin Ilya | in progress | | |
|`construct`| Function | Erokhin Ilya | in progress | | |
|`subscribeOnMeasureSize`| Function | Erokhin Ilya | in progress | | |
|`subscribeOnPlaceChildren`| Function | Erokhin Ilya | in progress | | |
|*SpringProp*| *Class* |managed side | managed side| | |
|`ctor`| Function |managed side |managed side | | |
|*SpringMotion*| *Class* |managed side |managed side | | |
|`ctor`| Function |managed side |managed side | | |
|*FrictionMotion*| *Class* |managed side | managed side| | |
|`ctor`| Function |managed side |managed side | | |
|*ScrollMotion*| *Class* |managed side | managed side| | |
|`ctor`| Function |managed side | managed side| | |
|*BaseContext*| *Class* | | | | |
|`ctor`| Function | | | | |
|*Context*| *Class* | | | | |
|`ctor`| Function | | | | |
|*LayoutChild*| *Class* | | | | |
|`ctor`| Function | | | | |
|`measure`| Function | | | | |
|`getName`| Function | | | | |
|`setName`| Function | | | | |
|`getId`| Function | | | | |
|`setId`| Function | | | | |
|`getPosition`| Function | | | | |
|`setPosition`| Function | | | | |
|*TapGestureInterface*| *Class* | Dudkin Sergey | done | | wait new generation for feature_branch, to merge CTOR impl |
|`ctor`| Function | Dudkin Sergey | done | | |
|`onAction`| Function | Dudkin Sergey | done | | |
|*LongPressGestureInterface*| *Class* | Morozov Sergey | done | | wait new generation for feature_branch, to merge CTOR impl |
|`ctor`| Function | Morozov Sergey | done | | |
|`onAction`| Function | Morozov Sergey | done | | |
|`onActionEnd`| Function | Morozov Sergey | done | | |
|`onActionCancel0`| Function | Morozov Sergey | done | | |
|`onActionCancel1`| Function | Morozov Sergey | done | | |
|*PanGestureInterface*| *Class* | Morozov Sergey | done | | wait new generation for feature_branch, to merge CTOR impl |
|`ctor`| Function | Morozov Sergey | done | | |
|`onActionStart`| Function | Morozov Sergey | done | | |
|`onActionUpdate`| Function | Morozov Sergey | done | | |
|`onActionEnd`| Function | Morozov Sergey | done | | |
|`onActionCancel0`| Function | Morozov Sergey | done | | |
|`onActionCancel1`| Function | Morozov Sergey | done | | |
|*PinchGestureInterface*| *Class* | Tuzhilkin Ivan | done | | wait new generation for feature_branch, to merge CTOR impl |
|`ctor`| Function | Tuzhilkin Ivan | done | | |
|`onActionStart`| Function | Tuzhilkin Ivan | done | | |
|`onActionUpdate`| Function | Tuzhilkin Ivan | done | | |
|`onActionEnd`| Function | Tuzhilkin Ivan | done | | |
|`onActionCancel0`| Function | Tuzhilkin Ivan | done | | |
|`onActionCancel1`| Function | Tuzhilkin Ivan | done | | |
|*GestureGroupInterface*| *Class* | Tuzhilkin Ivan | done | | wait new generation for feature_branch, to merge CTOR impl |
|`ctor`| Function |Tuzhilkin Ivan | done | | |
|`onCancel`| Function | Tuzhilkin Ivan | done | | |
|*WebCookie*| *Class* | Erokhin Ilya | done |  | |
|`ctor`| Function |Erokhin Ilya | done |  |  |
|`setCookie`| Function | Erokhin Ilya | done |  |deprecated |
|`saveCookie`| Function | Erokhin Ilya | done |  |deprecated |
|*ComponentContent*| *Class* | | | | |
|`ctor`| Function | | | | |
|`update`| Function | | | | |
|`reuse`| Function | | | | |
|`recycle`| Function | | | | |
|`dispose`| Function | | | | |
|`updateConfiguration`| Function | | | | |
|*FrameNode*| *Class* | Tuzhilkin Ivan | done |  | |
|`ctor`| Function | Tuzhilkin Ivan | in progress |  | |
|`isModifiable`| Function | Tuzhilkin Ivan | done |  | |
|`appendChild`| Function | Tuzhilkin Ivan | done |  | |
|`insertChildAfter`| Function | Tuzhilkin Ivan | done |  | |
|`removeChild`| Function | Tuzhilkin Ivan | done |  | |
|`clearChildren`| Function | Tuzhilkin Ivan | done |  | |
|`getChild`| Function | Tuzhilkin Ivan | done |  | |
|`getFirstChild`| Function | Tuzhilkin Ivan | done |  | |
|`getNextSibling`| Function | Tuzhilkin Ivan | done |  | |
|`getPreviousSibling`| Function | Tuzhilkin Ivan | done |  | |
|`getParent`| Function | Tuzhilkin Ivan | done |  | |
|`getChildrenCount`| Function | Tuzhilkin Ivan | done |  | |
|`dispose`| Function | Tuzhilkin Ivan | done |  | |
|`getOpacity`| Function | Morozov Sergey | done | | |
|`getPositionToWindowWithTransform`| Function | Morozov Sergey | done | | |
|`getFrameNodeByKey`| Function | | | | |
|`getIdByFrameNode`| Function | | | | |
|`moveTo`| Function | | | | |
|`getFirstChildIndexWithoutExpand`| Function | | | | |
|`getLastChildIndexWithoutExpand`| Function | | | | |
|`getAttachedFrameNodeById`| Function | | | | |
|`getFrameNodeById`| Function | | | | |
|`getFrameNodeByUniqueId`| Function | | | | |
|`reuse`| Function | | | | |
|`recycle`| Function | | | | |
|`getFrameNodePtr`| Function | | | | |
|*DrawContext*| *Class* | | | | |
|`ctor`| Function | | | | |
|`size`| Function | | | | |
|`sizeInPixel`| Function | | | | |
|`canvas`| Function | | | | |
|*LengthMetrics*| *Class* | Evstigneev Roman | done | | |
|`ctor`| Function |Evstigneev Roman | done | | |
|`px`| Function | Evstigneev Roman | done | | |
|`vp`| Function | Samarin Sergey | done | | |
|`fp`| Function | Samarin Sergey | done | | |
|`percent`| Function | Samarin Sergey | done | | |
|`lpx`| Function | Samarin Sergey | done | | |
|`resource`| Function | Evstigneev Roman | done | | |
|`getUnit`| Function | Samarin Sergey | done | | |
|`setUnit`| Function | Samarin Sergey | done | | |
|`getValue`| Function | Samarin Sergey | done | | |
|`setValue`| Function | Samarin Sergey | done | | |
|*ColorMetrics*| *Class* | Lobah Mikhail| done| | |
|`ctor`| Function | Lobah Mikhail| done| | |
|`numeric`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`rgba`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`resourceColor`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`blendColor`| Function | Lobah Mikhail| done| | |
|`color`| Function | Lobah Mikhail| done| | |
|`red`| Function | Lobah Mikhail| done| | |
|`green`| Function | Lobah Mikhail| done| | |
|`blue`| Function | Lobah Mikhail| done| | |
|`apha`| Function | Lobah Mikhail| done| | |
|*ShapeMask*| *Class* | Vadim Voronov | done | | |
|`ctor`| Function |  Vadim Voronov | done | |   |
|`setRectShape`| Function | Vadim Voronov | done | | |
|`setRoundRectShape`| Function | Vadim Voronov | done | | |
|`setCircleShape`| Function | Vadim Voronov | done | | |
|`setOvalShape`| Function | Vadim Voronov | done | | |
|`setCommandPath`| Function | Vadim Voronov | done | | |
|`getFillColor`| Function | Vadim Voronov | done | | |
|`setFillColor`| Function | Vadim Voronov | done | | |
|`getStrokeColor`| Function | Vadim Voronov | done | | |
|`setStrokeColor`| Function | Vadim Voronov | done | | |
|`getStrokeWidth`| Function | Vadim Voronov | done | | |
|`setStrokeWidth`| Function | Vadim Voronov | done | | |
|*ShapeClip*| *Class* | Andrey Khudenkikh | done | | |
|`ctor`| Function | Andrey Khudenkikh | done | | |
|`setRectShape`| Function | Andrey Khudenkikh | done | | |
|`setRoundRectShape`| Function | Andrey Khudenkikh | done | | |
|`setCircleShape`| Function | Andrey Khudenkikh | done | | |
|`setOvalShape`| Function | Andrey Khudenkikh | done | | |
|`setCommandPath`| Function | Andrey Khudenkikh | done | | |
|*NodeContent*| *Class* | | | | |
|`ctor`| Function | | | | |
|`addFrameNode`| Function | | | | |
|`removeFrameNode`| Function | | | | |
|*RenderNode*| *Class* | Morozov Sergey | in progress | | done on Upstream |
|`ctor`| Function | Morozov Sergey | done | | done on Upstream |
|`appendChild`| Function | Morozov Sergey | done | | done on Upstream |
|`insertChildAfter`| Function | Morozov Sergey | done | | done on Upstream |
|`removeChild`| Function | Morozov Sergey | done | | done on Upstream |
|`clearChildren`| Function | Morozov Sergey | done | | done on Upstream |
|`getChild`| Function | Morozov Sergey | done | | done on Upstream |
|`getFirstChild`| Function | Morozov Sergey | done | | done on Upstream |
|`getNextSibling`| Function | Morozov Sergey | done | | done on Upstream |
|`getPreviousSibling`| Function | Morozov Sergey | done | | done on Upstream |
|`draw`| Function | managed side | managed side | | |
|`invalidate`| Function | Morozov Sergey | testskipped | | done on Upstream |
|`dispose`| Function | Morozov Sergey | done | | done on Upstream |
|`getBackgroundColor`| Function | Morozov Sergey | done | | done on Upstream |
|`setBackgroundColor`| Function | Morozov Sergey | done | | done on Upstream |
|`getClipToFrame`| Function | Morozov Sergey | done | | done on Upstream |
|`setClipToFrame`| Function | Morozov Sergey | done | | done on Upstream |
|`getOpacity`| Function | Morozov Sergey | done | | done on Upstream |
|`setOpacity`| Function | Morozov Sergey | done | | done on Upstream |
|`getSize`| Function | Morozov Sergey | done | | done on Upstream |
|`setSize`| Function | Morozov Sergey | done | | done on Upstream |
|`getPosition`| Function | Morozov Sergey | done | | done on Upstream |
|`setPosition`| Function | Morozov Sergey | done | | done on Upstream |
|`getFrame`| Function | Morozov Sergey | done | | done on Upstream |
|`setFrame`| Function | Morozov Sergey | done | | done on Upstream |
|`getPivot`| Function | Morozov Sergey | done | | done on Upstream |
|`setPivot`| Function | Morozov Sergey | done | | done on Upstream |
|`getScale`| Function | Morozov Sergey | done | | done on Upstream |
|`setScale`| Function | Morozov Sergey | done | | done on Upstream |
|`getTranslation`| Function | Morozov Sergey | done | | done on Upstream |
|`setTranslation`| Function | Morozov Sergey | done | | done on Upstream |
|`getRotation`| Function | Morozov Sergey | done | | done on Upstream |
|`setRotation`| Function | Morozov Sergey | done | | done on Upstream |
|`getTransform`| Function | Morozov Sergey | done | | done on Upstream |
|`setTransform`| Function | Morozov Sergey | done | | done on Upstream |
|`getShadowColor`| Function | Morozov Sergey | done | | done on Upstream |
|`setShadowColor`| Function | Morozov Sergey | done | | done on Upstream |
|`getShadowOffset`| Function | Morozov Sergey | done | | done on Upstream 
|`setShadowOffset`| Function | Morozov Sergey | done | | done on Upstream |
|`getLabel`| Function | Morozov Sergey | done | | done on Upstream |
|`setLabel`| Function | Morozov Sergey | done | | done on Upstream |
|`getShadowAlpha`| Function | Morozov Sergey | done | | done on Upstream |
|`setShadowAlpha`| Function | Morozov Sergey | done | | done on Upstream |
|`getShadowElevation`| Function | Morozov Sergey | done | | done on Upstream |
|`setShadowElevation`| Function | Morozov Sergey | done | | done on Upstream |
|`getShadowRadius`| Function | Morozov Sergey | done | | done on Upstream |
|`setShadowRadius`| Function | Morozov Sergey | done | | done on Upstream |
|`getBorderStyle`| Function | Morozov Sergey | done | | done on Upstream |
|`setBorderStyle`| Function | Morozov Sergey | done | | done on Upstream |
|`getBorderWidth`| Function | Morozov Sergey | done | | done on Upstream |
|`setBorderWidth`| Function | Morozov Sergey | done | | done on Upstream |
|`getBorderColor`| Function | Morozov Sergey | done | | done on Upstream |
|`setBorderColor`| Function | Morozov Sergey | done | | done on Upstream |
|`getBorderRadius`| Function | Morozov Sergey | done | | done on Upstream |
|`setBorderRadius`| Function | Morozov Sergey | done | | done on Upstream |
|`getShapeMask`| Function | Morozov Sergey | done | | done on Upstream |
|`setShapeMask`| Function | Morozov Sergey | done | | done on Upstream |
|`getShapeClip`| Function | Morozov Sergey | done | | done on Upstream |
|`setShapeClip`| Function | Morozov Sergey | done | | done on Upstream |
|`getMarkNodeGroup`| Function | Morozov Sergey | done | | done on Upstream |
|`setMarkNodeGroup`| Function | Morozov Sergey | done | | done on Upstream |
|`getLengthMetricsUnit`| Function | Morozov Sergey | done | | done on Upstream |
|`setLengthMetricsUnit`| Function | Morozov Sergey | done | | done on Upstream |
|*CalendarController*| *Class* | Maksimov Nikita | done |  |  |
|`ctor`| Function | Maksimov Nikita | done |  |  |
|`backToToday`| Function | Maksimov Nikita | done |  |  |
|`goTo`| Function | Maksimov Nikita | done |  |  |
|*CalendarPickerDialog*| *Class* | Ekaterina Stepanova | testskipped |  | |
|`ctor`| Function | | | | |
|`show`| Function | Ekaterina Stepanova | testskipped |  | UT in progress, Skroba Gleb |
|*CanvasGradient*| *Class* | Vadim Voronov | done |  | |
|`ctor`| Function | Vadim Voronov | done |  | |
|`addColorStop`| Function | Vadim Voronov | done |  | |
|*CanvasPath*| *Class* | Vadim Voronov | testskipped |  |  |
|`ctor`| Function |Vadim Voronov | testskipped |  |  |
|`arc`| Function | Vadim Voronov | testskipped |  |  |
|`arcTo`| Function | Vadim Voronov | testskipped |  |  |
|`bezierCurveTo`| Function | Vadim Voronov | testskipped |  |  |
|`closePath`| Function | Vadim Voronov | testskipped |  |  |
|`ellipse`| Function | Vadim Voronov | testskipped |  |  |
|`lineTo`| Function | Vadim Voronov | testskipped |  |  |
|`moveTo`| Function | Vadim Voronov | testskipped |  |  |
|`quadraticCurveTo`| Function | Vadim Voronov | testskipped |  |  |
|`rect`| Function | Vadim Voronov | testskipped |  |  |
|*Path2D*| *Class* | Vadim Voronov | testskipped |  | |
|`ctor`| Function |Vadim Voronov | testskipped |  | |
|`addPath`| Function | Vadim Voronov | testskipped |  | |
|*CanvasPattern*| *Class* | Vadim Voronov | done |  |  |
|`ctor`| Function |Vadim Voronov | done |  |  |
|`setTransform`| Function | Vadim Voronov | done |  |  |
|*ImageBitmap*| *Class* | Vadim Voronov | testskipped  |  | |
|`ctor`| Function | Vadim Voronov | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`close`| Function | Vadim Voronov | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getHeight`| Function | Vadim Voronov | testskipped | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setHeight`| Function | | | | |
|`getWidth`| Function | Vadim Voronov | testskipped | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setWidth`| Function | | | | |
|*ImageData*| *Class* | Morozov Sergey | in progress | | |
|`ctor`| Function |Morozov Sergey | done | | |
|`getData`| Function | Morozov Sergey | in progress | | |
|`setData`| Function | | |
|`getHeight`| Function | Morozov Sergey | done | | |
|`setHeight`| Function | | | | |
|`getWidth`| Function | Morozov Sergey | done | | |
|`setWidth`| Function | | | | |
|*RenderingContextSettings*| *Class* | Vadim Voronov | done | Vadim Voronov | |
|`ctor`| Function |  Vadim Voronov | done | | |
|`getAntialias`| Function | Vadim Voronov | done | | |
|`setAntialias`| Function | Vadim Voronov | done | | |
|*CanvasRenderer*| *Class*  | Vadim Voronov | blocked IDL | Vadim Voronov | |
|`ctor`| Function |Vadim Voronov | done |  | |
|`drawImage0`| Function |Vadim Voronov | done |  | |
|`drawImage1`| Function  | Vadim Voronov | done |  | |
|`drawImage2`| Function  | Vadim Voronov | done |  | |
|`beginPath`| Function  | Vadim Voronov | done  |  | |
|`clip0`| Function  | Vadim Voronov | done  |  | |
|`clip1`| Function  | Vadim Voronov | done  |  | |
|`fill0`| Function  | Vadim Voronov | done  |  | |
|`fill1`| Function  | Vadim Voronov | done  |  | |
|`stroke0`| Function  | Vadim Voronov | done  |  | |
|`stroke1`| Function  | Vadim Voronov | done  |  | |
|`createLinearGradient`| Function  | Vadim Voronov | done | | |
|`createPattern`| Function  | Vadim Voronov | done | | |
|`createRadialGradient`| Function  | Vadim Voronov | done | |  |
|`createConicGradient`| Function  | Vadim Voronov | done | |  |
|`createImageData0`| Function  | Vadim Voronov | done | |  |
|`createImageData1`| Function  | Vadim Voronov | done | |  |
|`getImageData`| Function  | Vadim Voronov | done | | |
|`getPixelMap`| Function  | Vadim Voronov | done | | |
|`putImageData0`| Function  | Vadim Voronov | done   |  |  |
|`putImageData1`| Function  | Vadim Voronov | done   |  |  |
|`getLineDash`| Function  | Vadim Voronov |  done | |  |
|`setLineDash`| Function  | Vadim Voronov | done |  | |
|`clearRect`| Function  | Vadim Voronov | done |  | |
|`fillRect`| Function  | Vadim Voronov | done |  | |
|`strokeRect`| Function  | Vadim Voronov | done |  | |
|`restore`| Function  | Vadim Voronov | done |  | |
|`save`| Function  | Vadim Voronov | done |  | |
|`fillText`| Function  | Vadim Voronov | done |  | |
|`measureText`| Function  | Vadim Voronov | done |  |  |
|`strokeText`| Function  | Vadim Voronov | done |  | |
|`getTransform`| Function  | Vadim Voronov | done | |  |
|`resetTransform`| Function  | Vadim Voronov | done |  | |
|`rotate`| Function  | Vadim Voronov | done |  | |
|`scale`| Function  | Vadim Voronov | done |  | |
|`setTransform0`| Function  | Vadim Voronov | done |  | |
|`setTransform1`| Function  | Vadim Voronov | done |  | |
|`transform`| Function  | Vadim Voronov | done |  | |
|`translate`| Function  | Vadim Voronov | done |  | |
|`setPixelMap`| Function  | Vadim Voronov | done |  |  |
|`transferFromImageBitmap`| Function  | Vadim Voronov | done |  | |
|`saveLayer`| Function  | Vadim Voronov | done |  | |
|`restoreLayer`| Function  | Vadim Voronov | done |  | |
|`reset`| Function  | Vadim Voronov | done |  | |
|`getLetterSpacing`| Function | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setLetterSpacing`| Function | Vadim Voronov | done | | |
|`getGlobalAlpha`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setGlobalAlpha`| Function  | Vadim Voronov | done |  | |
|`getGlobalCompositeOperation`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setGlobalCompositeOperation`| Function  | Vadim Voronov | done |  | |
|`getFillStyle`| Function | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setFillStyle`| Function  | Vadim Voronov | done |  | |
|`getStrokeStyle`| Function | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setStrokeStyle`| Function  | Vadim Voronov | done |  | |
|`getFilter`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setFilter`| Function  | Vadim Voronov | done |  | |
|`getImageSmoothingEnabled`| Function  | Vadim Voronov | done |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setImageSmoothingEnabled`| Function  | Vadim Voronov | done |  | |
|`getImageSmoothingQuality`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setImageSmoothingQuality`| Function  | Vadim Voronov | done |  |   |
|`getLineCap`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setLineCap`| Function  | Vadim Voronov | done |  |  |
|`getLineDashOffset`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setLineDashOffset`| Function  | Vadim Voronov | done |  | |
|`getLineJoin`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setLineJoin`| Function  | Vadim Voronov | done |  |   |
|`getLineWidth`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setLineWidth`| Function  | Vadim Voronov | done |  | |
|`getMiterLimit`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setMiterLimit`| Function  | Vadim Voronov | done |  | |
|`getShadowBlur`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setShadowBlur`| Function  | Vadim Voronov | done |  | |
|`getShadowColor`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setShadowColor`| Function  | Vadim Voronov | done |  | |
|`getShadowOffsetX`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setShadowOffsetX`| Function  | Vadim Voronov | done |  | |
|`getShadowOffsetY`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setShadowOffsetY`| Function  | Vadim Voronov | done |  | |
|`getDirection`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setDirection`| Function  | Vadim Voronov | done |  |   |
|`getFont`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setFont`| Function  | Vadim Voronov | done |  | |
|`getTextAlign`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setTextAlign`| Function  | Vadim Voronov | done |  |   |
|`getTextBaseline`| Function  | Vadim Voronov | blocked IDL |  | to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setTextBaseline`| Function  | Vadim Voronov | done |  |   |
|*CanvasRenderingContext2D*| *Class* | Vadim Voronov | done | Vadim Voronov |  |
|`ctor`| Function |Vadim Voronov| in progress | pass | todo in API v.129 |
|`toDataURL`| Function |Vadim Voronov| done | failed | bug hos2393 |
|`startImageAnalyzer`| Function | Vadim Voronov | done | failed  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`stopImageAnalyzer`| Function | Vadim Voronov| done | failed | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`onOnAttach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`offOnAttach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`onOnDetach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`offOnDetach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`getHeight`| Function |Vadim Voronov| done | pass | |
|`setHeight`| Function |Vadim Voronov | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/ICDSL|
|`getWidth`| Function |Vadim Voronov| done | pass | |
|`setWidth`| Function |Vadim Voronov | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/ICDSL|
|`getCanvas`| Function |Vadim Voronov | testskipped | |  |
|`setCanvas`| Function |Vadim Voronov | in progress | | todo in API v.129 |
|*OffscreenCanvasRenderingContext2D*| *Class* | Vadim Voronov | done | Vadim Voronov | |
|`ctor`| Function |Vadim Voronov | done | | |
|`toDataURL`| Function | Vadim Voronov | done | | |
|`transferToImageBitmap`| Function | Vadim Voronov | done | |    |
|*OffscreenCanvas*| *Class* | Vadim Voronov | testskipped | | |
|`ctor`| Function |Vadim Voronov | testskipped | | |
|`transferToImageBitmap`| Function | Vadim Voronov | testskipped | | |
|`getContext2d`| Function | Vadim Voronov | testskipped | | |
|`getHeight`| Function | Vadim Voronov | testskipped | | |
|`setHeight`| Function | Vadim Voronov | testskipped | | |
|`getWidth`| Function | Vadim Voronov | testskipped| | |
|`setWidth`| Function | Vadim Voronov | testskipped | | |
|*DrawingRenderingContext*| *Class* | Vadim Voronov | done | Vadim Voronov | |
|`ctor`| Function | Vadim Voronov | done |  | |
|`invalidate`| Function | Vadim Voronov | done |  | |
|`getSize`| Function | Vadim Voronov | done |  | |
|`setSize`| Function | | | | |
|*ICurve*| *Class* | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`ctor`| Function |Erokhin Ilya | done |  |  |
|`interpolate`| Function | Erokhin Ilya | done |  |  |
|*DrawModifier*| *Class* | Erokhin Ilya | blocked IDL|  | |
|`ctor`| Function | Erokhin Ilya | done | pass | |
|`getDrawBehind`| Function | Erokhin Ilya | blocked IDL | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, https://gitee.com/nikolay-igotti/idlize/issues/IBAFYT |
|`setDrawBehind`| Function | | | | |
|`getDrawContent`| Function | Erokhin Ilya | blocked IDL |  test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, https://gitee.com/nikolay-igotti/idlize/issues/IBAFYT |
|`setDrawContent`| Function | | | | |
|`getDrawFront`| Function | Erokhin Ilya | blocked IDL | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, https://gitee.com/nikolay-igotti/idlize/issues/IBAFYT |
|`setDrawFront`| Function | | | | |
|`invalidate`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*TransitionEffect*| *Class* | Andrey Khudenkikh | in progress | test blocked |OHOSUI-2171 |
|`ctor`| Function |Andrey Khudenkikh | done |  | |
|`translate`| Function | Andrey Khudenkikh | done | Sergey Kovalev | |
|`rotate`| Function | Andrey Khudenkikh | done | failed| OHOSUI-2171|
|`scale`| Function | Andrey Khudenkikh | done | Sergey Kovalev | |
|`opacity`| Function | Andrey Khudenkikh | done | Sergey Kovalev | |
|`move`| Function | Andrey Khudenkikh | done | Sergey Kovalev | |
|`asymmetric`| Function | Andrey Khudenkikh | done | | |
|`animation`| Function | Andrey Khudenkikh | done |failed | OHOSUI-2171|
|`combine`| Function | Andrey Khudenkikh | done | failed| OHOSUI-2171|
|`getIDENTITY`| Function | Andrey Khudenkikh | done | | |
|`setIDENTITY`| Function | | |
|`getOPACITY`| Function | Andrey Khudenkikh | done | | |
|`setOPACITY`| Function | | |
|`getSLIDE`| Function | Andrey Khudenkikh | done | | |
|`setSLIDE`| Function | | |
|`getSLIDE_SWITCH`| Function | Andrey Khudenkikh | done | | |
|`setSLIDE_SWITCH`| Function | | |
|*BaseEvent*| *Class* | Politov Mikhail | in progress |  | |
|`ctor`| Function |Politov Mikhail | done |  | |
|`getTarget`| Function | Politov Mikhail | done |  | |
|`setTarget`| Function | Politov Mikhail | done |  | |
|`getTimestamp`| Function | Politov Mikhail | done |  |  |
|`setTimestamp`| Function | Politov Mikhail | done |  |  |
|`getSource`| Function | Tuzhilkin Ivan | done |  | |
|`setSource`| Function | Politov Mikhail | done |  | |
|`getAxisHorizontal`| Function | Politov Mikhail | done |  | |
|`setAxisHorizontal`| Function | Politov Mikhail | done |  | |
|`getAxisVertical`| Function | Politov Mikhail | done |  | |
|`setAxisVertical`| Function | Politov Mikhail | done |  | |
|`getPressure`| Function | Politov Mikhail | done |  | |
|`setPressure`| Function | Politov Mikhail | done |  | |
|`getTiltX`| Function | Politov Mikhail | done |  | |
|`setTiltX`| Function | Politov Mikhail | done |  | |
|`getTiltY`| Function | Politov Mikhail | done |  | |
|`setTiltY`| Function | Politov Mikhail | done |  | |
|`getRollAngle`| Function | Pavelyev Ivan | in progress | | |
|`setRollAngle`| Function | Pavelyev Ivan | in progress | | |
|`getSourceTool`| Function | Tuzhilkin Ivan | done |  | |
|`setSourceTool`| Function | Politov Mikhail | done |  | |
|`getModifierKeyState`| Function | Politov Mikhail | done |  | |
|`setGetModifierKeyState`| Function | | | | |
|`getDeviceId`| Function | Politov Mikhail | done |  | |
|`setDeviceId`| Function | Politov Mikhail | done |  | |
|`getTargetDisplayId`| Function | Maksimov Nikita | done |  | |
|`setTargetDisplayId`| Function | Maksimov Nikita | done |  | |
|*LayoutPolicy*| *Class* | | | | |
|`ctor`| Function | | | | |
|`getMatchParent`| Function | | | | |
|`setMatchParent`| Function | | | | |
|*ClickEvent*| *Class* | Maksimov Nikita | in progress |  | |
|`ctor`| Function |Tuzhilkin Ivan | done |  | |
|`getDisplayX`| Function | Tuzhilkin Ivan | done |  | |
|`setDisplayX`| Function | Maksimov Nikita | done |  | |
|`getDisplayY`| Function | Tuzhilkin Ivan | done |  | |
|`setDisplayY`| Function | Maksimov Nikita | done |  | |
|`getWindowX`| Function | Tuzhilkin Ivan | done |  | |
|`setWindowX`| Function | Maksimov Nikita | done |  | |
|`getWindowY`| Function | Tuzhilkin Ivan | done |  | |
|`setWindowY`| Function | Maksimov Nikita | done |  | |
|`getX`| Function | Tuzhilkin Ivan | done |  | |
|`setX`| Function | Maksimov Nikita | done |  | |
|`getY`| Function | Tuzhilkin Ivan | done |  | |
|`setY`| Function | Maksimov Nikita | done |  | |
|`getHand`| Function | Samarin Sergey | done | | |
|`setHand`| Function | Samarin Sergey | blocked IDL | | request to delete the interface from CAPI: https://gitee.com/nikolay-igotti/idlize/issues/IC5IO9 |
|`getPreventDefault`| Function | Samarin Sergey | done | | |
|`setPreventDefault`| Function | Maksimov Nikita | done |  | |
|*HoverEvent*| *Class* | Tuzhilkin Ivan | done |  | |
|`ctor`| Function | Tuzhilkin Ivan | done | | UT: need cherry-pick to FB |
|`getX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getWindowX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setWindowX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getWindowY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setWindowY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getDisplayX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setDisplayX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getDisplayY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setDisplayY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getStopPropagation`| Function | Samarin Sergey | done | | |
|`setStopPropagation`| Function | Tuzhilkin Ivan | done |  | empty implementation |
|*MouseEvent*| *Class* | Kovalev Sergey | done |  | |
|`ctor`| Function |Kovalev Sergey | done |  | |
|`getButton`| Function | Kovalev Sergey | done |  | |
|`setButton`| Function | Kovalev Sergey | done |  | |
|`getAction`| Function | Kovalev Sergey | done |  | |
|`setAction`| Function | Kovalev Sergey | done |  | |
|`getDisplayX`| Function | Kovalev Sergey | done |  | |
|`setDisplayX`| Function | Kovalev Sergey | done |  | |
|`getDisplayY`| Function | Kovalev Sergey | done |  | |
|`setDisplayY`| Function | Kovalev Sergey | done |  | |
|`getWindowX`| Function | Kovalev Sergey | done |  | |
|`setWindowX`| Function | Kovalev Sergey | done |  | |
|`getWindowY`| Function | Kovalev Sergey | done |  | |
|`setWindowY`| Function | Kovalev Sergey | done |  | |
|`getX`| Function | Kovalev Sergey | done |  | |
|`setX`| Function | Kovalev Sergey | done |  | |
|`getY`| Function | Kovalev Sergey | done |  | |
|`setY`| Function | Kovalev Sergey | done |  | |
|`getStopPropagation`| Function | Samarin Sergey | done | | |
|`setStopPropagation`| Function | Kovalev Sergey | done |  | empty implementation |
|`getRawDeltaX`| Function | Kovalev Sergey| done |  | doesn't present in FB missed in SDK since 15, done for Upstream |
|`setRawDeltaX`| Function | Kovalev Sergey| done |  | doesn't present in FB missed in SDK since 15, done for Upstream |
|`getRawDeltaY`| Function | Kovalev Sergey | done |  | doesn't present in FB missed in SDK since 15, done for Upstream |
|`setRawDeltaY`| Function | Kovalev Sergey | done |  | doesn't present in FB missed in SDK since 15, done for Upstream |
|`getPressedButtons`| Function | Kovalev Sergey | done |  | doesn't present in FB missed in SDK since 15, done for Upstream |
|`setPressedButtons`| Function |Kovalev Sergey| done |  | doesn't present in FB missed in SDK since 15, done for Upstream |
|*AccessibilityHoverEvent*| *Class* | Pavelyev Ivan | done |  | |
|`ctor`| Function |Pavelyev Ivan | done |  | |
|`getType`| Function | Pavelyev Ivan | done |  | |
|`setType`| Function | Pavelyev Ivan | done |  | |
|`getX`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setX`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getY`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setY`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getDisplayX`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setDisplayX`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getDisplayY`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setDisplayY`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getWindowX`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setWindowX`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getWindowY`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setWindowY`| Function | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|*TouchEvent*| *Class* | Tuzhilkin Ivan | done |  | |
|`ctor`| Function |  Tuzhilkin Ivan | done |  | |
|`getHistoricalPoints`| Function | Tuzhilkin Ivan | done |  |  |
|`getType`| Function | Tuzhilkin Ivan | done |  | |
|`setType`| Function | Tuzhilkin Ivan | done |  | empty implementation |
|`getTouches`| Function | Tuzhilkin Ivan | done | | |
|`setTouches`| Function | Tuzhilkin Ivan | done |  | empty implementation |
|`getChangedTouches`| Function | Tuzhilkin Ivan | done | | |
|`setChangedTouches`| Function | Tuzhilkin Ivan | done |  | empty implementation |
|`getStopPropagation`| Function | Samarin Sergey | done | | |
|`setStopPropagation`| Function | Tuzhilkin Ivan | done |  | empty implementation |
|`getPreventDefault`| Function | Samarin Sergey | done | | |
|`setPreventDefault`| Function | Tuzhilkin Ivan | done |  | empty implementation |
|*AxisEvent*| *Class* | Tuzhilkin Ivan | done | | |
|`ctor`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getHorizontalAxisValue`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getVerticalAxisValue`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getAction`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setAction`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getDisplayX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setDisplayX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getDisplayY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setDisplayY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getWindowX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setWindowX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getWindowY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setWindowY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setX`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setY`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getScrollStep`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setScrollStep`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`getPropagation`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
|`setPropagation`| Function | Tuzhilkin Ivan | done | | empty implementation, need cherry-pick to FB |
|*PixelMapMock*| *Class* | Maksimov Nikita | done |  | |
|`ctor`| Function |Maksimov Nikita | done |  | |
|`release`| Function | Maksimov Nikita | done |  | |
|*DragEvent*| *Class* | Evstigneev Roman | in progress |  | |
|`ctor`| Function | Tuzhilkin Ivan | done | | |
|`getDisplayX`| Function | Tuzhilkin Ivan | done | | |
|`getDisplayY`| Function | Tuzhilkin Ivan | done | | |
|`getWindowX`| Function | Evstigneev Roman | done | | |
|`getWindowY`| Function | Evstigneev Roman | done | | |
|`setData`| Function | Evstigneev Roman | done |  | |
|`getData`| Function | Evstigneev Roman | done |  | |
|`getSummary`| Function | Skroba Gleb | done |  | |
|`setResult`| Function | Evstigneev Roman | done | | |
|`getResult`| Function | Evstigneev Roman | done | | |
|`getPreviewRect`| Function | Evstigneev Roman | done | | |
|`getVelocityX`| Function | Tuzhilkin Ivan | done | | |
|`getVelocityY`| Function | Tuzhilkin Ivan | done | | |
|`getVelocity`| Function | Tuzhilkin Ivan | done | | |
|`executeDropAnimation`| Function | | | | can be implemented on 125 generation |
|`getDragBehavior`| Function | Tuzhilkin Ivan | done | | |
|`setDragBehavior`| Function | Tuzhilkin Ivan | done | | |
|`getUseCustomDropAnimation`| Function | Evstigneev Roman | done |  | priority |
|`setUseCustomDropAnimation`| Function | Evstigneev Roman | done |  | priority |
|`getGetModifierKeyState`| Function | Tuzhilkin Ivan | done |  | |
|`setGetModifierKeyState`| Function | | | | |
|*KeyEvent*| *Class* | Maksimov Nikita | done |  |  |
|`ctor`| Function |Maksimov Nikita | done | | |
|`getType`| Function | Maksimov Nikita | done |  | |
|`setType`| Function | Maksimov Nikita | done | | |
|`getKeyCode`| Function | Maksimov Nikita | done | | |
|`setKeyCode`| Function | Maksimov Nikita | done | | |
|`getKeyText`| Function | Maksimov Nikita | done | | |
|`setKeyText`| Function | Maksimov Nikita | done | | |
|`getKeySource`| Function | Maksimov Nikita | done | | |
|`setKeySource`| Function | Maksimov Nikita | done | | |
|`getDeviceId`| Function | Maksimov Nikita | done | | |
|`setDeviceId`| Function | Maksimov Nikita | done | | |
|`getMetaKey`| Function | Maksimov Nikita | done | | |
|`setMetaKey`| Function | Maksimov Nikita | done | | |
|`getTimestamp`| Function | Maksimov Nikita | done | |  |
|`setTimestamp`| Function | Maksimov Nikita | done | |  |
|`getStopPropagation`| Function | Samarin Sergey | done | | |
|`setStopPropagation`| Function | Maksimov Nikita | done | | empty implementation |
|`getIntentionCode`| Function |Maksimov Nikita | done | | |
|`setIntentionCode`| Function | Maksimov Nikita | done | |  KeyEventAccessor::SetIntentionCodeImpl doesn't have sense. |
|`getGetModifierKeyState`| Function | Maksimov Nikita | done | | |
|`setGetModifierKeyState`| Function | | | | |
|`getUnicode`| Function | Maksimov Nikita | done | | |
|`setUnicode`| Function | Maksimov Nikita | done | | |
|*FocusAxisEvent*| *Class* | Evstigneev Roman | done | | feature: API not present |
|`ctor`| Function | Evstigneev Roman | done | | |
|`getAxisMap`| Function | Evstigneev Roman | done | | |
|`setAxisMap`| Function | Evstigneev Roman | done | | empty implementation, feature: API not present |
|`getStopPropagation`| Function | Evstigneev Roman | done | | feature: API not present |
|`setStopPropagation`| Function | Evstigneev Roman | done  |  | empty implementation, feature: API not present |
|*ProgressMask*| *Class* | Maksimov Nikita | done |  | |
|`ctor`| Function |Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`updateProgress`| Function | Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`updateColor`| Function | Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`enableBreathingAnimation`| Function | Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Measurable*| *Class* | Samarin Sergey | in progress | | |
|`ctor`| Function | Samarin Sergey | in progress | | |
|`measure`| Function | Samarin Sergey | in progress | | |
|`getMargin`| Function | Samarin Sergey | in progress | | |
|`getPadding`| Function | Samarin Sergey | in progress | | |
|`getBorderWidth`| Function | Samarin Sergey | in progress | | |
|`getUniqueId`| Function | Samarin Sergey | in progress | | |
|`setUniqueId`| Function | Samarin Sergey | in progress | | |
|*Layoutable*| *Class* | Samarin Sergey | in progress | | |
|`ctor`| Function | Samarin Sergey | in progress | | |
|`measure`| Function | Samarin Sergey | in progress | | |
|`getMargin`| Function | Samarin Sergey | in progress | | |
|`getPadding`| Function | Samarin Sergey | in progress | | |
|`getBorderWidth`| Function | Samarin Sergey | in progress | | |
|`getMeasureResult`| Function | Samarin Sergey | in progress | | |
|`setMeasureResult`| Function | Samarin Sergey | in progress | | |
|`getUniqueId`| Function | Samarin Sergey | in progress | | |
|`setUniqueId`| Function | Samarin Sergey | in progress | | |
|*TextContentControllerBase*| *Class* | Morozov Sergey | done |  | |
|`ctor`| Function | Dudkin Sergey | done |  |  |
|`getCaretOffset`| Function | Dudkin Sergey | done |  |  |
|`getTextContentRect`| Function | Morozov Sergey | done | test blocked |
|`getTextContentLineCount`| Function | Morozov Sergey | done |  | |
|`addText`| Function | Morozov Sergey | done | | done on UB, no api in sdk on FB | |
|`deleteText`| Function | Morozov Sergey | done | | done on UB, no api in sdk on FB | |
|`getSelection`| Function | Morozov Sergey | done | | done on UB, no api in sdk on FB | |
|`clearPreviewText`| Function | | | | not generated on Upstream|
|`getText`| Function | | | | not generated on Upstream|
|*ScrollResult*| *Class* | | | | |
|`ctor`| Function | | | | |
|`getOffsetRemain`| Function | | | | |
|`setOffsetRemain`| Function | | | | |
|*ChildrenMainSize*| *Class* | Morozov Sergey | done |  |
|`ctor`| Function |Morozov Sergey | done |  |  |
|`splice`| Function | Morozov Sergey | done |  |  |
|`update`| Function | Morozov Sergey | done |  |  |
|`getChildDefaultSize`| Function | Morozov Sergey | done | |
|`setChildDefaultSize`| Function | Morozov Sergey| done |  | |
|*UICommonEvent*| *Class* | Andrey Khudenkikh | testskipped | | |
|`ctor`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnClick`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnTouch`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnAppear`| Function | Andrey Khudenkikh | testskipped | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnDisappear`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnKeyEvent`| Function | Andrey Khudenkikh | testskipped | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnFocus`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnBlur`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnHover`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnMouse`| Function |  Andrey Khudenkikh| done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnSizeChange`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setOnVisibleAreaApproximateChange`| Function | Andrey Khudenkikh | testskipped | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|*GestureModifier*| *Class* | Tuzhilkin Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|`ctor`| Function | Tuzhilkin Ivan | blocked IDL |  |  https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`applyGesture`| Function | Tuzhilkin Ivan | blocked IDL |  |  https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|*CustomBuild*| *Class* | | | | |
|`ctor`| Function | | | | |
|`build`| Function | | | | |
|*CustomDialogController*| *Class* | Maksimov Nikita | in progress |  | |
|`ctor`| Function |Maksimov Nikita | in progress |  |  |
|`open`| Function | Maksimov Nikita | testskipped |  |  |
|`close`| Function | Maksimov Nikita | testskipped |  |   |
|*LinearGradient*| *Class* | Morozov Sergey | done | | |
|`ctor`| Function | Morozov Sergey | done | | |
|*DatePickerDialog*| *Class* | Ekaterina Stepanova | testskipped |  | |
|`show`| Function | Ekaterina Stepanova | testskipped |  | UT in progress, Skroba Gleb |
|*BaseGestureEvent*| *Class* | Maksimov Nikita | done |  | |
|`ctor`| Function |Maksimov Nikita | done |  | |
|`getFingerList`| Function | Kovalev Sergey | done | | |
|`setFingerList`| Function | Maksimov Nikita | done |  | implementation and UT Vadim Voronov |
|*TapGestureEvent*| *Class* | Samarin Sergey | done | | nothing to do |
|`ctor`| Function |Samarin Sergey | done | | nothing to do |
|*LongPressGestureEvent*| *Class* | Kovalev Sergey | done | | |
|`ctor`| Function | Kovalev Sergey | done | | |
|`getRepeat`| Function | Kovalev Sergey | done | | |
|`setRepeat`| Function | Kovalev Sergey | done | | |
|*PanGestureEvent*| *Class* | Morozov Sergey | done | | |
|`ctor`| Function | Morozov Sergey | done | | |
|`getOffsetX`| Function | Morozov Sergey | done | | |
|`setOffsetX`| Function | Morozov Sergey | done | | |
|`getOffsetY`| Function | Morozov Sergey | done | | |
|`setOffsetY`| Function | Morozov Sergey | done | | |
|`getVelocityX`| Function | Morozov Sergey | done | | |
|`setVelocityX`| Function | Morozov Sergey | done | | |
|`getVelocityY`| Function | Morozov Sergey | done | | |
|`setVelocityY`| Function | Morozov Sergey | done | | |
|`getVelocity`| Function | Morozov Sergey | done | | |
|`setVelocity`| Function | Morozov Sergey | done | | |
|*PinchGestureEvent*| *Class* | Vadim Voronov | done | | |
|`ctor`| Function |Vadim Voronov | done | | |
|`getScale`| Function | Vadim Voronov | done | | |
|`setScale`| Function | Vadim Voronov | done | | |
|`getPinchCenterX`| Function | Vadim Voronov | done | | |
|`setPinchCenterX`| Function | Vadim Voronov | done | | |
|`getPinchCenterY`| Function | Vadim Voronov | done | | |
|`setPinchCenterY`| Function | Vadim Voronov | done | | |
|*RotationGestureEvent*| *Class* | Andrey Khudenkikh | done | | |
|`ctor`| Function |  Andrey Khudenkikh | done | | |
|`getAngle`| Function | Andrey Khudenkikh | done | | |
|`setAngle`| Function | Andrey Khudenkikh | done | | |
|*SwipeGestureEvent*| *Class* | Evstigneev Roman | done | | |
|`ctor`| Function |Evstigneev Roman | done | | |
|`getAngle`| Function | Evstigneev Roman | done | | |
|`setAngle`| Function | Evstigneev Roman | done | | |
|`getSpeed`| Function | Evstigneev Roman | done | | |
|`setSpeed`| Function | Evstigneev Roman | done | | |
|*GestureEvent*| *Class* | Samarin Sergey | done |  | |
|`ctor`| Function |Samarin Sergey | done |  | |
|`getRepeat`| Function | Samarin Sergey | done | pass | |
|`setRepeat`| Function | Samarin Sergey | done |  | |
|`getFingerList`| Function | Kovalev Sergey | done | failed | crash, need submit |
|`setFingerList`| Function | Samarin Sergey | done | | |
|`getOffsetX`| Function | Samarin Sergey | done | pass | |
|`setOffsetX`| Function | Samarin Sergey | done |  | |
|`getOffsetY`| Function | Samarin Sergey | done | pass | |
|`setOffsetY`| Function | Samarin Sergey | done |  | |
|`getAngle`| Function | Samarin Sergey | done | pass | |
|`setAngle`| Function | Samarin Sergey | done |  | |
|`getSpeed`| Function | Samarin Sergey | done|  | |
|`setSpeed`| Function | Samarin Sergey | done |  | |
|`getScale`| Function | Samarin Sergey | done |  | |
|`setScale`| Function | Samarin Sergey | done |  | |
|`getPinchCenterX`| Function | Samarin Sergey | done |  | |
|`setPinchCenterX`| Function | Samarin Sergey | done |  | |
|`getPinchCenterY`| Function | Samarin Sergey | done |  | |
|`setPinchCenterY`| Function | Samarin Sergey | done |  | |
|`getVelocityX`| Function | Samarin Sergey | done |  | |
|`setVelocityX`| Function | Samarin Sergey | done |  | |
|`getVelocityY`| Function | Samarin Sergey | done |  | |
|`setVelocityY`| Function | Samarin Sergey | done |  | |
|`getVelocity`| Function | Samarin Sergey | done |  | |
|`setVelocity`| Function | Lobah Mikhail | done|  |  |
|*Gesture*| *Class* | | | | |
|`ctor`| Function | | | | |
|`tag`| Function | | | | |
|`allowedTypes`| Function | | | | |
|*PanGestureOptions*| *Class* | Politov Mikhail | done | | wait new generation for feature_branch, to merge CTOR impl |
|`ctor`| Function | Politov Mikhail | done |  | |
|`setDirection`| Function | Politov Mikhail | done |  | |
|`setDistance`| Function | Politov Mikhail | done |  | |
|`setFingers`| Function | Politov Mikhail | done |  | |
|`getDirection`| Function | Dudkin Sergey | done |  |  |
|`getDistance`| Function | Erokhin Ilya | done | | |
|*SwipeGesture*| *Class* | | | | |
|`ctor`| Function | | | | |
|`$_instantiate`| Function | | | | |
|`onAction`| Function | | | | |
|*RotationGesture*| *Class* | | | | |
|`ctor`| Function | | | | |
|`$_instantiate`| Function | | | | |
|`onActionStart`| Function | | | | |
|`onActionUpdate`| Function | | | | |
|`onActionEnd`| Function | | | | |
|`onActionCancel`| Function | | | | |
|*ScrollableTargetInfo*| *Class* | Maksimov Nikita | done |  | |
|`ctor`| Function |Maksimov Nikita | done |  | |
|`isBegin`| Function | Maksimov Nikita | done |  | |
|`isEnd`| Function | Maksimov Nikita | done |  | |
|*EventTargetInfo*| *Class* | Maksimov Nikita | done |  | |
|`ctor`| Function | Maksimov Nikita | done | | |
|`getId`| Function | Maksimov Nikita | done | | |
|*GestureRecognizer*| *Class* | Kovalev Sergey | done |  | |
|`ctor`| Function | Kovalev Sergey | done | | |
|`getTag`| Function | Kovalev Sergey | done | | |
|`getType`| Function | Kovalev Sergey | done |  | |
|`isBuiltIn`| Function | Kovalev Sergey | done |  | |
|`setEnabled`| Function | Kovalev Sergey | done |  | |
|`isEnabled`| Function | Kovalev Sergey | done |  | |
|`getState`| Function | Kovalev Sergey | done |  | |
|`getEventTargetInfo`| Function | Maksimov Nikita | done |  | |
|`isValid`| Function | Kovalev Sergey | done |  | |
|`getFingerCount`| Function | Pavelyev Ivan | done | | |
|`isFingerCountLimit`| Function | Pavelyev Ivan | done | | |
|*TapRecognizer*| *Class* | Lobah Mikhail| done| | |
|`ctor`| Function | Lobah Mikhail| done| | |
|`getTapCount`| Function | Lobah Mikhail| done| | |
|*LongPressRecognizer*| *Class* | Vadim Voronov | in progress | | |
|`ctor`| Function | Vadim Voronov | in progress | | |
|`isRepeat`| Function | Vadim Voronov | in progress | | |
|`getDuration`| Function | Vadim Voronov | in progress | | |
|*SwipeRecognizer*| *Class* | Vadim Voronov | in progress | | |
|`ctor`| Function | Vadim Voronov | in progress | | |
|`getVelocityThreshold`| Function | Vadim Voronov | in progress | | |
|`getDirection`| Function | Vadim Voronov | in progress | | |
|*PinchRecognizer*| *Class* | Vadim Voronov | in progress | | |
|`ctor`| Function | Vadim Voronov | in progress | | |
|`getDistance`| Function | Vadim Voronov | in progress | | |
|*RotationRecognizer*| *Class* | Lobah Mikhail| done| | |
|`ctor`| Function | Lobah Mikhail| done| | |
|`getAngle`| Function | Lobah Mikhail| done| | |
|*PanRecognizer*| *Class* | Politov Mikhail | done |  | done on upstream |
|`ctor`| Function |Politov Mikhail | done |  | done on upstream |
|`getPanGestureOptions`| Function | Politov Mikhail | done |  | done on upstream |
|*ColorContent*| *Class* | | | | |
|`ctor`| Function | | | | |
|`getORIGIN`| Function | | | | |
|`setORIGIN`| Function | | | | |
|*ImageAnalyzerController*| *Class* |Vadim Voronov|  blocked AceEngine |  | |
|`ctor`| Function | Vadim Voronov|  blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IBPTCE |
|`getImageAnalyzerSupportTypes`| Function |Vadim Voronov|  blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IBPTCE |
|*IndicatorComponentController*| *Class* | Skroba Gleb | done |  |  |
|`ctor`| Function | Skroba Gleb | done | failed | "Can't have nullptr ptr ${}" probably no the component code |
|`showNext`| Function | Skroba Gleb | done |  |  |
|`showPrevious`| Function | Skroba Gleb | done |  |  |
|`changeIndex`| Function | Skroba Gleb | done |  |  |
|*LinearIndicatorController*| *Class* | Kovalev Sergey | done |  | depricated |
|`ctor`| Function |Kovalev Sergey | done |  | depricated |
|`setProgress`| Function | Kovalev Sergey | done |  | depricated |
|`start`| Function | Kovalev Sergey | done |  | depricated |
|`pause`| Function | Kovalev Sergey | done |  | depricated |
|`stop`| Function | Kovalev Sergey | done |  | depricated |
|*ListScroller*| *Class* |Morozov Sergey | done| Politov Mikhail |  |
|`ctor`| Function | Morozov Sergey | done | | |
|`getItemRectInGroup`| Function |Morozov Sergey | done | | |
|`scrollToItemInGroup`| Function |Morozov Sergey | done | | |
|`closeAllSwipeActions`| Function |Morozov Sergey | done | | |
|`getVisibleListContentInfo`| Function |Morozov Sergey | done | | |
|*Matrix2D*| *Class* | Vadim Voronov | done |  |  |
|`ctor`| Function |  Vadim Voronov | done |  | |
|`identity`| Function | Vadim Voronov | done |  | |
|`invert`| Function | Vadim Voronov | done |  | |
|`rotate`| Function | Vadim Voronov | done |  |  |
|`translate`| Function | Vadim Voronov | done |  | |
|`scale`| Function | Vadim Voronov | done |  | |
|`getScaleX`| Function | Vadim Voronov | done |  | |
|`setScaleX`| Function | Vadim Voronov | done |  | |
|`getRotateY`| Function | Vadim Voronov | done |  | |
|`setRotateY`| Function | Vadim Voronov | done |  | |
|`getRotateX`| Function | Vadim Voronov | done |  | |
|`setRotateX`| Function | Vadim Voronov | done |  | |
|`getScaleY`| Function | Vadim Voronov | done |  | |
|`setScaleY`| Function | Vadim Voronov | done |  | |
|`getTranslateX`| Function | Vadim Voronov | done |  | |
|`setTranslateX`| Function | Vadim Voronov | done |  | |
|`getTranslateY`| Function | Vadim Voronov | done |  | |
|`setTranslateY`| Function | Vadim Voronov | done |  | |
|*NavDestinationContext*| *Class* | managed side | managed side |  |  |
|`ctor`| Function | managed side | managed side |  |  |
|`getConfigInRouteMap`| Function | managed side | managed side |  |  |
|`getPathInfo`| Function | managed side| managed side| | |
|`setPathInfo`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getPathStack`| Function | managed side| managed side| | |
|`setPathStack`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getNavDestinationId`| Function | managed side | managed side |  | |
|`setNavDestinationId`| Function | Morozov Sergey | done |  |  |
|*NavPathInfo*| *Class* |  managed side | managed side | | done in C-API as workarond, the managed side support is planned  |
|`ctor`| Function | Skroba Gleb | done | |  |
|`getName`| Function | Skroba Gleb | done | |  |
|`setName`| Function | Skroba Gleb | done | |  |
|`getParam`| Function | managed side | managed side | |  |
|`setParam`| Function | Skroba Gleb | done | |  |
|`getOnPop`| Function | Skroba Gleb | done | |  |
|`setOnPop`| Function | Skroba Gleb | done | |  |
|`getIsEntry`| Function | Skroba Gleb | done | |  |
|`setIsEntry`| Function | Skroba Gleb | done | |  |
|`getNavDestinationId`| Function |managed side | managed side | |  |
|`setNavDestinationId`| Function |managed side | managed side | |  |
|*NavPathStack*| *Class* | managed side | managed side |  |   |
|`ctor`| Function | Skroba Gleb | done |  |   |
|`pushPath0`| Function | Skroba Gleb | done |  |   |
|`pushPath1`| Function | Skroba Gleb | done |  |   |
|`pushDestination0`| Function | managed side | managed side |  |   |
|`pushDestination1`| Function | managed side | managed side |  |   |
|`pushPathByName0`| Function | managed side | managed side|  | |
|`pushPathByName1`| Function | managed side | managed side|  |  |
|`pushDestinationByName0`| Function | managed side | managed side |  |  | 
|`pushDestinationByName1`| Function | managed side | managed side |  |  | 
|`replacePath0`| Function | managed side | managed side |  |  |
|`replacePath1`| Function | managed side | managed side |  |  |
|`replaceDestination`| Function | managed side | managed side |  | |
|`replacePathByName`| Function | managed side | managed side |  |  |
|`removeByIndexes`| Function | managed side | managed side |  |  |
|`removeByName`| Function | managed side | managed side |  |  |
|`removeByNavDestinationId`| Function | managed side | managed side |  |  |
|`pop0`| Function | managed side | managed side |  | |  
|`pop1`| Function | managed side | managed side |  | |  
|`popToName0`| Function | managed side | managed side |  |  |
|`popToName1`| Function | managed side | managed side |  |  |
|`popToIndex0`| Function | managed side | managed side |  |  |
|`popToIndex1`| Function | managed side | managed side |  |  |
|`moveToTop`| Function | managed side | managed side |  |  |
|`moveIndexToTop`| Function | managed side | managed side |  |  |
|`clear`| Function | managed side | managed side |  |  |
|`getAllPathName`| Function | managed side | managed side |  |  | 
|`getParamByIndex`| Function | managed side | managed side |  |  | 
|`getParamByName`| Function | managed side | managed side |  |  |
|`getIndexByName`| Function | managed side | managed side |  |  |
|`getParent`| Function | managed side | managed side |  |  |
|`size`| Function | Skroba Gleb | done |  |  |
|`disableAnimation`| Function | managed side | managed side |  |  |
|`setInterception`| Function | managed side | managed side |  |  |
|`getPathStack`| Function | managed side | managed side | | |
|`setPathStack`| Function | managed side | managed side | | |
|*NavigationTransitionProxy*| *Class* | managed side | managed side |  |  |
|`ctor`| Function |Morozov Sergey | done |  |  |
|`finishTransition`| Function | Morozov Sergey | done |  |  |
|`getFrom`| Function | managed side | managed side | | |
|`setFrom`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getTo`| Function | managed side | managed side | | |
|`setTo`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getIsInteractive`| Function | Morozov Sergey | done |  |  |
|`setIsInteractive`| Function | Morozov Sergey | done |  |  |
|`getCancelTransition`| Function | Morozov Sergey | done |  |  |
|`setCancelTransition`| Function | Morozov Sergey |  |  |  |
|`getUpdateTransition`| Function | Morozov Sergey | done |  |  |
|`setUpdateTransition`| Function | Morozov Sergey |  |  |  |
|*Context*| *Class* | | | | |
|`ctor`| Function | | | | |
|`createBundleContext`| Function | | | | |
|`createModuleContext0`| Function | | | | |
|`createModuleContext1`| Function | | | | |
|`getGroupDir0`| Function | | | | |
|`getGroupDir1`| Function | | | | |
|`getCacheDir`| Function | | | | |
|`setCacheDir`| Function | | | | |
|`getTempDir`| Function | | | | |
|`setTempDir`| Function | | | | |
|`getFilesDir`| Function | | | | |
|`setFilesDir`| Function | | | | |
|`getDatabaseDir`| Function | | | | |
|`setDatabaseDir`| Function | | | | |
|`getPreferencesDir`| Function | | | | |
|`setPreferencesDir`| Function | | | | |
|`getBundleCodeDir`| Function | | | | |
|`setBundleCodeDir`| Function | | | | |
|`getDistributedFilesDir`| Function | | | | |
|`setDistributedFilesDir`| Function | | | | |
|`getResourceDir`| Function | | | | |
|`setResourceDir`| Function | | | | |
|`getCloudFileDir`| Function | | | | |
|`setCloudFileDir`| Function | | | | |
|*DrawableDescriptor*| *Class* | Evstigneev Roman | done | | need cherry-pick to FB |
|`ctor`| Function | Evstigneev Roman | done | | need cherry-pick to FB |
|`getPixelMap`| Function | Evstigneev Roman | done | | need cherry-pick to FB |
|*CircleShape*| *Class* |Dudkin Sergey |done | out of scope | |
|`ctor`| Function |Dudkin Sergey | done | out of scope| |
|`offset`| Function |Dudkin Sergey | done | out of scope | |
|`fill`| Function | Dudkin Sergey | done | out of scope | |
|`position`| Function |Dudkin Sergey | done | out of scope | |
|`width`| Function |Dudkin Sergey | done | out of scope | |
|`height`| Function |Dudkin Sergey | done | out of scope | |
|`size`| Function |Dudkin Sergey | done | out of scope | |
|*EllipseShape*| *Class* | Erokhin Ilya | done | | |
|`ctor`| Function | Erokhin Ilya | done | | |
|`offset`| Function | Erokhin Ilya | done | | |
|`fill`| Function | Erokhin Ilya | done | | |
|`position`| Function | Erokhin Ilya | done | | |
|`width`| Function | Erokhin Ilya | done | | |
|`height`| Function | Erokhin Ilya | done | | |
|`size`| Function | Erokhin Ilya | done | | |
|*PathShape*| *Class* | Lobah Mikhail | done| | |
|`ctor`| Function |Lobah Mikhail | done| | |
|`offset`| Function | Lobah Mikhail| done| | |
|`fill`| Function | Lobah Mikhail | done| | |
|`position`| Function | Lobah Mikhail| done| | |
|`commands`| Function | Lobah Mikhail| done| | |
|*RectShape*| *Class* | Samarin Sergey | done | | |
|`ctor`| Function | Samarin Sergey | done | | |
|`offset`| Function | Samarin Sergey | done | | |
|`fill`| Function | Samarin Sergey | done | | |
|`position`| Function | Samarin Sergey | done | | |
|`width`| Function | Samarin Sergey | done | | |
|`height`| Function | Samarin Sergey | done | | |
|`size`| Function | Samarin Sergey | done | | |
|`radiusWidth`| Function | Samarin Sergey | done | | |
|`radiusHeight`| Function | Samarin Sergey | done | | |
|`radius`| Function | Samarin Sergey | done | | |
|*ThemeControl*| *Class* | | | | |
|`ctor`| Function | | | | |
|`setDefaultTheme`| Function | | | | |
|*UIContext*| *Class* | | | | |
|`ctor`| Function | | | | |
|`getFont`| Function | | | | |
|`getFilteredInspectorTree`| Function | | | | |
|`getFilteredInspectorTreeById`| Function | | | | |
|`animateTo`| Function | | | | |
|`showTextPickerDialog`| Function | | | | |
|`runScopedTask`| Function | | | | |
|`animateToImmediately`| Function | | | | |
|`getFrameNodeById`| Function | | | | |
|`getAttachedFrameNodeById`| Function | | | | |
|`getFrameNodeByUniqueId`| Function | | | | |
|`vp2px`| Function | | | | |
|`px2vp`| Function | | | | |
|`fp2px`| Function | | | | |
|`px2fp`| Function | | | | |
|`lpx2px`| Function | | | | |
|`px2lpx`| Function | | | | |
|`getHostContext`| Function | | | | |
|`setDynamicDimming`| Function | | | | |
|`getWindowName`| Function | | | | |
|`openBindSheet`| Function | | | | |
|`updateBindSheet`| Function | | | | |
|`closeBindSheet`| Function | | | | |
|`clearResourceCache`| Function | | | | |
|`isFollowingSystemFontScale`| Function | | | | |
|`getMaxFontScale`| Function | | | | |
|*UnifiedData*| *Class* | Tuzhilkin Ivan | blocked IDL |  | |
|`ctor`| Function | Tuzhilkin Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY|
|`hasType`| Function | Tuzhilkin Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|`getTypes`| Function | Tuzhilkin Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|*RoundRect*| *Class* | | |
|`ctor`| Function | | |
|`setCorner`| Function | | |
|`getCorner`| Function | | |
|`offset`| Function | | |
|*Path*| *Class* | | |
|`ctor`| Function | | |
|`moveTo`| Function | | |
|`lineTo`| Function | | |
|`arcTo`| Function | | |
|`quadTo`| Function | | |
|`conicTo`| Function | | |
|`cubicTo`| Function | | |
|`rMoveTo`| Function | | |
|`rLineTo`| Function | | |
|`rQuadTo`| Function | | |
|`rConicTo`| Function | | |
|`rCubicTo`| Function | | |
|`addPolygon`| Function | | |
|`op`| Function | | |
|`addArc`| Function | | |
|`addCircle`| Function | | |
|`addOval`| Function | | |
|`addRect`| Function | | |
|`addRoundRect`| Function | | |
|`addPath`| Function | | |
|`transform`| Function | | |
|`contains`| Function | | |
|`setFillType`| Function | | |
|`getBounds`| Function | | |
|`close`| Function | | |
|`offset`| Function | | |
|`reset`| Function | | |
|`getLength`| Function | | |
|`getPositionAndTangent`| Function | | |
|`isClosed`| Function | | |
|`getMatrix`| Function | | |
|`buildFromSvgString`| Function | | |
|*SamplingOptions*| *Class* | | |
|`ctor`| Function | | |
|*Canvas*| *Component* |Vadim Voronov | blocked AceEngine |  |
|`ctor`| Function | | |
|`drawRect0`| Function | | |
|`drawRect1`| Function | | |
|`drawRoundRect`| Function | | |
|`drawNestedRoundRect`| Function | | |
|`drawBackground`| Function | | |
|`drawShadow0`| Function | | |
|`drawShadow1`| Function | | |
|`drawCircle`| Function | | |
|`drawImage`| Function | | |
|`drawImageRect`| Function | | |
|`drawImageRectWithSrc`| Function | | |
|`drawColor0`| Function | | |
|`drawColor1`| Function | | |
|`drawColor2`| Function | | |
|`drawOval`| Function | | |
|`drawArc`| Function | | |
|`drawPoint`| Function | | |
|`drawPoints`| Function | | |
|`drawPath`| Function | | |
|`drawLine`| Function | | |
|`drawSingleCharacter`| Function | | |
|`drawTextBlob`| Function | | |
|`drawPixelMapMesh`| Function | | |
|`drawRegion`| Function | | |
|`attachPen`| Function | | |
|`attachBrush`| Function | | |
|`detachPen`| Function | | |
|`detachBrush`| Function | | |
|`save`| Function | | |
|`saveLayer`| Function | | |
|`clear0`| Function | | |
|`clear1`| Function | | |
|`restore`| Function | | |
|`restoreToCount`| Function | | |
|`getSaveCount`| Function | | |
|`getWidth`| Function | | |
|`getHeight`| Function | | |
|`getLocalClipBounds`| Function | | |
|`getTotalMatrix`| Function | | |
|`scale`| Function | | |
|`skew`| Function | | |
|`rotate`| Function | | |
|`translate`| Function | | |
|`clipPath`| Function | | |
|`clipRect`| Function | | |
|`concatMatrix`| Function | | |
|`clipRegion`| Function | | |
|`clipRoundRect`| Function | | |
|`isClipEmpty`| Function | | |
|`setMatrix`| Function | | |
|`resetMatrix`| Function | | |
|*TextBlob*| *Class* | | |
|`ctor`| Function | | |
|`makeFromString`| Function | | |
|`makeFromPosText`| Function | | |
|`makeFromRunBuffer`| Function | | |
|`bounds`| Function | | |
|`uniqueID`| Function | | |
|*Typeface*| *Class* | | |
|`ctor`| Function | | |
|`getFamilyName`| Function | | |
|`makeFromFile`| Function | | |
|*Font*| *Class* | | |
|`ctor`| Function | | |
|`enableSubpixel`| Function | | |
|`enableEmbolden`| Function | | |
|`enableLinearMetrics`| Function | | |
|`setSize`| Function | | |
|`getSize`| Function | | |
|`setTypeface`| Function | | |
|`getTypeface`| Function | | |
|`getMetrics`| Function | | |
|`measureSingleCharacter`| Function | | |
|`measureText`| Function | | |
|`setScaleX`| Function | | |
|`setSkewX`| Function | | |
|`setEdging`| Function | | |
|`setHinting`| Function | | |
|`countText`| Function | | |
|`setBaselineSnap`| Function | | |
|`isBaselineSnap`| Function | | |
|`setEmbeddedBitmaps`| Function | | |
|`isEmbeddedBitmaps`| Function | | |
|`setForceAutoHinting`| Function | | |
|`isForceAutoHinting`| Function | | |
|`getWidths`| Function | | |
|`textToGlyphs`| Function | | |
|`isSubpixel`| Function | | |
|`isLinearMetrics`| Function | | |
|`getSkewX`| Function | | |
|`isEmbolden`| Function | | |
|`getScaleX`| Function | | |
|`getHinting`| Function | | |
|`getEdging`| Function | | |
|`createPathForGlyph`| Function | | |
|`getBounds`| Function | | |
|`getTextPath`| Function | | |
|*Lattice*| *Class* |Evstigneev Roman | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|`ctor`| Function |Evstigneev Roman | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|`createImageLattice`| Function |Evstigneev Roman | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|*MaskFilter*| *Class* | | |
|`ctor`| Function | | |
|`createBlurMaskFilter`| Function | | |
|*PathEffect*| *Class* | | |
|`ctor`| Function | | |
|`createDashPathEffect`| Function | | |
|`createCornerPathEffect`| Function | | |
|*ShaderEffect*| *Class* | | |
|`ctor`| Function | | |
|`createColorShader`| Function | | |
|`createLinearGradient`| Function | | |
|`createRadialGradient`| Function | | |
|`createSweepGradient`| Function | | |
|`createConicalGradient`| Function | | |
|*ShadowLayer*| *Class* | | |
|`ctor`| Function | | |
|`create0`| Function | | |
|`create1`| Function | | |
|*ColorFilter*| *Class* | Evstigneev Roman | done |
|`ctor`| Function | Evstigneev Roman | in progress |
|`createBlendModeColorFilter0`| Function | Evstigneev Roman | in progress |
|`createBlendModeColorFilter1`| Function | Evstigneev Roman | in progress |
|`createComposeColorFilter`| Function | Evstigneev Roman | in progress |
|`createLinearToSRGBGamma`| Function | Evstigneev Roman | in progress |
|`createSRGBGammaToLinear`| Function | Evstigneev Roman | in progress |
|`createLumaColorFilter`| Function | Evstigneev Roman | in progress |
|`createMatrixColorFilter`| Function | Evstigneev Roman | in progress |
|*ImageFilter*| *Class* | | |
|`ctor`| Function | | |
|`createBlurImageFilter`| Function | | |
|`createFromColorFilter`| Function | | |
|*Pen*| *Class* | | |
|`ctor`| Function | | |
|`setMiterLimit`| Function | | |
|`getMiterLimit`| Function | | |
|`setShaderEffect`| Function | | |
|`setColor0`| Function | | |
|`setColor1`| Function | | |
|`setColor2`| Function | | |
|`getColor`| Function | | |
|`getHexColor`| Function | | |
|`setStrokeWidth`| Function | | |
|`getWidth`| Function | | |
|`setAntiAlias`| Function | | |
|`isAntiAlias`| Function | | |
|`setAlpha`| Function | | |
|`getAlpha`| Function | | |
|`setColorFilter`| Function | | |
|`getColorFilter`| Function | | |
|`setImageFilter`| Function | | |
|`setMaskFilter`| Function | | |
|`setPathEffect`| Function | | |
|`setShadowLayer`| Function | | |
|`setBlendMode`| Function | | |
|`setDither`| Function | | |
|`setJoinStyle`| Function | | |
|`getJoinStyle`| Function | | |
|`setCapStyle`| Function | | |
|`getCapStyle`| Function | | |
|`reset`| Function | | |
|`getFillPath`| Function | | |
|*Brush*| *Class* | | |
|`ctor`| Function | | |
|`setColor0`| Function | | |
|`setColor1`| Function | | |
|`setColor2`| Function | | |
|`getColor`| Function | | |
|`getHexColor`| Function | | |
|`setAntiAlias`| Function | | |
|`isAntiAlias`| Function | | |
|`setAlpha`| Function | | |
|`getAlpha`| Function | | |
|`setColorFilter`| Function | | |
|`getColorFilter`| Function | | |
|`setImageFilter`| Function | | |
|`setMaskFilter`| Function | | |
|`setShadowLayer`| Function | | |
|`setShaderEffect`| Function | | |
|`setBlendMode`| Function | | |
|`reset`| Function | | |
|*Matrix*| *Class* | | |
|`ctor`| Function | | |
|`setRotation`| Function | | |
|`setScale`| Function | | |
|`setTranslation`| Function | | |
|`setMatrix`| Function | | |
|`preConcat`| Function | | |
|`isEqual`| Function | | |
|`invert`| Function | | |
|`isIdentity`| Function | | |
|`getValue`| Function | | |
|`postRotate`| Function | | |
|`postScale`| Function | | |
|`postTranslate`| Function | | |
|`preRotate`| Function | | |
|`preScale`| Function | | |
|`preTranslate`| Function | | |
|`reset`| Function | | |
|`mapPoints`| Function | | |
|`getAll`| Function | | |
|`mapRect`| Function | | |
|`setRectToRect`| Function | | |
|`setPolyToPoly`| Function | | |
|*Region*| *Class* | | |
|`ctor`| Function | | |
|`isPointContained`| Function | | |
|`isRegionContained`| Function | | |
|`op`| Function | | |
|`quickReject`| Function | | |
|`setPath`| Function | | |
|`setRect`| Function | | |
|*FontCollection*| *Class* | | |
|`ctor`| Function | | |
|`getGlobalInstance`| Function | | |
|`loadFontSync`| Function | | |
|`loadFont`| Function | | |
|`clearCaches`| Function | | |
|*Paragraph*| *Class* | | |
|`ctor`| Function | | |
|`layoutSync`| Function | | |
|`layout`| Function | | |
|`paint`| Function | | |
|`paintOnPath`| Function | | |
|`getMaxWidth`| Function | | |
|`getHeight`| Function | | |
|`getLongestLine`| Function | | |
|`getLongestLineWithIndent`| Function | | |
|`getMinIntrinsicWidth`| Function | | |
|`getMaxIntrinsicWidth`| Function | | |
|`getAlphabeticBaseline`| Function | | |
|`getIdeographicBaseline`| Function | | |
|`getRectsForRange`| Function | | |
|`getRectsForPlaceholders`| Function | | |
|`getGlyphPositionAtCoordinate`| Function | | |
|`getWordBoundary`| Function | | |
|`getLineCount`| Function | | |
|`getLineHeight`| Function | | |
|`getLineWidth`| Function | | |
|`didExceedMaxLines`| Function | | |
|`getTextLines`| Function | | |
|`getActualTextRange`| Function | | |
|`getLineMetrics0`| Function | | |
|`getLineMetrics1`| Function | | |
|*LineTypeset*| *Class* | | |
|`ctor`| Function | | |
|`getLineBreak`| Function | | |
|`createLine`| Function | | |
|*ParagraphBuilder*| *Class* | | |
|`ctor`| Function | | |
|`pushStyle`| Function | | |
|`popStyle`| Function | | |
|`addText`| Function | | |
|`addPlaceholder`| Function | | |
|`build`| Function | | |
|`buildLineTypeset`| Function | | |
|`addSymbol`| Function | | |
|*TextLine*| *Class* | | |
|`ctor`| Function | | |
|`getGlyphCount`| Function | | |
|`getTextRange`| Function | | |
|`getGlyphRuns`| Function | | |
|`paint`| Function | | |
|`createTruncatedLine`| Function | | |
|`getTypographicBounds`| Function | | |
|`getImageBounds`| Function | | |
|`getTrailingSpaceWidth`| Function | | |
|`getStringIndexForPosition`| Function | | |
|`getOffsetForStringIndex`| Function | | |
|`enumerateCaretOffsets`| Function | | |
|`getAlignmentOffset`| Function | | |
|*Run*| *Class* | | |
|`ctor`| Function | | |
|`getGlyphCount`| Function | | |
|`getGlyphs0`| Function | | |
|`getGlyphs1`| Function | | |
|`getPositions0`| Function | | |
|`getPositions1`| Function | | |
|`getOffsets`| Function | | |
|`getFont`| Function | | |
|`paint`| Function | | |
|`getStringIndices`| Function | | |
|`getStringRange`| Function | | |
|`getTypographicBounds`| Function | | |
|`getImageBounds`| Function | | |
|*VisualEffect*| *Class* |  |  |
|`ctor`| Function | | |
|`backgroundColorBlender`| Function |  | napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3 |
|*Matrix4Transit*| *Class* | Samarin Sergey | testskipped | | |
|`ctor`| Function |Samarin Sergey | done | |
|`copy`| Function | Samarin Sergey | done | | |
|`invert`| Function | Samarin Sergey | done | | |
|`combine`| Function | Samarin Sergey | done | | |
|`translate`| Function | Samarin Sergey | done | failed | to submit internal issue |
|`scale`| Function | Samarin Sergey | done | failed | to submit internal issue |
|`skew`| Function | Samarin Sergey | done | | |
|`rotate`| Function | Samarin Sergey | done | failed | to submit internal issue |
|`transformPoint`| Function | Samarin Sergey | done | | |
|`setPolyToPoly`| Function | Samarin Sergey | testskipped | | |
|*PixelMap*| *Class* | Andrey Khudenkikh | blocked  | |
|`ctor`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`readPixelsToBufferSync`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`writeBufferToPixels`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`getIsEditable`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`getIsStrideAlignment`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|*PatternLockController*| *Class* |Dmitry A Smirnov| done |  |  |
|`ctor`| Function |Dmitry A Smirnov| done |  |  |
|`reset`| Function |Dmitry A Smirnov| done |  |  |
|`setChallengeResult`| Function |Dmitry A Smirnov| done |  |  |
|*RichEditorBaseController*| *Class*|Dudkin Sergey| blocked IDL|  | |
|`ctor`| Function|Dudkin Sergey| done |  | |
|`getCaretOffset`| Function|Dudkin Sergey| done |  | |
|`setCaretOffset`| Function|Dudkin Sergey| done |  | |
|`closeSelectionMenu`| Function|Dudkin Sergey| done |  | |
|`getTypingStyle`| Function|Dmitry A Smirnov| done |  |  |
|`setTypingStyle`| Function|Dudkin Sergey| done |  | |
|`setSelection`| Function|Dudkin Sergey| done |  | |
|`isEditing`| Function|Dudkin Sergey| done |  | |
|`stopEditing`| Function|Dudkin Sergey| done |  | |
|`getLayoutManager`| Function|Dudkin Sergey| done |  | |
|`getCaretRect`| Function | Erokhin Ilya | done | | |
|`getPreviewText`| Function|Dmitry A Smirnov| done |  |  |
|`setPreviewText`| Function|Dmitry A Smirnov|  |  |  |
|*RichEditorController*| *Class* |Dudkin Sergey| blocked IDL|  |  |
|`ctor`| Function |Dudkin Sergey| done |  |  |
|`addTextSpan`| Function |Dudkin Sergey | testskipped |  | tests are partially ready, but not all fields inside arguments' structs are tested yet |
|`addImageSpan`| Function |Dudkin Sergey | done |  |  |
|`addBuilderSpan`| Function | Lobah Mikhail | done |  | UT done Lobah Mikhail |
|`addSymbolSpan`| Function | Dudkin Sergey| done |  |  |
|`updateSpanStyle`| Function | Dudkin Sergey| done |  |  |
|`updateParagraphStyle`| Function | Dudkin Sergey| done |  |  |
|`deleteSpans`| Function |Dudkin Sergey| done |  |  |
|`getSpans`| Function |Dudkin Sergey| done |  |  |
|`getParagraphs`| Function |Dmitry A Smirnov| done |  | |
|`getSelection`| Function |Dudkin Sergey| done |  |  |
|`fromStyledString`| Function | Dudkin Sergey| done |  |  |
|`toStyledString`| Function | Dudkin Sergey| done |  |  |
|*RichEditorStyledStringController*| *Class* |Dudkin Sergey| blocked IDL |  | |
|`ctor`| Function |Dudkin Sergey| done |  | |
|`setStyledString`| Function |Dudkin Sergey| done |  | |
|`getStyledString`| Function | Maksimov Nikita | done |  | |
|`getSelection`| Function |Dudkin Sergey| done |  | |
|`onContentChanged`| Function | Dudkin Sergey| blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IB944G + |
|*Scroller*| *Class* | Erokhin Ilya | done |  |  |
|`ctor`| Function | Erokhin Ilya | done |  |  |
|`scrollTo`| Function | Erokhin Ilya | done |  |  |
|`scrollEdge`| Function | Erokhin Ilya | done |  |  |
|`fling`| Function | Erokhin Ilya | done |  |  |
|`scrollPage`| Function | Erokhin Ilya | done |  |  |
|`currentOffset`| Function | Skroba Gleb | done | | |
|`scrollToIndex`| Function | Erokhin Ilya | done |  | |
|`scrollBy`| Function | Erokhin Ilya | done |  |  |
|`isAtEnd`| Function | Erokhin Ilya | done |  |  |
|`getItemRect`| Function | Skroba Gleb | done | | |
|`getItemIndex`| Function | Erokhin Ilya | done |  |  |
|*SearchController*| *Class* |Evstigneev Roman | done |  |  |
|`ctor`| Function |Evstigneev Roman | done |  |  |
|`caretPosition`| Function |Evstigneev Roman | done |  |  |
|`stopEditing`| Function |Evstigneev Roman | done |  |  |
|`setTextSelection`| Function |Evstigneev Roman | done |  |  |
|*StyledString*| *Class* | Pavelyev Ivan | blocked IDL |  |  |
|`ctor`| Function | Pavelyev Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`getString`| Function | Pavelyev Ivan | done |  | |
|`getStyles`| Function | Politov Mikhail | done |  | |
|`equals`| Function | Pavelyev Ivan | done |  | |
|`subStyledString`| Function | Pavelyev Ivan | done |  | |
|`fromHtml`| Function | Pavelyev Ivan | done |  | |
|`toHtml`| Function | Pavelyev Ivan | done |  |  |
|`marshalling0`| Function | Politov Mikhail | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`marshalling1`| Function | Politov Mikhail | done | | |
|`unmarshalling0`| Function | Pavelyev Ivan | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`unmarshalling1`| Function | Pavelyev Ivan | done | | |
|`getLength`| Function | Pavelyev Ivan | done |  | |
|`setLength`| Function | Pavelyev Ivan | done |  | |
|*TextStyle*| *Class* | | |
|`ctor`| Function | | |
|`getFontColor`| Function | | |
|`setFontColor`| Function | | |
|`getFontFamily`| Function | | |
|`setFontFamily`| Function | | |
|`getFontSize`| Function | | |
|`setFontSize`| Function | | |
|`getFontWeight`| Function | | |
|`setFontWeight`| Function | | |
|`getFontStyle`| Function | | |
|`setFontStyle`| Function | | |
|*DecorationStyle*| *Class* | Tuzhilkin Ivan | in progress |  | |
|`ctor`| Function |Tuzhilkin Ivan | done |  | |
|`getType`| Function | Tuzhilkin Ivan | done |  | |
|`setType`| Function | | |
|`getColor`| Function | Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`setColor`| Function | | |
|`getStyle`| Function | Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`setStyle`| Function | | |
|*BaselineOffsetStyle*| *Class* | Tuzhilkin Ivan | done |  | |
|`ctor`| Function |  Tuzhilkin Ivan | done |  | |
|`getBaselineOffset`| Function | Tuzhilkin Ivan | done |  | |
|`setBaselineOffset`| Function | | |
|*LetterSpacingStyle*| *Class* | Tuzhilkin Ivan | done |  | |
|`ctor`| Function |Tuzhilkin Ivan | done |  | |
|`getLetterSpacing`| Function | Tuzhilkin Ivan | done |  | |
|`setLetterSpacing`| Function | | |
|*TextShadowStyle*| *Class* |  Politov Mikhail | done |  | |
|`ctor`| Function |Politov Mikhail | done |  | |
|`getTextShadow`| Function |  Politov Mikhail | done | | |
|`setTextShadow`| Function | | |
|*BackgroundColorStyle*| *Class* | Politov Mikhail | done |  | |
|`ctor`| Function |Politov Mikhail | done |  | |
|`getTextBackgroundStyle`| Function | Tuzhilkin Ivan | done | | |
|`setTextBackgroundStyle`| Function | | |
|*GestureStyle*| *Class* | Dudkin Sergey| done | | |
|`ctor`| Function |Dudkin Sergey| done | | |
|*ParagraphStyle*| *Class* |Dudkin Sergey | done |  | |
|`ctor`| Function |Dudkin Sergey | done |  | |
|`getTextAlign`| Function |Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`setTextAlign`| Function | | |
|`getTextIndent`| Function |Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`setTextIndent`| Function | | |
|`getMaxLines`| Function |Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`setMaxLines`| Function | | |
|`getOverflow`| Function |Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`setOverflow`| Function | | |
|`getWordBreak`| Function |Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation|
|`setWordBreak`| Function | | |
|`getLeadingMargin`| Function | Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`setLeadingMargin`| Function | | |
|`getParagraphSpacing`| Function | | | | no such API in generation 125 |
|`setParagraphSpacing`| Function | | |
|*LineHeightStyle*| *Class* |Dudkin Sergey |done|  | |
|`ctor`| Function |Dudkin Sergey |done|  | |
|`getLineHeight`| Function |Dudkin Sergey | done |  | |
|`setLineHeight`| Function | | |
|*UrlStyle*| *Class* | Politov Mikhail | done |  | |
|`ctor`| Function | Politov Mikhail | done |  | |
|`getUrl`| Function | Politov Mikhail | done |  | |
|`setUrl`| Function | | |
|*MutableStyledString*| *Class* | Maksimov Nikita | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBBYJE + |
|`ctor`| Function |Maksimov Nikita | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBBYJE + |
|`replaceString`| Function | Maksimov Nikita | done |  | |
|`insertString`| Function | Maksimov Nikita | done |  | |
|`removeString`| Function | Maksimov Nikita | done |  | |
|`replaceStyle`| Function | Maksimov Nikita | done |  | |
|`setStyle`| Function | Maksimov Nikita | done |  | |
|`removeStyle`| Function | Maksimov Nikita | done |  | |
|`removeStyles`| Function | Maksimov Nikita | done |  | |
|`clearStyles`| Function | Maksimov Nikita | done |  | |
|`replaceStyledString`| Function | Maksimov Nikita | done |  | |
|`insertStyledString`| Function | Maksimov Nikita | done |  | |
|`appendStyledString`| Function | Maksimov Nikita | done |  | |
|*ImageAttachment*| *Class* | Evstigneev Roman | in progress | | |
|`ctor`| Function |Evstigneev Roman | done | | |
|`getValue`| Function | Evstigneev Roman | done | | |
|`setValue`| Function | | |
|`getSize`| Function | Evstigneev Roman | done | | |
|`setSize`| Function | | |
|`getVerticalAlign`| Function | Evstigneev Roman | done | | |
|`setVerticalAlign`| Function | | |
|`getObjectFit`| Function | Evstigneev Roman | done | | |
|`setObjectFit`| Function | | |
|`getLayoutStyle`| Function | Evstigneev Roman | done | | |
|`setLayoutStyle`| Function | | |
|`getColorFilter`| Function | Evstigneev Roman | in progress | | ColorFilter done, feature: API not present |
|`setColorFilter`| Function | | |
|*CustomSpan*| *Class* | Politov Mikhail | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`ctor`| Function |Politov Mikhail | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`invalidate`| Function | Politov Mikhail | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`getOnMeasure`| Function | | |
|`setOnMeasure`| Function | | |
|`getOnDraw`| Function | | |
|`setOnDraw`| Function | | |
|*UserDataSpan*| *Class* | | |
|`ctor`| Function | | |
|*SwiperController*| *Class* | Skroba Gleb | done |  |  |
|`ctor`| Function | Skroba Gleb | done |  |  |
|`showNext`| Function | Skroba Gleb | done | failed |  |
|`showPrevious`| Function | Skroba Gleb | done | failed |  |
|`changeIndex`| Function | Skroba Gleb | done |  |  |
|`finishAnimation`| Function | Skroba Gleb | done |  |  |
|`preloadItems`| Function | Skroba Gleb| done | | |
|*SwiperContentTransitionProxy*| *Class* | Skroba Gleb | done | | |
|`ctor`| Function |Skroba Gleb | done | | |
|`finishTransition`| Function | Skroba Gleb | done | | |
|`getSelectedIndex`| Function | Skroba Gleb | done | | |
|`setSelectedIndex`| Function | Skroba Gleb | done | | |
|`getIndex`| Function | Skroba Gleb | done | | |
|`setIndex`| Function | Skroba Gleb | done | | |
|`getPosition`| Function | Skroba Gleb | done | | |
|`setPosition`| Function | Skroba Gleb | done | | |
|`getMainAxisLength`| Function | Skroba Gleb | done | | |
|`setMainAxisLength`| Function | Skroba Gleb | done | | |
|*SymbolEffect*| *Class* | wangtao | done | | |
|`ctor`| Function |wangtao | done | | empty implementation |
|*ScaleSymbolEffect*| *Class* | Andrey Khudenkikh | done | | |
|`ctor`| Function |Andrey Khudenkikh | done | | |
|`getScope`| Function | Andrey Khudenkikh | done | | |
|`setScope`| Function | Andrey Khudenkikh | done | | |
|`getDirection`| Function | Andrey Khudenkikh | done | | |
|`setDirection`| Function | Andrey Khudenkikh | done | | |
|*HierarchicalSymbolEffect*| *Class* | wangtao  | done | | |
|`ctor`| Function | wangtao  | done | | |
|`getFillStyle`| Function | wangtao  | done | | |
|`setFillStyle`| Function | wangtao  | done | | |
|*AppearSymbolEffect*| *Class* | wangtao  | done | | |
|`ctor`| Function | wangtao  | done | | |
|`getScope`| Function | wangtao  | done | | |
|`setScope`| Function | wangtao  | done | | |
|*DisappearSymbolEffect*| *Class* | wangtao  | done | | |
|`ctor`| Function | wangtao  | done | | |
|`getScope`| Function | wangtao  | done | | |
|`setScope`| Function | wangtao  | done | | |
|*BounceSymbolEffect*| *Class* | wangtao  | done | | |
|`ctor`| Function | wangtao  | done | | |
|`getScope`| Function | wangtao  | done | | |
|`setScope`| Function | wangtao  | done | | |
|`getDirection`| Function | wangtao  | done | | |
|`setDirection`| Function | wangtao  | done | | |
|*ReplaceSymbolEffect*| *Class* | Andrey Khudenkikh | done | | |
|`ctor`| Function |Andrey Khudenkikh | done | | |
|`getScope`| Function | Andrey Khudenkikh | done | | |
|`setScope`| Function | Andrey Khudenkikh | done | | |
|*PulseSymbolEffect*| *Class* | Maksimov Nikita | done | | |
|`ctor`| Function | Maksimov Nikita | done | | |
|*TabBarSymbol*| *Class* | | |
|`ctor`| Function | | |
|`getNormal`| Function | | |
|`setNormal`| Function | | |
|`getSelected`| Function | | |
|`setSelected`| Function | | |
|*TabsController*| *Class* | Skroba Gleb | done |  | |
|`ctor`| Function |  Skroba Gleb | done |  | |
|`changeIndex`| Function | Skroba Gleb | done |  | |
|`preloadItems`| Function | Skroba Gleb | done |  | |
|`setTabBarTranslate`| Function | Skroba Gleb | done |  | |
|`setTabBarOpacity`| Function | Skroba Gleb | done |  | |
|*TabContentTransitionProxy*| *Class* | Dudkin Sergey | done |  | |
|`ctor`| Function | Dudkin Sergey | done |  | |
|`finishTransition`| Function | Dudkin Sergey | done |  | |
|`getFrom`| Function | Dudkin Sergey | done |  | |
|`setFrom`| Function | Dudkin Sergey | done |  | |
|`getTo`| Function | Dudkin Sergey | done |  | |
|`setTo`| Function | Dudkin Sergey | done |  | |
|*TextController*| *Class* | Samarin Sergey | done |  | |
|`ctor`| Function | Samarin Sergey | done |  | |
|`closeSelectionMenu`| Function | Samarin Sergey | done |  | |
|`setStyledString`| Function | Samarin Sergey | done |  | |
|`getLayoutManager`| Function | Samarin Sergey | done |  | |
|*TextAreaController*| *Class* | Tuzhilkin Ivan | done |  |  |
|`ctor`| Function |Tuzhilkin Ivan | done |  |  |
|`caretPosition`| Function | Tuzhilkin Ivan | done |  |  |
|`setTextSelection`| Function | Tuzhilkin Ivan | done |  |  |
|`stopEditing`| Function | Tuzhilkin Ivan | done |  |  |
|*TextClockController*| *Class* |Pavelyev Ivan| done |  |  |
|`ctor`| Function | Pavelyev Ivan| done |  |  |
|`start`| Function |Pavelyev Ivan| done |  |  |
|`stop`| Function |Pavelyev Ivan| done |  |  |
|*TextBaseController*| *Class* | Morozov Sergey | done |  | |
|`ctor`| Function | Morozov Sergey | done |  | |
|`setSelection`| Function | Morozov Sergey | done |  | |
|`closeSelectionMenu`| Function | Morozov Sergey | done |  | |
|`getLayoutManager`| Function | Morozov Sergey | done |  | |
|*TextEditControllerEx*| *Class* | Morozov Sergey | done |  | |
|`ctor`| Function | Morozov Sergey | done |  | |
|`isEditing`| Function | Morozov Sergey | done |  | |
|`stopEditing`| Function | Morozov Sergey | done |  | |
|`setCaretOffset`| Function | Morozov Sergey | done |  | |
|`getCaretOffset`| Function | Morozov Sergey | done |  | |
|`getGetPreviewText`| Function | Morozov Sergey | done |  | |
|`setGetPreviewText`| Function | | |
|*StyledStringController*| *Class* | Pavelyev Ivan | done |  | |
|`ctor`| Function |Pavelyev Ivan | done |  | |
|`setStyledString`| Function | Pavelyev Ivan | done |  | |
|`getStyledString`| Function | Pavelyev Ivan | done |  | |
|*LayoutManager*| *Class* | Andrey Khudenkikh, Vadim Voronov | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`ctor`| Function | Andrey Khudenkikh | done |  | |
|`getLineCount`| Function | Andrey Khudenkikh | done |  | |
|`getGlyphPositionAtCoordinate`| Function | Vadim Voronov | done |  |  |
|*TextMenuItemId*| *Class* | Maksimov Nikita | done |  | |
|`ctor`| Function |Maksimov Nikita | done |  | |
|`of`| Function | Maksimov Nikita | done |  | |
|`equals`| Function | Maksimov Nikita | done |  | |
|`getCUT`| Function | Maksimov Nikita | done | | |
|`setCUT`| Function | | |
|`getCOPY`| Function | Maksimov Nikita | done | | |
|`setCOPY`| Function | | |
|`getPASTE`| Function | Maksimov Nikita | done | | |
|`setPASTE`| Function | | |
|`getSELECT_ALL`| Function | Maksimov Nikita | done | | |
|`setSELECT_ALL`| Function | | |
|`getCOLLABORATION_SERVICE`| Function | Maksimov Nikita | done | | |
|`setCOLLABORATION_SERVICE`| Function | | |
|`getCAMERA_INPUT`| Function | Maksimov Nikita | done | | |
|`setCAMERA_INPUT`| Function | | |
|`getAI_WRITER`| Function | Maksimov Nikita | done | | |
|`setAI_WRITER`| Function | | |
|`getTRANSLATE`| Function | Maksimov Nikita | done | | |
|`setTRANSLATE`| Function | | |
|`getSEARCH`| Function | Maksimov Nikita | done | | |
|`setSEARCH`| Function | | |
|`getSHARE`| Function | Maksimov Nikita | done | | |
|`setSHARE`| Function | | |
|*SubmitEvent*| *Class* | Tuzhilkin Ivan | done |  | |
|`ctor`| Function |Tuzhilkin Ivan | done |  | |
|`keepEditableState`| Function | Tuzhilkin Ivan | done |  | |
|`getText`| Function | Tuzhilkin Ivan | done |  | |
|`setText`| Function | Tuzhilkin Ivan | done |  | |
|*TextInputController*| *Class* | Spirin Andrey | done |  |  |
|`ctor`| Function | Spirin Andrey | done |  |  |
|`caretPosition`| Function | Spirin Andrey | done |  |  |
|`setTextSelection`| Function | Spirin Andrey | done |  |  |
|`stopEditing`| Function |  Spirin Andrey | done |  |  |
|*TextPickerDialog*| *Class* | Ekaterina Stepanova | done |  | |
|`ctor`| Function | Ekaterina Stepanova |  |  |  |
|*TextTimerController*| *Class* |Ekaterina Stepanova| done |  |  |
|`ctor`| Function |Ekaterina Stepanova| done | pass |  |
|`start`| Function |Ekaterina Stepanova| done | test blocked |  test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`pause`| Function |Ekaterina Stepanova| done |  |  |
|`reset`| Function |Ekaterina Stepanova| done |  |  |
|*TimePickerDialog*| *Class* | Ekaterina Stepanova | done |  | |
|`ctor`| Function | Ekaterina Stepanova |  |  |  |
|*UIExtensionProxy*| *Class* | Tuzhilkin Ivan | blocked IDL|  | |
|`ctor`| Function | Tuzhilkin Ivan | testskipped |  | |
|`send`| Function | Tuzhilkin Ivan | blocked |  | blocked Arkoala. Want processing |
|`sendSync`| Function | Tuzhilkin Ivan | blocked |  | blocked Arkoala. Want processing |
|`onAsyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|`onSyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|`offAsyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|`offSyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|*ColorFilter*| *Class* | Evstigneev Roman | done | |  |
|`ctor`| Function |Evstigneev Roman | in progress| test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*VideoController*| *Class* | Erokhin Ilya | done |  |  |
|`ctor`| Function |Erokhin Ilya | done |  |  |
|`start`| Function | Erokhin Ilya | done |  |  |
|`pause`| Function | Erokhin Ilya | done |  |  |
|`stop`| Function | Erokhin Ilya | done |  |  |
|`setCurrentTime0`| Function | Erokhin Ilya | done |  |  |
|`setCurrentTime1`| Function |Erokhin Ilya | done |  |  |
|`requestFullscreen`| Function | Erokhin Ilya | done |  |  |
|`exitFullscreen`| Function | Erokhin Ilya | done |  |  |
|`reset`| Function | Erokhin Ilya | done |  |  |
|*WaterFlowSections*| *Class* | Kovalev Sergey | done |  | |
|`ctor`| Function |Kovalev Sergey | done |  | |
|`splice`| Function | Kovalev Sergey | done |  | |
|`push`| Function | Kovalev Sergey | done |  | |
|`update`| Function | Kovalev Sergey | done |  | |
|`values`| Function | Kovalev Sergey | done |  |  |
|`length`| Function | Kovalev Sergey | done |  | |
|*XComponentController*| *Class* | Tuzhilkin Ivan | blocked IDL |  | |
|`ctor`| Function |Tuzhilkin Ivan | testskipped | pass | |
|`getXComponentSurfaceId`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getXComponentContext`| Function | Tuzhilkin Ivan | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IAYQZF +, demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`setXComponentSurfaceRect`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getXComponentSurfaceRect`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setXComponentSurfaceRotation`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getXComponentSurfaceRotation`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`startImageAnalyzer`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`stopImageAnalyzer`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getOnSurfaceCreated`| Function | | |
|`setOnSurfaceCreated`| Function | | |
|`getOnSurfaceChanged`| Function | | |
|`setOnSurfaceChanged`| Function | | |
|`getOnSurfaceDestroyed`| Function | | |
|`setOnSurfaceDestroyed`| Function | | |
|*AnimationExtender*| *Class* | Lobah Mikhail| in progress| | |
|`SetClipRect`| Function | Lobah Mikhail| in progress| | |
|`OpenImplicitAnimation`| Function | Lobah Mikhail| in progress| | |
|`CloseImplicitAnimation`| Function | Lobah Mikhail| in progress| | |
|`StartDoubleAnimation`| Function | Lobah Mikhail| in progress| | |
|`AnimationTranslate`| Function | Lobah Mikhail| in progress| | |
|*LazyForEachOps*| *Class* | managed side | done | | |
|`NeedMoreElements`| Function | managed side |done  |  |
|`OnRangeUpdate`| Function | managed side | done | | |
|`SetCurrentIndex`| Function | managed side | done | | |
|`Prepare`| Function | managed side | done | | |
|`NotifyChange`| Function |managed side |done | | |
|*SystemOps*| *Class* | managed side| managed side| | |
|`StartFrame`| Function |managed side |managed side | | |
|`EndFrame`| Function | managed side | managed side | | |
|`syncInstanceId`| Function |managed side |managed side | | |
|`restoreInstanceId`| Function |managed side |managed side | | |
|`getResourceId`| Function |managed side |managed side | | |
|`resourceManagerReset`| Function | | |
|`setFrameCallback`| Function | | |
|*FocusController*| *Class* | Lobah Mikhail| done| | |
|`requestFocus`| Function | Lobah Mikhail| done| pass | |
|*Scene*| *Class* | | |
|`ctor`| Function | | |
|`load`| Function | | |
|`destroy`| Function | | |
|*RestrictedWorker*| *Class* | | |
|`ctor`| Function | | |
|`postMessage0`| Function | | |
|`postMessage1`| Function | | |
|`postMessageWithSharedSendable`| Function | | |
|`on`| Function | | |
|`once`| Function | | |
|`off`| Function | | |
|`terminate`| Function | | |
|`addEventListener`| Function | | |
|`dispatchEvent`| Function | | |
|`removeEventListener`| Function | | |
|`removeAllListener`| Function | | |
|`registerGlobalCallObject`| Function | | |
|`unregisterGlobalCallObject`| Function | | |
|`getOnexit`| Function | | |
|`setOnexit`| Function | | |
|`getOnerror`| Function | | |
|`setOnerror`| Function | | |
|`getOnmessage`| Function | | |
|`setOnmessage`| Function | | |
|`getOnmessageerror`| Function | | |
|`setOnmessageerror`| Function | | |
|*StateStylesOps*| *Class* | | |
|`onStateStyleChange`| Function | | |
|*UIContextAtomicServiceBar*| *Class* | | |
|`getBarRect`| Function | | |
|*DrawingColorFilter*| *Class* | | |
|`ctor`| Function | | |
|`createBlendModeColorFilter0`| Function | | |
|`createBlendModeColorFilter1`| Function | | |
|`createComposeColorFilter`| Function | | |
|`createLinearToSRGBGamma`| Function | | |
|`createSRGBGammaToLinear`| Function | | |
|`createLumaColorFilter`| Function | | |
|`createMatrixColorFilter`| Function | | |
|*DrawingLattice*| *Class* | | |
|`ctor`| Function | | |
|`createImageLattice`| Function | | |
|*GlobalScope_ohos_arkui_componentSnapshot*| *Class* | Dudkin Sergey| done | out of scope | |
|`get`| Function | Dudkin Sergey | done | out of scope | |
|*GlobalScope_ohos_arkui_performanceMonitor*| *Class* | Vadim Voronov | done | | blocked IDL on FB |
|`begin`| Function | Vadim Voronov | done | | |
|`end`| Function | Vadim Voronov | done | | |
|`recordInputEventTime`| Function | Vadim Voronov | done | |  |
|*CommonShape*| *Class* | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`ctor`| Function |Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`offset`| Function | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`fill`| Function | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`position`| Function | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|*BaseShape*| *Class* | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`ctor`| Function |Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`width`| Function | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`height`| Function | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`size`| Function | Tuzhilkin Ivan | done | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|*GlobalScope_ohos_font*| *Class* | Pavelyev Ivan | done | | |
|`registerFont`| Function | Pavelyev Ivan | done | | |
|`getSystemFontList`| Function | Pavelyev Ivan | done | | |
|`getFontByName`| Function | Pavelyev Ivan | done | | |
|*GlobalScope_ohos_measure_utils*| *Class* | Dudkin Sergey | done | | |
|`measureText`| Function | Dudkin Sergey | done | | |
|`measureTextSize`| Function | Dudkin Sergey | done | | |
|*IUIContext*| *Class* | | |
|`freezeUINode0`| Function | | |
|`freezeUINode1`| Function | | |
|*NavExtender*| *Class* |managed side |managed side | | |
|`setNavigationOptions`| Function | managed side| managed side| | |
|`setUpdateStackCallback`| Function |managed side |managed side | | |
|`syncStack`| Function |managed side |managed side | | |
|`checkNeedCreate`| Function |managed side |managed side | | |
|`setNavDestinationNode`| Function |managed side |managed side | | |
|`pushPath`| Function | | |
|`replacePath`| Function | | |
|`pop`| Function | | |
|`setOnPopCallback`| Function | | |
|`getIdByIndex`| Function | | |
|`getIdByName`| Function | | |
|`popToIndex`| Function | | |
|`popToName`| Function | | |
|*EventEmulator*| *Class* | Dmitry A Smirnov | managed side | | |
|`emitClickEvent`| Function | managed side | managed side | | |
|`emitTextInputEvent`| Function | managed side | managed side | | |
