| Component | Function | Owner | Status (done=merged **with** UT, testskipped=merged **without** UT, blocked=blocked by IDL)| verification status |issue/comment|
| --------- | -------- | ----- | ------ |------|------|
|*AlphabetIndexer*| *Component* |Ekaterina Stepanova| done | tested partially |  |
|`construct`| Function |Ekaterina Stepanova| done | pass |  |
|`setAlphabetIndexerOptions`| Function |Ekaterina Stepanova| done | pass | deprecated |
|`setColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setSelectedColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setSelectedBackgroundColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupBackground`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupSelectedColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupUnselectedColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupItemBackgroundColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setUsingPopup`| Function |Ekaterina Stepanova| done | pass |  |
|`setSelectedFont`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupFont`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupItemFont`| Function |Ekaterina Stepanova| done | pass |  |
|`setItemSize`| Function |Ekaterina Stepanova| done | pass |  |
|`setFont`| Function |Ekaterina Stepanova| done | pass |  |
|`setOnSelect`| Function |Ekaterina Stepanova| done | failed | OHOSUI-2172 |
|`setOnRequestPopupData`| Function |Skroba Gleb| done | failed | OHOSUI-2172 |
|`setOnPopupSelect`| Function |Ekaterina Stepanova| done | failed | OHOSUI-2172 |
|`setSelected`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupPosition`| Function |Ekaterina Stepanova| done |  |  |
|`setAutoCollapse`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupItemBorderRadius`| Function |Ekaterina Stepanova| done | pass |  |
|`setItemBorderRadius`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupBackgroundBlurStyle`| Function |Ekaterina Stepanova| done | pass |  |
|`setPopupTitleBackground`| Function |Ekaterina Stepanova| done | pass |  |
|`setEnableHapticFeedback`| Function |Ekaterina Stepanova| done |  | not supported by dayu200; need to test on mobile device |
|`setAlignStyle`| Function |Ekaterina Stepanova| done | pass |  |
|*Animator*| *Component* |  managed side | managed side |  |  |
|`construct`| Function |  managed side | managed side |  |  |
|`setAnimatorOptions`| Function | managed side | managed side |  |
|`setState`| Function |  managed side | managed side |  |  |
|`setDuration`| Function |  managed side | managed side |  |  |
|`setCurve`| Function |  managed side | managed side |  |  |
|`setDelay`| Function |  managed side | managed side |  |  |
|`setFillMode`| Function |  managed side | managed side |  |  |
|`setIterations`| Function |  managed side | managed side |  |  |
|`setPlayMode`| Function |  managed side | managed side |  |  |
|`setMotion`| Function |  managed side | managed side |  |  |
|`setOnStart`| Function |  managed side | managed side |  |  |
|`setOnPause`| Function |  managed side | managed side |  |  |
|`setOnRepeat`| Function |  managed side | managed side |  |  |
|`setOnCancel`| Function |  managed side | managed side |  |  |
|`setOnFinish`| Function |  managed side | managed side |  | deprecated since 12  |
|`setOnFrame`| Function |  managed side | managed side |  | deprecated since 12  |
|*Badge*| *Component* |Vadim Voronov | done | test blocked |  |
|`construct`| Function |Vadim Voronov | done | test blocked | test blocked by incorrect SDK.|
|`setBadgeOptions0`| Function |Vadim Voronov | done | test blocked | test blocked by incorrect SDK.|
|*Blank*| *Component* | Skroba Gleb | done | pass |  |
|`construct`| Function | Skroba Gleb | done | pass |  |
|`setBlankOptions`| Function | Skroba Gleb | done | pass |  |
|`setColor`| Function | Skroba Gleb | done | pass |  |
|*Button*| *Component* | Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function | Evstigneev Roman | done |  pass12 |  |
|`setButtonOptions`| Function | Evstigneev Roman | done | pass12 |  |
|`setType`| Function | Evstigneev Roman | done | pass12 |  |
|`setStateEffect`| Function |Evstigneev Roman | done | pass12 |  |
|`setButtonStyle`| Function |Evstigneev Roman | done | pass12 |  |
|`setControlSize`| Function |Evstigneev Roman | done | pass12 |  |
|`setRole`| Function | Evstigneev Roman | done | pass12 |  |
|`setFontColor`| Function | Evstigneev Roman | testskipped | pass12 | Ace issue fixed, test in progress Evstigneev Roman |
|`setFontSize`| Function | Evstigneev Roman | testskipped | fail12 | Ace issue fixed, test in progress Evstigneev Roman, verification fail: working with string resources is not supported |
|`setFontWeight`| Function |Evstigneev Roman | testskipped | pass12 | Ace issue fixed, test in progress Evstigneev Roman |
|`setFontStyle`| Function |Evstigneev Roman | done | pass12 |  |
|`setFontFamily`| Function |Evstigneev Roman | done | pass12|  |
|`setContentModifier`| Function |Evstigneev Roman | done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG (+) & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|`setLabelStyle`| Function |Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMinFontScale`| Function | Kovalev Sergey | done |  | |
|`setMaxFontScale`| Function | Kovalev Sergey | done |  | |
|*CalendarPicker*| *Component* |Politov Mikhail | done |  |  |
|`construct`| Function |Politov Mikhail | done |  |  |
|`setCalendarPickerOptions`| Function |Politov Mikhail | testskipped | failed | UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IB7RNZ, test failed OHOSUI-2244 |
|`setTextStyle`| Function |Politov Mikhail | done | pass |  |
|`setOnChange`| Function |Politov Mikhail | done | pass |  |
|`setMarkToday`| Function | Samarin Sergey | done | pass | same as in arkui, false is not applied |
|`setEdgeAlign`| Function |Politov Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Canvas*| *Component* |Vadim Voronov | blocked AceEngine |  |
|`construct`| Function |Vadim Voronov | done | pass |
|`setCanvasOptions0`| Function |Vadim Voronov | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setCanvasOptions1`| Function |Vadim Voronov | blocked AceEngine | test blocked | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnReady`| Function |Vadim Voronov | done |  |  |
|`setEnableAnalyzer`| Function |Vadim Voronov | done |  |  |
|*Checkbox*| *Component* | Andrey Khudenkikh | blocked IDL | failed |  |
|`construct`| Function |Samarin Sergey | done | pass | |
|`setCheckboxOptions`| Function | Samarin Sergey | done | pass | |
|`setSelect`| Function | Andrey Khudenkikh | done | pass |  |
|`setSelectedColor`| Function | Andrey Khudenkikh | done | pass |  |
|`setShape`| Function | Andrey Khudenkikh | done | pass |  |
|`setUnselectedColor`| Function | Andrey Khudenkikh | done | pass |  |
|`setMark`| Function | Andrey Khudenkikh | done | pass |  |
|`setOnChange`| Function | Andrey Khudenkikh | done | pass |  |
|`setContentModifier`| Function | Andrey Khudenkikh | done | | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*CheckboxGroup*| *Component* | Dudkin Sergey| done |  |  |
|`construct`| Function |Dudkin Sergey| done | pass |  |
|`setCheckboxGroupOptions`| Function | Dudkin Sergey| done | pass |  |
|`setSelectAll`| Function | Dudkin Sergey | done | pass |  |
|`setSelectedColor`| Function | Dudkin Sergey | done | failed | OHOSUI-2181 |
|`setUnselectedColor`| Function | Dudkin Sergey | done | failed | OHOSUI-2181 |
|`setMark`| Function | Dudkin Sergey | done | failed | test failed info: strokeColor doesn`t work, OHOSUI-2181 |
|`setOnChange`| Function | Dudkin Sergey | done | pass |  |
|`setCheckboxShape`| Function | Dudkin Sergey | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Circle*|*Component*| Erokhin Ilya | done | pass |  |
|`construct`| Function |Erokhin Ilya | done | pass |  |
|`setCircleOptions`|Function| Erokhin Ilya | done | pass |  |
|*Column*| *Component* | Politov Mikhail | done |  |  |
|`construct`| Function | Politov Mikhail | done | pass |  |
|`setColumnOptions`| Function | Politov Mikhail | done | | |
|`setAlignItems`| Function | Politov Mikhail | done | pass |  |
|`setJustifyContent`| Function | Politov Mikhail | done | pass |  |
|`setPointLight`| Function | Evstigneev Roman | done | pass | UT by Evstigneev Roman |
|`setReverse`| Function | Politov Mikhail | done | pass |  |
|*ColumnSplit*| *Component* | Dmitry A Smirnov| done |  | |
|`construct`| Function |Dmitry A Smirnov| done | pass | |
|`setColumnSplitOptions`| Function | Dmitry A Smirnov| done | pass |  |
|`setResizeable`| Function | Dmitry A Smirnov| done | pass |  |
|`setDivider`| Function | Dmitry A Smirnov| done | test blocked IDL | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*CommonMethod*|*Component*|Skroba Gleb,Erokhin Ilya | in progress |  |  |
|`construct`| Function |Skroba Gleb |done | pass | empty implementation, functional is supported by managed side |
|`setWidth`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setHheight`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setDrawModifier`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setResponseRegion`| Function | Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`setMouseResponseRegion`| Function | Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`setSize`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setConstraintSize`| Function | Roman Sedaikin | done | pass | |
|`setHitTestBehavior`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setOnChildTouchTest`| Function | Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setLayoutWeight`| Function | Roman Sedaikin | done | pass | |
|`setChainWeight`| Function | Politov Mikhail | testskipped | test blocked | https://gitee.com/openharmony/arkui_ace_engine/issues/IBJW6H, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA
|`setPadding`| Function | Skroba Gleb | done | pass | |
|`setSafeAreaPadding`| Function |Dmitry A Smirnov | done | failed | commented ViewAbstract static methods code |
|`setMargin`| Function | Skroba Gleb | done | pass | |
|`setBackgroundColor`| Function |Skroba Gleb| done | failed | commented ViewAbstract static methods code |
|`setPixelRound`| Function | Skroba Gleb | done | pass |  |
|`setBackgroundImageSize`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`setBackgroundImagePosition`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`setBackgroundEffect0`| Function |Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setBackgroundImageResizable`| Function | Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`setForegroundEffect`| Function | Skroba Gleb | done | pass |  |
|`setVisualEffect`| Function | Skroba Gleb | blocked IDL | failed | napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code | |
|`setBackgroundFilter`| Function | Skroba Gleb | blocked IDL | failed  | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY & napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code |
|`setForegroundFilter`| Function | Skroba Gleb |  blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY & napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code |
|`setCompositingFilter`| Function | Skroba Gleb | blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY & napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3, commented ViewAbstract static methods code |
|`setOpacity`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setBorder`| Function | Roman Sedaikin | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setBorderStyle`| Function | Roman Sedaikin | done | pass | |
|`setBorderWidth`| Function | Roman Sedaikin | done | pass | |
|`setBorderColor`| Function | Roman Sedaikin | done | pass | |
|`setBorderRadius`| Function | Roman Sedaikin | done | pass | |
|`setBorderImage`| Function | Roman Sedaikin | done | failed | |
|`setOutline`| Function |Skroba Gleb | done | pass | |
|`setOutlineStyle`| Function | Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`setOutlineWidth`| Function |Skroba Gleb | done | failed | bug hos2403, commented ViewAbstract static methods code, demo test by Vadim Voronov |
|`setOutlineColor`| Function | Skroba Gleb | done | failed | bug hos2403, commented ViewAbstract static methods code, demo test by Vadim Voronov |
|`setOutlineRadius`| Function |Skroba Gleb | done | failed | commented ViewAbstract static methods code |
|`setForegroundColor`| Function | Erokhin Ilya | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnClick0`| Function |Roman Sedaikin | done | pass | EVENT |
|`setOnHover`| Function | Andrey Khudenkikh | done | pass | EVENT |
|`setOnHoverMove`| Function | Tuzhilkin Ivan | done | failed | need cherry-pick to feature_branch, commented ViewAbstract static methods code |
|`setOnAccessibilityHover`| Function | Andrey Khudenkikh | done | test blocked | UT by Vadim Voronov EVENT, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
| `setOnAccessibilityHoverTransparent` | Function    |              |                   |
|`setHoverEffect`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setOnMouse`| Function | Kovalev Sergey | done | pass | EVENT |
|`setOnTouch`| Function | Roman Sedaikin | testskipped | pass | EVENT |
|`setOnKeyEvent0`| Function | Pavelyev Ivan | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setOnKeyEvent1`| Function |Pavelyev Ivan | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setOnDigitalCrown`| Function | Evstigneev Roman | done | test blocked | feature: API not present, test blocked since wearable, commented ViewAbstract static methods code |
|`setOnKeyPreIme`| Function | Pavelyev Ivan | done | failed | unit tests failed, commented ViewAbstractModelNG static methods code |
|`setOnKeyEventDispatch`| Function | Lobah Mikhail| done| failed | |
|`setOnFocusAxisEvent`| Function | Evstigneev Roman | done | test blocked | feature: API not present, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnAxisEvent`| Function | Tuzhilkin Ivan | done | failed | need cherry-pick to feature_branch, need to submit issue |
|`setFocusable`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setNextFocus`| Function | Politov Mikhail | done | test blocked | done on upstream, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setTabStop`| Function | Lobah Mikhail| done| failed | |
|`setOnFocus`| Function | Roman Sedaikin | done | pass | |
|`setOnBlur`| Function | Roman Sedaikin | done | pass | |
|`setTabIndex`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`setDefaultFocus`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`setGroupDefaultFocus`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`setFocusOnTouch`| Function | Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`setFocusBox`| Function | Dudkin Sergey | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA info: LinkerUnresolvedClassError arkui.Graphics.ColorMetrics |
|`setAnimation`| Function | managed side | managed side | test blocked | test blocked by ICurve |
|`setTransition0`| Function |Dmitry A Smirnov| done | test blocked | test is blocked due to ArkTS 1.2 Compilation Issue, transition(Ark_TransitionOptions) - deprecated, this case tesskipped|
|`setTransition1`| Function |Dmitry A Smirnov| done | test blocked | test is blocked due to ArkTS 1.2 Compilation Issue, transition(Ark_TransitionOptions) - deprecated, this case tesskipped, commented ViewAbstract static methods code |
|`setMotionBlur`| Function |Dmitry A Smirnov| done | failed | commented ViewAbstract static methods code |
|`setBrightness`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setContrast`| Function |Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setGrayscale`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setColorBlend`| Function |Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setSaturate`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setSepia`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setInvert`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setHueRotate`| Function |Lobah Mikhail | done | pass | |
|`setUseShadowBatching`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setUseEffect0`| Function |Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setUseEffect1`| Function | Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setRenderGroup`| Function |Lobah Mikhail | done  | failed | same as arkui, but looks like there is an issue in ace_engine, commented ViewAbstract static methods code |
|`setFreeze`| Function | Lobah Mikhail | done | failed | method does not work https://gitee.com/openharmony/arkui_ace_engine/issues/IC851K, commented ViewAbstract static methods code |
|`setTranslate`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`setScale`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`setRotate`| Function | Dmitry A Smirnov | done | pass | Dmitry A Smirnov|
|`setTransform`| Function |Lobah Mikhail | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBUR61 Type `object` is converted to `ArkCustomObject`|
|`setOnAppear`| Function | Roman Sedaikin | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnDisAppear`| Function | Roman Sedaikin | done |  | |
|`setOnAttach`| Function | Andrey Khudenkikh | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnDetach`| Function | Andrey Khudenkikh | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnAreaChange`| Function | Roman Sedaikin | done | pass | |
|`setVisibility`| Function | Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setFlexGrow`| Function | Dmitry A Smirnov| done | pass | |
|`setFlexShrink`| Function | Dmitry A Smirnov| done | pass | |
|`setFlexBasis`| Function | Dmitry A Smirnov| done | pass | |
|`setAlignSelf`| Function | Roman Sedaikin | done | pass | |
|`setDisplayPriority`| Function | Roman Sedaikin | done | pass | |
|`setZIndex`| Function | Roman Sedaikin | done | pass | |
|`setDirection`| Function | Roman Sedaikin | done | pass | |
|`setAlign`| Function | Roman Sedaikin | done | pass | |
|`setPosition`| Function | Roman Sedaikin | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMarkAnchor`| Function | Dmitry A Smirnov| done | pass | |
|`setOffset`| Function | Skroba Gleb | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setEnabled`| Function | Roman Sedaikin | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setAlignRulesWithAlignRuleOptionTypedValue`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setAlignRulesWithLocalizedAlignRuleOptionsTypedValue`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setAspectRatio`| Function | Roman Sedaikin | done | pass | |
|`setClickEffect`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code | |
|`setOnDragStart`| Function | Skroba Gleb | done | failed | It needs DragEventAccessor implemented to complete Unit tests, but it is empty C-API now, commented ViewAbstract static methods code |
|`setOnDragEnter`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setOnDragMove`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setOnDragLeave`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setOnDrop0`| Function |Lobah Mikhail | done | test blocked | runtime linker issue, commented ViewAbstract static methods code |
|`setOnDragEnd`| Function | Lobah Mikhail | done | failed | won't work because of guozejun changes, commented ViewAbstract static methods code |
|`setAllowDrop`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setDraggable`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setDragPreview0`| Function |Lobah Mikhail | done | test blocked | UT done Lobah Mikhail CustomBuilder, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setDragPreview1`| Function | Lobah Mikhail | done | test blocked | UT done Lobah Mikhail CustomBuilder, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, not implemented |
|`setOnPreDrag`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setLinearGradient`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setSweepGradient`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setRadialGradient`| Function |Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`setMotionPath`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setShadow`| Function |Roman Sedaikin | done | failed | commented ViewAbstract static methods code |
|`setClip`| Function | Dudkin Sergey | done |  | clip1, clip2 not implemented |
|`setClipShape`| Function | Tuzhilkin Ivan | testskipped | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setMask`| Function | Maksimov Nikita | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setMaskShape`| Function |Tuzhilkin Ivan| done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setKey`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setId`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`setGeometryTransition0`| Function | Lobah Mikhail | testskipped | test blocked | no method found test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IC3EHG |
|`setStateStyles`| Function | managed side | managed side | test blocked | managed side https://gitee.com/rri_opensource/koala_projects/issues/IBOSCF |
|`setRestoreId`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setSphericalEffect`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setLightUpEffect`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setPixelStretchEffect`| Function | Lobah Mikhail | done | failed | commented ViewAbstract static methods code |
|`setAccessibilityGroupWithValue`| Function |Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityTextOfStringType`| Function | Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityNextFocusId`| Function | Lobah Mikhail| done| test blocked | Not exists on FB, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`setAccessibilityDefaultFocus`| Function | Lobah Mikhail| blocked IDL | test blocked IDL | managed side https://gitee.com/openharmony/arkui_ace_engine/issues/IBYL00, commented ViewAbstractModelNG static methods code |
|`setAccessibilityUseSamePage`| Function | Lobah Mikhail| done| test blocked | Not exists on FB, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`setAccessibilityScrollTriggerable`| Function | Tuzhilkin Ivan | done | test blocked | WRONG_GENERATION: parameter should be Opt, need cherry-pick to feature_branch, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`setAccessibilityTextOfResourceType`| Function | Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityRole`| Function | Lobah Mikhail| done| test blocked | Not exists on FB, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`setOnAccessibilityFocus`| Function | Evstigneev Roman | done | test blocked | feature: API not present, no accessibility srvice on FB, commented ViewAbstractModelNG static methods code |
|`setAccessibilityTextHint`| Function | Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityDescriptionOfStringType`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityDescriptionOfResourceType`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityLevel`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityVirtualNode`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilityChecked`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setAccessibilitySelected`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setObscured`| Function |Dmitry A Smirnov | done | failed | commented ViewAbstract static methods code |
|`setReuseId`| Function |managed side | managed side | | not implemented in ace_engine |
|`setReuse`| Function |managed side | managed side | | to be removed from CAPI generation |
|`setRenderFit`| Function | Dmitry A Smirnov| done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setGestureModifier`| Function | Erokhin Ilya | blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7, failed | commented ViewAbstract static methods code |
|`setBackgroundBrightness`| Function | Skroba Gleb | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setOnGestureJudgeBegin`| Function | Skroba Gleb | done |  | UT by Vadim Voronov  |
|`setOnGestureRecognizerJudgeBegin0`| Function | Skroba Gleb | done | failed | runtime linker issue |
|`setShouldBuiltInRecognizerParallelWith`| Function | Skroba Gleb | done | test blocked | test blocked by `id` interface |
|`setMonopolizeEvents`| Function | Erokhin Ilya | done | pass | UT by Vadim Voronov |
|`setOnTouchIntercept`| Function | Andrey Khudenkikh | done | pass | EVENT |
|`setOnSizeChange`| Function | Dmitry A Smirnov| done | failed | issue OHOSUI-2216, commented ViewAbstract static methods code |
|`setAccessibilityFocusDrawLevel`| Function | Tuzhilkin Ivan | done | test blocked | need cherry-pick to feature_branch, test blocked since no accessibility service on FB, commented ViewAbstract static methods code |
|`setCustomProperty`| Function | Dmitry A Smirnov| in progress | test blocked | need clarify bridge implementation, test blocked by FrameNode.getCustomProperty, commented ViewAbstract static methods code |
|`setExpandSafeArea`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setBackground`| Function | Lobah Mikhail | done | test blocked | UT done Lobah Mikhail, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setBackgroundImage0`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setBackgroundImage1`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setBackgroundBlurStyle`| Function | Skroba Gleb | done | test blocked |  test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setBackgroundEffect1`| Function | Evstigneev Roman | testskipped |  |  |  |  |
|`setForegroundBlurStyle`| Function | Evstigneev Roman | in progress | | |
|`setOnClick1`| Function | Skroba Gleb | done |  |  |  |  |
|`setFocusScopeId`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setFocusScopePriority`| Function | Dmitry A Smirnov| done | pass | |
|`setTransition1`| Function |Dmitry A Smirnov| done | test blocked | test is blocked due to ArkTS 1.2 Compilation Issue, transition(Ark_TransitionOptions) - deprecated, this case tesskipped, commented ViewAbstract static methods code |
|`setGesture`| Function | Erokhin Ilya | testskipped | pass |  |
|`setPriorityGesture`| Function | Erokhin Ilya | testskipped |  |  |
|`setParallelGesture`| Function | Erokhin Ilya | testskipped | test blocked | test blocked by `id` interface |
|`setBlur`| Function | Erokhin Ilya | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setLinearGradientBlur`| Function |Lobah Mikhail | done | failed | linearGradientBlur1 not implemented |
|`setSystemBarEffect`| Function | Ekaterina Stepanova | in progress |  |  |
|`setBackdropBlur`| Function | Berezin Kirill | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setSharedTransition`|Function|Skroba Gleb | done | test blocked | navigation between pages does not work to check transition, commented ViewAbstract static methods code |
|`setChainMode`| Function | Berezin Kirill | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnDrop1`| Function | Lobah Mikhail | in progress | failed | not implemented |
|`setDragPreview1`| Function | Lobah Mikhail | done | test blocked | UT done Lobah Mikhail CustomBuilder, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, not implemented |
|`setDragPreviewOptions`| Function | Erokhin Ilya | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setOverlay`| Function | Lobah Mikhail | blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBUXWQ Correct generation of the 'Ark_ComponentContent' class without stubs is required, commented ViewAbstract static methods code |
|`setBlendMode`| Function | Lobah Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setAdvancedBlendMode`| Function | Erokhin Ilya |in progress | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setGeometryTransition1`| Function | Lobah Mikhail | testskipped | failed | to be removed? OHOSUI-2375, UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IC3EHG, commented ViewAbstract static methods code |
|`setBindTips`| Function | Tuzhilkin Ivan | in progress | | only for generation > 125|
|`setBindPopup`| Function | Erokhin Ilya | done | test blocked | fixes of issues were provided by our team, https://gitee.com/openharmony/arkui_ace_engine/issues/IBYL2K, https://gitee.com/openharmony/arkui_ace_engine/issues/IBY31B, test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setBindMenu0`| Function | Erokhin Ilya | blocked IDL | test blocked | SymbolGlyphModifier https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG  & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`setBindMenu1`| Function | Erokhin Ilya | blocked IDL | test blocked | SymbolGlyphModifier https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`setBindContextMenu0`| Function | Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setBindContextMenu1`| Function | Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setBindContentCover0`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov, commented ViewAbstractModelNG static methods code |
|`setBindContentCover1`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov, commented ViewAbstractModelNG static methods code |
|`setBindSheet`| Function | Erokhin Ilya | testskipped | test blocked | UT in progress Vadim Voronov, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setOnVisibleAreaChange`| Function | Erokhin Ilya | done | failed | commented ViewAbstract static methods code |
|`setOnVisibleAreaApproximateChange`| Function | Tuzhilkin Ivan | done | failed | need cherry-pick to feature_branch, commented ViewAbstract static methods code |
|`setKeyboardShortcut`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstract static methods code |
|`setAccessibilityGroupWithConfig`| Function | Lobah Mikhail | done | test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, commented ViewAbstractModelNG static methods code |
|`setOnGestureRecognizerJudgeBegin1`| Function | Skroba Gleb | done | test blocked | test blocked by `id` interface |
|*CommonShapeMethod*|*Component*|Skroba Gleb| done |  |  |
|`construct`| Function |Skroba Gleb| done |  | empty implementation, functional is supported by managed side |
|`setStroke`|Function| Skroba Gleb | done | pass |  |
|`setFill`|Function| Skroba Gleb | done | pass |  |
|`setStrokeDashOffset`| Function | Evstigneev Roman | done | test blocked |  |
|`setStrokeLineCap`| Function | Evstigneev Roman | done | test blocked |  |
|`setStrokeLineJoin`| Function | Evstigneev Roman | done | test blocked |  |
|`setStrokeMiterLimit`| Function | Evstigneev Roman | done | test blocked |  |
|`setStrokeOpacity`| Function | Evstigneev Roman | done | pass |  |
|`setFillOpacity`| Function | Evstigneev Roman | done | pass |  |
|`setStrokeWidth`| Function | Evstigneev Roman | done | pass |  |
|`setAntiAlias`| Function | Evstigneev Roman | done | pass |  |
|`setStrokeDashArray`| Function | Erokhin Ilya| done| failed | to submit internal issue |
|*ScrollableCommonMethod*| *Component* | Samarin Sergey | blocked IDL |  |  |
|`construct`| Function |Samarin Sergey | done | pass | empty implementation, functional is supported by managed side |
|`setScrollBar`| Function | Samarin Sergey | done | pass |  |
|`setScrollBarColor`| Function | Samarin Sergey | done | pass |  |
|`setScrollBarWidth`| Function | Samarin Sergey | done | pass |  |
|`setNestedScroll`| Function | Samarin Sergey | done |  | pass |
|`setEnableScrollInteraction`| Function | Samarin Sergey | done | pass |  |
|`setFriction`| Function | Samarin Sergey | done | pass |  |
|`setOnReachStart`| Function | Samarin Sergey | done | pass | |
|`setOnReachEnd`| Function | Samarin Sergey | done | pass | |
|`setOnScrollStart`| Function | Samarin Sergey | done | pass | |
|`setOnScrollStop`| Function | Samarin Sergey | done | pass | |
|`setFlingSpeedLimit`| Function | Samarin Sergey | done | pass |  |
|`setClipContent`| Function | Evstigneev Roman | done |  |  |
|`setDigitalCrownSensitivity`| Function | Kovalev Sergey | done | test blocked | test blocked since wearable feature |
|`setBackToTop`| Function | Kovalev Sergey | done |  | |
|`setEdgeEffect`| Function | Samarin Sergey | done | pass | |
|`setFadingEdge`| Function | Samarin Sergey | done | test blocked | |
| *Component3D*                                        | *Component* |                                  |                   |
| `construct`                                            | Function    |                                  |                   |
| `setComponent3DOptions`                                | Function    |                                  |                   |
| `setEnvironment`                                       | Function    |                                  |                   |
| `setShader`                                            | Function    |                                  |                   |
| `setShaderImageTexture`                                | Function    |                                  |                   |
| `setShaderInputBuffer`                                 | Function    |                                  |                   |
| `setRenderWidth`                                       | Function    |                                  |                   |
| `setRenderHeight`                                      | Function    |                                  |                   |
| `setCustomRender`                                      | Function    |                                  |                   |
|*ContainerSpan*| *Component* | Tuzhilkin Ivan| done | pass |  |
|`construct`| Function | Tuzhilkin Ivan| done | pass |  |
|`setContainerSpanOptions`| Function |Tuzhilkin Ivan| done | pass |  |
|`setTextBackgroundStyle`| Function |Tuzhilkin Ivan| done | pass |  |
|*Counter*| *Component* | Erokhin Ilya | done | pass |  |
|`construct`| Function |Erokhin Ilya | done | pass |  |
|`setCounterOptions`| Function | Erokhin Ilya | done | pass |  |
|`setOnInc`| Function | Erokhin Ilya | done | pass |  |
|`setOnDec`| Function | Erokhin Ilya | done | pass |  |
|`setEnableDec`| Function | Erokhin Ilya | done | pass |  |
|`setEnableInc`| Function | Erokhin Ilya | done | pass |  |
|*DataPanel*| *Component* | Morozov Sergey | blocked IDL |  |  |
|`construct`| Function |Morozov Sergey | done | pass |  |
|`setDataPanelOptions`| Function | Morozov Sergey | done | pass |  |
|`setCloseEffect`| Function | Morozov Sergey | done | pass |  |
|`setValueColors`| Function |Morozov Sergey | done | failed | 2068 |
|`setTrackBackgroundColor`| Function |Morozov Sergey | done | pass |  |
|`setStrokeWidth`| Function | Morozov Sergey | done | pass |  |
|`setTrackShadow`| Function |Morozov Sergey | testskipped | test blocked | https://gitee.com/openharmony/arkui_ace_engine/issues/IBVDFV , demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`setContentModifier`| Function | Morozov Sergey | done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|*DatePicker*| *Component* | Vadim Voronov | done |  |  |
|`construct`| Function |Vadim Voronov | done | pass |  |
|`setDatePickerOptions`| Function | Vadim Voronov| done | pass | |
|`setLunar`| Function |Vadim Voronov | done | pass |  |
|`setDisappearTextStyle`| Function | Vadim Voronov| done | pass |  |
|`setTextStyle`| Function |Vadim Voronov | done | pass |  |
|`setSelectedTextStyle`| Function |Vadim Voronov | done | pass |  |
|`setOnDateChange`| Function |Vadim Voronov | done | pass | |
|`setDigitalCrownSensitivity`| Function | Vadim Voronov | done |  | |
|`setEnableHapticFeedback`| Function | Vadim Voronov | done |  | not supported by dayu200; need to test on mobile device |
|*Divider*| *Component* | Tuzhilkin Ivan | done | pass |  |
|`construct`| Function | Tuzhilkin Ivan |done | pass | |
|`setDividerOptions`| Function | Tuzhilkin Ivan| done | pass |  |
|`setVertical`| Function | Tuzhilkin Ivan | done | pass |  |
|`setColor`| Function | Tuzhilkin Ivan | done | pass |  |
|`setStrokeWidth`| Function | Tuzhilkin Ivan | done | pass |  |
|`setLineCap`| Function | Tuzhilkin Ivan | done | pass |  |
|*EffectComponent*| *Component* | Ekaterina Stepanova | done | out of scope | |
|`construct`| Function |Ekaterina Stepanova | done | out of scope | |
|`setEffectComponentOptions`| Function | Ekaterina Stepanova | done | out of scope | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setAlwaysSnapshot`                                    | Function    |                                  |                   |
|*Ellipse*| *Component* | Ekaterina Stepanova | done | pass | |
|`construct`| Function |Ekaterina Stepanova | done | pass | |
|`setEllipseOptions`| Function | Ekaterina Stepanova | done | pass | |
|*EmbeddedComponent*| *Component* | Ekaterina Stepanova | blocked |  | |
|`construct`| Function | Ekaterina Stepanova | testskipped |  |  |
|`setEmbeddedComponentOptions`| Function | Ekaterina Stepanova | blocked |  | blocked Arkoala. Want processing |
|`setOnTerminated`| Function | Ekaterina Stepanova | blocked |  | blocked Arkoala. Want processing |
|`setOnError`| Function | Ekaterina Stepanova | testskipped |  |  |
|*Flex*| *Component* | Kovalev Sergey | done | |  |
|`construct`| Function | Kovalev Sergey | done | pass |  |
|`setFlexOptions`| Function | Kovalev Sergey | done | pass |  |
|`setPointLight`| Function | Evstigneev Roman | done | pass | UT by Evstigneev Roman |
|*FlowItem*| *Component* | Evstigneev Roman | done | pass |  |
|`construct`| Function | Evstigneev Roman | done | pass |  |
|`setFlowItemOptions`| Function | Evstigneev Roman | done |  |  |
|*FolderStack*| *Component* | Politov Mikhail | done |  |  |
|`construct`| Function | Politov Mikhail | done | pass |  |
|`setFolderStackOptions`| Function | Politov Mikhail | done | pass |  |
|`setAlignContent`| Function | Politov Mikhail | done | pass |  |
|`setOnFolderStateChange`| Function | Politov Mikhail | done | pass |  |
|`setOnHoverStatusChange`| Function | Politov Mikhail | done | pass |  |
|`setEnableAnimation`| Function | Politov Mikhail | done | test blocked | no screen rotation supported by dayu200 |
|`setAutoHalfFold`| Function | Politov Mikhail | done | test blocked | no screen rotation supported by dayu200 |
|*FormComponent*| *Component* | Vadim Voronov | in progress |  | whole component out of scope, no need to develop |
|`construct`| Function | Vadim Voronov | done | out of scope |  |
|`setFormComponentOptions`| Function | Vadim Voronov |skip | out of scope |  |
|`setSize`| Function | Vadim Voronov | done | out of scope | empty method https://gitee.com/openharmony/arkui_ace_engine/issues/IB78HF |
|`setModuleName`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setDimension`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setAllowUpdate`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setVisibility`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnAcquired`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnError`| Function | Vadim Voronov | done | out of scope | on FB testskipped, test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnRouter`| Function | Vadim Voronov | skip | out of scope | https://gitee.com/nikolay-igotti/idlize/issues/ICAZXO |
|`setOnUninstall`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnLoad`| Function | Vadim Voronov | done | out of scope | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnUpdate`| Function | Vadim Voronov | in progress |  |  |  |  |
|*FormLink*| *Component* | Dmitry A Smirnov| done | out of scope | whole component out of scope, no need to develop |
|`construct`| Function |Dmitry A Smirnov| done | out of scope |  |
|`setFormLinkOptions`| Function | Dmitry A Smirnov| done | out of scope |  |
|*Gauge*| *Component* | Maksimov Nikita | blocked IDL |  |  |
|`construct`| Function | Maksimov Nikita | done | pass | |
|`setGaugeOptions`| Function | Maksimov Nikita | done | pass | |
|`setValue`| Function | Maksimov Nikita | done | pass | |
|`setStartAngle`| Function | Maksimov Nikita | done | pass | |
|`setEndAngle`| Function | Maksimov Nikita | done | pass | |
|`setColors`| Function | Maksimov Nikita | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`setStrokeWidth`| Function | Maksimov Nikita | done | pass | |
|`setDescription`| Function | Lobah Mikhail | done | test blocked | UT done Lobah Mikhail, demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`setTrackShadow`| Function | Maksimov Nikita | done | pass |  |
|`setIndicator`| Function | Maksimov Nikita | done | pass |  |
|`setPrivacySensitive`| Function | Maksimov Nikita | done | pass ||
|`setContentModifier`| Function | Maksimov Nikita | done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*Grid*|*Component*| Erokhin Ilya | done |  |  |
|`construct`| Function |Erokhin Ilya | done | pass | |
|`setGridOptions`|Function| Erokhin Ilya | done | pass | |
|`setColumnsTemplate`|Function| Erokhin Ilya | done |  |  |
|`setRowsTemplate`|Function| Erokhin Ilya | done | pass |  |
|`setColumnsGap`|Function| Erokhin Ilya | done | pass |  |
|`setRowsGap`|Function| Erokhin Ilya | done | pass |  |
|`setScrollBarWidth`|Function||||
|`setScrollBarColor`|Function||||
|`setScrollBar`|Function||||
|`setOnScrollBarUpdate`|Function| Skroba Gleb | done |  | |
|`setOnScrollIndex`|Function| Erokhin Ilya | done |  |  |
|`setCachedCount0`| Function |Erokhin Ilya | done | test blocked |  |
|`setEditMode`|Function| Erokhin Ilya | done | pass |  |
|`setMultiSelectable`|Function| Erokhin Ilya | done | pass |  |
|`setMaxCount`|Function| Erokhin Ilya | done | pass |  |
|`setMinCount`|Function| Erokhin Ilya | done | pass |  |
|`setCellLength`|Function| Erokhin Ilya | done | pass |  |
|`setLayoutDirection`|Function| Erokhin Ilya | done | pass |  |
|`setSupportAnimation`|Function| Erokhin Ilya | done | pass |  |
|`setOnItemDragStart`|Function| Skroba Gleb | done |  |  |
|`setOnItemDragEnter`|Function| Erokhin Ilya | done |  |  |
|`setOnItemDragMove`|Function| Erokhin Ilya | done |  |  |
|`setOnItemDragLeave`|Function| Erokhin Ilya | done |  |  |
|`setOnItemDrop`|Function| Erokhin Ilya | done |  |  |
|`setNestedScroll`|Function||||
|`setEnableScrollInteraction`|Function||||
|`setFriction`|Function||||
|`setAlignItems`| Function | Erokhin Ilya | done | pass |  |
|`setOnScrollFrameBegin`|Function| Skroba Gleb | done |  |   |
|`setOnWillScroll`| Function | wangtao | done | | |
|`setOnDidScroll`|Function|wangtao|done||
|`setCachedCount1`|Function| Erokhin Ilya | done | test blocked |  |
|`setEdgeEffect`|Function||||
|*GridCol*| *Component* | Lobah Mikhail| done |  |  |
|`construct`| Function |Lobah Mikhail| done | pass |  |
|`setGridColOptions`| Function |Lobah Mikhail| done | pass |  |
|`setSpan`| Function |Lobah Mikhail| done | pass |  |
|`setGridColOffset`| Function |Lobah Mikhail| done | pass |  |
|`setOrder`| Function |Lobah Mikhail| done | pass |  |
|*GridItem*|*Component*| Erokhin Ilya | done | test blocked |  |
|`construct`| Function |Erokhin Ilya | done | test blocked |  |
|`setGridItemOptions`|Function| Erokhin Ilya | done | test blocked |  |
|`setRowStart`|Function| Erokhin Ilya | done | test blocked  |  |
|`setRowEnd`|Function| Erokhin Ilya | done | test blocked  |  |
|`setColumnStart`|Function| Erokhin Ilya | done | test blocked  |  |
|`setColumnEnd`|Function| Erokhin Ilya | done | test blocked |  |
|`setSelectable`|Function| Erokhin Ilya | done | test blocked  |  |
|`setSelected`|Function| Erokhin Ilya | done | test blocked  |  |
|`setOnSelect`|Function| Erokhin Ilya | done |  |  |
|*GridRow*| *Component* |Lobah Mikhail| done | |  |
|`construct`| Function |Lobah Mikhail| done | pass |  |
|`setGridRowOptions`| Function |Lobah Mikhail| done | pass |  |
|`setOnBreakpointChange`| Function |Lobah Mikhail| done |  |  |
|`setAlignItems`| Function |Lobah Mikhail| done | pass |  |
|*Hyperlink*| *Component* | Morozov Sergey | done |  |   |
|`construct`| Function | Morozov Sergey | done |  |   |
|`setHyperlinkOptions`| Function | Morozov Sergey | done | pass | |
|`setColor`| Function | Morozov Sergey | done | pass | |
|*Image*| *Component* | Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function |Berezin Kirill | done |  |  |
|`setImageOptions0`| Function | Berezin Kirill | done | pass |  |
|`setImageOptions1`| Function | |  |  | blocked by DrawableDescriptor  |
|`setAlt`| Function | Evstigneev Roman | done | pass | UT done Lobah Mikhail   |
|`setMatchTextDirection`| Function | Evstigneev Roman | done | pass | |
|`setFitOriginalSize`| Function | Evstigneev Roman | done | pass | |
|`setFillColor`| Function | Evstigneev Roman | done | pass | |
|`setObjectFit`| Function |Berezin Kirill| done | pass | |
|`setImageMatrix`| Function | Samarin Sergey | done | failed | no effect, to submit |
|`setObjectRepeat`| Function | Evstigneev Roman | done | pass | |
|`setAutoResize`| Function | Evstigneev Roman | done | pass |   |
|`setRenderMode`| Function | Evstigneev Roman | done | pass | |
|`setDynamicRangeMode`| Function | Evstigneev Roman | testskipped | pass | test blocked by aceEngine https://gitee.com/openharmony/arkui_ace_engine/issues/IB1IEY, test in progress Evstgneev Roman |
|`setInterpolation`| Function | Evstigneev Roman | done | pass | |
|`setSourceSize`| Function | Evstigneev Roman | done | pass | |
|`setSyncLoad`| Function | Evstigneev Roman | done | pass | |
|`setColorFilter`| Function | Evstigneev Roman | blocked |  |  |  | blocked by DrawColorFilter |
|`setCopyOption`| Function | Evstigneev Roman | testskipped | pass |  tests blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IBEEFF (+) |
|`setDraggable`| Function | Evstigneev Roman | done | pass |   |
|`setPointLight`| Function | Evstigneev Roman | done | pass |    |
|`setEdgeAntialiasing`| Function | Evstigneev Roman | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnComplete`| Function | Evstigneev Roman | done | pass |    |
|`setOnError`| Function | Evstigneev Roman | done | pass | |
|`setOnFinish`| Function | Evstigneev Roman | done | failed | same in ArkUI, https://gitee.com/openharmony/arkui_ace_engine/issues/ICG623 |
|`setEnableAnalyzer`| Function | Evstigneev Roman | done | pass | |
|`setAnalyzerConfig`| Function | Evstigneev Roman | blocked AceEngine | test blocked | methods is not implemented, https://gitee.com/openharmony/arkui_ace_engine/issues/IB0Y51 (actual on the 01.09.2025) |
|`setResizable`| Function | Evstigneev Roman | blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY, blocked by DrawingLattice |
|`setPrivacySensitive`| Function | Evstigneev Roman | done | pass | |
|`setEnhancedImageQuality` | Function | Erokhin Ilya | done |  |  |  |  |
|`setOrientation`| Function | Samarin Sergey | done | pass | |
|*ImageAnimator*| *Component* | Pavelyev Ivan | done |  | |
|`construct`| Function | Pavelyev Ivan | done | pass | |
|`setImageAnimatorOptions`| Function | Pavelyev Ivan | done | pass | |
|`setImages`| Function | Pavelyev Ivan | done | pass |  |
|`setState`| Function | Pavelyev Ivan | done | pass | |
|`setDuration`| Function | Pavelyev Ivan | done | pass | |
|`setReverse`| Function | Pavelyev Ivan | done | pass | |
|`setFixedSize`| Function | Pavelyev Ivan | done |  | |
|`setFillMode`| Function | Pavelyev Ivan | done | pass | |
|`setIterations`| Function | Pavelyev Ivan | done | pass | |
|`setMonitorInvisibleArea`| Function | Samarin Sergey | done | failed | |
|`setOnStart`| Function | Pavelyev Ivan | done | pass | |
|`setOnPause`| Function | Pavelyev Ivan | done | pass | |
|`setOnRepeat`| Function | Pavelyev Ivan | done | pass | |
|`setOnCancel`| Function | Pavelyev Ivan | done |  | |
|`setOnFinish`| Function | Pavelyev Ivan | done | pass | |
|*ImageSpan*| *Component* | Politov Mikhail | blocked IDL |  |  |
|`construct`| Function | Politov Mikhail | done | pass | |
|`setImageSpanOptions`| Function | Politov Mikhail | done | pass | |
|`setVerticalAlign`| Function | Politov Mikhail | done | pass |  |
|`setColorFilter`| Function | Evstigneev Roman | blocked |  |  |  | blocked by DrawColorFilter |
|`setObjectFit`| Function | Politov Mikhail | done | pass |  |
|`setOnComplete`| Function | Politov Mikhail | done | pass |  |
|`setOnError`| Function | Politov Mikhail | done |  |  |
|`setAlt`| Function | Politov Mikhail | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*IndicatorComponent*| *Component* | Skroba Gleb | done | |  |
|`construct`| Function | Skroba Gleb | done | failed | "Can't have nullptr ptr ${}" probably no the component code |
|`setIndicatorComponentOptions`| Function | Skroba Gleb | done |  |  |
|`setInitialIndex`| Function | Skroba Gleb | done |  |  |
|`setCount`| Function | Skroba Gleb | done |  |  |
|`setStyle`| Function | Skroba Gleb | done |  |  |
|`setLoop`| Function | Skroba Gleb | done |  |  |
|`setVertical`| Function | Skroba Gleb | done |  |  |
|`setOnChange`| Function | Skroba Gleb | done |  |  |
|*Line*|*Component*|Dudkin Sergey| done |  |  |
|`construct`| Function |Dudkin Sergey| done |  |  |
|`setLineOptions`|Function|Dudkin Sergey| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStartPoint`|Function|Dudkin Sergey| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setEndPoint`|Function|Dudkin Sergey| done | pass |  |
|*List*|*Component*|Morozov Sergey| done | Evstigneev Roman |  |
|`construct`| Function |Morozov Sergey| done | in progress |  |
|`setListOptions`|Function|Morozov Sergey| done | in progress |  |
|`setAlignListItem`|Function|Morozov Sergey| done | in progress |  |
|`setListDirection`|Function|Morozov Sergey| done | in progress |  |
|`setContentStartOffset`|Function|Morozov Sergey| done | in progress   |  |
|`setContentEndOffset`|Function|Morozov Sergey| done | in progress   |  |
|`setDivider`|Function|Morozov Sergey| done | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMultiSelectable`|Function|Morozov Sergey| done | in progress |  |
|`setCachedCount0`|Function|Morozov Sergey| done | in progress |  |
|`setChainAnimation`|Function|Morozov Sergey| done | in progress |  |
|`setChainAnimationOptions`|Function|Morozov Sergey| done | in progress |  |
|`setSticky`|Function|Morozov Sergey| done | in progress |  |
|`setScrollSnapAlign`|Function|Morozov Sergey| done | in progress |  |
|`setChildrenMainSize`|Function|Morozov Sergey| done | in progress |  |
|`setMaintainVisibleContentPosition`|Function|Morozov Sergey| done | in progress |  |
|`setStackFromEnd`| Function | Samarin Sergey | done | in progress | |
|`setOnScrollIndex`|Function|Morozov Sergey| done | in progress |  |
|`setOnScrollVisibleContentChange`|Function|Morozov Sergey| done | in progress |  |
|`setOnItemMove`|Function| Skroba Gleb | done | in progress |   |
|`setOnItemDragStart`|Function| Skroba Gleb | done | in progress |   |
|`setOnItemDragEnter`|Function|Morozov Sergey| done | in progress |  |
|`setOnItemDragMove`|Function|Morozov Sergey| done | in progress |  |
|`setOnItemDragLeave`|Function|Morozov Sergey| done | in progress |  |
|`setOnItemDrop`|Function|Morozov Sergey| done | in progress |  |
|`setOnScrollFrameBegin`|Function| Skroba Gleb | done | in progress |   |
|`setOnWillScroll`| Function | wangtao | done | | |
|`setOnDidScroll`| Function | wangtao | done | | |
|`setLanes`|Function|Morozov Sergey| done | in progress |  |
|`setCachedCount1`| Function |Morozov Sergey| done | in progress |  |
|*ListItem*|*Component*|Morozov Sergey| done | Evstigneev Roman, test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Morozov Sergey| done | in progress |  |
|`setListItemOptions`| Function | Morozov Sergey| done |  | deprecated for SetListItemOptions1Impl |
|`setSelectable`|Function|Morozov Sergey| done | in progress |  |
|`setSelected`|Function|Morozov Sergey| done | in progress |  |
|`setSwipeAction`|Function|Samarin Sergey| done | in progress |  |
|`setOnSelect`|Function|Morozov Sergey| done | in progress |  |
|*ListItemGroup*|*Component*|Morozov Sergey| done | Evstigneev Roman, test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Morozov Sergey| done | in progress |  |
|`setListItemGroupOptions`|Function|Dmitry A Smirnov | done | in progress |   |
|`setDivider`|Function|Morozov Sergey| done | in progress |  |
|`setChildrenMainSize`|Function|Morozov Sergey| done | in progress |  |
|*LoadingProgress*|*Component*| Samarin Sergey | done | Samarin Sergey |  |
|`construct`| Function | Samarin Sergey | done | pass |  |
|`setLoadingProgressOptions`|Function| Samarin Sergey | done | pass |  |
|`setColor`|Function| Samarin Sergey | done | pass |  |
|`setEnableLoading`|Function| Samarin Sergey | done | pass |  |
|`setContentModifier`|Function| Samarin Sergey| done | test blocked | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*Marquee*| *Component* | Andrey Khudenkikh| done |  |  |
|`construct`| Function |Andrey Khudenkikh| done |  |  |
|`setMarqueeOptions`| Function | Andrey Khudenkikh| done | failed | loop is not applied |
|`setFontColor`| Function |Andrey Khudenkikh | done | pass |  |
|`setFontSize`| Function |Andrey Khudenkikh | done | pass |  |
|`setAllowScale`| Function |Andrey Khudenkikh | done | pass |  |
|`setFontWeight`| Function | Andrey Khudenkikh| done | failed | FontWeight.Bolder does not work |
|`setFontFamily`| Function | Andrey Khudenkikh| done |  |  |
|`setMarqueeUpdateStrategy`| Function |Andrey Khudenkikh | done | pass |  |
|`setOnStart`| Function | Andrey Khudenkikh| done | failed | wrong timing for "on" events |
|`setOnBounce`| Function |Andrey Khudenkikh | done | failed | wrong timing for "on" events |
|`setOnFinish`| Function |Andrey Khudenkikh | done | failed | wrong timing for "on" events |
|*MediaCachedImage*| *Component* | Skroba Gleb | done |  | |
|`construct`| Function | Skroba Gleb | done |  |  |
|`setMediaCachedImageOptions`| Function | Skroba Gleb | done |  |   |
|*Menu*|*Component*|Morozov Sergey| done |  |  |
|`construct`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMenuOptions`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setFont`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setFontColor`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setRadius`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMenuItemDivider`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`setMenuItemGroupDivider`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA|
|`setSubMenuExpandingMode`|Function|Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*MenuItem*| *Component* |Morozov Sergey| blocked IDL |  |  |
|`construct`| Function |Kovalev Sergey| blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD + |
|`setMenuItemOptions`| Function |Kovalev Sergey| blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD + |
|`setSelected`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setSelectIcon`| Function |Morozov Sergey| blocked IDL | test blocked IDL | https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB |
|`setOnChange`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setContentFont`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setContentFontColor`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setLabelFont`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setLabelFontColor`| Function |Morozov Sergey| done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*MenuItemGroup*| *Component* |Morozov Sergey | done |  |  |
|`construct`| Function |Morozov Sergey | done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMenuItemGroupOptions`| Function | Dmitry A Smirnov | done | test blocked | test blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|*NavDestination*| *Component* | managed side | managed side | test blocked | OHOSUI-2171 |
|`construct`| Function |Kovalev Sergey | done | test blocked | OHOSUI-2171 |
|`setNavDestinationOptions`| Function |Kovalev Sergey | done | test blocked |  |
|`setHideTitleBar0`| Function |Kovalev Sergey | done | test blocked |   |
|`setHideBackButton`| Function | managed side | managed side | test blocked| |
|`setOnShown`| Function |Kovalev Sergey | done | test blocked |  |
|`setOnHidden`| Function |Kovalev Sergey | done | test blocked |   |
|`setOnBackPressed`| Function |Dudkin Sergey | done | test blocked |  |
|`setOnResult`| Function |  |  |  |  |  |  |
|`setMode`| Function |Kovalev Sergey | done | test blocked |   |
|`setBackButtonIcon0`| Function | managed side | managed side | test blocked | |
|`setBackButtonIcon1`| Function | managed side | managed side | test blocked |  |
|`setMenus0`| Function | managed side | managed side | test blocked |  |
|`setMenus1`| Function | managed side | managed side | test blocked |  |
|`setOnReady`| Function | managed side | managed side | test blocked |  |
|`setOnWillAppear`| Function |Kovalev Sergey | done |  | test blocked |
|`setOnWillDisappear`| Function |Kovalev Sergey | done | test blocked |  |
|`setOnWillShow`| Function |Kovalev Sergey | done | test blocked |   |
|`setOnWillHide`| Function | Kovalev Sergey | done | test blocked |   |
|`setSystemBarStyle`| Function |Kovalev Sergey | blocked IDL | test blocked |  https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`setRecoverable`| Function |Kovalev Sergey | done | test blocked |   |
|`setSystemTransition`| Function | managed side | managed side | test blocked |  |
|`setBindToScrollable`| Function | managed side|managed side | test blocked| |
|`setBindToNestedScrollable`| Function | managed side| managed side| test blocked| |
|`setOnActive`| Function |managed side |managed side | test blocked| |
|`setOnInactive`| Function | managed side|managed side | test blocked| |
|`setCustomTransition`| Function | managed side|managed side | test blocked| |
|`setOnNewParam`| Function |managed side |managed side | test blocked| |
|`setPreferredOrientation`| Function |managed side |managed side | test blocked| |
|`setEnableNavigationIndicator`| Function |managed side |managed side |test blocked | |
|`setTitle`| Function | managed side | managed side | test blocked |  |
|`setHideTitleBar1`| Function |Kovalev Sergey | done | test blocked |   |
|`setToolbarConfiguration`| Function | managed side | managed side | test blocked |  |
|`setHideToolBar`| Function | managed side | managed side | test blocked |  |
|`setIgnoreLayoutSafeArea`| Function |Kovalev Sergey | done | test blocked |   |
|`setEnableStatusBar`| Function |managed side |managed side |test blocked | |
|*Navigation*| *Component* | | | | |
|`construct`| Function | | | | |
|`setNavigationOptions`| Function | | | | |
|`setNavBarWidth`| Function | | | | |
|`setNavBarPosition`| Function | | | | |
|`setNavBarWidthRange`| Function | | | | |
|`setMinContentWidth`| Function | | | | |
|`setMode`| Function | | | | |
|`setBackButtonIcon0`| Function | | | | |
|`setBackButtonIcon1`| Function | | | | |
|`setHideNavBar`| Function | | | | |
|`setHideTitleBar0`| Function | | | | |
|`setHideTitleBar1`| Function | | | | |
|`setHideBackButton`| Function | | | | |
|`setTitleMode`| Function | | | | |
|`setMenus0`| Function | | | | |
|`setMenus1`| Function | | | | |
|`setHideToolBar0`| Function | | | | |
|`setHideToolBar1`| Function | | | | |
|`setEnableToolBarAdaptation`| Function | | | | |
|`setOnTitleModeChange`| Function | | | | |
|`setOnNavBarStateChange`| Function | | | | |
|`setOnNavigationModeChange`| Function | | | | |
|`setNavDestination`| Function | | | | |
|`setCustomNavContentTransition`| Function | | | | |
|`setSystemBarStyle`| Function | | | | |
|`setRecoverable`| Function | | | | |
|`setEnableDragBar`| Function | | | | |
|`setEnableModeChangeAnimation`| Function | | | | |
|`setTitle`| Function | | | | |
|`setToolbarConfiguration`| Function | | | | |
|`setIgnoreLayoutSafeArea`| Function | | | | |
|*NodeContainer*| *Component* | Skroba Gleb | blocked IDL |  | |
|`construct`| Function | managed side | managed side | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|`setNodeContainerOptions`| Function |  managed side | managed side | test blocked | Compilation error: Cannot find type 'BuilderNode' |
|*Path*| *Component* | Skroba Gleb | done |  |  |
|`construct`| Function |Skroba Gleb | done |  |  |
|`setPathOptions`| Function | Skroba Gleb | done | pass |  |
|`setCommands`| Function | Skroba Gleb | done | pass |  |
|*PatternLock*| *Component* | Dmitry A Smirnov| in progress |  |  |
|`construct`| Function | Dmitry A Smirnov| done | pass |  |
|`setPatternLockOptions`| Function | Dmitry A Smirnov| done | pass |  |
|`setSideLength`| Function | Dmitry A Smirnov| done | pass |  |
|`setCircleRadius`| Function | Dmitry A Smirnov| done | pass |  |
|`setBackgroundColor`| Function | Dmitry A Smirnov| done |  |common method |
|`setRegularColor`| Function | Dmitry A Smirnov| done | pass |  |
|`setSelectedColor`| Function | Dmitry A Smirnov| done | pass |  |
|`setActiveColor`| Function | Dmitry A Smirnov| done | pass |  |
|`setPathColor`| Function | Dmitry A Smirnov| done | pass |  |
|`setPathStrokeWidth`| Function | Dmitry A Smirnov| done | pass |  |
|`setOnPatternComplete`| Function | Dmitry A Smirnov| done |  |  |
|`setAutoReset`| Function | Dmitry A Smirnov| done | pass |  |
|`setOnDotConnect`| Function | Dmitry A Smirnov| done |  |  |
|`setActivateCircleStyle`| Function | Dmitry A Smirnov| done |  | |
|`setSkipUnselectedPoint`| Function | Dmitry A Smirnov | done| | need merge to fb|
|*PluginComponent*| *Component* | Evstigneev Roman | done | blocked | Not compilable on SDK from 06.06.2025|
|`construct`| Function |Evstigneev Roman | done | blocked | E2E by Dudkin Sergey |
|`setPluginComponentOptions`| Function | Evstigneev Roman | done | blocked |  need merge to fb |
|`setOnComplete`| Function | Evstigneev Roman | done | blocked | E2E by Dudkin Sergey |
|`setOnError`| Function | Evstigneev Roman | done | blocked | E2E by Dudkin Sergey |
|*Polygon*| *Component* |Politov Mikhail | done |  | |
|`construct`| Function |Politov Mikhail | done | pass | |
|`setPolygonOptions`| Function | Politov Mikhail | done | pass | |
|`setPoints`| Function | Politov Mikhail | done | pass | |
|*Polyline*| *Component* | Politov Mikhail | done |  |  |
|`construct`| Function |Politov Mikhail | done | pass |  |
|`setPolylineOptions`| Function | Politov Mikhail | done | pass |  |
|`setPoints`| Function | Politov Mikhail | done | pass |  |
|*Progress*| *Component* | Erokhin Ilya | blocked IDL |  | |
|`construct`| Function | Erokhin Ilya | done | pass | deprecated for `style` property |
|`setProgressOptions`| Function | Erokhin Ilya | done | test blocked | deprecated for `style` property, test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setValue`| Function | Erokhin Ilya | done | test blocked | test blocked by runtime error in Koala part during setProgressOptions |
|`setColor`| Function | Erokhin Ilya | done | test blocked | test blocked by runtime error in Koala part during setProgressOptions |
|`setStyle`| Function | Erokhin Ilya | done | test blocked | UT by Vadim Voronov linearStyle.strokeRadius need to be tested, test blocked by runtime error in Koala part during setProgressOptions |
|`setPrivacySensitive`| Function | Erokhin Ilya | done | test blocked | test blocked by runtime error in Koala part during setProgressOptions |
|`setContentModifier`| Function | Erokhin Ilya | done | test blocked | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|*QRCode*| *Component* | Evstigneev Roman | done | pass  |  |
|`construct`| Function |Evstigneev Roman | done | pass |  |
|`setQRCodeOptions`| Function |Evstigneev Roman | done | pass |  |
|`setColor`| Function |Evstigneev Roman | testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZVOQ (+) or https://gitee.com/openharmony/arkui_ace_engine/issues/IBJUC2 |
|`setBackgroundColor`| Function |Evstigneev Roman | testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZVOQ (+) or https://gitee.com/openharmony/arkui_ace_engine/issues/IBJUC2 |
|`setContentOpacity`| Function |Evstigneev Roman | testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZVOQ (+) or https://gitee.com/openharmony/arkui_ace_engine/issues/IBJUC2 |
|*Radio*| *Component* | Evstigneev Roman | done |  |  |
|`construct`| Function |Evstigneev Roman | done | pass |  |
|`setRadioOptions`| Function | Dmitry A Smirnov | done | pass | CustomBuilder, test passed but differs with ArkUI behavior |
|`setChecked`| Function | Evstigneev Roman | done | pass |  |
|`setOnChange`| Function |  Evstigneev Roman | done | pass |  |
|`setRadioStyle`| Function | Evstigneev Roman | done | pass |  |
|`setContentModifier`| Function | Evstigneev Roman | done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|*Rating*| *Component* | Lobah Mikhail| done |  |  |
|`construct`| Function | Lobah Mikhail| done |  |  |
|`setRatingOptions`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`setStars`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`setStepSize`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`setStarStyle`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`setOnChange`| Function | Lobah Mikhail| done | failed | OHOSUI-2171 |
|`setContentModifier`| Function | Lobah Mikhail| done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*Rect*|*Component*|Dudkin Sergey| done |  |  |
|`construct`| Function |Dudkin Sergey| done |  |  |
|`setRectOptions`|Function|Dudkin Sergey| done | pass |  |
|`setRadiusWidth`|Function|Dudkin Sergey| done | pass |  |
|`setRadiusHeight`|Function|Dudkin Sergey| done | pass |  |
|`setRadius`|Function|Dudkin Sergey| done | pass |   |
|*Refresh*| *Component* |Politov Mikhail | blocked IDL | failed | OHOSUI-2196 |
|`construct`| Function |Samarin Sergey | blocked IDL | failed | is not called in demo; https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD ; offset, friction - deprecated + |
|`setRefreshOptions`| Function | Samarin Sergey | blocked IDL | failed | is not called in demo; https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD ; offset, friction - deprecated + |
|`setOnStateChange`| Function |Politov Mikhail | done | failed | is not called in demo |
|`setOnRefreshing`| Function |Politov Mikhail | done | failed | is not called in demo |
|`setRefreshOffset`| Function |Politov Mikhail | done | failed | is not called in demo |
|`setPullToRefresh`| Function |Politov Mikhail | done | failed | is not called in demo |
|`setOnOffsetChange`| Function |Politov Mikhail | done | failed | Ois not called in demo |
|`setPullDownRatio`| Function |Politov Mikhail | done | failed | is not called in demo |
|*RelativeContainer*| *Component* | Dmitry A Smirnov | done | blocked |  https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Dmitry A Smirnov | done |  |  |
|`setRelativeContainerOptions`| Function | Dmitry A Smirnov | done | | |
|`setGuideLine`| Function | Dmitry A Smirnov | done | blocked | LinkerUnresolvedClassError message: arkui.component.common.arkui$component$common$AlignRuleParam|
|`setBarrier`| Function |Dmitry A Smirnov | done | blocked | LinkerUnresolvedClassError message: arkui.component.common.arkui$component$common$AlignRuleParam|
|*RemoteWindow*| *Component* | Spirin Andrey | done |  | |
|`construct`| Function |Spirin Andrey | done |  | |
|`setRemoteWindowOptions`| Function | Spirin Andrey | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 (+) |
|*RichEditor*| *Component* | Dudkin Sergey| testskipped | Alexander Porodin |  |
|`construct`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setRichEditorOptions`| Function | Dudkin Sergey| done |  |  |
|`setOnReady`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setOnSelect`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import  |
|`setOnSelectionChange`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setAboutToIMEInput`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setOnIMEInputComplete`| Function | Dudkin Sergey | testskipped | test blocked | reopened after refactoring methods, Compilation issue on RichEditor import |
|`setOnDidIMEInput`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setAboutToDelete`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setOnDeleteComplete`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setCopyOptions`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setOnPaste`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setEnableDataDetector`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setEnablePreviewText`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setDataDetectorConfig`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setCaretColor`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setSelectedBackgroundColor`| Function | Dudkin Sergey| done | test blocked | Compilation issue on RichEditor import |
|`setOnEditingChange`| Function | Dudkin Sergey| done |  |  |
|`setEnterKeyType`| Function | Dudkin Sergey| done |  |  |
|`setOnSubmit`| Function | Dudkin Sergey | done |  |  |
|`setOnWillChange`| Function | Dudkin Sergey| done |  |  |
|`setOnDidChange`| Function | Dudkin Sergey| done |  |  |
|`setOnCut`| Function | Dudkin Sergey | testskipped |  | reopened after refactoring methods |
|`setOnCopy`| Function | Dudkin Sergey | testskipped |  | reopened after refactoring methods |
|`setEditMenuOptions`| Function | Pavelyev Ivan | done |  |  |
|`setEnableKeyboardOnFocus`| Function | Dudkin Sergey| done |  |  |
|`setEnableHapticFeedback`| Function | Dudkin Sergey| done |  | not supported by dayu200; need to test on mobile device |
|`setBarState`| Function | Dudkin Sergey| done |  |  |
|`setMaxLength`| Function | Lobah Mikhail| done| | not exists on FB|
|`setMaxLines`| Function | Lobah Mikhail| done| | not exists on FB|
|`setKeyboardAppearance`| Function | Dudkin Sergey|done | | needs merging to FB|
|`setStopBackPress`| Function | Dudkin Sergey| done | | needs merging to FB|
|`setBindSelectionMenu`| Function | Dmitry A Smirnov| done |  |  |
|`setCustomKeyboard`| Function | Dmitry A Smirnov| done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, Cannot find method 'customKeyboard |
|`setPlaceholder`| Function | Dudkin Sergey| done | failed | pass for String, failed for resourceStr |
|*RichText*| *Component* | Dudkin Sergey| done | pass |  |
|`construct`| Function | Dudkin Sergey| done | pass |  |
|`setRichTextOptions`| Function | Dudkin Sergey| done | pass |  |
|`setOnStart`| Function | Dudkin Sergey| done | pass |  |
|`setOnComplete`| Function | Dudkin Sergey| done | pass |  |
|*RootScene*| *Component* | Spirin Andrey | done |  | |
|`construct`| Function |Spirin Andrey | done |  | |
|`setRootSceneOptions`| Function | Spirin Andrey | done |  | |
|*Row*| *Component* | Andrey Khudenkikh | done |  |  |
|`construct`| Function |Andrey Khudenkikh | done |  |  |
|`setRowOptions`| Function | Andrey Khudenkikh | done | pass |  |
|`setAlignItems`| Function | Andrey Khudenkikh | done | pass |  |
|`setJustifyContent`| Function | Andrey Khudenkikh | done | pass |  |
|`setPointLight`| Function | Evstigneev Roman | done | failed | UT by Evstigneev Roman, method does not work |
|`setReverse`| Function | Andrey Khudenkikh | done | pass |  |
|*RowSplit*| *Component* | Dmitry A Smirnov| done |  | |
|`construct`| Function | Dmitry A Smirnov| done |  | |
|`setRowSplitOptions`| Function | Dmitry A Smirnov| done | failed | OHOSUI-2201 Text in rowSplit does not appear |
|`setResizeable`| Function | Dmitry A Smirnov| done | failed | OHOSUI-2202 resizeable does not work |
|*Screen*| *Component* | Dudkin Sergey | done |  | |
|`construct`| Function | Dudkin Sergey | done |  | |
|`setScreenOptions`| Function | Dudkin Sergey | done |  | |
|*Scroll*| *Component* | Berezin Kirill | done |  |  |
|`construct`| Function |Berezin Kirill | done |  |  |
|`setScrollOptions`| Function | Berezin Kirill | done |  |  |
|`setScrollable`| Function | Berezin Kirill | done |  |  |
|`setOnWillScroll`| Function | Berezin Kirill | done |  |   |
|`setOnDidScroll`| Function | Berezin Kirill | done |  |    |
|`setOnScrollEdge`| Function | Berezin Kirill | done |  |  |
|`setOnScrollStart`| Function | Berezin Kirill | done |  |  |
|`setOnScrollStop`| Function | Berezin Kirill | done |  |  |
|`setScrollBar`| Function | Berezin Kirill | done |  |  |
|`setScrollBarColor`| Function | Berezin Kirill | done |  |  |
|`setScrollBarWidth`| Function | Berezin Kirill | done |  |  |
|`setOnScrollFrameBegin`| Function | Dudkin Sergey | done | failed | |
|`setNestedScroll`| Function | Berezin Kirill | done |  |  |
|`setEnableScrollInteraction`| Function | Berezin Kirill | done |  |  |
|`setFriction`| Function | Berezin Kirill | done | pass |  |
|`setScrollSnap`| Function | Berezin Kirill | done |  |  |
|`setEnablePaging`| Function | Berezin Kirill | done |  |  |
|`setInitialOffset`| Function | Berezin Kirill | done |  |  |
|`setEdgeEffect`| Function | Berezin Kirill | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*ScrollBar*| *Component* | Maksimov Nikita | done |  | |
|`construct`| Function | Maksimov Nikita | done | pass | |
|`setScrollBarOptions`| Function | Maksimov Nikita | done | pass | |
|`setEnableNestedScroll`| Function | Maksimov Nikita | done |  | |
|*Search*|*Component*| Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function |Evstigneev Roman | done | pass |   |
|`setSearchOptions`|Function| Evstigneev Roman | done | pass |   |
|`setFontColor`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setSearchIcon`|Function| Evstigneev Roman | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IAYXQ8 (+)|
|`setCancelButton`|Function| Evstigneev Roman | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB |
|`setTextIndent`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setOnEditChange`|Function| Evstigneev Roman | done |  |  |
|`setSelectedBackgroundColor`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setCaretStyle`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setPlaceholderColor`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setPlaceholderFont`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setTextFont`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setEnterKeyType`|Function| Evstigneev Roman | done |  |  |
|`setOnSubmit`| Function |Evstigneev Roman | done |  |  |
|`setOnChange`|Function| Evstigneev Roman | done |  |  |
|`setOnTextSelectionChange`|Function| Evstigneev Roman | done |  |  |
|`setOnContentScroll`|Function| Evstigneev Roman | done |  |  |
|`setOnCopy`|Function| Evstigneev Roman | done |  |  |
|`setOnCut`|Function| Evstigneev Roman | done |  |  |
|`setOnPaste`|Function| Evstigneev Roman | done |  |  |
|`setCopyOption`|Function| Evstigneev Roman | done |  |  |
|`setMaxLength`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setTextAlign`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setEnableKeyboardOnFocus`|Function| Evstigneev Roman | done |  |  |
|`setSelectionMenuHidden`|Function| Evstigneev Roman | done |  |  |
|`setMinFontSize`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setMaxFontSize`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setMinFontScale`| Function | Kovalev Sergey | done | Pavelyev Ivan | |
|`setMaxFontScale`| Function | Kovalev Sergey | done | Pavelyev Ivan | |
|`setDecoration`|Function| Evstigneev Roman | done | pass |  |
|`setLetterSpacing`|Function| Evstigneev Roman | done | pass |  |
|`setLineHeight`|Function| Evstigneev Roman | done | pass |  |
|`setType`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setFontFeature`|Function| Evstigneev Roman | done | Pavelyev Ivan |  |
|`setOnWillInsert`|Function| Skroba Gleb | done |  |   |
|`setOnDidInsert`|Function| Evstigneev Roman | done |  |  |
|`setOnWillDelete`|Function| Skroba Gleb | done |  |   |
|`setOnDidDelete`|Function| Evstigneev Roman | done |  |  |
|`setEditMenuOptions`|Function| Pavelyev Ivan | done |  |  |
|`setEnablePreviewText`|Function| Evstigneev Roman | done |  |  |
|`setEnableHapticFeedback`|Function|Evstigneev Roman| done |  | not supported by dayu200; need to test on mobile device |
|`setAutoCapitalizationMode`| Function | Evstigneev Roman | done | | no such API in generation 125 |
|`setHalfLeading`| Function | Kovalev Sergey | done |  | |
|`setStopBackPress`| Function | Kovalev Sergey | done |  | |
|`setOnWillChange`| Function | Kovalev Sergey| done | | |
|`setKeyboardAppearance`| Function | Kovalev Sergey|done | | |
|`setSearchButton`|Function| Evstigneev Roman | done |  |  |
|`setInputFilter`|Function| Evstigneev Roman | done |  |  |
|`setCustomKeyboard`|Function| Lobah Mikhail | done |  |   |
|*Select*| *Component* | Samarin Sergey | blocked IDL | test blocked | runtime error in Koala part during setSelectOptions |
|`construct`| Function | Samarin Sergey | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD + |
|`setSelectOptions` | Function | Samarin Sergey | blocked IDL | failed | https://gitee.com/nikolay-igotti/idlize/issues/IBC7UD +; runtime error in Arkoala part, issue https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setSelected`| Function | Samarin Sergey | done | test blocked |  |
|`setValue`| Function |Samarin Sergey | done | test blocked |  |
|`setFont`| Function |Samarin Sergey | done | test blocked |  |
|`setFontColor` | Function | Samarin Sergey | done | test blocked |  |
|`setSelectedOptionBgColor`| Function | Samarin Sergey | done | test blocked |  |
|`setSelectedOptionFont` | Function | Samarin Sergey | done | test blocked |  |
|`setSelectedOptionFontColor`| Function | Samarin Sergey | done | test blocked |  |
|`setOptionBgColor` | Function | Samarin Sergey | done | test blocked |  |
|`setOptionFont`| Function | Samarin Sergey | done | test blocked |  |
|`setOptionFontColor` | Function | Samarin Sergey | done | test blocked |  |
|`setOnSelect`| Function | Samarin Sergey | done | test blocked |  |
|`setSpace` | Function | Samarin Sergey | done | test blocked |  |
|`setArrowPosition`| Function | Samarin Sergey | done | test blocked |  |
|`setOptionWidth` | Function | Samarin Sergey | done | test blocked |  |
|`setOptionHeight`| Function | Dmitry A Smirnov | done | test blocked | |
|`setMenuBackgroundColor` | Function | Samarin Sergey | done | test blocked |  |
|`setMenuBackgroundBlurStyle` | Function | Samarin Sergey | done | test blocked |  |
|`setControlSize` | Function | Samarin Sergey | done | test blocked |  |
|`setMenuItemContentModifier` | Function | Samarin Sergey | done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`setDivider` | Function | Samarin Sergey | done | test blocked |  |
|`setTextModifier`| Function | managed side | managed side |  | |
|`setArrowModifier`| Function | managed side | managed side | | https://gitee.com/nikolay-igotti/idlize/issues/IBREFA, https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB  |
|`setOptionTextModifier`| Function | managed side | managed side | | https://gitee.com/nikolay-igotti/idlize/issues/IBREFA, https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB  |
|`setSelectedOptionTextModifier`| Function | managed side | managed side | | https://gitee.com/nikolay-igotti/idlize/issues/IBREFA, https://gitee.com/nikolay-igotti/idlize/issues/IBIKVB  |
|`setDividerStyle`| Function | Evstigneev Roman | testskipped | | |
|`setAvoidance`| Function | Evstigneev Roman | testskipped | | |
|`setMenuOutline`| Function | Evstigneev Roman | testskipped | | |
|`setMenuAlign` | Function | Samarin Sergey | done | test blocked |  |
|*Shape*|*Component*|Dudkin Sergey| in progress |  |  |
|`construct`| Function |Samarin Sergey| testskipped | test blocked | method Shape() not found demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setShapeOptions`| Function |Samarin Sergey| testskipped | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setViewPort`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStroke`|Function|Dudkin Sergey| done | pass |  |
|`setFill`|Function|Dudkin Sergey| done | pass |  |
|`setStrokeDashOffset`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStrokeDashArray`|Function|Erokhin Ilya| done | pass |  |
|`setStrokeLineCap`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStrokeLineJoin`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStrokeMiterLimit`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStrokeOpacity`|Function|Dudkin Sergey| done | pass |  |
|`setFillOpacity`|Function|Dudkin Sergey| done | pass |  |
|`setStrokeWidth`|Function|Dudkin Sergey| done | pass |  |
|`setAntiAlias`|Function|Dudkin Sergey| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setMesh`|Function|Erokhin Ilya| done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*SideBarContainer*| *Component* |Dmitry A Smirnov|in progress|  |
|`construct`| Function |Dmitry A Smirnov| done |  |  |
|`setSideBarContainerOptions`| Function |Dmitry A Smirnov| done |  |  |
|`setShowSideBar`| Function |Dmitry A Smirnov| done | pass |  |
|`setControlButton`| Function |Dmitry A Smirnov| done |  | need submit to FB |
|`setShowControlButton`| Function |Dmitry A Smirnov| done | pass |  |
|`setOnChange`| Function |Dmitry A Smirnov| done |  |  |
|`setSideBarWidth`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`setMinSideBarWidth`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`setMaxSideBarWidth`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2169 |
|`setAutoHide`| Function |Dmitry A Smirnov| done | pass |  |
|`setSideBarPosition`| Function |Dmitry A Smirnov| done | pass |  |
|`setDivider`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2170 |
|`setMinContentWidth`| Function |Dmitry A Smirnov| done | failed | OHOSUI-2170 |
|*Slider*| *Component* |Morozov Sergey | done |  |  |
|`construct`| Function |Morozov Sergey | done | pass |  |
|`setSliderOptions`| Function |Morozov Sergey | done | pass |  |
|`setBlockColor`| Function |Morozov Sergey | done | pass |  |
|`setTrackColor`| Function |Morozov Sergey | testskipped | pass | AceEngine won't fix, https://gitee.com/openharmony/arkui_ace_engine/issues/IBPH6O |
|`setSelectedColor`| Function |Morozov Sergey |done  | pass |
|`setShowSteps`| Function |Morozov Sergey | done | pass |  |
|`setTrackThickness`| Function |Morozov Sergey | done | pass |  |
|`setOnChange`| Function |Morozov Sergey | done | pass |  |
|`setBlockBorderColor`| Function |Morozov Sergey | done | pass |  |
|`setBlockBorderWidth`| Function |Morozov Sergey | done | pass |  |
|`setStepColor`| Function |Morozov Sergey | done | pass |  |
|`setTrackBorderRadius`| Function |Morozov Sergey | done | pass |  |
|`setSelectedBorderRadius`| Function |Morozov Sergey | done | pass |  |
|`setBlockSize`| Function |Morozov Sergey | done | pass |  |
|`setBlockStyle`| Function |Morozov Sergey | blocked IDL | test blocked | TBD |
|`setStepSize`| Function |Morozov Sergey | done | pass |  |
|`setSliderInteractionMode`| Function |Morozov Sergey | done | pass |  |
|`setMinResponsiveDistance`| Function |Morozov Sergey | done | pass |  |
|`setContentModifier`| Function |Morozov Sergey | done | test blocked | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|`setSlideRange`| Function | Morozov Sergey | done | pass |  |
|`setDigitalCrownSensitivity`| Function | Kovalev Sergey | done | | |
|`setEnableHapticFeedback`| Function | Kovalev Sergey | done |  | not supported by dayu200; need to test on mobile device |
|`setShowTips`| Function |Morozov Sergey | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*BaseSpan*| *Component* |Politov Mikhail | done |  |  |
|`construct`| Function |Politov Mikhail | done | pass |  |
|`setTextBackgroundStyle`| Function | Politov Mikhail | done | pass |  |
|`setBaselineOffset`| Function | Politov Mikhail | done |  |  |
|*Span*| *Component* | Politov Mikhail | done | pass |  |
|`construct`| Function |Politov Mikhail | done | pass |  |
|`setSpanOptions`| Function |Politov Mikhail | done | pass |  |
|`setFont`| Function | Politov Mikhail | done | pass |  |
|`setFontColor`| Function |Politov Mikhail | done | pass |  |
|`setFontSize`| Function |Politov Mikhail | done | Olga Daryina |  |
|`setFontStyle`| Function |Politov Mikhail | done | pass |  |
|`setFontWeight`|Function||||
|`setFontFamily`| Function |Politov Mikhail | done | Olga Daryina |  |
|`setDecoration`| Function | Politov Mikhail | done | pass |  |
|`setLetterSpacing`|Function||||
|`setTextCase`| Function | Politov Mikhail | done | pass |  |
|`setLineHeight`| Function | Politov Mikhail | done | pass |  |
|`setTextShadow`| Function | Politov Mikhail | testskipped | Olga Daryina | test blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IB1K3Z |
|*Stack*| *Component* | Korobeinikov Evgeny | done | pass |  |
|`construct`| Function |Korobeinikov Evgeny | done | pass |  |
|`setStackOptions` | Function | Korobeinikov Evgeny | done | pass |  |
|`setAlignContent` | Function | Korobeinikov Evgeny | done | pass |  |
|`setPointLight` | Function | Evstigneev Roman | done |  |  UT by Evstigneev Roman |
|*Stepper*| *Component* | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`construct`| Function |Morozov Sergey | done | |  |
|`setStepperOptions`| Function | Morozov Sergey | done |  |  |
|`setOnFinish`| Function | Morozov Sergey | done |  |  |
|`setOnSkip`| Function | Morozov Sergey | done |  |  |
|`setOnChange`| Function | Morozov Sergey | done |  |  |
|`setOnNext`| Function | Morozov Sergey | done |  |  |
|`setOnPrevious`| Function | Morozov Sergey | done |  |  |
|*StepperItem*| *Component* | Morozov Sergey | done |  | |
|`construct`| Function |Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStepperItemOptions`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setPrevLabel`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setNextLabel`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setStatus`| Function | Morozov Sergey | done | test blocked | demo blocked https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*Swiper*| *Component* | Skroba Gleb | done |  |  |
|`construct`| Function |Skroba Gleb | done | pass  |  |
|`setSwiperOptions`| Function | Skroba Gleb | done | pass  |  |
|`setIndex`| Function | Skroba Gleb| done | pass |  |
|`setInterval`| Function | Skroba Gleb| done | pass |  |
|`setIndicator`| Function |  Skroba Gleb| done | pass |  |
|`setLoop`| Function | Skroba Gleb| done | pass |  |
|`setDuration`| Function | Skroba Gleb | done | pass |  |
|`setVertical`| Function | Skroba Gleb | done | pass |  |
|`setItemSpace`| Function | Skroba Gleb | done | pass |  |
|`setDisplayMode`| Function | Skroba Gleb| done | pass |  |
|`setCachedCount0`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setCachedCount1`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setEffectMode`| Function | Skroba Gleb | done | pass |  |
|`setDisableSwipe`| Function | Skroba Gleb| done | pass |  |
|`setCurve`| Function | Skroba Gleb| done | pass |  |
|`setOnChange`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnSelected`| Function | Pavelyev Ivan | done | test blocked | |
|`setOnUnselected`| Function | Pavelyev Ivan | done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnAnimationStart`| Function | Skroba Gleb| done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnAnimationEnd`| Function | Skroba Gleb | done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnGestureSwipe`| Function | Skroba Gleb | done | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setNestedScroll`| Function | Skroba Gleb| testskipped | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IB3ULZ |
|`setCustomContentTransition`| Function | Skroba Gleb | done |  | |
|`setOnContentDidScroll`| Function | Skroba Gleb| done |  | |
|`setIndicatorInteractive`| Function | Skroba Gleb| done | pass  |  |
|`setPageFlipMode`| Function | Lobah Mikhail| done | | Not exists on FB|
|`setOnContentWillScroll`| Function | Pavelyev Ivan | done | | |
|`setAutoPlay1`| Function | Skroba Gleb| done | pass |  |
|`setDisplayArrow`| Function | Skroba Gleb| done | pass |  |
|`setDisplayCount`| Function |Skroba Gleb | done | pass |  |
|`setPrevMargin`| Function | Skroba Gleb| done | pass |  |
|`setNextMargin`| Function | Skroba Gleb | done | pass |  |
|*SymbolGlyph*| *Component* |Andrey Khudenkikh | blocked IDL |  |  |
|`construct`| Function |Andrey Khudenkikh | done |  |  |
|`setSymbolGlyphOptions`| Function |Andrey Khudenkikh | done | pass |  |
|`setFontSize`| Function |Andrey Khudenkikh | done | pass |  |
|`setFontColor`| Function |Andrey Khudenkikh | done | pass |  |
|`setFontWeight`| Function |Andrey Khudenkikh | done | pass |  |
|`setEffectStrategy`| Function |Andrey Khudenkikh | done |  |  |
|`setRenderingStrategy`| Function |Andrey Khudenkikh | done |  |  |
|`setMinFontScale`| Function | Kovalev Sergey | done  | |
|`setMaxFontScale`| Function | Kovalev Sergey | done  | |
|`setSymbolEffect`| Function |Andrey Khudenkikh | done |  |  |
|*SymbolSpan*| *Component* |Dmitry A Smirnov| done |  |  |
|`construct`| Function |Dmitry A Smirnov| done | pass |  |
|`setSymbolSpanOptions`| Function |Dmitry A Smirnov| done | pass |   |
|`setFontSize`| Function |Dmitry A Smirnov| done | pass |  |
|`setFontColor`| Function |Dmitry A Smirnov| done | pass |  |
|`setFontWeight`| Function |Dmitry A Smirnov| done | pass |  |
|`setEffectStrategy`| Function |Dmitry A Smirnov| done |  |  |
|`setRenderingStrategy`| Function |Dmitry A Smirnov| done |  |  |
|*TabContent*| *Component* | Evstigneev Roman | blocked IDL |  |  |
|`construct`| Function | Evstigneev Roman | done | pass |  |
|`setTabContentOptions`| Function | Evstigneev Roman | done |  |  |
|`setTabBar`| Function | Evstigneev Roman | done | pass |  |
|`setOnWillShow`| Function |Evstigneev Roman | done |  |  |
|`setOnWillHide`| Function |Evstigneev Roman | done |  |  |
|*Tabs*| *Component* | Tuzhilkin Ivan | done |  |  |
|`construct`| Function |Tuzhilkin Ivan | done | pass |  |
|`setTabsOptions`| Function | Skroba Gleb | done | pass |  |
|`setVertical`| Function | Tuzhilkin Ivan | done | pass |  |
|`setBarPosition`| Function | Tuzhilkin Ivan | done | pass |  |
|`setScrollable`| Function | Tuzhilkin Ivan | done | pass |  |
|`setBarWidth`| Function | Tuzhilkin Ivan | done | pass |  |
|`setBarHeight`| Function | Tuzhilkin Ivan | done  | pass |
|`setAnimationDuration`| Function | Tuzhilkin Ivan | done | failed | |
|`setAnimationMode`| Function | Tuzhilkin Ivan | done | failed |  |
|`setEdgeEffect`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`setOnChange`| Function | Tuzhilkin Ivan | done | pass |  |
|`setOnSelected`| Function |Erokhin Ilya | done | pass | |
|`setOnTabBarClick`| Function | Tuzhilkin Ivan | done |  |  |
|`setOnUnselected`| Function |Erokhin Ilya | done | pass | |
|`setOnAnimationStart`| Function | Tuzhilkin Ivan | done | failed |  |
|`setOnAnimationEnd`| Function | Tuzhilkin Ivan | done | failed |  |
|`setOnGestureSwipe`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`setFadingEdge`| Function | Tuzhilkin Ivan | done | pass |  |
|`setDivider`| Function | Tuzhilkin Ivan | done | failed |  |
|`setBarOverlap`| Function | Tuzhilkin Ivan | done | pass |  |
|`setBarBackgroundColor`| Function | Tuzhilkin Ivan | done | pass |  |
|`setBarGridAlign`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh |  |
|`setCustomContentTransition`| Function | Dudkin Sergey | done | Andrey Khudenkikh |  |
|`setBarBackgroundBlurStyle0`|  Function | Tuzhilkin Ivan | done |  |  |
|`setPageFlipMode`| Function | Lobah Mikhail| done| | Not exists on FB |
|`setBarBackgroundEffect`| Function | Tuzhilkin Ivan | done | Andrey Khudenkikh | |
|`setOnContentWillChange`| Function | Dudkin Sergey | done | Andrey Khudenkikh | |
|`setBarMode`| Function |Tuzhilkin Ivan | done | failed |  |
|`setCachedMaxCount`| Function | Erokhin Ilya| done | failed | |
|*Text*| *Component* | Samarin Sergey | blocked IDL |  | |
|`construct`| Function |  Kirill Kirichenko | done | pass |  |
|`setTextOptions`| Function | Kirill Kirichenko | done | pass  |  |
|`setFontColor`| Function |Samarin Sergey | done | pass |  |
|`setFontSize`| Function |Samarin Sergey | done | Olga Daryina |  |
|`setMinFontSize`| Function |Samarin Sergey | done | pass |  |
|`setMaxFontSize`| Function |Samarin Sergey | done | pass |  |
|`setMinFontScale`| Function |Samarin Sergey | done | pass |  |
|`setMaxFontScale`| Function |Samarin Sergey | done | pass |  |
|`setFontStyle`| Function |Samarin Sergey | done | pass |  |
|`setLineSpacing`| Function |Samarin Sergey | done | pass |  |
|`setTextAlign`| Function |Samarin Sergey | done | pass |  |
|`setLineHeight`| Function |Samarin Sergey | done | pass |  |
|`setTextOverflow`| Function |Samarin Sergey | done | pass |  |
|`setFontFamily`| Function |Samarin Sergey | done | failed | OHOSUI-2187 |
|`setMaxLines`| Function |Samarin Sergey | done | pass |  |
|`setDecoration`| Function |Samarin Sergey | done | pass |  |
|`setLetterSpacing`| Function |Samarin Sergey | done | pass |  |
|`setTextCase`| Function |Samarin Sergey | done | pass |  |
|`setBaselineOffset`| Function |Samarin Sergey | done | pass |  |
|`setCopyOption`| Function |Samarin Sergey | done | pass |  |
|`setDraggable`| Function |Samarin Sergey | done | pass |  |
|`setTextShadow`| Function |Samarin Sergey | done | pass |  |
|`setHeightAdaptivePolicy`| Function |Samarin Sergey | done | pass |  |
|`setTextIndent`| Function |Samarin Sergey | done | pass |  |
|`setWordBreak`| Function | Samarin Sergey | done | pass |  |
|`setLineBreakStrategy`| Function |Samarin Sergey | done | pass |  |
|`setOnCopy`| Function | Kirill Kirichenko | done | pass |  |
|`setCaretColor`| Function |Samarin Sergey | done | pass |  |
|`setSelectedBackgroundColor`| Function |Samarin Sergey | done | pass |  |
|`setEllipsisMode`| Function |Samarin Sergey | done | pass |  |
|`setEnableDataDetector`| Function | Kirill Kirichenko | done | pass |  |
|`setDataDetectorConfig`| Function | Samarin Sergey | done | pass |  |
|`setOnTextSelectionChange`| Function | Kirill Kirichenko | done | pass |  |
|`setFontFeature`| Function |Samarin Sergey | done | pass |  |
|`setMarqueeOptions`| Function | Samarin Sergey | done |  | |
|`setOnMarqueeStateChange`| Function | Samarin Sergey | done |  | |
|`setPrivacySensitive`| Function |Samarin Sergey | done | pass |  |
|`setTextSelectable`| Function |Samarin Sergey | done | pass |  |
|`setEditMenuOptions`| Function | Pavelyev Ivan | done |  |  |
|`setHalfLeading`| Function |Samarin Sergey | done | pass |  |
|`setEnableHapticFeedback`| Function |Samarin Sergey | done |  | not supported by dayu200; need to test on mobile device |
|`setFont`| Function |Samarin Sergey | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setFontWeight`| Function | Samarin Sergey | done | failed |  |
|`setSelection`| Function |Samarin Sergey | done | pass | |
|`setBindSelectionMenu`| Function | Lobah Mikhail | done |  |  |
|*TextArea*|*Component*|Tuzhilkin Ivan| done |  |  |
|`construct`| Function | Tuzhilkin Ivan| done | pass | |
|`setTextAreaOptions`|Function|Tuzhilkin Ivan| done | pass | |
|`setPlaceholderColor`|Function|Tuzhilkin Ivan| done | pass | |
|`setPlaceholderFont`|Function|Tuzhilkin Ivan| done | pass | |
|`setEnterKeyType`|Function|Tuzhilkin Ivan| done | pass |  |
|`setTextAlign`|Function|Tuzhilkin Ivan| done | pass |  |
|`setCaretColor`|Function|Tuzhilkin Ivan| done | pass |  |
|`setFontColor`|Function|Tuzhilkin Ivan| done | pass |  |
|`setFontSize`|Function|Tuzhilkin Ivan| done | pass |  |
|`setFontStyle`|Function|Tuzhilkin Ivan| done | pass |  |
|`setFontWeight`|Function|Tuzhilkin Ivan| done | pass |  |
|`setFontFamily`|Function|Tuzhilkin Ivan| done | pass |  |
|`setTextOverflow`|Function|Tuzhilkin Ivan| done | failed |  |
|`setTextIndent`|Function|Tuzhilkin Ivan| done | pass |  |
|`setCaretStyle`|Function|Tuzhilkin Ivan| done | pass |  |
|`setSelectedBackgroundColor`|Function|Tuzhilkin Ivan| done | pass | |
|`setOnSubmit`| Function | Tuzhilkin Ivan| done | not covered |  |
|`setOnChange`|Function|Tuzhilkin Ivan| done | pass | not covered |
|`setOnTextSelectionChange`|Function|Tuzhilkin Ivan| done | not covered | |
|`setOnContentScroll`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setOnEditChange`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setOnCopy`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setOnCut`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setOnPaste`|Function|Tuzhilkin Ivan| done | not covered | |
|`setCopyOption`|Function|Tuzhilkin Ivan| done | pass |  |
|`setEnableKeyboardOnFocus`|Function|Tuzhilkin Ivan| done | pass |  |
|`setMaxLength`|Function|Tuzhilkin Ivan| done | pass |  |
|`setStyle`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setBarState`|Function|Tuzhilkin Ivan| done | pass |  |
|`setSelectionMenuHidden`|Function|Tuzhilkin Ivan| done | pass |  |
|`setMinFontSize`|Function|Tuzhilkin Ivan| done | pass |  |
|`setMaxFontSize`|Function|Tuzhilkin Ivan| done | pass |  |
|`setMinFontScale`| Function | Kovalev Sergey | done | not covered | |
|`setMaxFontScale`| Function | Kovalev Sergey | done | not covered | |
|`setHeightAdaptivePolicy`|Function|Tuzhilkin Ivan| done | pass |  |
|`setMaxLines`|Function|Tuzhilkin Ivan| done | pass |  |
|`setWordBreak`|Function|Tuzhilkin Ivan| done | pass |  |
|`setLineBreakStrategy`|Function|Tuzhilkin Ivan| done | pass |  |
|`setDecoration`|Function|Tuzhilkin Ivan| done | pass |  |
|`setLetterSpacing`|Function|Tuzhilkin Ivan| done | pass |  |
|`setLineSpacing`|Function|Tuzhilkin Ivan| done | pass | |
|`setLineHeight`|Function|Tuzhilkin Ivan| done | pass | |
|`setType`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setEnableAutoFill`|Function|Tuzhilkin Ivan| done | pass |  |
|`setContentType`|Function|Tuzhilkin Ivan| done | failed |  |
|`setFontFeature`|Function|Tuzhilkin Ivan| done | pass |  |
|`setOnWillInsert`|Function| Skroba Gleb | done | not covered |   |
|`setOnDidInsert`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setOnWillDelete`|Function| Skroba Gleb | done | not covered |   |
|`setOnDidDelete`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setEditMenuOptions`|Function| Pavelyev Ivan | done | not covered |  |
|`setEnablePreviewText`|Function|Tuzhilkin Ivan| done | not covered |  |
|`setEnableHapticFeedback`|Function|Tuzhilkin Ivan| done |  | not supported by dayu200; need to test on mobile device |
|`setAutoCapitalizationMode`| Function | Evstigneev Roman | done | not covered | no such API in generation 125 |
|`setHalfLeading`| Function | Kovalev Sergey | done | not covered | |
|`setEllipsisMode`| Function | Kovalev Sergey | done | not covered | |
|`setStopBackPress`| Function | Kovalev Sergey | done | not covered | |
|`setOnWillChange`| Function | Erokhin Ilya | done | not covered | |
|`setKeyboardAppearance`| Function | Erokhin Ilya | done | not covered | |
|`setInputFilter`|Function|Tuzhilkin Ivan| done | test blocked  | blocked IDL |
|`setShowCounter`|Function|Tuzhilkin Ivan| done | pass |   |
|`setCustomKeyboard`|Function| Erokhin Ilya | done | not covered | UT by Vadim Voronov  |
|*TextClock*| *Component* |Pavelyev Ivan| blocked IDL |  |  |
|`construct`| Function |Pavelyev Ivan| done | pass |  |
|`setTextClockOptions`| Function |Pavelyev Ivan| done | pass |  |
|`setFormat0`| Function |Pavelyev Ivan| done | pass |  |
|`setFormat1`| Function |Pavelyev Ivan|  |  |  |
|`setOnDateChange`| Function |Pavelyev Ivan| done | not covered |  |
|`setFontColor`| Function |Pavelyev Ivan| done | pass |  |
|`setFontSize`| Function |Pavelyev Ivan| done | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IBT6PK |
|`setFontStyle`| Function |Pavelyev Ivan| done | pass |  |
|`setFontWeight`| Function |Pavelyev Ivan| done | pass |  |
|`setFontFamily`| Function |Pavelyev Ivan| done | pass | https://gitee.com/openharmony/arkui_ace_engine/issues/IBT6QC |
|`setTextShadow`| Function |Pavelyev Ivan| done | failed | https://gitee.com/openharmony/arkui_ace_engine/issues/IBT6PK, when ShadowOptions is empty cpp crash happen |
|`setFontFeature`| Function |Pavelyev Ivan| done |  |  |
|`setContentModifier`| Function |Pavelyev Ivan| done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|`setDateTimeOptions`| Function |Politov Mikhail| testskipped |  |  |
|*TextInput*| *Component* | Spirin Andrey | in progress |  |  |
|`construct`| Function | Spirin Andrey | done | pass | |
|`setTextInputOptions`| Function | Spirin Andrey | done | pass | |
|`setType`| Function | Spirin Andrey | done | pass |  |
|`setContentType`| Function | Spirin Andrey | done |  |  |
|`setPlaceholderColor`| Function | Spirin Andrey | done | failed | info: placeholder is not displayed without any log error |
|`setTextOverflow`| Function | Lobah Mikhail| done|  |https://gitee.com/openharmony/arkui_ace_engine/issues/IB57XU|
|`setTextIndent`| Function | Spirin Andrey | done |  |  |
|`setPlaceholderFont`| Function | Spirin Andrey | testskipped | failed | info: placeholder is not displayed without any log error |
|`setEnterKeyType`| Function | Spirin Andrey | done | pass |  |
|`setCaretColor`| Function | Spirin Andrey | done | pass |  |
|`setOnEditChange`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setOnSubmit`| Function | Spirin Andrey | done |  | EVENT |
|`setOnChange`| Function | Lobah Mikhail | done | pass | UT done Lobah Mikhail  |
|`setOnTextSelectionChange`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setOnContentScroll`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setMaxLength`| Function | Spirin Andrey | done |  |  |
|`setFontColor`| Function | Spirin Andrey | done |  |  |
|`setFontSize`| Function | Spirin Andrey | done |  |  |
|`setFontStyle`| Function | Spirin Andrey | done |  |  |
|`setFontWeight`| Function | Spirin Andrey | done |  |  |
|`setFontFamily`| Function | Spirin Andrey | done |  |  |
|`setOnCopy`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setOnCut`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setOnPaste`| Function | Lobah Mikhail | done |  | UT done Lobah Mikhail |
|`setCopyOption`| Function | Spirin Andrey | done |  |  |
|`setShowPasswordIcon`| Function | Spirin Andrey | done |  |  |
|`setTextAlign`| Function | Spirin Andrey | done |  |  |
|`setStyle`| Function | Spirin Andrey | done |  |  |
|`setCaretStyle`| Function | Spirin Andrey | done |  |  |
|`setSelectedBackgroundColor`| Function | Spirin Andrey | done |  |  |
|`setCaretPosition`| Function | Spirin Andrey | done |  |  |
|`setEnableKeyboardOnFocus`| Function | Spirin Andrey | done |  |  |
|`setPasswordIcon`| Function | Spirin Andrey | done |  |  |
|`setShowError`| Function | Spirin Andrey | done |  |  |
|`setShowUnit`| Function | Erokhin Ilya | done |  | |
|`setShowUnderline`| Function | Spirin Andrey | done |  |  |
|`setUnderlineColor`| Function | Spirin Andrey | done |  |  |
|`setSelectionMenuHidden`| Function | Spirin Andrey | done |  |  |
|`setBarState`| Function | Spirin Andrey | done |  |  |
|`setMaxLines`| Function | Lobah Mikhail| done| |
|`setWordBreak`| Function | Spirin Andrey | done |  |  |
|`setLineBreakStrategy`| Function | Spirin Andrey | done |  |  |
|`setCancelButton`| Function | Spirin Andrey | done |  |  |
|`setSelectAll`| Function | Spirin Andrey | done |  |  |
|`setMinFontSize`| Function | Spirin Andrey | done  |  |
|`setMaxFontSize`| Function | Spirin Andrey | done  |  |
|`setMinFontScale`| Function | Kovalev Sergey | done |  | |
|`setMaxFontScale`| Function | Kovalev Sergey | done |  | |
|`setHeightAdaptivePolicy`| Function | Spirin Andrey | done |  |  |
|`setEnableAutoFill`| Function | Spirin Andrey | done |  |  |
|`setDecoration`| Function | Spirin Andrey | done |  | |
|`setLetterSpacing`| Function | Spirin Andrey | done |  | |
|`setLineHeight`| Function | Spirin Andrey | done |  | |
|`setPasswordRules`| Function | Spirin Andrey | done |  |  |
|`setFontFeature`| Function | Spirin Andrey | done |  | |
|`setShowPassword`| Function | Spirin Andrey | done |  |  |
|`setOnSecurityStateChange`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setOnWillInsert`| Function | Skroba Gleb | done |  |   |
|`setOnDidInsert`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setOnWillDelete`| Function | Skroba Gleb | done |  |   |
|`setOnDidDelete`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setEditMenuOptions`| Function | Pavelyev Ivan| done|  |  |
|`setEnablePreviewText`| Function | Spirin Andrey | done |  |  |
|`setEnableHapticFeedback`| Function | Spirin Andrey | done |  | not supported by dayu200; need to test on mobile device |
|`setAutoCapitalizationMode`| Function | Evstigneev Roman | done | | no such API in generation 125 |
|`setHalfLeading`| Function | Kovalev Sergey | done |  | |
|`setEllipsisMode`| Function |  Kovalev Sergey| done |  | |
|`setStopBackPress`| Function | Kovalev Sergey | done |  | |
|`setOnWillChange`| Function | Lobah Mikhail| done| | |
|`setKeyboardAppearance`| Function | Erokhin Ilya | done | | |
|`setInputFilter`| Function | Spirin Andrey | done |  | UT Kovalev Sergey |
|`setCustomKeyboard`| Function | Lobah Mikhail | done |  |   |
|`setShowCounter`| Function | Lobah Mikhail| done| | https://gitee.com/openharmony/arkui_ace_engine/issues/IB3V0N |
|*TextPicker*| *Component* | Ekaterina Stepanova | done | Ekaterina Stepanova |  |
|`construct`| Function | Tuzhilkin Ivan | done | pass |  |
|`setTextPickerOptions`| Function | Tuzhilkin Ivan | done | failed | OHOSUI-2386 multi column picker not working |
|`setDefaultPickerItemHeight`| Function | Ekaterina Stepanova | done | pass |  |
|`setCanLoop`| Function | Ekaterina Stepanova | done | pass |  |
|`setDisappearTextStyle`| Function | Ekaterina Stepanova | done | pass |  |
|`setTextStyle`| Function | Ekaterina Stepanova | done | pass |  |
|`setSelectedTextStyle`| Function | Ekaterina Stepanova | done | pass |  |
|`setDisableTextStyleAnimation`| Function | Kovalev Sergey | done | pass |  |
|`setDefaultTextStyle`| Function | Kovalev Sergey | done | pass |  |
|`setOnChange`| Function | Tuzhilkin Ivan | done | pass |  |
|`setOnScrollStop`| Function | Kovalev Sergey | done | pass |  |
|`setOnEnterSelectedArea`| Function | Kovalev Sergey | done | pass |  |
|`setSelectedIndex`| Function | Ekaterina Stepanova | done | blocked | Note: number type passed, need to check also with number[] once multi-column picker works (OHOSUI-2386) |
|`setDivider`| Function | Ekaterina Stepanova | done | blocked | API mismatch (image from 17.06.25) https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setGradientHeight`| Function | Ekaterina Stepanova | done | pass |  |
|`setEnableHapticFeedback`| Function | Kovalev Sergey | done | pass |  |
|`setDigitalCrownSensitivity`| Function | Kovalev Sergey | done | pass |  |
|*TextTimer*| *Component* |Ekaterina Stepanova| blocked IDL |  |  |
|`construct`| Function | Ekaterina Stepanova| done | pass |  |
|`setTextTimerOptions`| Function |Ekaterina Stepanova| done | pass |  |
|`setFormat`| Function |Ekaterina Stepanova| done | pass |  |
|`setFontColor`| Function |Ekaterina Stepanova| done | pass |  |
|`setFontSize`| Function |Ekaterina Stepanova| done | pass |  |
|`setFontStyle`| Function | Ekaterina Stepanova| done | pass |  |
|`setFontWeight`| Function |Ekaterina Stepanova| done | pass |  |
|`setFontFamily`| Function |Ekaterina Stepanova| done | pass  |  |
|`setOnTimer`| Function |Ekaterina Stepanova| blocked IDL | not covered | https://gitee.com/nikolay-igotti/idlize/issues/IB3V0H |
|`setTextShadow`| Function |Ekaterina Stepanova| testskipped | pass | UT blocked by https://gitee.com/openharmony/arkui_ace_engine/issues/IB2SZK |
|`setContentModifier`| Function |Ekaterina Stepanova| done | not covered | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7 |
|*TimePicker*| *Component* | Ekaterina Stepanova| blocked IDL |  |  |
|`construct`| Function |Politov Mikhail| done |  |  |
|`setTimePickerOptions`| Function |Politov Mikhail| done |  |  |
|`setUseMilitaryTime`| Function |Ekaterina Stepanova| done | pass |  |
|`setLoop`| Function |Ekaterina Stepanova| done | pass |  |
|`setDisappearTextStyle`| Function |Ekaterina Stepanova| done | pass |  |
|`setTextStyle`| Function |Ekaterina Stepanova| done | pass |  |
|`setSelectedTextStyle`| Function |Ekaterina Stepanova| done | pass |  |
|`setDateTimeOptions`| Function |Politov Mikhail| done |  | |
|`setOnChange`| Function |Ekaterina Stepanova| done | pass |  |
|`setOnEnterSelectedArea`| Function | Kovalev Sergey | done | pass | API is present on Upstream only |
|`setEnableHapticFeedback`| Function |Ekaterina Stepanova| done |  | not supported by dayu200; need to test on mobile device |
|`setDigitalCrownSensitivity`| Function | Kovalev Sergey | done | | API is present on Upstream only |
|`setEnableCascade`| Function | Kovalev Sergey | done | pass | API is present on Upstream only |
|*Toggle*| *Component* |Morozov Sergey |blocked IDL |  |
|`construct`| Function |Morozov Sergey | done | | unblocked since AceEngine won't fix it |
|`setToggleOptions`| Function |Morozov Sergey | done |  | unblocked since AceEngine won't fix it |
|`setOnChange`| Function | Morozov Sergey| done | pass |  |
|`setContentModifier`| Function |Morozov Sergey | done |  | removed from generation https://gitee.com/nikolay-igotti/idlize/issues/IAU9SG & https://gitee.com/rri_opensource/koala_projects/issues/IC1OJ7|
|`setSelectedColor`| Function | Morozov Sergey| done | pass |  |
|`setSwitchPointColor`| Function | Morozov Sergey| done | pass |  |
|`setSwitchStyle`| Function | Morozov Sergey| done | pass |  |
|*ToolBarItem*|*Component*||||
|`construct`|Function||||
|`setToolBarItemOptions`|Function||||
|*UIExtensionComponent*| *Component* | Tuzhilkin Ivan | blocked IDL |  | |
|`construct`| Function | Tuzhilkin Ivan | testskipped |  | |
|`setUIExtensionComponentOptions`| Function | Tuzhilkin Ivan |  |  | |
|`setOnRemoteReady`| Function | Tuzhilkin Ivan | testskipped |  | |
|`setOnReceive`| Function | Tuzhilkin Ivan |  |  | |
|`setOnError`| Function | Skroba Gleb | testskipped |  | |
|`setOnTerminated`| Function | Tuzhilkin Ivan | testskipped |  | |
| `setOnDrawReady` | Function |  |  |  |  |  |  |
|*Video*| *Component* | Erokhin Ilya | blocked AceEngine|  |  |
|`construct`| Function |Erokhin Ilya | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`setVideoOptions`| Function | Erokhin Ilya | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`setMuted`| Function | Erokhin Ilya | done | pass |  |
|`setAutoPlay`| Function | Erokhin Ilya | done | pass |  |
|`setControls`| Function | Erokhin Ilya | done | pass |  |
|`setLoop`| Function | Erokhin Ilya | done | pass |  |
|`setObjectFit`| Function | Erokhin Ilya | done | pass |  |
|`setOnStart`| Function | Erokhin Ilya | done | pass |  |
|`setOnPause`| Function | Erokhin Ilya | done | pass |  |
|`setOnFinish`| Function | Erokhin Ilya | done | pass |  |
|`setOnFullscreenChange`| Function | Erokhin Ilya | done | pass |  |
|`setOnPrepared`| Function | Erokhin Ilya | done | pass |  |
|`setOnSeeking`| Function | Erokhin Ilya | done | pass |  |
|`setOnSeeked`| Function | Erokhin Ilya | done | pass |  |
|`setOnUpdate`| Function | Erokhin Ilya | done | pass |  |
|`setOnError`| Function | Erokhin Ilya | done | pass |  |
|`setOnStop`| Function | Erokhin Ilya | done | pass |  |
|`setEnableAnalyzer`| Function | Erokhin Ilya | done | pass |  |
|`setAnalyzerConfig`| Function | Erokhin Ilya | blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`setEnableShortcutKey`| Function | Kovalev Sergey | done | pass | |
|*WaterFlow*| *Component* | Kovalev Sergey | done |  |  |
|`construct`| Function | Kovalev Sergey | done | pass | |
|`setWaterFlowOptions`| Function | Kovalev Sergey | done | pass | |
|`setColumnsTemplate`| Function | Kovalev Sergey | done | pass | |
|`setItemConstraintSize`| Function | Kovalev Sergey | done | | |
|`setRowsTemplate`| Function | Kovalev Sergey | done | | |
|`setColumnsGap`| Function | Kovalev Sergey | done | pass | |
|`setRowsGap`| Function |Kovalev Sergey | done | pass | |
|`setLayoutDirection`| Function |Kovalev Sergey | done | | |
|`setCachedCount0`| Function |Kovalev Sergey | done | | |
|`setCachedCount1`| Function | Kovalev Sergey | done | | |
|`setOnScrollFrameBegin`| Function | Dudkin Sergey | in progress | |
|`setOnScrollIndex`| Function | Kovalev Sergey | done | | |
|`setOnWillScroll`| Function | wangtao | done | | |
|`setOnDidScroll`| Function | wangtao | done | | |
|*Web*|*Component*|out of scope|out of scope|
|`construct`|Function|out of scope|out of scope|
|`setWebOptions`|Function|out of scope|out of scope|
|`setJavaScriptAccess`|Function|out of scope|out of scope|
|`setFileAccess`|Function|out of scope|out of scope|
|`setOnlineImageAccess`|Function|out of scope|out of scope|
|`setDomStorageAccess`|Function|out of scope|out of scope|
|`setImageAccess`|Function|out of scope|out of scope|
|`setMixedMode`|Function|out of scope|out of scope|
|`setZoomAccess`|Function|out of scope|out of scope|
|`setGeolocationAccess`|Function|out of scope|out of scope|
|`setJavaScriptProxy`|Function|out of scope|out of scope|
|`setCacheMode`|Function|out of scope|out of scope|
|`setDarkMode`|Function|out of scope|out of scope|
|`setForceDarkAccess`|Function|out of scope|out of scope|
|`setMediaOptions`|Function|out of scope|out of scope|
|`setOverviewModeAccess`|Function|out of scope|out of scope|
|`setOverScrollMode`|Function|out of scope|out of scope|
|`setBlurOnKeyboardHideMode`|Function|out of scope|out of scope|
|`setTextZoomRatio`|Function|out of scope|out of scope|
|`setDatabaseAccess`|Function|out of scope|out of scope|
|`setInitialScale`|Function|out of scope|out of scope|
|`setMetaViewport`|Function|out of scope|out of scope|
|`setOnPageEnd`|Function|out of scope|out of scope|
|`setOnPageBegin`|Function|out of scope|out of scope|
|`setOnLoadStarted`|Function|out of scope|out of scope|
|`setOnLoadFinished`|Function|out of scope|out of scope|
|`setOnProgressChange`|Function|out of scope|out of scope|
|`setOnTitleReceive`|Function|out of scope|out of scope|
|`setOnGeolocationHide`|Function|out of scope|out of scope|
|`setOnGeolocationShow`|Function|out of scope|out of scope|
|`setOnRequestSelected`|Function|out of scope|out of scope|
|`setOnAlert`|Function|out of scope|out of scope|
|`setOnBeforeUnload`|Function|out of scope|out of scope|
|`setOnConfirm`|Function|out of scope|out of scope|
|`setOnPrompt`|Function|out of scope|out of scope|
|`setOnConsole`|Function|out of scope|out of scope|
|`setOnErrorReceive`|Function|out of scope|out of scope|
|`setOnHttpErrorReceive`|Function|out of scope|out of scope|
|`setOnDownloadStart`|Function|out of scope|out of scope|
|`setOnRefreshAccessedHistory`|Function|out of scope|out of scope|
|`setOnRenderExited`|Function|out of scope|out of scope|
|`setOnShowFileSelector`|Function|out of scope|out of scope|
|`setOnResourceLoad`|Function|out of scope|out of scope|
|`setOnFullScreenExit`|Function|out of scope|out of scope|
|`setOnFullScreenEnter`|Function|out of scope|out of scope|
|`setOnScaleChange`|Function|out of scope|out of scope|
|`setOnHttpAuthRequest`|Function|out of scope|out of scope|
|`setOnInterceptRequest`|Function|out of scope|out of scope|
|`setOnPermissionRequest`|Function|out of scope|out of scope|
|`setOnScreenCaptureRequest`|Function|out of scope|out of scope|
|`setOnContextMenuShow`|Function|out of scope|out of scope|
|`setOnContextMenuHide`|Function|out of scope|out of scope|
|`setMediaPlayGestureAccess`|Function|out of scope|out of scope|
|`setOnSearchResultReceive`|Function|out of scope|out of scope|
|`setOnScroll`|Function|out of scope|out of scope|
|`setOnSslErrorEventReceive`|Function|out of scope|out of scope|
|`setOnSslErrorEvent`|Function|out of scope|out of scope|
|`setOnClientAuthenticationRequest`|Function|out of scope|out of scope|
|`setOnWindowNew`|Function|out of scope|out of scope|
|`setOnWindowExit`|Function|out of scope|out of scope|
|`setMultiWindowAccess`|Function|out of scope|out of scope|
|`setOnInterceptKeyEvent`|Function|out of scope|out of scope|
|`setWebStandardFont`|Function|out of scope|out of scope|
|`setWebSerifFont`|Function|out of scope|out of scope|
|`setWebSansSerifFont`|Function|out of scope|out of scope|
|`setWebFixedFont`|Function|out of scope|out of scope|
|`setWebFantasyFont`|Function|out of scope|out of scope|
|`setWebCursiveFont`|Function|out of scope|out of scope|
|`setDefaultFixedFontSize`|Function|out of scope|out of scope|
|`setDefaultFontSize`|Function|out of scope|out of scope|
|`setMinFontSize`|Function|out of scope|out of scope|
|`setMinLogicalFontSize`|Function|out of scope|out of scope|
|`setDefaultTextEncodingFormat`|Function|out of scope|out of scope|
|`setForceDisplayScrollBar`|Function|out of scope|out of scope|
|`setBlockNetwork`|Function|out of scope|out of scope|
|`setHorizontalScrollBarAccess`|Function|out of scope|out of scope|
|`setVerticalScrollBarAccess`|Function|out of scope|out of scope|
|`setOnTouchIconUrlReceived`|Function|out of scope|out of scope|
|`setOnFaviconReceived`|Function|out of scope|out of scope|
|`setOnPageVisible`|Function|out of scope|out of scope|
|`setOnDataResubmitted`|Function|out of scope|out of scope|
|`setPinchSmooth`|Function|out of scope|out of scope|
|`setAllowWindowOpenMethod`|Function|out of scope|out of scope|
|`setOnAudioStateChanged`|Function|out of scope|out of scope|
|`setOnFirstContentfulPaint`|Function|out of scope|out of scope|
|`setOnFirstMeaningfulPaint`|Function|out of scope|out of scope|
|`setOnLargestContentfulPaint`|Function|out of scope|out of scope|
|`setOnLoadIntercept`|Function|out of scope|out of scope|
|`setOnControllerAttached`|Function|out of scope|out of scope|
|`setOnOverScroll`|Function|out of scope|out of scope|
|`setOnSafeBrowsingCheckResult`|Function|out of scope|out of scope|
|`setOnNavigationEntryCommitted`|Function|out of scope|out of scope|
|`setOnIntelligentTrackingPreventionResult`|Function|out of scope|out of scope|
|`setJavaScriptOnDocumentStart`|Function|out of scope|out of scope|
|`setJavaScriptOnDocumentEnd`|Function|out of scope|out of scope|
|`setLayoutMode`|Function|out of scope|out of scope|
|`setNestedScroll`|Function|out of scope|out of scope|
|`setEnableNativeEmbedMode`|Function|out of scope|out of scope|
|`setOnNativeEmbedLifecycleChange`|Function|out of scope|out of scope|
|`setOnNativeEmbedVisibilityChange`|Function|out of scope|out of scope|
|`setOnNativeEmbedGestureEvent`|Function|out of scope|out of scope|
|`setCopyOptions`|Function|out of scope|out of scope|
|`setOnOverrideUrlLoading`|Function|out of scope|out of scope|
|`setTextAutosizing`|Function|out of scope|out of scope|
|`setEnableNativeMediaPlayer`|Function|out of scope|out of scope|
|`setOnRenderProcessNotResponding`|Function|out of scope|out of scope|
|`setOnRenderProcessResponding`|Function|out of scope|out of scope|
|`setOnViewportFitChanged`|Function|out of scope|out of scope|
|`setOnInterceptKeyboardAttach`|Function|out of scope|out of scope|
|`setOnAdsBlocked`|Function|out of scope|out of scope|
|`setKeyboardAvoidMode`|Function|out of scope|out of scope|
|`setEditMenuOptions`|Function|out of scope|out of scope|
|`setEnableHapticFeedback`|Function|out of scope|out of scope|
|`setOptimizeParserBudget`|Function|out of scope|out of scope|
|`setEnableFollowSystemFontWeight`|Function|out of scope|out of scope|
|`setEnableWebAVSession`|Function|out of scope|out of scope|
|`setRunJavaScriptOnDocumentStart`|Function|out of scope|out of scope|
|`setRunJavaScriptOnDocumentEnd`|Function|out of scope|out of scope|
|`setRunJavaScriptOnHeadEnd`|Function|out of scope|out of scope|
|`setNativeEmbedOptions`|Function|out of scope|out of scope|
|`setRegisterNativeEmbedRule`|Function|out of scope|out of scope|
|`setBindSelectionMenu`|Function|out of scope|out of scope|
|*WindowScene*| *Component* | Dudkin Sergey | done |  | |
|`construct`| Function |Dudkin Sergey | done |  | |
|`setWindowSceneOptions`| Function | Dudkin Sergey | done |  | |
|`setAttractionEffect`| Function | Dudkin Sergey  | done |  |  |
|*WithTheme*| *Component* | | |
|`construct`| Function | | |
|`setWithThemeOptions`| Function | | |
|*XComponent*| *Component* | Tuzhilkin Ivan | blocked IDL |  | |
|`construct`| Function |Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setXComponentOptions`| Function | Tuzhilkin Ivan | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IB8FFO, https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 (+), demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setOnLoad`| Function | Tuzhilkin Ivan | blocked IDL | test blocked | https://gitee.com/nikolay-igotti/idlize/issues/IB7RSS (+), demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`setOnDestroy`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setEnableAnalyzer`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setEnableSecure`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setEnableTransparentLayer`| Function  |                                  |                   |
|`setHdrBrightness`| Function | Tuzhilkin Ivan | testskipped | test blocked | supported only on UPSTREAM now, demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|*Root*| *Component* | Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|`construct`| Function | Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|*ComponentRoot*| *Component* | Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|`construct`| Function |Tuzhilkin Ivan | testskipped | | implementation is created early by Nikolay Pisanov |
|*CustomBuilderRoot*|*Component*||||
|`construct`|Function||||
| *ConditionScope*                                     | *Component* |                                  |                   |
|`construct`| Function    |                                  |                   |
|*CustomLayoutRoot*| *Component* | Erokhin Ilya | in progress | | |
|`construct`| Function | Erokhin Ilya | in progress | | |
|`setSubscribeOnMeasureSize`| Function | Erokhin Ilya | in progress | | |
|`setSubscribeOnPlaceChildren`| Function | Erokhin Ilya | in progress | | |
|*Ability*|*Class*||||
|`construct`|Function||||
|`onConfigurationUpdate`|Function||||
|`onMemoryLevel`|Function||||
|*AbilityInfo*                      |*Class*||||
|`construct`                        |Function||||
|`getBundleName`                    |Property||||
|`getModuleName`                    |Property||||
|`getName`                          |Property||||
|`getLabel`                         |Property||||
|`getLabelId`                       |Property||||
|`getDescription`                   |Property||||
|`getDescriptionId`                 |Property||||
|`getIcon`                          |Property||||
|`getIconId`                        |Property||||
|`getProcess`                       |Property||||
|`getExported`                      |Property||||
|`getOrientation`                   |Property||||
|`getLaunchType`                    |Property||||
|`getPermissions`                   |Property||||
|`getDeviceTypes`                   |Property||||
|`getApplicationInfo`               |Property||||
|`getMetadata`                      |Property||||
|`getEnabled`                       |Property||||
|`getSupportWindowModes`            |Property||||
|`getWindowSize`                    |Property||||
|`getExcludeFromDock`               |Property||||
|`getSkills`                        |Property||||
|`getAppIndex`                      |Property||||
|`getOrientationId`                 |Property||||
|*AbilityLifecycleCallback*|*Class*||||
|`construct`              |Function||||
|`onAbilityCreate`        |Function||||
|`onWindowStageCreate`    |Function||||
|`onWindowStageDestroy`   |Function||||
|`onAbilityDestroy`       |Function||||
|`onAbilityForeground`    |Function||||
|`onAbilityBackground`    |Function||||
|*AbilityResult*|*Class*||||
|`construct`    |Function||||
|`getResultCode`|Property||||
|`setResultCode`|Property||||
|`getWant`      |Property||||
|`setWant`      |Property||||
|*AbilityStartCallback*|*Class*||||
|`construct`           |Function||||
|`onError`             |Function||||
|`getOnResult`         |Property||||
|`setOnResult`         |Property||||
|*AccessibilityHoverEvent*| *Class* | Pavelyev Ivan | done |  | |
|`construct`| Function |Pavelyev Ivan | done |  | |
|`getType`| Property | Pavelyev Ivan | done |  | |
|`setType`| Property | Pavelyev Ivan | done |  | |
|`getX`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setX`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getY`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setY`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getDisplayX`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setDisplayX`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getDisplayY`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setDisplayY`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getWindowX`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setWindowX`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`getWindowY`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
|`setWindowY`| Property | Pavelyev Ivan | done |  | UT by Vadim Voronov |
| *Animation*                                          | *Class*     |                                  |                   |
|`construct`                                            | Function    |                                  |                   |
|`onFinished`                                           | Function    |                                  |                   |
|`restart`                                              | Function    |                                  |                   |
|`start`                                                | Function    |                                  |                   |
|`stop`                                                 | Function    |                                  |                   |
|`getRunning`                                           | Property    |                                  |                   |
|`getProgress`                                          | Property    |                                  |                   |
|*AnimationExtender*| *Class* | Lobah Mikhail| in progress| | |
|`SetClipRect`| Function | Lobah Mikhail| in progress| | |
|`OpenImplicitAnimation`| Function | Lobah Mikhail| in progress| | |
|`CloseImplicitAnimation`| Function | Lobah Mikhail| in progress| | |
|`StartDoubleAnimation`| Function | Lobah Mikhail| in progress| | |
|`AnimationTranslate`| Function | Lobah Mikhail| in progress| | |
|*AnimatorOptions*|*Class*||||
|`construct`      |Function|||| 
|`getDuration`    |Property|||| 
|`setDuration`    |Property|||| 
|`getEasing`      |Property|||| 
|`setEasing`      |Property|||| 
|`getDelay`       |Property|||| 
|`setDelay`       |Property|||| 
|`getFill`        |Property|||| 
|`setFill`        |Property|||| 
|`getDirection`   |Property|||| 
|`setDirection`   |Property|||| 
|`getIterations`  |Property|||| 
|`setIterations`  |Property|||| 
|`getBegin`       |Property|||| 
|`setBegin`       |Property|||| 
|`getEnd`         |Property|||| 
|`setEnd`         |Property||||
|*AnimatorResult*|*Class*||||
|`construct`      |Function||||
|`reset`          |Function||||
|`play`           |Function||||
|`finish`         |Function||||
|`pause`          |Function||||
|`cancel`         |Function||||
|`reverse`        |Function||||
|`setExpectedFrameRateRange`|Function||||
|`getOnFrame`     |Property||||
|`setOnFrame`     |Property||||
|`getOnFinish`    |Property||||
|`setOnFinish`    |Property||||
|`getOnCancel`    |Property||||
|`setOnCancel`    |Property||||
|`getOnRepeat`    |Property||||
|`setOnRepeat`    |Property||||
|*AppearSymbolEffect*| *Class* | wangtao  | done | | |
|`construct`| Function | wangtao  | done | | |
|`getScope`| Function | wangtao  | done | | |
|`setScope`| Function | wangtao  | done | | |
|*ApplicationContext*|*Class*||||
|`construct`         |Function||||
|`onAbilityLifecycle`|Function||||
|`onInteropAbilityLifecycle`|Function||||
|`offAbilityLifecycle0`|Function||||
|`offAbilityLifecycle1`|Function||||
|`offInteropAbilityLifecycle`|Function||||
|`onEnvironment`     |Function||||
|`offEnvironment0`   |Function||||
|`offEnvironment1`   |Function||||
|`onApplicationStateChange`|Function||||
|`offApplicationStateChange`|Function||||
|`getRunningProcessInformation0`|Function||||
|`getRunningProcessInformation1`|Function||||
|`killAllProcesses0`|Function||||
|`killAllProcesses1`|Function||||
|`killAllProcesses2`|Function||||
|`setColorMode`      |Function||||
|`setLanguage`       |Function||||
|`clearUpApplicationData0`|Function||||
|`clearUpApplicationData1`|Function||||
|`restartApp`        |Function||||
|`preloadUIExtensionAbility`|Function||||
|`setSupportedProcessCache`|Function||||
|`setFont`           |Function||||
|`getCurrentAppCloneIndex`|Function||||
|`setFontSizeScale`  |Function||||
|`getCurrentInstanceKey`|Function||||
|`getAllRunningInstanceKeys`|Function||||
|*ApplicationInfo*|*Class*||||
|`construct`       |Function||||
|`getName`         |Property||||
|`getDescription`  |Property||||
|`getDescriptionId`|Property||||
|`getEnabled`      |Property||||
|`getLabel`        |Property||||
|`getLabelId`      |Property||||
|`getIcon`         |Property||||
|`getIconId`       |Property||||
|`getProcess`      |Property||||
|`getPermissions`  |Property||||
|`getCodePath`     |Property||||
|`getMetadataArray`|Property||||
|`getRemovable`    |Property||||
|`getAccessTokenId`|Property||||
|`getUid`          |Property||||
|`getIconResource` |Property||||
|`getLabelResource`|Property||||
|`getDescriptionResource`|Property||||
|`getAppDistributionType`|Property||||
|`getAppProvisionType`|Property||||
|`getSystemApp`    |Property||||
|`getBundleType`   |Property||||
|`getDebug`        |Property||||
|`getDataUnclearable`|Property||||
|`getNativeLibraryPath`|Property||||
|`getMultiAppMode` |Property||||
|`getAppIndex`     |Property||||
|`getInstallSource`|Property||||
|`getReleaseType`  |Property||||
|`getCloudFileSyncEnabled`|Property||||
|`getFlags`        |Property||||
|*ApplicationStateChangeCallback*|*Class*||||
|`construct`              |Function||||
|`onApplicationForeground`|Function||||
|`onApplicationBackground`|Function||||
| *AtomicServiceBar*                                   | *Class*     |                                  |                   |
| `construct`                                            | Function    |                                  |                   |
| `setVisible`                                           | Function    |                                  |                   |
| `setBackgroundColor`                                   | Function    |                                  |                   |
| `setTitleContent`                                      | Function    |                                  |                   |
| `setTitleFontStyle`                                    | Function    |                                  |                   |
| `setIconColor`                                         | Function    |                                  |                   |
| `getBarRect`                                           | Function    |                                  |                   |
|*AtomicServiceOptions*|*Class*||||
|`construct`             |Function||||
|`getFlags`              |Property||||
|`setFlags`              |Property||||
|`getParameters`         |Property||||
|`setParameters`         |Property||||
|*AxisEvent*| *Class* | Tuzhilkin Ivan | done | | |
|`construct`| Function | Tuzhilkin Ivan | done | | need cherry-pick to FB |
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
|*BackgroundColorStyle*| *Class* | Politov Mikhail | done |  | |
|`construct`| Function |Politov Mikhail | done |  | |
|`getTextBackgroundStyle`| Function | Tuzhilkin Ivan | done | | |
|*BaseContext*|*Class*||||
|`construct`   |Function||||
|`getStageMode`|Property||||
|`setStageMode`|Property||||
|*BaseEvent*| *Class* | Politov Mikhail | in progress |  | |
|`construct`| Function |Politov Mikhail | done |  | |
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
|`getRollAngle`| Function | Pavelyev Ivan | done | | |
|`setRollAngle`| Function | Pavelyev Ivan | done | | |
|`getSourceTool`| Function | Tuzhilkin Ivan | done |  | |
|`setSourceTool`| Function | Politov Mikhail | done |  | |
|`getGetModifierKeyState`| Function | | | | |
|`setGetModifierKeyState`| Function | Politov Mikhail | done |  | |
|`getDeviceId`| Function | Politov Mikhail | done |  | |
|`setDeviceId`| Function | Politov Mikhail | done |  | |
|`getTargetDisplayId`| Function | Maksimov Nikita | done |  | |
|`setTargetDisplayId`| Function | Maksimov Nikita | done |  | |
|*BaseGestureEvent*| *Class* | Maksimov Nikita | done |  | |
|`construct`| Function |Maksimov Nikita | done |  | |
|`getFingerList`| Function | Kovalev Sergey | done | | |
|`setFingerList`| Function | Maksimov Nikita | done |  | implementation and UT Vadim Voronov |
|*BaselineOffsetStyle*| *Class* | Tuzhilkin Ivan | done |  | |
|`construct`| Function |  Tuzhilkin Ivan | done |  | |
|`getBaselineOffset`| Function | Tuzhilkin Ivan | done |  | |
|*BaseShape*| *Class* | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`construct`| Function |Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`width`| Function | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`height`| Function | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`size`| Function | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|*BounceSymbolEffect*| *Class* | wangtao  | done | | |
|`construct`| Function | wangtao  | done | | |
|`getScope`| Function | wangtao  | done | | |
|`setScope`| Function | wangtao  | done | | |
|`getDirection`| Function | wangtao  | done | | |
|`setDirection`| Function | wangtao  | done | | |
|*BuilderNodeOps*| *Class* | | |
|`construct`| Function | | |
|`create`| Function | | |
|`disposeNode`| Function | | |
|`setUpdateConfigurationCallback`| Function | | |
|`setOptions`| Function | | |
|`postTouchEvent`| Function | | |
|`setRootFrameNodeInBuilderNode`| Function | | |
|*BusinessError*|*Class*||||
|`construct0`       |Function||||
|`construct1`       |Function||||
|`construct2`       |Function||||
|`getCode`          |Property||||
|`setCode`          |Property||||
|`getData`          |Property||||
|`setData`          |Property||||
| *BusinessError_Void*                                 | *Class*     |                                  |                   |
| construct0                                           | Function    |                                  |                   |
| construct1                                           | Function    |                                  |                   |
| construct2                                           | Function    |                                  |                   |
| getCode                                              | Property    |                                  |                   |
| setCode                                              | Property    |                                  |                   |
| getData                                              | Property    |                                  |                   |
| setData                                              | Property    |                                  |                   |
|*CalendarPickerDialog*| *Class* | Ekaterina Stepanova | testskipped |  | |
|`construct`| Function | | | | |
|`show`| Function | Ekaterina Stepanova | testskipped |  | UT in progress, Skroba Gleb |
|*Callee*|*Class*||||
|`construct`             |Function||||
|`on`                    |Function||||
|`off`                   |Function||||
|*Caller*|*Class*||||
|`construct`             |Function||||
|`call`                  |Function||||
|`callWithResult`        |Function||||
|`release`               |Function||||
|`onRelease0`            |Function||||
|`onRemoteStateChange`   |Function||||
|`onRelease1`            |Function||||
|`offRelease0`           |Function||||
|`offRelease1`           |Function||||
| *Camera*                                             | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| getEnabled                                           | Property    |                                  |                   |
| setEnabled                                           | Property    |                                  |                   |
| getPostProcess                                       | Property    |                                  |                   |
| setPostProcess                                       | Property    |                                  |                   |
|*CanvasGradient*| *Class* | Vadim Voronov | done |  | |
|`construct`| Function | Vadim Voronov | done |  | |
|`addColorStop`| Function | Vadim Voronov | done |  | |
|*CanvasPath*| *Class* | Vadim Voronov | testskipped |  |  |
|`construct`| Function |Vadim Voronov | testskipped |  |  |
|`arc`| Function | Vadim Voronov | testskipped |  |  |
|`arcTo`| Function | Vadim Voronov | testskipped |  |  |
|`bezierCurveTo`| Function | Vadim Voronov | testskipped |  |  |
|`closePath`| Function | Vadim Voronov | testskipped |  |  |
|`ellipse`| Function | Vadim Voronov | testskipped |  |  |
|`lineTo`| Function | Vadim Voronov | testskipped |  |  |
|`moveTo`| Function | Vadim Voronov | testskipped |  |  |
|`quadraticCurveTo`| Function | Vadim Voronov | testskipped |  |  |
|`rect`| Function | Vadim Voronov | testskipped |  |  |
|*CanvasPattern*| *Class* | Vadim Voronov | done |  |  |
|`construct`| Function |Vadim Voronov | done |  |  |
|`setTransform`| Function | Vadim Voronov | done |  |  |
|*CanvasRenderer*| *Class*  | Vadim Voronov | blocked IDL | Vadim Voronov | |
|`construct`| Function |Vadim Voronov | done | pass | |
|`drawImage0`| Function |Vadim Voronov | done | failed | bug hos2416 compilation error |
|`drawImage1`| Function  | Vadim Voronov | done | failed | bug hos2416 compilation error |
|`drawImage2`| Function  | Vadim Voronov | done | failed | bug hos2416 compilation error |
|`beginPath`| Function  | Vadim Voronov | done  | failed | bug hos2417 no methods from CanvasPath interface|
|`clip0`| Function  | Vadim Voronov | done  | failed | bug hos2417 no methods from CanvasPath interface|
|`clip1`| Function  | Vadim Voronov | done  | failed | bug hos2417 no methods from CanvasPath interface|
|`fill0`| Function  | Vadim Voronov | done  | failed | bug hos2417 no methods from CanvasPath interface|
|`fill1`| Function  | Vadim Voronov | done  | failed | bug hos2417 no methods from CanvasPath interface|
|`stroke`| Function  | Vadim Voronov | done | failed | bug hos2417 no methods from CanvasPath interface|
|`createLinearGradient`| Function  | Vadim Voronov | done | pass | |
|`createPattern`| Function  | Vadim Voronov | done | failed | bug hos2416 compilation error |
|`createRadialGradient`| Function  | Vadim Voronov | done | pass |  |
|`createConicGradient`| Function  | Vadim Voronov | done | pass |  |
|`createImageData0`| Function  | Vadim Voronov | done | failed | bug hos2422 |
|`createImageData1`| Function  | Vadim Voronov | done | failed | bug hos2422 |
|`getImageData`| Function  | Vadim Voronov | done | pass | |
|`getPixelMap`| Function  | Vadim Voronov | done | failed | bug hos2423 |
|`putImageData0`| Function  | Vadim Voronov | done | failed | bug hos2422 |
|`putImageData1`| Function  | Vadim Voronov | done | pass |  |
|`getLineDash`| Function  | Vadim Voronov |  done | failed | bug hos2440 |
|`setLineDash`| Function  | Vadim Voronov | done | pass | |
|`clearRect`| Function  | Vadim Voronov | done | pass | |
|`fillRect`| Function  | Vadim Voronov | done | pass | |
|`strokeRect`| Function  | Vadim Voronov | done | pass | |
|`restore`| Function  | Vadim Voronov | done | pass | |
|`save`| Function  | Vadim Voronov | done | pass | |
|`fillText`| Function  | Vadim Voronov | done | pass | |
|`measureText`| Function  | Vadim Voronov | done | failed | bug hos2441 |
|`strokeText`| Function  | Vadim Voronov | done | pass | |
|`getTransform`| Function  | Vadim Voronov | done | |  |
|`resetTransform`| Function  | Vadim Voronov | done |  | |
|`rotate`| Function  | Vadim Voronov | done |  | |
|`scale`| Function  | Vadim Voronov | done |  | |
|`setTransform0`| Function  | Vadim Voronov | done |  | |
|`setTransform1`| Function  | Vadim Voronov | done |  | |
|`transform`| Function  | Vadim Voronov | done |  | |
|`translate`| Function  | Vadim Voronov | done |  | |
|`setPixelMap`| Function  | Vadim Voronov | done | failed | bug hos2423 |
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
|`getFillStyle`| Function | Vadim Voronov | blocked IDL | failed | bug hos2442, to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setFillStyle`| Function  | Vadim Voronov | done | pass | |
|`getStrokeStyle`| Function | Vadim Voronov | blocked IDL | failed | bug hos2442, to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setStrokeStyle`| Function  | Vadim Voronov | done | pass | |
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
|`getLineWidth`| Function  | Vadim Voronov | blocked IDL | failed | bug hos2442, to be removed from generation, https://gitee.com/nikolay-igotti/idlize/issues/IBP7O2 |
|`setLineWidth`| Function  | Vadim Voronov | done | pass | |
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
|*CanvasRenderingContext2D*| *Class* | Vadim Voronov | in progress | Vadim Voronov |  |
|`construct`| Function |Vadim Voronov| in progress | pass | todo in API v.129 |
|`toDataURL`| Function |Vadim Voronov| done | failed | bug hos2393 |
|`startImageAnalyzer`| Function | Vadim Voronov | done | failed  | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`stopImageAnalyzer`| Function | Vadim Voronov| done | failed | https://gitee.com/openharmony/arkui_ace_engine/issues/IAZ229 |
|`onOnAttach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`offOnAttach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`onOnDetach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`offOnDetach`| Function | Vadim Voronov | done | failed | bug hos2391 |
|`getHeight`| Function |Vadim Voronov| done | pass | |
|`getWidth`| Function |Vadim Voronov| done | pass | |
|`getCanvas`| Function |Vadim Voronov | testskipped | |  |
|*CertExtension*|*Class*||||
|`construct`      |Function||||
|`getEncoded`     |Function||||
|`getOidList`     |Function||||
|`getEntry`       |Function||||
|`checkCA`        |Function||||
|`hasUnsupportedCriticalExtension`|Function||||
|*X500DistinguishedName*|*Class*||||
|`construct`             |Function||||
|`getName0`              |Function||||
|`getName1`              |Function||||
|`getName2`              |Function||||
|`getEncoded`            |Function||||
|*X509Cert*|*Class*||||
|`construct`        |Function||||
|`verify0`          |Function||||
|`verify1`          |Function||||
|`getEncoded0`      |Function||||
|`getEncoded1`      |Function||||
|`getPublicKey`     |Function||||
|`checkValidityWithDate`|Function||||
|`getVersion`       |Function||||
|`getCertSerialNumber`|Function||||
|`getIssuerName0`   |Function||||
|`getIssuerName1`   |Function||||
|`getSubjectName`   |Function||||
|`getNotBeforeTime` |Function||||
|`getNotAfterTime`  |Function||||
|`getSignature`     |Function||||
|`getSignatureAlgName`|Function||||
|`getSignatureAlgOid`|Function||||
|`getSignatureAlgParams`|Function||||
|`getKeyUsage`      |Function||||
|`getExtKeyUsage`   |Function||||
|`getBasicConstraints`|Function||||
|`getSubjectAltNames`|Function||||
|`getIssuerAltNames`|Function||||
|`getItem`          |Function||||
|`match`            |Function||||
|`getCRLDistributionPoint`|Function||||
|`getIssuerX500DistinguishedName`|Function||||
|`getSubjectX500DistinguishedName`|Function||||
|`toString0`        |Function||||
|`toString1`        |Function||||
|`hashCode`         |Function||||
|`getExtensionsObject`|Function||||
|*ChildrenMainSize*| *Class* | Morozov Sergey | done |  |
|`construct`| Function |Morozov Sergey | done |  |  |
|`splice`| Function | Morozov Sergey | done |  |  |
|`update`| Function | Morozov Sergey | done |  |  |
|`getChildDefaultSize`| Function | Morozov Sergey | done | |
|`setChildDefaultSize`| Function | Morozov Sergey| done |  | |
|*CircleShape*| *Class* |Dudkin Sergey |done | out of scope | |
|`construct`| Function |Dudkin Sergey | done | out of scope| |
|*ClickEvent*| *Class* | Maksimov Nikita | in progress |  | |
|`construct`| Function |Tuzhilkin Ivan | done |  | |
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
|*ClientAuthenticationHandler*|*Class*||||
|`construct`                 |Function||||
|`confirm0`                  |Function||||
|`confirm1`                  |Function||||
|`cancel`                    |Function||||
|`ignore`                    |Function||||
|*ColorContent*| *Class* | | | | |
|`construct`| Function | | | | |
|`getORIGIN`| Function | | | | |
|*ColorFilter*| *Class* | Evstigneev Roman | done | |  |
|`construct`| Function |Evstigneev Roman | in progress| test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*ColorMetrics*| *Class* | Lobah Mikhail| done| | |
|`construct`| Function | Lobah Mikhail| done| | |
|`numeric`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`rgba`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`resourceColor`| Function | Lobah Mikhail| done| test blocked | test blocked by by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`blendColor`| Function | Lobah Mikhail| done| | |
| getWHITE                                             | Property    |                                  |                   |
| getBLACK                                             | Property    |                                  |                   |
| getBLUE                                              | Property    |                                  |                   |
| getBROWN                                             | Property    |                                  |                   |
| getGRAY                                              | Property    |                                  |                   |
| getGREEN                                             | Property    |                                  |                   |
| getGREY                                              | Property    |                                  |                   |
| getORANGE                                            | Property    |                                  |                   |
| getPINK                                              | Property    |                                  |                   |
| getRED                                               | Property    |                                  |                   |
| getYELLOW                                            | Property    |                                  |                   |
| getTRANSPARENT                                       | Property    |                                  |                   |
|`getColor`| Function | Lobah Mikhail| done| | |
|`setColor`| Function | Lobah Mikhail| done| | |
|`getRed`| Function | Lobah Mikhail| done| | |
|`setRed`| Function | Lobah Mikhail| done| | |
|`getGreen`| Function | Lobah Mikhail| done| | |
|`setGreen`| Function | Lobah Mikhail| done| | |
|`getBlue`| Function | Lobah Mikhail| done| | |
|`setBlue`| Function | Lobah Mikhail| done| | |
|`getAlpha`| Function | Lobah Mikhail| done| | |
|`setAlpha`| Function | Lobah Mikhail| done| | |
|*ColorSpaceManager*|*Class*||||
|`construct`           |Function||||
|`getColorSpaceName`   |Function||||
|`getWhitePoint`       |Function||||
|`getGamma`            |Function||||
|*CommonShape*| *Class* | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`construct`| Function |Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`offset`| Function | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`fill`| Function | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|`position`| Function | Tuzhilkin Ivan | in progress | | Empty implementation is acceptable now. Can be reworked/deleted in future generated |
|*CommonShapeMethod_Ohos_Arkui_Shape_PathShape*|*Class*||||
|`construct`|Function||||
|`offset`|Function||||
|`fill`|Function||||
|`position`|Function||||
| *CompletionHandler*                                  | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| getOnRequestSuccess                                  | Property    |                                  |                   |
| setOnRequestSuccess                                  | Property    |                                  |                   |
| getOnRequestFailure                                  | Property    |                                  |                   |
| setOnRequestFailure                                  | Property    |                                  |                   |
|*ComponentSnapshot*|*Class*||||
|`construct`               |Function||||
|`get0`                    |Function||||
|`get1`                    |Function||||
|`createFromBuilder0`      |Function||||
|`createFromBuilder1`      |Function||||
|`getSync`                 |Function||||
|`getWithUniqueId`         |Function||||
|`getSyncWithUniqueId`     |Function||||
|`createFromComponent`     |Function||||
|`getWithRange`            |Function||||
|*ComponentUtils*|*Class*||||
|`construct`       |Function||||
|`getRectangleById`|Function||||
|*Configuration*|*Class*||||
|`construct`             |Function||||
|`getLanguage`           |Property||||
|`setLanguage`           |Property||||
|`getColorMode`          |Property||||
|`setColorMode`          |Property||||
|`getDirection`          |Property||||
|`setDirection`          |Property||||
|`getScreenDensity`      |Property||||
|`setScreenDensity`      |Property||||
|`getDisplayId`          |Property||||
|`setDisplayId`          |Property||||
|`getHasPointerDevice`   |Property||||
|`setHasPointerDevice`   |Property||||
| getFontId                                            | Property    |                                  |                   |
| setFontId                                            | Property    |                                  |                   |
|`getFontSizeScale`      |Property||||
|`setFontSizeScale`      |Property||||
|`getFontWeightScale`    |Property||||
|`setFontWeightScale`    |Property||||
|`getMcc`                |Property||||
|`setMcc`                |Property||||
|`getMnc`                |Property||||
|`setMnc`                |Property||||
| getLocale                                            | Property    |                                  |                   |
| setLocale                                            | Property    |                                  |                   |
|*ConnectOptions*       |*Class*||||
|`construct`           |Function||||
|`getOnConnect`        |Property||||
|`setOnConnect`        |Property||||
|`getOnDisconnect`     |Property||||
|`setOnDisconnect`     |Property||||
|`getOnFailed`         |Property||||
|`setOnFailed`         |Property||||
|*ConsoleMessage*|*Class*||||
|`construct`      |Function||||
|`getMessage`     |Function||||
|`getSourceId`    |Function||||
|`getLineNumber`  |Function||||
|`getMessageLevel`|Function||||
|*Content*             |*Class*||||
|`construct`           |Function||||
|*ContentCoverController*|*Class*||||
|`construct`              |Function||||
|`update`                 |Function||||
|`close`                  |Function||||
|*ContentModifierHelper*| *Class* | Erokhin Ilya | done |
|`contentModifierButton`              |Function| Erokhin Ilya | done ||
|`resetContentModifierButton`         |Function| Erokhin Ilya | done ||
|`contentModifierCheckBox`            |Function| Erokhin Ilya | done ||
|`resetContentModifierCheckBox`       |Function| Erokhin Ilya | done ||
|`contentModifierDataPanel`           |Function| Erokhin Ilya | done ||
|`resetContentModifierDataPanel`      |Function| Erokhin Ilya | done ||
|`contentModifierGauge`               |Function| Erokhin Ilya | done ||
|`resetContentModifierGauge`          |Function| Erokhin Ilya | done ||
|`contentModifierLoadingProgress`     |Function| Erokhin Ilya | done ||
|`resetContentModifierLoadingProgress`|Function| Erokhin Ilya | done ||
|`contentModifierProgress`            |Function| Erokhin Ilya | done ||
|`resetContentModifierProgress`       |Function| Erokhin Ilya | done ||
|`contentModifierRadio`               |Function| Erokhin Ilya | done ||
|`resetContentModifierRadio`          |Function| Erokhin Ilya | done ||
|`contentModifierRating`              |Function| Erokhin Ilya | done ||
|`resetContentModifierRating`         |Function| Erokhin Ilya | done ||
|`contentModifierMenuItem`            |Function| Erokhin Ilya | done ||
|`resetContentModifierMenuItem`       |Function| Erokhin Ilya | done ||
|`contentModifierSlider`              |Function| Erokhin Ilya | done ||
|`resetContentModifierSlider`         |Function| Erokhin Ilya | done ||
|`contentModifierTextClock`           |Function| Erokhin Ilya | done ||
|`resetContentModifierTextClock`      |Function| Erokhin Ilya | done ||
|`contentModifierTextTimer`           |Function| Erokhin Ilya | done ||
|`resetContentModifierTextTimer`      |Function| Erokhin Ilya | done ||
|`contentModifierToggle`              |Function| Erokhin Ilya | done ||
|`resetContentModifierToggle`         |Function| Erokhin Ilya | done ||
|*Context*            |*Class*||||
|`construct`          |Function||||
|`getApplicationContext`|Function||||
|`getGroupDir0`       |Function||||
|`getGroupDir1`       |Function||||
|`createModuleResourceManager`|Function||||
|`createAreaModeContext`|Function||||
|`createDisplayContext`|Function||||
|`getResourceManager`  |Property||||
|`setResourceManager`  |Property||||
|`getApplicationInfo`  |Property||||
|`setApplicationInfo`  |Property||||
|`getCacheDir`         |Property||||
|`setCacheDir`         |Property||||
|`getTempDir`          |Property||||
|`setTempDir`          |Property||||
|`getFilesDir`         |Property||||
|`setFilesDir`         |Property||||
|`getDatabaseDir`      |Property||||
|`setDatabaseDir`      |Property||||
|`getPreferencesDir`   |Property||||
|`setPreferencesDir`   |Property||||
|`getBundleCodeDir`    |Property||||
|`setBundleCodeDir`    |Property||||
|`getDistributedFilesDir`|Property||||
|`setDistributedFilesDir`|Property||||
|`getResourceDir`      |Property||||
|`setResourceDir`      |Property||||
|`getCloudFileDir`     |Property||||
|`setCloudFileDir`     |Property||||
|`getEventHub`         |Property||||
|`setEventHub`         |Property||||
|`getArea`             |Property||||
|`setArea`             |Property||||
|`getProcessName`      |Property||||
|`setProcessName`      |Property||||
|*ContextMenuController*|*Class*||||
|`construct`           |Function||||
|`close`               |Function||||
|*ControllerHandler*|*Class*||||
|`construct`         |Function||||
|`setWebController`  |Function||||
| *CopyEvent*                                          | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| preventDefault                                       | Function    |                                  |                   |
|*Key*|*Class*||||
|`construct` |Function||||
|`getEncoded`|Function||||
|`getFormat` |Property||||
|`getAlgName`|Property||||
|*PubKey*|*Class*||||
|`construct`     |Function||||
|`getAsyKeySpec`  |Function||||
|`getEncodedDer` |Function||||
|`getEncodedPem` |Function||||
|*CursorController*|*Class*||||
|`construct`       |Function||||
|`restoreDefault`  |Function||||
|`setCursor`       |Function||||
|*ICurve*| *Class* | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA  |
|`construct`| Function |Erokhin Ilya | done |  |  |
|`interpolate`| Function | Erokhin Ilya | done |  |  |
|*CustomDialogController*| *Class* | Maksimov Nikita | testskipped |  | |
|`construct`| Function | Maksimov Nikita | testskipped |  | finished by HQ |
|`open`| Function | Maksimov Nikita | testskipped |  |  |
|`close`| Function | Maksimov Nikita | testskipped |  |   |
|`getExternalOptions`|Function||||
|*CustomSpan*| *Class* | Samarin Sergey | in progress | | |
|`construct`| Function | Samarin Sergey | in progress | | |
|`invalidate`| Function | Samarin Sergey | in progress | | |
|`getOnMeasure_callback`| Function | Samarin Sergey | in progress | | |
|`setOnMeasure_callback`| Function | Samarin Sergey | in progress | | |
|`getOnDraw_callback`| Function | Samarin Sergey | in progress | | |
|`setOnDraw_callback`| Function | Samarin Sergey | in progress | | |
|*DataItem*|*Class*||||
|`construct` |Function||||
|`getKey`     |Property||||
|`getValue`   |Property||||
|*DataResubmissionHandler*|*Class*||||
|`construct`            |Function||||
|`resend`               |Function||||
|`cancel`               |Function||||
|*DatePickerDialog*| *Class* | Ekaterina Stepanova | testskipped |  | |
|`construct`| Function | Ekaterina Stepanova | testskipped |  | UT in progress, Skroba Gleb |
|*DecorationStyle*| *Class* | Tuzhilkin Ivan | in progress |  | |
|`construct`| Function |Tuzhilkin Ivan | done |  | |
|`getType`| Function | Tuzhilkin Ivan | done |  | |
|`getColor`| Function | Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|`getStyle`| Function | Tuzhilkin Ivan | done | | FB: Return value will be changed to optional after 125 generation |
|*Dependency*|*Class*||||
|`construct`   |Function||||
|`getModuleName`|Property||||
|`getBundleName`|Property||||
|`getVersionCode`|Property||||
|*DisappearSymbolEffect*| *Class* | wangtao  | done | | |
|`construct`| Function | wangtao  | done | | |
|`getScope`| Function | wangtao  | done | | |
|`setScope`| Function | wangtao  | done | | |
|*DismissDialogAction*|*Class*||||
|`construct`         |Function||||
|`dismiss`           |Function||||
|`getReason`         |Property||||
|`setReason`         |Property||||
|*DismissPopupAction*| *Class* | | |
|`construct`| Function | | |
|`dismiss`| Function | | |
|`getReason`| Function | | |
|`setReason`| Function | | |
|*DragController*|*Class*||||
|`construct`                       |Function||||
|`executeDrag0`                    |Function||||
|`executeDrag1`                    |Function||||
|`createDragAction`                |Function||||
|`getDragPreview`                  |Function||||
|`setDragEventStrictReportingEnabled`|Function||||
|`notifyDragStartRequest`          |Function||||
|`cancelDataLoading`               |Function||||
|`enableDropDisallowedBadge`       |Function||||
|*DragAction*|*Class*||||
|`construct`             |Function||||
|`startDrag`             |Function||||
|`onStatusChange`        |Function||||
|`offStatusChange`       |Function||||
|*DragPreview*|*Class*||||
|`construct`             |Function||||
|`setForegroundColor`    |Function||||
|`animate`               |Function||||
|*DragEvent*| *Class* | Evstigneev Roman | in progress |  | |
|`construct`| Function | Tuzhilkin Ivan | done | | |
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
|`executeDropAnimation`| Function | wangtao | done | | can be implemented on 125 generation |
|`enableInternalDropAnimation`| Function | | |
|`getDragBehavior`| Function | Tuzhilkin Ivan | done | | |
|`setDragBehavior`| Function | Tuzhilkin Ivan | done | | |
|`getUseCustomDropAnimation`| Function | Evstigneev Roman | done |  | priority |
|`setUseCustomDropAnimation`| Function | Evstigneev Roman | done |  | priority |
|`getGetModifierKeyState`| Function | Tuzhilkin Ivan | done |  | |
|`setGetModifierKeyState`| Function | | | | |
|*DrawableDescriptor*| *Class* | Evstigneev Roman | done | | need cherry-pick to FB |
|`construct`| Function | Evstigneev Roman | done | | need cherry-pick to FB |
|`getPixelMap`| Function | Evstigneev Roman | done | | need cherry-pick to FB |
|*DrawContext*| *Class* | | | | |
|`construct`| Function | Samarin Sergey | in progress | | |
|`getSize`| Function | Samarin Sergey | in progress | | |
|`setSize`| Function | Samarin Sergey | in progress | | |
|`getSizeInPixel`| Function | Samarin Sergey | in progress | | |
|`setSizeInPixel`| Function | Samarin Sergey | in progress | | |
|`getCanvas`| Function | Samarin Sergey | in progress | | |
|`setCanvas`| Function | Samarin Sergey | in progress | | |
|*Brush*| *Class* | Samarin Sergey | out of scope | | external object |
|`construct0`| Function | | |
|`construct1`| Function | | |
|`setBlendMode`| Function | | |
|`reset`| Function | | |
|*Canvas*| *Class* |Vadim Voronov | out of scope |  | external object |
|`construct`         |Function||||
|`drawRect0`         |Function||||
|`drawRect1`         |Function||||
|`drawImageRect`     |Function||||
|`drawPixelMapMesh`  |Function||||
|`attachBrush`       |Function||||
|`detachBrush`       |Function||||
|`saveLayer`         |Function||||
|`restore`           |Function||||
|`rotate`            |Function||||
|*ColorFilter*| *Class* | Evstigneev Roman | done |
|`construct`| Function | Evstigneev Roman | in progress |
|`createBlendModeColorFilter`| Function | Evstigneev Roman | in progress |
|*Lattice*| *Class* |Evstigneev Roman | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|`construct`| Function |Evstigneev Roman | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|`createImageLattice`| Function |Evstigneev Roman | blocked IDL | | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY |
|*SamplingOptions*| *Class* | | |
| `construct0` | Function |  |  |  |  |  |  |
| `construct1` | Function |  |  |  |  |  |  |
|*DrawingRenderingContext*| *Class* | Vadim Voronov | done | Vadim Voronov | |
|`construct`| Function | Vadim Voronov | done |  | |
|`invalidate`| Function | Vadim Voronov | done |  | |
|`getSize`| Function | Vadim Voronov | done |  | |
|`setSize`| Function | | | | |
| getCanvas                                            | Property    |                                  |                   |
|*DrawModifier*| *Class* | Erokhin Ilya | blocked IDL|  | |
|`construct`| Function | Erokhin Ilya | done | pass | |
|`invalidate`| Function | Erokhin Ilya | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getDrawBehind_callback`| Function | Erokhin Ilya | blocked IDL | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, https://gitee.com/nikolay-igotti/idlize/issues/IBAFYT |
|`setDrawBehind_callback`| Function | | | | |
|`getDrawContent_callback`| Function | Erokhin Ilya | blocked IDL |  test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA, https://gitee.com/nikolay-igotti/idlize/issues/IBAFYT |
|`setDrawContent_callback`| Function | | | | |
| getDrawFront_callback                                | Property    |                                  |                   |
| setDrawFront_callback                                | Property    |                                  |                   |
|*DynamicSyncScene*|*Class*||||
|`construct`       |Function||||
|`setFrameRateRange`|Function||||
|`getFrameRateRange`|Function||||
|*ElementName*            |*Class*||||
|`construct`              |Function||||
|`getDeviceId`            |Property||||
|`setDeviceId`            |Property||||
|`getBundleName`          |Property||||
|`setBundleName`          |Property||||
|`getModuleName`          |Property||||
|`setModuleName`          |Property||||
|`getAbilityName`         |Property||||
|`setAbilityName`         |Property||||
|`getUri`                 |Property||||
|`setUri`                 |Property||||
|`getShortName`           |Property||||
|`setShortName`           |Property||||
|*EllipseShape*| *Class* | Erokhin Ilya | done | | |
|`construct`| Function | Erokhin Ilya | done | | |
|*EnvironmentBackend*     |*Class*| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`isAccessibilityEnabled`  |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`getColorMode`            |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`getFontScale`            |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`getFontWeightScale`      |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`getLayoutDirection`      |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`getLanguageCode`         |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|*EnvironmentCallback*|*Class*||||
|`construct`             |Function||||
|`onConfigurationUpdated`|Function||||
|`onMemoryLevel`         |Function||||
|*EventEmulator*| *Class* | Dmitry A Smirnov | managed side | | |
|`emitClickEvent`| Function | managed side | managed side | | |
|`emitTextInputEvent`| Function | managed side | managed side | | |
|*EventHub*              |*Class*||||
|`construct`             |Function||||
|`on`                    |Function||||
|`off`                   |Function||||
|`emit`                  |Function||||
|*EventResult*|*Class*||||
|`construct`   |Function||||
|`setGestureEventResult0`|Function||||
|`setGestureEventResult1`|Function||||
|*EventTargetInfo*| *Class* | Maksimov Nikita | done |  | |
|`construct`| Function | Maksimov Nikita | done | | |
|`getId`| Function | Maksimov Nikita | done | | |
|*ExtensionAbilityInfo*  |*Class*||||
|`construct`             |Function||||
|`getBundleName`         |Property||||
|`getModuleName`         |Property||||
|`getName`               |Property||||
|`getLabelId`            |Property||||
|`getDescriptionId`      |Property||||
|`getIconId`             |Property||||
|`getExported`           |Property||||
|`getExtensionAbilityType`|Property||||
|`getExtensionAbilityTypeName`|Property||||
|`getPermissions`        |Property||||
|`getApplicationInfo`    |Property||||
|`getMetadata`           |Property||||
|`getEnabled`            |Property||||
|`getReadPermission`     |Property||||
|`getWritePermission`    |Property||||
|`getSkills`             |Property||||
|`getAppIndex`           |Property||||
|*ExtensionContext*      |*Class*||||
|`construct`             |Function||||
|`getCurrentHapModuleInfo`|Property||||
|`setCurrentHapModuleInfo`|Property||||
|`getConfig`             |Property||||
|`setConfig`             |Property||||
|`getExtensionAbilityInfo`|Property||||
|`setExtensionAbilityInfo`|Property||||
|*FileSelectorParam*|*Class*||||
|`construct`          |Function||||
|`getTitle`           |Function||||
|`getMode`            |Function||||
|`getAcceptType`      |Function||||
|`isCapture`          |Function||||
|`getMimeTypes`       |Function||||
|*FileSelectorResult*|*Class*||||
|`construct`         |Function||||
|`handleFileList`    |Function||||
|*FocusAxisEvent*| *Class* | Evstigneev Roman | done | | feature: API not present |
|`construct`| Function | Evstigneev Roman | done | | |
|`getAxisMap`| Function | Evstigneev Roman | done | | |
|`setAxisMap`| Function | Evstigneev Roman | done | | empty implementation, feature: API not present |
|`getStopPropagation`| Function | Evstigneev Roman | done | | feature: API not present |
|`setStopPropagation`| Function | Evstigneev Roman | done  |  | empty implementation, feature: API not present |
|*FocusController*|*Class*|Lobah Mikhail|done||
|`construct`       |Function||||
|`clearFocus`      |Function||||
|`requestFocus`    |Function|Lobah Mikhail|done||
|`activate`        |Function||||
|`isActive`        |Function||||
|`setAutoFocusTransfer`|Function||||
|`setKeyProcessingMode`|Function||||
|*Font*                |*Class*||||
|`construct`           |Function||||
|`registerFont`        |Function||||
|`getSystemFontList`   |Function||||
|`getFontByName`       |Function||||
|*FrameCallback*|*Class*||||
|`construct`     |Function||||
|`onFrame`       |Function||||
|`onIdle`        |Function||||
|*FrameNode*| *Class* | Tuzhilkin Ivan | done |  | |
|`construct`| Function | Tuzhilkin Ivan | in progress |  | |
|`getRenderNode`|Function||||
|`isModifiable`| Function | Tuzhilkin Ivan | done |  | |
|`appendChild`| Function | Tuzhilkin Ivan | done |  | |
|`insertChildAfter`| Function | Tuzhilkin Ivan | done |  | |
|`removeChild`| Function | Tuzhilkin Ivan | done |  | |
|`clearChildren`| Function | Tuzhilkin Ivan | done |  | |
|`getChild`| Function | Tuzhilkin Ivan | done |  | |
|`getFirstChildIndexWithoutExpand`| Function | wangtao | done | | |
|`getLastChildIndexWithoutExpand`| Function | wangtao | done | | |
|`getFirstChild`| Function | Tuzhilkin Ivan | done |  | |
|`getNextSibling`| Function | Tuzhilkin Ivan | done |  | |
|`getPreviousSibling`| Function | Tuzhilkin Ivan | done |  | |
|`getParent`| Function | Tuzhilkin Ivan | done |  | |
|`getChildrenCount`| Function | Tuzhilkin Ivan | done |  | |
|`moveTo`| Function | wangtao | done | | |
|`dispose`| Function | Tuzhilkin Ivan | done |  | |
|`getPositionToWindow`|Function||||
|`isDisposed`|Function||||
|`getPositionToParent`|Function||||
|`getMeasuredSize`|Function||||
|`getLayoutPosition`|Function||||
|`getUserConfigBorderWidth`|Function||||
|`getUserConfigPadding`|Function||||
|`getUserConfigMargin`|Function||||
|`getUserConfigSize`|Function||||
|`getId`| Function | wangtao | done | | |
|`getUniqueId`| Function | wangtao | done | | |
|`getNodeType`| Function | wangtao | done | | |
|`getOpacity`| Function | Morozov Sergey | done | | |
|`isVisible`| Function | wangtao | done | | |
|`isClipToFrame`| Function | wangtao | done | | |
|`isAttached`| Function | wangtao | done | | |
|`getInspectorInfo`| Function | wangtao | done | | |
|`getCustomProperty`|Function||||
|`onMeasure`|Function||||
|`onLayout`|Function||||
|`setMeasuredSize`| Function | wangtao | done | |
|`setLayoutPosition`| Function | wangtao | done | |
|`measure`| Function | wangtao | done  | |
|`layout`| Function | wangtao | done | |
|`setNeedsLayout`| Function | wangtao | done | |
|`invalidate`| Function | wangtao | done | |
|`getPositionToScreen`|Function||||
|`getGlobalPositionOnDisplay`|Function||||
|`getPositionToWindowWithTransform`| Function | Morozov Sergey | done | | |
|`getPositionToParentWithTransform`|Function||||
|`getPositionToScreenWithTransform`|Function||||
|`disposeTree`| Function | wangtao | done | |
|`addComponentContent`|Function||||
|`setCrossLanguageOptions`| Function | wangtao | done | |
|`getCrossLanguageOptions`| Function | wangtao | done | |
|`recycle`| Function | wangtao | done | | |
|`reuse`| Function | wangtao | done | | |
|`isTransferred`|Function||||
|`getCommonEvent`|Property||||
|`getGestureEvent`|Property||||
|`getCommonAttribute`|Property||||
|*FrictionMotion*| *Class* |managed side | managed side| | |
|`construct`| Function |managed side |managed side | | |
|*FullScreenExitHandler*|*Class*||||
|`construct`           |Function||||
|`exitFullScreen`      |Function||||
|*Gesture*| *Class* | | | | |
|`construct`| Function | | | | |
|`tag`| Function | | | | |
|`allowedTypes`| Function | | | | |
|*GestureEvent*| *Class* | Samarin Sergey | done |  | |
|`construct`| Function |Samarin Sergey | done |  | |
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
|*GestureGroup*|*Class*||||
|`construct`|Function||||
|$_instantiate|Function||||
|`onCancel`|Function||||
|*GestureObserverConfigs*|*Class*||||
|`construct`              |Function||||
|`getActionPhases`        |Property||||
|`setActionPhases`        |Property||||
|*GestureRecognizer*| *Class* | Kovalev Sergey | done |  | |
|`construct`| Function | Kovalev Sergey | done | | |
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
|*GestureStyle*| *Class* | Dudkin Sergey| done | | |
|`construct`| Function |Dudkin Sergey| done | | |
|*GestureTriggerInfo*|*Class*||||
|`construct`              |Function||||
|`getEvent`               |Property||||
|`setEvent`               |Property||||
|`getCurrent`             |Property||||
|`setCurrent`             |Property||||
|`getCurrentPhase`        |Property||||
|`setCurrentPhase`        |Property||||
|`getNode`                |Property||||
|`setNode`                |Property||||
|*GlobalScope_ohos_arkui_componentSnapshot*| *Class* | Dudkin Sergey| done | out of scope | |
|`get`| Function | Dudkin Sergey | done | out of scope | |
|*GlobalScope_ohos_arkui_performanceMonitor*| *Class* | Vadim Voronov | done | | blocked IDL on FB |
|`begin`| Function | Vadim Voronov | done | | |
|`end`| Function | Vadim Voronov | done | | |
|`recordInputEventTime`| Function | Vadim Voronov | done | |  |
|*GlobalScope_ohos_font*| *Class* | Pavelyev Ivan | done | | |
|`registerFont`| Function | Pavelyev Ivan | done | | |
|`getSystemFontList`| Function | Pavelyev Ivan | done | | |
|`getFontByName`| Function | Pavelyev Ivan | done | | |
|*GlobalScope_ohos_measure_utils*| *Class* | Dudkin Sergey | done | | |
|`measureText`| Function | Dudkin Sergey | done | | |
|`measureTextSize`| Function | Dudkin Sergey | done | | |
|*HapModuleInfo*|*Class*||||
|`construct`      |Function||||
|`getName`        |Property||||
|`getIcon`        |Property||||
|`getIconId`      |Property||||
|`getLabel`       |Property||||
|`getLabelId`     |Property||||
|`getDescription` |Property||||
|`getDescriptionId`|Property||||
|`getMainElementName`|Property||||
|`getAbilitiesInfo`|Property||||
|`getExtensionAbilitiesInfo`|Property||||
|`getMetadata`    |Property||||
|`getDeviceTypes` |Property||||
|`getInstallationFree`|Property||||
|`getHashValue`   |Property||||
|`getType`        |Property||||
|`getDependencies`|Property||||
|`getPreloads`    |Property||||
|`getFileContextMenuConfig`|Property||||
|`getRouterMap`   |Property||||
|`getNativeLibraryPath`|Property||||
|`getCodePath`    |Property||||
|*HierarchicalSymbolEffect*| *Class* | wangtao  | done | | |
|`construct`| Function | wangtao  | done | | |
|`getFillStyle`| Function | wangtao  | done | | |
|`setFillStyle`| Function | wangtao  | done | | |
|*HoverEvent*| *Class* | Tuzhilkin Ivan | done |  | |
|`construct`| Function | Tuzhilkin Ivan | done | | UT: need cherry-pick to FB |
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
|*HttpAuthHandler*|*Class*| Erokhin Ilya | done ||
|`construct`       |Function| Erokhin Ilya | done ||
|`confirm`         |Function| Erokhin Ilya | done ||
|`cancel`          |Function| Erokhin Ilya | done ||
|`isHttpAuthInfoSaved`|Function| Erokhin Ilya | done ||
|*PixelMap*| *Class* | Andrey Khudenkikh | blocked  | |
|`construct`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`readPixelsToBuffer0`          |Function||||
|`readPixelsToBuffer1`          |Function||||
|`readPixelsToBufferSync`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`readPixels0`                  |Function||||
|`readPixels1`                  |Function||||
|`readPixelsSync`               |Function||||
|`writePixels0`                 |Function||||
|`writePixels1`                 |Function||||
|`writePixelsSync`              |Function||||
|`writeBufferToPixels0`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`writeBufferToPixels1`         |Function||||
|`writeBufferToPixelsSync`      |Function||||
|`toSdr`                        |Function||||
|`getImageInfo0`                |Function||||
|`getImageInfo1`                |Function||||
|`getImageInfoSync`             |Function||||
|`getBytesNumberPerRow`         |Function||||
|`getPixelBytesNumber`          |Function||||
|`getDensity`                   |Function||||
|`opacity0`                     |Function||||
|`opacity1`                     |Function||||
|`opacitySync`                  |Function||||
|`createAlphaPixelmap0`         |Function||||
|`createAlphaPixelmap1`         |Function||||
|`createAlphaPixelmapSync`      |Function||||
|`scale0`                       |Function||||
|`scale1`                       |Function||||
|`scaleSync0`                   |Function||||
|`scale2`                       |Function||||
|`scaleSync1`                   |Function||||
|`createScaledPixelMap`         |Function||||
|`createScaledPixelMapSync`     |Function||||
|`translate0`                   |Function||||
|`translate1`                   |Function||||
|`translateSync`                |Function||||
|`rotate0`                      |Function||||
|`rotate1`                      |Function||||
|`rotateSync`                   |Function||||
|`flip0`                        |Function||||
|`flip1`                        |Function||||
|`flipSync`                     |Function||||
|`crop0`                        |Function||||
|`crop1`                        |Function||||
|`cropSync`                     |Function||||
|`getColorSpace`                |Function||||
|`marshalling`                  |Function||||
|`unmarshalling`                |Function||||
|`setColorSpace`                |Function||||
|`applyColorSpace0`             |Function||||
|`applyColorSpace1`             |Function||||
|`convertPixelFormat`           |Function||||
|`release0`                     |Function||||
|`release1`                     |Function||||
| setTransferDetached                                  | Function    |                                  |                   |
| getMetadata                                          | Function    |                                  |                   |
| setMemoryNameSync                                    | Function    |                                  |                   |
| cloneSync                                            | Function    |                                  |                   |
| clone                                                | Function    |                                  |                   |
| setMetadata                                          | Function    |                                  |                   |
|`getIsEditable`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|`getIsStrideAlignment`| Function | Andrey Khudenkikh | blocked IDL |  | To be removed from generation. https://gitee.com/nikolay-igotti/idlize/issues/IBZ4RZ |
|*ImageAnalyzerController*| *Class* |Vadim Voronov|  blocked AceEngine |  | |
|`construct`| Function | Vadim Voronov|  blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IBPTCE |
|`getImageAnalyzerSupportTypes`| Function |Vadim Voronov|  blocked AceEngine |  | https://gitee.com/openharmony/arkui_ace_engine/issues/IBPTCE |
|*ImageAttachment*| *Class* | Evstigneev Roman | in progress | | |
|`construct`| Function |Evstigneev Roman | done | | |
|`getValue`| Function | Evstigneev Roman | done | | |
|`getSize`| Function | Evstigneev Roman | done | | |
|`getVerticalAlign`| Function | Evstigneev Roman | done | | |
|`getObjectFit`| Function | Evstigneev Roman | done | | |
|`getLayoutStyle`| Function | Evstigneev Roman | done | | |
|`getColorFilter`| Function | Evstigneev Roman | in progress | | ColorFilter done, feature: API not present |
|*ImageBitmap*| *Class* | Vadim Voronov | in progress |  | |
|`construct`| Function | Vadim Voronov | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`close`| Function | Vadim Voronov | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getHeight`| Function | Vadim Voronov | testskipped | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getWidth`| Function | Vadim Voronov | testskipped | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*ImageData*| *Class* | Morozov Sergey | in progress | | |
|`construct`| Function |Morozov Sergey | done | | |
|`getData`| Function | Dudkin Sergey | in progress | | |
|`setData`| Function | | Dudkin Sergey | in progress | | |
|`getHeight`| Function | Morozov Sergey | done | | |
|`setHeight`| Function | Dudkin Sergey | in progress | | |
|`getWidth`| Function | Morozov Sergey | done | | |
|`setWidth`| Function | Dudkin Sergey | in progress| | |
|*IndicatorComponentController*| *Class* | Skroba Gleb | done |  |  |
|`construct`| Function | Skroba Gleb | done | failed | "Can't have nullptr ptr ${}" probably no the component code |
|`showNext`| Function | Skroba Gleb | done |  |  |
|`showPrevious`| Function | Skroba Gleb | done |  |  |
|`changeIndex`| Function | Skroba Gleb | done |  |  |
|*ComponentObserver*|*Class*||||
|`construct`|Function||||
|`onLayoutLayout`|Function||||
|`offLayoutLayout`|Function||||
|`onDrawDraw`|Function||||
|`offDrawDraw`|Function||||
|`onDrawChildrenDrawChildren`|Function||||
|`offDrawChildrenDrawChildren`|Function||||
|*InteropAbilityLifecycleCallback*|*Class*||||
|`construct`                     |Function||||
|`getOnAbilityCreate`            |Property||||
|`setOnAbilityCreate`            |Property||||
|`getOnWindowStageCreate`        |Property||||
|`setOnWindowStageCreate`        |Property||||
|`getOnWindowStageDestroy`       |Property||||
|`setOnWindowStageDestroy`       |Property||||
|`getOnAbilityDestroy`           |Property||||
|`setOnAbilityDestroy`           |Property||||
|`getOnAbilityForeground`        |Property||||
|`setOnAbilityForeground`        |Property||||
|`getOnAbilityBackground`        |Property||||
|`setOnAbilityBackground`        |Property||||
|*IUIContext*| *Class* | | |
|`freezeUINode0`| Function | | |
|`freezeUINode1`| Function | | |
|*JsGeolocation*|*Class*||||
|`construct`      |Function||||
|`invoke`         |Function||||
|*JsResult*|*Class*||||
|`construct`        |Function||||
|`handleCancel`     |Function||||
|`handleConfirm`    |Function||||
|`handlePromptConfirm`|Function||||
|*KeyEvent*| *Class* | Maksimov Nikita | done |  |  |
|`construct`| Function |Maksimov Nikita | done | | |
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
|*Layoutable*| *Class* | Samarin Sergey | in progress | | |
|`construct`| Function | Samarin Sergey | in progress | | |
|`layout`|Function||||
|`getMargin`| Function | Samarin Sergey | in progress | | |
|`getPadding`| Function | Samarin Sergey | in progress | | |
|`getBorderWidth`| Function | Samarin Sergey | in progress | | |
|`getMeasureResult`| Function | Samarin Sergey | in progress | | |
|`setMeasureResult`| Function | Samarin Sergey | in progress | | |
|`getUniqueId`| Function | Samarin Sergey | in progress | | |
|`setUniqueId`| Function | Samarin Sergey | in progress | | |
|*LayoutChild*|*Class*||||
|`construct`|Function||||
|`measure`|Function||||
|`getName`|Property||||
|`setName`|Property||||
|`getId`|Property||||
|`setId`|Property||||
|`getPosition`|Property||||
|`setPosition`|Property||||
|*LayoutManager*| *Class* | Andrey Khudenkikh, Vadim Voronov | done |  |  |
|`construct`| Function | Andrey Khudenkikh | done |  | |
|`getLineCount`| Function | Andrey Khudenkikh | done |  | |
|`getGlyphPositionAtCoordinate`| Function | Vadim Voronov | done |  |  |\
|*LayoutPolicy*| *Class* | | | | |
|`construct`| Function | | | | |
|`getMatchParent`| Function | | | | |
|*LazyForEachOps*| *Class* | managed side | done | | |
|`Sync`| Function | managed side |  |  |
| SyncOnMoveOps                                        | Function    |                                  |                   |
|*LengthMetrics*| *Class* | Evstigneev Roman | done | | |
|`construct`| Function |Evstigneev Roman | done | | |
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
|*LetterSpacingStyle*| *Class* | Tuzhilkin Ivan | done |  | |
|`construct`| Function |Tuzhilkin Ivan | done |  | |
|`getLetterSpacing`| Function | Tuzhilkin Ivan | done |  | |
|*LevelOrder*| *Class* | | |
|`construct`| Function | | |
|`clamp`| Function | | |
|`getOrder`| Function | | |
| *Light*                                              | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| getColor                                             | Property    |                                  |                   |
| setColor                                             | Property    |                                  |                   |
| getIntensity                                         | Property    |                                  |                   |
| setIntensity                                         | Property    |                                  |                   |
| getShadowEnabled                                     | Property    |                                  |                   |
| setShadowEnabled                                     | Property    |                                  |                   |
| getEnabled                                           | Property    |                                  |                   |
| setEnabled                                           | Property    |                                  |                   |
|*LinearGradient*| *Class* | Morozov Sergey | done | | |
|`construct`| Function | Morozov Sergey | done | | |
|*LineHeightStyle*| *Class* |Dudkin Sergey |done|  | |
|`construct`| Function |Dudkin Sergey |done|  | |
|`getLineHeight`| Function |Dudkin Sergey | done |  | |
|*ListScroller*| *Class* |Morozov Sergey | done| Politov Mikhail |  |
|`construct`| Function | Morozov Sergey | done | done | |
|`getItemRectInGroup`| Function |Morozov Sergey | done | blocked | |
|`scrollToItemInGroup`| Function |Morozov Sergey | done | blocked | |
|`closeAllSwipeActions`| Function |Morozov Sergey | done | blocked | |
|`getVisibleListContentInfo`| Function |Morozov Sergey | done | blocked | |
|*LongPressGestureEvent*| *Class* | Kovalev Sergey | done | | |
|`construct`| Function | Kovalev Sergey | done | | |
|`getRepeat`| Function | Kovalev Sergey | done | | |
|`setRepeat`| Function | Kovalev Sergey | done | | |
|*LongPressRecognizer*| *Class* | Vadim Voronov | done | | |
|`construct`| Function | Vadim Voronov | done | | |
|`isRepeat`| Function | Vadim Voronov | done | | |
|`getDuration`| Function | Vadim Voronov | done | | |
|*Matrix2D*| *Class* | Vadim Voronov | done |  |  |
|`construc0t`| Function |  Vadim Voronov | done |  | |
| construct1                                           | Function    |                                  |                   |
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
|*Matrix4Transit*| *Class* | Samarin Sergey | testskipped | | |
|`construct`| Function |Samarin Sergey | done | |
|`copy`| Function | Samarin Sergey | done | | |
|`invert`| Function | Samarin Sergey | done | | |
|`combine`| Function | Samarin Sergey | done | | |
|`translate`| Function | Samarin Sergey | done | failed | to submit internal issue |
|`scale`| Function | Samarin Sergey | done | failed | to submit internal issue |
|`skew`| Function | Samarin Sergey | done | | |
|`rotate`| Function | Samarin Sergey | done | failed | to submit internal issue |
|`transformPoint`| Function | Samarin Sergey | done | | |
|`setPolyToPoly`| Function | Samarin Sergey | testskipped | | |
|*Measurable*| *Class* | Samarin Sergey | in progress | | |
|`construct`| Function | Samarin Sergey | in progress | | |
|`measure`| Function | Samarin Sergey | in progress | | |
|`getMargin`| Function | Samarin Sergey | in progress | | |
|`getPadding`| Function | Samarin Sergey | in progress | | |
|`getBorderWidth`| Function | Samarin Sergey | in progress | | |
|`getUniqueId`| Function | Samarin Sergey | in progress | | |
|`setUniqueId`| Function | Samarin Sergey | in progress | | |
|*MeasureUtils*|*Class*||||
|`construct`   |Function||||
|`measureText` |Function||||
|`measureTextSize`|Function||||
|*MediaQuery*          |*Class*||||
|`construct`           |Function||||
|`matchMediaSync`      |Function||||
|*MediaQueryListener*|*Class*||||
|`construct`|Function||||
|`onChange`|Function||||
|`offChange`|Function||||
|`getMatches`|Function||||
|`getMedia`|Function||||
|*Metadata*|*Class*||||
|`construct`|Function||||
|`getName`|Property||||
|`setName`|Property||||
|`getValue`|Property||||
|`setValue`|Property||||
|`getResource`|Property||||
|`setResource`|Property||||
|`getValueId`|Property||||
|*ModuleMetadata*|*Class*||||
|`construct`      |Function||||
|`getModuleName`  |Property||||
|`getMetadata`    |Property||||
|*MouseEvent*| *Class* | Kovalev Sergey | done |  | |
|`construct`| Function |Kovalev Sergey | done |  | |
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
|*MultiAppMode*|*Class*||||
|`construct`     |Function||||
|`getMultiAppModeType`|Property||||
|`getMaxCount`   |Property||||
|*MutableStyledString*| *Class* | Maksimov Nikita | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBBYJE + |
|`construct`| Function |Maksimov Nikita | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBBYJE + |
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
|*NavDestinationContext*| *Class* | managed side | managed side |  |  |
|`construct`| Function | managed side | managed side |  |  |
|`getConfigInRouteMap`| Function | managed side | managed side |  |  |
|`getPathInfo`| Function | managed side| managed side| | |
|`setPathInfo`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getPathStack`| Function | managed side| managed side| | |
|`setPathStack`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getNavDestinationId`| Function | managed side | managed side |  | |
|`setNavDestinationId`| Function | Morozov Sergey | done |  |  |
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
|*NavigationTransitionProxy*| *Class* | managed side | managed side |  |  |
|`construct`| Function |Morozov Sergey | done |  |  |
|`finishTransition`| Function | Morozov Sergey | done |  |  |
|`getFrom`| Function | managed side | managed side | | |
|`setFrom`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getTo`| Function | managed side | managed side | | |
|`setTo`| Function | managed side | managed side |  | , https://gitee.com/nikolay-igotti/idlize/issues/IB7ZKX |
|`getIsInteractive`| Function | Morozov Sergey | done |  |  |
|`setIsInteractive`| Function | Morozov Sergey | done |  |  |
|`getCancelTransition`| Function | Morozov Sergey | done |  |  |
|`setCancelTransition`| Function | Morozov Sergey | testskipped |  |  |
|`getUpdateTransition`| Function | Morozov Sergey | done |  |  |
|`setUpdateTransition`| Function | Morozov Sergey | testskipped |  |  |
|*NavPathInfo*| *Class* |  managed side | managed side | | done in C-API as workarond, the managed side support is planned  |
|`construct`| Function | Skroba Gleb | done | |  |
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
|`construct`| Function | Skroba Gleb | done |  |   |
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
| *Node*                                               | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| getNodeByPath                                        | Function    |                                  |                   |
| getPosition                                          | Property    |                                  |                   |
| setPosition                                          | Property    |                                  |                   |
| getRotation                                          | Property    |                                  |                   |
| setRotation                                          | Property    |                                  |                   |
| getScale                                             | Property    |                                  |                   |
| setScale                                             | Property    |                                  |                   |
| getVisible                                           | Property    |                                  |                   |
| setVisible                                           | Property    |                                  |                   |
| getNodeType                                          | Property    |                                  |                   |
|*NodeController*|*Class*||||
|`construct`|Function||||
|`makeNode`|Function||||
|`aboutToResize`|Function||||
|`aboutToAppear`|Function||||
|`aboutToDisappear`|Function||||
|`rebuild`|Function||||
|`onTouchEvent`|Function||||
|`onAttach`|Function||||
|`onDetach`|Function||||
|`onWillBind`|Function||||
|`onWillUnbind`|Function||||
|`onBind`|Function||||
|`onUnbind`|Function||||
|*OffscreenCanvas*| *Class* | Vadim Voronov | testskipped | | |
|`construct`| Function |Vadim Voronov | testskipped | | |
|`transferToImageBitmap`| Function | Vadim Voronov | testskipped | | |
|`getContext2d`| Function | Vadim Voronov | testskipped | | |
|`getHeight`| Function | Vadim Voronov | testskipped | | |
|`setHeight`| Function | Vadim Voronov | testskipped | | |
|`getWidth`| Function | Vadim Voronov | testskipped| | |
|`setWidth`| Function | Vadim Voronov | testskipped | | |
|*OffscreenCanvasRenderingContext2D*| *Class* | Vadim Voronov | done | Vadim Voronov | |
|`construct`| Function |Vadim Voronov | done | | |
|`toDataURL`| Function | Vadim Voronov | done | | |
|`transferToImageBitmap`| Function | Vadim Voronov | done | |    |
|*OpenLinkOptions*|*Class*||||
|`construct`             |Function||||
|`getAppLinkingOnly`     |Property||||
|`setAppLinkingOnly`     |Property||||
|`getParameters`         |Property||||
|`setParameters`         |Property||||
|*OverlayManager*|*Class*||||
|`construct`                    |Function||||
|`addComponentContent`         |Function||||
|`addComponentContentWithOrder`|Function||||
|`removeComponentContent`       |Function||||
|`showComponentContent`         |Function||||
|`hideComponentContent`         |Function||||
|`showAllComponentContents`     |Function||||
|`hideAllComponentContents`     |Function||||
|*OverlayManagerOptions*|*Class*||||
|`construct`                    |Function||||
|`getRenderRootOverlay`         |Property||||
|`setRenderRootOverlay`         |Property||||
|`getEnableBackPressedEvent`    |Property||||
|`setEnableBackPressedEvent`    |Property||||
|*PageInfo*|*Class*|| out of scope || external object |
|`construct`                |Function|| out of scope || external object |
|`getRouterPageInfo`        |Property|| out of scope || external object |
|`setRouterPageInfo`        |Property|| out of scope || external object |
|`getNavDestinationInfo`    |Property|| out of scope || external object |
|`setNavDestinationInfo`    |Property|| out of scope || external object |
|*PanGestureEvent*| *Class* | Morozov Sergey | done | | |
|`construct`| Function | Morozov Sergey | done | | |
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
|*PanGestureOptions*| *Class* | Politov Mikhail | done | | wait new generation for feature_branch, to merge CTOR impl |
|`construct`| Function | Politov Mikhail | done |  | |
|`setDirection`| Function | Politov Mikhail | done |  | |
|`setDistance`| Function | Politov Mikhail | done |  | |
|`setFingers`| Function | Politov Mikhail | done |  | |
|`getDirection`| Function | Dudkin Sergey | done |  |  |
|`getDistance`| Function | Erokhin Ilya | done | | |
|*PanRecognizer*| *Class* | Politov Mikhail | done |  | done on upstream |
|`construct`| Function |Politov Mikhail | done |  | done on upstream |
|`getPanGestureOptions`| Function | Politov Mikhail | done |  | done on upstream |
|*ParagraphStyle*| *Class* |Dudkin Sergey | done |  | |
|`construct`| Function |Dudkin Sergey | done |  | |
|`getTextAlign`| Function |Tuzhilkin Ivan | done | | |
|`getTextIndent`| Function |Tuzhilkin Ivan | done | | |
|`getMaxLines`| Function |Tuzhilkin Ivan | done | | |
|`getOverflow`| Function |Tuzhilkin Ivan | done | | |
|`getWordBreak`| Function |Tuzhilkin Ivan | done | | |
|`getLeadingMargin`| Function | Tuzhilkin Ivan | done | | |
|`getParagraphSpacing`| Function | HQ | testskipped | | |
| *PasteEvent*                                         | *Class*     | | blocked | | no such API in generation 137 |
| construct                                            | Function    | | blocked | | no such API in generation 137 |
| preventDefault                                       | Function    | | blocked | | no such API in generation 137 |
|*Path2D*| *Class* | Vadim Voronov | done |  | |
|`construct0`| Function | Vadim Voronov | done |  | |
|`construct1`| Function | Vadim Voronov | done |
|`construct2`| Function | Vadim Voronov| done |
|`construct3`| Function | Vadim Voronov| done |
|`construct4`| Function | Vadim Voronov | done |
|`construct5`| Function | Vadim Voronov | done |
|`addPath`| Function | Vadim Voronov | done |  | |
|*PathShape*| *Class* | Lobah Mikhail | done| | |
|`construct`| Function |Lobah Mikhail | done| | |
|`commands`| Function | Lobah Mikhail| done| | |
|*PatternLockController*| *Class* |Dmitry A Smirnov| done |  |  |
|`construct`| Function |Dmitry A Smirnov| done |  |  |
|`reset`| Function |Dmitry A Smirnov| done |  |  |
|`setChallengeResult`| Function |Dmitry A Smirnov| done |  |  |
|*PermissionRequest*|*Class*| Erokhin Ilya | done ||
|`construct`        |Function| Erokhin Ilya | done ||
|`deny`             |Function| Erokhin Ilya | done ||
|`getOrigin`        |Function| Erokhin Ilya | done ||
|`getAccessibleResource`|Function| Erokhin Ilya | done ||
|`grant`            |Function| Erokhin Ilya | done ||
|*PersistentStorageBackend*|*Class*| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`get`                     |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`has`                     |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`remove`                  |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`set`                     |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|`clear`                   |Function| Tuzhilkin Ivan | blocked || https://gitee.com/rri_opensource/koala_projects/issues/ICTC33 |
|*PinchGestureEvent*| *Class* | Vadim Voronov | done | | |
|`construct`| Function |Vadim Voronov | done | | |
|`getScale`| Function | Vadim Voronov | done | | |
|`setScale`| Function | Vadim Voronov | done | | |
|`getPinchCenterX`| Function | Vadim Voronov | done | | |
|`setPinchCenterX`| Function | Vadim Voronov | done | | |
|`getPinchCenterY`| Function | Vadim Voronov | done | | |
|`setPinchCenterY`| Function | Vadim Voronov | done | | |
|*PinchRecognizer*| *Class* | Vadim Voronov | done | | |
|`construct`| Function | Vadim Voronov | done | | |
|`getDistance`| Function | Vadim Voronov | done | | |
|*PixelMapMock*| *Class* | Maksimov Nikita | done |  | |
|`construct`| Function |Maksimov Nikita | done |  | |
|`release`| Function | Maksimov Nikita | done |  | |
|*PreloadItem*|*Class*||||
|`construct`    |Function||||
|`getModuleName`|Property||||
|*PrintDocumentAdapter*|*Class*||||
|`construct`|Function||||
|`onStartLayoutWrite`|Function||||
|`onJobStateChanged`|Function||||
|*ProcessInformation*|*Class*||||
|`construct`         |Function||||
|`getPid`            |Property||||
|`setPid`            |Property||||
|`getUid`            |Property||||
|`setUid`            |Property||||
|`getProcessName`    |Property||||
|`setProcessName`    |Property||||
|`getBundleNames`    |Property||||
|`setBundleNames`    |Property||||
|`getState`          |Property||||
|`setState`          |Property||||
|`getBundleType`     |Property||||
|`setBundleType`     |Property||||
|`getAppCloneIndex`  |Property||||
|`setAppCloneIndex`  |Property||||
|*ProgressMask*| *Class* | Maksimov Nikita | done |  | |
|`construct`| Function |Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`updateProgress`| Function | Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`updateColor`| Function | Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`enableBreathingAnimation`| Function | Maksimov Nikita | done | test blocked | test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|*PromptAction*| *Class* | | |
|`construct`| Function | | |
|`showToast`                         |Function||||
|`openToast`                         |Function||||
|`closeToast`                        |Function||||
|`showDialog0`                       |Function||||
|`showDialog1`                       |Function||||
|`showActionMenu0`                   |Function||||
|`showActionMenu1`                   |Function||||
|`openCustomDialog0`                 |Function||||
|`openCustomDialogWithController`    |Function||||
|`updateCustomDialog`                |Function||||
|`closeCustomDialog0`                |Function||||
|`openCustomDialog1`                 |Function||||
|`presentCustomDialog`               |Function||||
|`closeCustomDialog1`                |Function||||
|`getTopOrder`                       |Function||||
|`getBottomOrder`                    |Function||||
|`openPopup`| Function | | |
|`upatePopup`| Function | | |
|`closePopup`| Function | | |
|`openMenu`| Function | | |
|`updateMenu`| Function | | |
|`closeMenu`| Function | | |
|*CommonController*|*Class*||||
|`construct`       |Function||||
|`close`           |Function||||
|*DialogController*|*Class*||||
|`construct`      |Function||||
|*PulseSymbolEffect*|*Class*||||
|`construct`|Function||||
|*RawFileDescriptor*|*Class*||||
|`construct`        |Function||||
|`getFd`            |Property||||
|`setFd`            |Property||||
|`getOffset`        |Property||||
|`setOffset`        |Property||||
|`getLength`        |Property||||
|`setLength`        |Property||||
|*RectShape*| *Class* | Samarin Sergey | done | | |
|`construct`| Function | Samarin Sergey | done | | |
|`radiusWidth`| Function | Samarin Sergey | done | | |
|`radiusHeight`| Function | Samarin Sergey | done | | |
|`radius`| Function | Samarin Sergey | done | | |
|*RenderingContextSettings*| *Class* | Vadim Voronov | done | Vadim Voronov | |
|`construct`| Function |  Vadim Voronov | done | | |
|`getAntialias`| Property | Vadim Voronov | done | | |
|`setAntialias`| Property | Vadim Voronov | done | | |
|*RenderNode*| *Class* | Morozov Sergey | in progress | | done on Upstream |
|`construct`| Function | Morozov Sergey | done | | done on Upstream |
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
|`setTranslation`| Property | Morozov Sergey | done | | done on Upstream |
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
|`getLengthMetricsUnit`| Property | Morozov Sergey | done | | done on Upstream |
|`setLengthMetricsUnit`| Property | Morozov Sergey | done | | done on Upstream |
|*RenderServiceNode*| *Class* | | |
|`getNodeId`| Function | | |
|*ReplaceSymbolEffect*| *Class* | Andrey Khudenkikh | done | | |
|`construct`| Function |Andrey Khudenkikh | done | | |
|`getScope`| Function | Andrey Khudenkikh | done | | |
|`setScope`| Function | Andrey Khudenkikh | done | | |
|*Configuration*|*Class*||||
|`construct`     |Function||||
|`getDirection`  |Property||||
|`setDirection`  |Property||||
|`getLocale`     |Property||||
|`setLocale`     |Property||||
|`getDeviceType` |Property||||
|`setDeviceType` |Property||||
|`getScreenDensity`|Property||||
|`setScreenDensity`|Property||||
|`getColorMode`  |Property||||
|`setColorMode`  |Property||||
|`getMcc`        |Property||||
|`setMcc`        |Property||||
|`getMnc`        |Property||||
|`setMnc`        |Property||||
|*DeviceCapability*|*Class*||||
|`construct`       |Function||||
|`getScreenDensity`  |Property||||
|`setScreenDensity`  |Property||||
|`getDeviceType`   |Property||||
|`setDeviceType`   |Property||||
|*ResourceManager*|*Class*||||
|`construct`       |Function||||
|`getDeviceCapability0`|Function||||
|`getDeviceCapability1`|Function||||
|`getConfiguration0`  |Function||||
|`getConfiguration1`  |Function||||
|`getStringByName0`   |Function||||
|`getStringByName1`   |Function||||
|`getStringArrayByName0`|Function||||
|`getStringArrayByName1`|Function||||
|`getMediaByName0`    |Function||||
|`getMediaByName1`    |Function||||
|`getMediaByName2`    |Function||||
|`getMediaByName3`    |Function||||
|`getMediaBase64ByName0`|Function||||
|`getMediaBase64ByName1`|Function||||
|`getMediaBase64ByName2`|Function||||
|`getMediaBase64ByName3`|Function||||
|`getStringSync0`   |Function||||
|`getStringSync1`   |Function||||
|`getStringByNameSync0`|Function||||
|`getStringByNameSync1`|Function||||
|`getBoolean`       |Function||||
|`getBooleanByName`  |Function||||
|`getInt`           |Function||||
|`getDouble`        |Function||||
|`getIntByName`     |Function||||
|`getDoubleByName`  |Function||||
|`getStringValue0`  |Function||||
|`getStringValue1`  |Function||||
|`getStringArrayValue0`|Function||||
|`getStringArrayValue1`|Function||||
|`getIntPluralStringValueSync`|Function||||
|`getIntPluralStringByNameSync`|Function||||
|`getDoublePluralStringValueSync`|Function||||
|`getDoublePluralStringByNameSync`|Function||||
|`getMediaContent0` |Function||||
|`getMediaContent1` |Function||||
|`getMediaContent2` |Function||||
|`getMediaContent3` |Function||||
|`getMediaContentBase640`|Function||||
|`getMediaContentBase641`|Function||||
|`getMediaContentBase642`|Function||||
|`getMediaContentBase643`|Function||||
|`getRawFileContent0` |Function||||
|`getRawFileContent1` |Function||||
|`getRawFd0`        |Function||||
|`getRawFd1`        |Function||||
|`closeRawFd0`      |Function||||
|`closeRawFd1`      |Function||||
|`getDrawableDescriptor`|Function||||
|`getDrawableDescriptorByName`|Function||||
|`getRawFileList0`  |Function||||
|`getRawFileList1`  |Function||||
|`getColor0`        |Function||||
|`getColor1`        |Function||||
|`getColorByName0`  |Function||||
|`getColorByName1`  |Function||||
|`getColorSync`     |Function||||
|`getColorByNameSync`|Function||||
|`addResource`      |Function||||
|`removeResource`   |Function||||
|`getRawFdSync`     |Function||||
|`closeRawFdSync`   |Function||||
|`getRawFileListSync`|Function||||
|`getRawFileContentSync`|Function||||
|`getMediaContentSync`|Function||||
|`getMediaContentBase64Sync`|Function||||
|`getStringArrayValueSync`|Function||||
|`getMediaByNameSync`|Function||||
|`getMediaBase64ByNameSync`|Function||||
|`getStringArrayByNameSync`|Function||||
|`getConfigurationSync`|Function||||
|`getDeviceCapabilitySync`|Function||||
|`getLocales`       |Function||||
|`getSymbol`        |Function||||
|`getSymbolByName`  |Function||||
|`isRawDir`         |Function||||
|`getOverrideResourceManager`|Function||||
|`getOverrideConfiguration`|Function||||
|`updateOverrideConfiguration`|Function||||
|*RestrictedWorker*| *Class* | | |
|`construct`| Function | | |
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
|`getOnexit`| Property | | |
|`setOnexit`| Property | | |
|`getOnerror`| Property | | |
|`setOnerror`| Property | | |
|`getOnmessage`| Property | | |
|`setOnmessage`| Property | | |
|`getOnmessageerror`| Property | | |
|`setOnmessageerror`| Property | | |
|*RichEditorBaseController*| *Class*|Dudkin Sergey| done|  | |
|`construct`| Function|Dudkin Sergey| done |  | |
|`getCaretOffset`| Function|Dudkin Sergey| done |  | |
|`setCaretOffset`| Function|Dudkin Sergey| done |  | |
|`closeSelectionMenu`| Function|Dudkin Sergey| done |  | |
|`getTypingStyle`| Function|Dmitry A Smirnov| done |  |  |
|`setTypingStyle`| Function|Dudkin Sergey| done |  | |
|`setSelection`| Function|Dudkin Sergey| done |  | |
|`isEditing`| Function|Dudkin Sergey| done |  | |
|`stopEditing`| Function|Dudkin Sergey| done |  | |
|`getLayoutManager`| Function|Dudkin Sergey| done |  | |
|`getPreviewText`| Function|Dmitry A Smirnov| done |  |  |
|`getCaretRect`| Function | Erokhin Ilya | done | | |
|*RichEditorController*| *Class* |Dudkin Sergey| testskipped|  |  |
|`construct`| Function |Dudkin Sergey| done |  |  |
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
|`construct`| Function |Dudkin Sergey| done |  | |
|`setStyledString`| Function |Dudkin Sergey| done |  | |
|`getStyledString`| Function | Maksimov Nikita | done |  | |
|`getSelection`| Function |Dudkin Sergey| done |  | |
|`onContentChanged`| Function | Dudkin Sergey| done |  | |
|*RotationGesture*| *Class* | | | | |
|`construct`| Function | | | | |
|`$_instantiate`| Function | | | | |
|`onActionStart`| Function | | | | |
|`onActionUpdate`| Function | | | | |
|`onActionEnd`| Function | | | | |
|`onActionCancel`| Function | | | | |
|*RotationGestureEvent*| *Class* | Andrey Khudenkikh | done | | |
|`construct`| Function |  Andrey Khudenkikh | done | | |
|`getAngle`| Property | Andrey Khudenkikh | done | | |
|`setAngle`| Property | Andrey Khudenkikh | done | | |
|*RotationRecognizer*| *Class* | Lobah Mikhail| done| | |
|`construct`| Function | Lobah Mikhail| done| | |
|`getAngle`| Function | Lobah Mikhail| done| | |
|*Router*              |*Class*||||
|`construct`           |Function||||
|`pushUrl0`            |Function||||
|`pushUrl1`            |Function||||
|`pushUrl2`            |Function||||
|`pushUrl3`            |Function||||
|`replaceUrl0`         |Function||||
|`replaceUrl1`         |Function||||
|`replaceUrl2`         |Function||||
|`replaceUrl3`         |Function||||
|`back0`               |Function||||
|`back1`               |Function||||
|`clear`               |Function||||
|`getLength`           |Function||||
|`getState`            |Function||||
|`getStateByIndex`     |Function||||
|`getStateByUrl`       |Function||||
|`showAlertBeforeBackPage`|Function||||
|`hideAlertBeforeBackPage`|Function||||
|`getParams`           |Function||||
|`pushNamedRoute0`     |Function||||
|`pushNamedRoute1`     |Function||||
|`pushNamedRoute2`     |Function||||
|`pushNamedRoute3`     |Function||||
|`replaceNamedRoute0`  |Function||||
|`replaceNamedRoute1`  |Function||||
|`replaceNamedRoute2`  |Function||||
|`replaceNamedRoute3`  |Function||||
|*RouterItem*|*Class*||||
|`construct`   |Function||||
|`getName`      |Property||||
|`getPageSourceFile`|Property||||
|`getBuildFunction`|Property||||
|`getCustomData`|Property||||
|`getData`      |Property||||
|*Ashmem*|*Class*||||
|`construct`     |Function||||
|`create0`       |Function||||
|`create1`       |Function||||
|`getAshmemSize` |Function||||
|`mapReadWriteAshmem`|Function||||
|*DeathRecipient*|*Class*||||
|`construct`     |Function||||
|`onRemoteDied`  |Function||||
|*IRemoteObject*|*Class*||||
|`construct`   |Function||||
|`sendMessageRequest0`|Function||||
|`sendMessageRequest1`|Function||||
|`registerDeathRecipient`|Function||||
|`unregisterDeathRecipient`|Function||||
|`getDescriptor`|Function||||
|`isObjectDead`|Function||||
|*MessageOption*|*Class*||||
|`construct0`    |Function||||
|`construct1`    |Function||||
|`isAsync`       |Function||||
|`setAsync`      |Function||||
|*MessageSequence*|*Class*||||
|`construct`      |Function||||
|`create`         |Function||||
|`reclaim`        |Function||||
|`writeRemoteObject`|Function||||
|`readRemoteObject`|Function||||
|`writeInterfaceToken`|Function||||
|`readInterfaceToken`|Function||||
|`getCapacity`    |Function||||
|`setCapacity`    |Function||||
|`writeNoException`|Function||||
|`readException`  |Function||||
|`writeInt`       |Function||||
|`writeLong`      |Function||||
|`writeBoolean`   |Function||||
|`writeString`    |Function||||
|`writeParcelable`|Function||||
|`writeByteArray` |Function||||
|`writeIntArray`  |Function||||
|`writeDoubleArray`|Function||||
|`writeBooleanArray`|Function||||
|`writeStringArray`|Function||||
|`writeParcelableArray`|Function||||
|`readInt`        |Function||||
|`readLong`       |Function||||
|`readBoolean`    |Function||||
|`readString`     |Function||||
|`readParcelable` |Function||||
|`readIntArray0`  |Function||||
|`readIntArray1`  |Function||||
|`readDoubleArray0`|Function||||
|`readDoubleArray1`|Function||||
|`readBooleanArray0`|Function||||
|`readBooleanArray1`|Function||||
|`readStringArray0`|Function||||
|`readStringArray1`|Function||||
|`readParcelableArray`|Function||||
|`closeFileDescriptor`|Function||||
|`writeFileDescriptor`|Function||||
|`readFileDescriptor`|Function||||
|`writeAshmem`    |Function||||
|`readAshmem`     |Function||||
|`writeRawDataBuffer`|Function||||
|`readRawDataBuffer`|Function||||
|*Parcelable*|*Class*||||
|`construct` |Function||||
|`marshalling`|Function||||
|`unmarshalling`|Function||||
|*ScaleSymbolEffect*| *Class* | Andrey Khudenkikh | done | | |
|`construct`| Function |Andrey Khudenkikh | done | | |
|`getScope`| Property | Andrey Khudenkikh | done | | |
|`setScope`| Property | Andrey Khudenkikh | done | | |
|`getDirection`| Property | Andrey Khudenkikh | done | | |
|`setDirection`| Property | Andrey Khudenkikh | done | | |
|*Scene*| *Class* | | |
|`construct`| Function | | |
|`load`| Function | | |
| getNodeByPath                                        | Function    |                                  |                   |
| getResourceFactory                                   | Function    |                                  |                   |
|`destroy`| Function | | |
| renderFrame                                          | Function    |                                  |                   |
| getEnvironment                                       | Property    |                                  |                   |
| setEnvironment                                       | Property    |                                  |                   |
| getAnimations                                        | Property    |                                  |                   |
| *SceneResource*                                      | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| destroy                                              | Function    |                                  |                   |
| *SceneResourceFactory*                               | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| createCamera                                         | Function    |                                  |                   |
| createLight                                          | Function    |                                  |                   |
|*ScreenCaptureHandler*|*Class*| Erokhin Ilya | done ||
|`construct`           |Function| Erokhin Ilya | done ||
|`getOrigin`          |Function| Erokhin Ilya | done ||
|`grant`              |Function| Erokhin Ilya | done ||
|`deny`               |Function| Erokhin Ilya | done ||
|*ScreenshotService*| *Class* | | |
|`requestScreenshot`| Function | | |
|*ScrollableTargetInfo*| *Class* | Maksimov Nikita | done |  | |
|`construct`| Function |Maksimov Nikita | done |  | |
|`isBegin`| Function | Maksimov Nikita | done |  | |
|`isEnd`| Function | Maksimov Nikita | done |  | |
|*Scroller*| *Class* | Erokhin Ilya | done | Politov Mikhail |  |
|`construct`| Function | Erokhin Ilya | done | pass |  |
|`scrollTo`| Function | Erokhin Ilya | done | pass |  |
|`scrollEdge`| Function | Erokhin Ilya | done | pass |  |
|`fling`| Function | Erokhin Ilya | done | pass |  |
|`scrollPage`| Function | Erokhin Ilya | done | pass |  |
|`currentOffset`| Function | Skroba Gleb | done | pass | |
|`scrollToIndex`| Function | Erokhin Ilya | done | pass | |
|`scrollBy`| Function | Erokhin Ilya | done | pass |  |
|`isAtEnd`| Function | Erokhin Ilya | done | pass |  |
|`getItemRect`| Function | Skroba Gleb | done | | pass |
|`getItemIndex`| Function | Erokhin Ilya | done | pass |  |
|*ScrollMotion*| *Class* |managed side | managed side| | |
|`construct`| Function |managed side | managed side| | |
|*ScrollResult*| *Class* | Dudkin Sergey| in progress | | |
|`construct`| Function | Dudkin Sergey | in progress| | |
|`getOffsetRemain`| Property | Dudkin Sergey |in progress | | |
|`setOffsetRemain`| Property | Dudkin Sergey |in progress | | |
|*SearchController*| *Class* |Evstigneev Roman | done |  |  |
|`construct`| Function |Evstigneev Roman | done |  |  |
|`caretPosition`| Function |Evstigneev Roman | done |  |  |
|`stopEditing`| Function |Evstigneev Roman | done |  |  |
|`setTextSelection`| Function |Evstigneev Roman | done |  |  |
|*SearchOps*| *Class* | | |
|`registerSearchValueCallback`| Function | | |
|*ShapeClip*| *Class* | Andrey Khudenkikh | done | | |
|`construct`| Function | Andrey Khudenkikh | done | | |
|`setRectShape`| Function | Andrey Khudenkikh | done | | |
|`setRoundRectShape`| Function | Andrey Khudenkikh | done | | |
|`setCircleShape`| Function | Andrey Khudenkikh | done | | |
|`setOvalShape`| Function | Andrey Khudenkikh | done | | |
|`setCommandPath`| Function | Andrey Khudenkikh | done | | |
|*ShapeMask*| *Class* | Vadim Voronov | done | | |
|`construct`| Function |  Vadim Voronov | done | |   |
|`setRectShape`| Function | Vadim Voronov | done | | |
|`setRoundRectShape`| Function | Vadim Voronov | done | | |
|`setCircleShape`| Function | Vadim Voronov | done | | |
|`setOvalShape`| Function | Vadim Voronov | done | | |
|`setCommandPath`| Function | Vadim Voronov | done | | |
|`getFillColor`| Property | Vadim Voronov | done | | |
|`setFillColor`| Property | Vadim Voronov | done | | |
|`getStrokeColor`| Property | Vadim Voronov | done | | |
|`setStrokeColor`| Property | Vadim Voronov | done | | |
|`getStrokeWidth`| Property | Vadim Voronov | done | | |
|`setStrokeWidth`| Property | Vadim Voronov | done | | |
|*SimpleAnimatorOptions*|*Class*||||
|`construct`|Function||||
|`duration`|Function||||
|`easing`|Function||||
|`delay`|Function||||
|`fill`|Function||||
|`direction`|Function||||
|`iterations`|Function||||
|*Skill*|*Class*||||
|`construct`      |Function||||
|`getActions`     |Property||||
|`getEntities`    |Property||||
|`getUris`        |Property||||
|`getDomainVerify`|Property||||
|*SkillUri*|*Class*||||
|`construct`   |Function||||
|`getScheme`   |Property||||
|`getHost`     |Property||||
|`getPort`     |Property||||
|`getPath`     |Property||||
|`getPathStartWith`|Property||||
|`getPathRegex`|Property||||
|`getType`     |Property||||
|`getUtd`      |Property||||
|`getMaxFileSupported`|Property||||
|`getLinkFeature`|Property||||
| *SpringBackAction*                                   | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| springBack                                           | Function    |                                  |                   |
|*SpringMotion*| *Class* |managed side |managed side | | |
|`construct`| Function |managed side |managed side | | |
|*SpringProp*| *Class* |managed side | managed side| | |
|`construct`| Function |managed side |managed side | | |
|*SslErrorHandler*|*Class*||||
|`construct`      |Function||||
|`handleConfirm`  |Function||||
|`handleCancel`   |Function||||
|*StartOptions*|*Class*||||
|`construct`             |Function||||
|`getWindowMode`         |Property||||
|`setWindowMode`         |Property||||
|`getDisplayId`          |Property||||
|`setDisplayId`          |Property||||
|`getWithAnimation`      |Property||||
|`setWithAnimation`      |Property||||
|`getWindowLeft`         |Property||||
|`setWindowLeft`         |Property||||
|`getWindowTop`          |Property||||
|`setWindowTop`          |Property||||
|`getWindowWidth`        |Property||||
|`setWindowWidth`        |Property||||
|`getWindowHeight`       |Property||||
|`setWindowHeight`       |Property||||
|`getWindowFocused`      |Property||||
|`setWindowFocused`      |Property||||
|`getProcessMode`        |Property||||
|`setProcessMode`        |Property||||
|`getStartupVisibility`  |Property||||
|`setStartupVisibility`  |Property||||
|`getStartWindowIcon`    |Property||||
|`setStartWindowIcon`    |Property||||
|`getStartWindowBackgroundColor`|Property||||
|`setStartWindowBackgroundColor`|Property||||
|`getSupportWindowModes` |Property||||
|`setSupportWindowModes` |Property||||
|`getMinWindowWidth`     |Property||||
|`setMinWindowWidth`     |Property||||
|`getMinWindowHeight`    |Property||||
|`setMinWindowHeight`    |Property||||
|`getMaxWindowWidth`     |Property||||
|`setMaxWindowWidth`     |Property||||
|`getMaxWindowHeight`    |Property||||
|`setMaxWindowHeight`    |Property||||
| getCompletionHandler                                 | Property    |                                  |                   |
| setCompletionHandler                                 | Property    |                                  |                   |
| getHideStartWindow                                   | Property    |                                  |                   |
| setHideStartWindow                                   | Property    |                                  |                   |
|*StateStylesOps*| *Class* | | |
|`onStateStyleChange`| Function | | |
|*StyledString*| *Class* | Pavelyev Ivan | blocked IDL |  |  |
|`construct`| Function | Pavelyev Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IB4H0N |
|`getString`| Function | Pavelyev Ivan | done |  | |
|`getStyles`| Function | Politov Mikhail | done |  | |
|`equals`| Function | Pavelyev Ivan | done |  | |
|`subStyledString`| Function | Pavelyev Ivan | done |  | |
|`fromHtml`| Function | Pavelyev Ivan | done |  | |
|`toHtml`| Function | Pavelyev Ivan | done |  |  |
|`marshalling0`| Function | Pavelyev Ivan | in progress | | |
|`marshalling1`| Function | Politov Mikhail | done | | |
|`unmarshalling0`| Function | Pavelyev Ivan | in progress | | |
|`unmarshalling1`| Function | Pavelyev Ivan | done | | |
|`getLength`| Property | Pavelyev Ivan | done |  | |
|*StyledStringController*| *Class* | Pavelyev Ivan | done |  | |
|`construct`| Function |Pavelyev Ivan | done |  | |
|`setStyledString`| Function | Pavelyev Ivan | done |  | |
|`getStyledString`| Function | Pavelyev Ivan | done |  | |
|*SubmitEvent*| *Class* | Tuzhilkin Ivan | done |  | |
|`construct`| Function |Tuzhilkin Ivan | done |  | |
|`keepEditableState`| Function | Tuzhilkin Ivan | done |  | |
|`getText`| Property | Tuzhilkin Ivan | done |  | |
|`setText`| Property | Tuzhilkin Ivan | done |  | |
|*SwipeGesture*| *Class* | Samarin Sergey | in progress | | |
|`construct`| Function | Samarin Sergey | in progress | | |
|`$_instantiate`| Function | Samarin Sergey | in progress | | |
|`onAction`| Function | Samarin Sergey | in progress | | |
|*SwipeGestureEvent*| *Class* | Evstigneev Roman | done | | |
|`construct`| Function |Evstigneev Roman | done | | |
|`getAngle`| Property | Evstigneev Roman | done | | |
|`setAngle`| Property | Evstigneev Roman | done | | |
|`getSpeed`| Property | Evstigneev Roman | done | | |
|`setSpeed`| Property | Evstigneev Roman | done | | |
|*SwiperContentTransitionProxy*| *Class* | Skroba Gleb | done | | |
|`construct`| Function |Skroba Gleb | done | | |
|`finishTransition`| Function | Skroba Gleb | done | | |
|`getSelectedIndex`| Property | Skroba Gleb | done | | |
|`setSelectedIndex`| Property | Skroba Gleb | done | | |
|`getIndex`| Property | Skroba Gleb | done | | |
|`setIndex`| Property | Skroba Gleb | done | | |
|`getPosition`| Property | Skroba Gleb | done | | |
|`setPosition`| Property | Skroba Gleb | done | | |
|`getMainAxisLength`| Property | Skroba Gleb | done | | |
|`setMainAxisLength`| Property | Skroba Gleb | done | | |
|*SwiperController*| *Class* | Skroba Gleb | done |  |  |
|`construct`| Function | Skroba Gleb | done |  |  |
|`showNext`| Function | Skroba Gleb | done | failed |  |
|`showPrevious`| Function | Skroba Gleb | done | failed |  |
|`changeIndex`| Function | Skroba Gleb | done |  |  |
|`finishAnimation`| Function | Skroba Gleb | done |  |  |
|`preloadItems`| Function | Skroba Gleb| done | | |
|*SwipeRecognizer*| *Class* | Vadim Voronov | done | | |
|`construct`| Function | Vadim Voronov | done | | |
|`getVelocityThreshold`| Function | Vadim Voronov | done | | |
|`getDirection`| Function | Vadim Voronov | done | | |
|*SymbolEffect*| *Class* | wangtao | done | | |
|`construct`| Function |wangtao | done | | empty implementation |
|*SymbolGlyphModifier*|*Class*||||
|`construct`|Function||||
|*SystemOps*| *Class* | managed side| managed side| | |
|`StartFrame`| Function |managed side |managed side | | |
|`EndFrame`| Function | managed side | managed side | | |
|`syncInstanceId`| Function |managed side |managed side | | |
|`restoreInstanceId`| Function |managed side |managed side | | |
|`getResourceId`| Function |managed side |managed side | | |
|`resourceManagerReset`| Function | | |
|`setFrameCallback`| Function | | |
|`colorMetricsResourceColor`| Function | | |
|*TabBarSymbol*| *Class* | Ekaterina Stepanova | in progress |  |  |
|`construct`| Function | Ekaterina Stepanova | in progress |  |  |
|`getNormal`| Property | Ekaterina Stepanova | in progress |  |  |
|`setNormal`| Property | Ekaterina Stepanova | in progress |  |  |
|`getSelected`| Property | Ekaterina Stepanova | in progress |  |  |
|`setSelected`| Property | Ekaterina Stepanova | in progress |  |  |
|*TabContentTransitionProxy*| *Class* | Dudkin Sergey | done |  | |
|`construct`| Function | Dudkin Sergey | done |  | |
|`finishTransition`| Function | Dudkin Sergey | done |  | |
|`getFrom`| Property | Dudkin Sergey | done |  | |
|`setFrom`| Property | Dudkin Sergey | done |  | |
|`getTo`| Property | Dudkin Sergey | done |  | |
|`setTo`| Property | Dudkin Sergey | done |  | |
|*TabsController*| *Class* | Skroba Gleb | done |  | |
|`construct`| Function |  Skroba Gleb | done |  | |
|`changeIndex`| Function | Skroba Gleb | done |  | |
|`preloadItems`| Function | Skroba Gleb | done |  | |
|`setTabBarTranslate`| Function | Skroba Gleb | done |  | |
|`setTabBarOpacity`| Function | Skroba Gleb | done |  | |
|*TapGestureEvent*| *Class* | Samarin Sergey | done | | nothing to do |
|`construct`| Function |Samarin Sergey | done | | nothing to do |
|*TapRecognizer*| *Class* | Lobah Mikhail| done| | |
|`construct`| Function | Lobah Mikhail| done| | |
|`getTapCount`| Function | Lobah Mikhail| done| | |
|*TargetInfo*          |*Class*||||
|`construct`           |Function||||
|`getId`               |Property||||
|`setId`               |Property||||
|`getComponentId`      |Property||||
|`setComponentId`      |Property||||
|*TextAreaController*| *Class* | Tuzhilkin Ivan | done |  |  |
|`construct`| Function |Tuzhilkin Ivan | done |  |  |
|`caretPosition`| Function | Tuzhilkin Ivan | done |  |  |
|`setTextSelection`| Function | Tuzhilkin Ivan | done |  |  |
|`stopEditing`| Function | Tuzhilkin Ivan | done |  |  |
|*TextBaseController*| *Class* | Morozov Sergey | done |  | |
|`construct`| Function | Morozov Sergey | done |  | |
|`setSelection`| Function | Morozov Sergey | done |  | |
|`closeSelectionMenu`| Function | Morozov Sergey | done |  | |
|`getLayoutManager`| Function | Morozov Sergey | done |  | |
|*TextClockController*| *Class* |Pavelyev Ivan| done |  |  |
|`construct`| Function | Pavelyev Ivan| done |  |  |
|`start`| Function |Pavelyev Ivan| done |  |  |
|`stop`| Function |Pavelyev Ivan| done |  |  |
|*TextContentControllerBase*| *Class* | Morozov Sergey | done |  | |
|`construct`| Function | Dudkin Sergey | done |  |  |
|`getCaretOffset`| Function | Dudkin Sergey | done |  |  |
|`getTextContentRect`| Function | Morozov Sergey | done | test blocked |
|`getTextContentLineCount`| Function | Morozov Sergey | done |  | |
|`addText`| Function | Morozov Sergey | done | | | |
|`deleteText`| Function | Morozov Sergey | done | | | |
|`getSelection`| Function | Morozov Sergey | done | | | |
|`clearPreviewText`| Function | HQ | done | | UT by Samarin Sergey |
|`getText`| Function | HQ | done | | UT by Samarin Sergey |
|*TextController*| *Class* | Samarin Sergey | done |  | |
|`construct`| Function | Samarin Sergey | done |  | |
|`closeSelectionMenu`| Function | Samarin Sergey | done |  | |
|`setStyledString`| Function | Samarin Sergey | done |  | |
|`getLayoutManager`| Function | Samarin Sergey | done |  | |
|*TextEditControllerEx*| *Class* | Morozov Sergey | done |  | |
|`construct`| Function | Morozov Sergey | done |  | |
|`isEditing`| Function | Morozov Sergey | done |  | |
|`stopEditing`| Function | Morozov Sergey | done |  | |
|`setCaretOffset`| Function | Morozov Sergey | done |  | |
|`getCaretOffset`| Function | Morozov Sergey | done |  | |
|`getPreviewText`| Function | Morozov Sergey | done |  | |
|*TextFieldOps*| *Class* | | |
|`registerTextFieldValueCallback`| Function | | |
|`textFieldOpsSetWidth`| Function | | |
|`textFieldOpsSetHeight`| Function | | |
|`textFieldOpsSetPadding`| Function | | |
|`textFieldOpsSetMargin`| Function | | |
|`textFieldOpsSetBorder`| Function | | |
|`textFieldOpsSetBorderWidth`| Function | | |
|`textFieldOpsSetBorderColor`| Function | | |
|`textFieldOpsSetBorderStyle`| Function | | |
|`textFieldOpsSetBorderRadius`| Function | | |
|`textFieldOpsSetBackgroundColor`| Function | | |
|*TextInputController*| *Class* | Spirin Andrey | done |  |  |
|`construct`| Function | Spirin Andrey | done |  |  |
|`caretPosition`| Function | Spirin Andrey | done |  |  |
|`setTextSelection`| Function | Spirin Andrey | done |  |  |
|`stopEditing`| Function |  Spirin Andrey | done |  |  |
|*TextMenuController*| *Class* | | |
|`construct`| Function | | |
|`setMenuOptions`| Function | | |
|`disableSystemServiceMenuItems`|Function||||
|*TextMenuItemId*| *Class* | Maksimov Nikita | done |  | |
|`construct`| Function |Maksimov Nikita | done |  | |
|`of`| Function | Maksimov Nikita | done |  | |
|`equals`| Function | Maksimov Nikita | done |  | |
|`getCUT`| Property | Maksimov Nikita | done | | |
|`getCOPY`| Property | Maksimov Nikita | done | | |
|`getPASTE`| Property | Maksimov Nikita | done | | |
|`getSELECT_ALL`| Property | Maksimov Nikita | done | | |
|`getCOLLABORATION_SERVICE`| Property | Maksimov Nikita | done | | |
|`getCAMERA_INPUT`| Property | Maksimov Nikita | done | | |
|`getAI_WRITER`| Property | Maksimov Nikita | done | | |
|`getTRANSLATE`| Property | Maksimov Nikita | done | | |
|`getSEARCH`| Property | Maksimov Nikita | done | | |
|`getSHARE`| Property | Maksimov Nikita | done | | |
|*TextModifier*|*Class*||||
|`construct`|Function||||
|*TextPickerDialog*| *Class* | Ekaterina Stepanova | done |  | |
|`construct`| Function | Ekaterina Stepanova | done |  |  |
|*TextShadowStyle*| *Class* |  Politov Mikhail | done |  | |
|`construct`| Function |Politov Mikhail | done |  | |
|`getTextShadow`| Property |  Politov Mikhail | done | | |
|*TextStyle*| *Class* | ? | testskipped |
|`construct`| Function | ? | testskipped |
|`getFontColor`| Property | ? | testskipped |
|`getFontFamily`| Property | ? | testskipped |
|`getFontSize`| Property | ? | testskipped |
|`getFontWeight`| Property | ? | testskipped |
|`getFontStyle`| Property | ? | testskipped |
|*TextTimerController*| *Class* |Ekaterina Stepanova| done |  |  |
|`construct`| Function |Ekaterina Stepanova| done | pass |  |
|`start`| Function |Ekaterina Stepanova| done | test blocked |  test blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`pause`| Function |Ekaterina Stepanova| done |  |  |
|`reset`| Function |Ekaterina Stepanova| done |  |  |
|*TimePickerDialog*| *Class* | Ekaterina Stepanova | done |  | |
|`construct`| Function | Ekaterina Stepanova | done |  |  |
|*TouchEvent*| *Class* | Tuzhilkin Ivan | done |  | |
|`construct`| Function |  Tuzhilkin Ivan | done |  | |
|`getHistoricalPoints`| Function | Tuzhilkin Ivan | done |  |  |
|`getType`| Property | Tuzhilkin Ivan | done |  | |
|`setType`| Property | Tuzhilkin Ivan | done |  | empty implementation |
|`getTouches`| Property | Tuzhilkin Ivan | done | | |
|`setTouches`| Property | Tuzhilkin Ivan | done |  | empty implementation |
|`getChangedTouches`| Property | Tuzhilkin Ivan | done | | |
|`setChangedTouches`| Property | Tuzhilkin Ivan | done |  | empty implementation |
|`getStopPropagation`| Property | Samarin Sergey | done | | |
|`setStopPropagation`| Property | Tuzhilkin Ivan | done |  | empty implementation |
|`getPreventDefault`| Property | Samarin Sergey | done | | |
|`setPreventDefault`| Property | Tuzhilkin Ivan | done |  | empty implementation |
|*TransitionEffect*| *Class* | Andrey Khudenkikh | in progress | Sergey Kovalev |OHOSUI-2171 |
|`construct0`| Function |Andrey Khudenkikh | done |  | |
|`construct1`| Function | HQ | testskipped |
|`construct2`| Function | HQ | testskipped |
|`construct3`| Function | HQ | testskipped |
|`construct4`| Function | HQ | testskipped |
|`construct5`| Function | HQ | testskipped |
|`construct6`| Function | HQ | testskipped |
|`translate`| Function | Andrey Khudenkikh | done | failed | OHOSUI-2171 |
|`rotate`| Function | Andrey Khudenkikh | done | failed| OHOSUI-2171|
|`scale`| Function | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|`opacity`| Function | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|`move`| Function | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|`asymmetric`| Function | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|`animation`| Function | Andrey Khudenkikh | done |failed | OHOSUI-2171|
|`combine`| Function | Andrey Khudenkikh | done | failed| OHOSUI-2171|
|`getIDENTITY`| Property | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|`getOPACITY`| Property | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|`getSLIDE`| Property | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|`getSLIDE_SWITCH`| Property | Andrey Khudenkikh | done | failed | OHOSUI-2171|
|*UIAbility*|*Class*||||
|`construct`             |Function||||
|`onCreate`              |Function||||
|`onWindowStageCreate`   |Function||||
|`onWindowStageWillDestroy`|Function||||
|`onWindowStageDestroy`  |Function||||
|`onWindowStageRestore`  |Function||||
|`onDestroy`             |Function||||
|`onDestroyAsync`        |Function||||
|`onForeground`          |Function||||
|`onWillForeground`      |Function||||
|`onDidForeground`       |Function||||
|`onBackground`          |Function||||
|`onWillBackground`      |Function||||
|`onDidBackground`       |Function||||
|`onNewWant`             |Function||||
|`onDump`                |Function||||
|`onShare`               |Function||||
|`onPrepareToTerminate`  |Function||||
|`onPrepareToTerminateAsync`|Function||||
|`onBackPressed`         |Function||||
| onCollaborate                                        | Function    |                                  |                   |
|`getContext`            |Property||||
|`setContext`            |Property||||
|`getLaunchWant`         |Property||||
|`setLaunchWant`         |Property||||
|`getLastRequestWant`    |Property||||
|`setLastRequestWant`    |Property||||
|`getCallee`             |Property||||
|`setCallee`             |Property||||
|*UIAbilityContext*|*Class*||||
|`construct`                              |Function||||
|`startAbility0`                          |Function||||
|`startAbility1`                          |Function||||
|`startAbility2`                          |Function||||
|`openLink`                               |Function||||
| startAbilityAsCaller0                                | Function    |                                  |                   |
| startAbilityAsCaller1                                | Function    |                                  |                   |
| startAbilityAsCaller2                                | Function    |                                  |                   |
|`startAbilityByCall`                     |Function||||
| startAbilityWithAccount0                             | Function    |                                  |                   |
| startAbilityWithAccount1                             | Function    |                                  |                   |
| startAbilityWithAccount2                             | Function    |                                  |                   |
|`startAbilityForResult0`                 |Function||||
|`startAbilityForResult1`                 |Function||||
|`startAbilityForResult2`                 |Function||||
| startAbilityForResultWithAccount0                    | Function    |                                  |                   |
| startAbilityForResultWithAccount1                    | Function    |                                  |                   |
| startAbilityForResultWithAccount2                    | Function    |                                  |                   |
|`startServiceExtensionAbility0`          |Function||||
|`startServiceExtensionAbility1`          |Function||||
|`startServiceExtensionAbilityWithAccount0`|Function||||
|`startServiceExtensionAbilityWithAccount1`|Function||||
|`stopServiceExtensionAbility0`           |Function||||
|`stopServiceExtensionAbility1`           |Function||||
|`stopServiceExtensionAbilityWithAccount0`|Function||||
|`stopServiceExtensionAbilityWithAccount1`|Function||||
|`terminateSelf0`                         |Function||||
|`terminateSelf1`                         |Function||||
|`terminateSelfWithResult0`               |Function||||
|`terminateSelfWithResult1`               |Function||||
| backToCallerAbilityWithResult                        | Function    |                                  |                   |
|`connectServiceExtensionAbility`         |Function||||
|`connectServiceExtensionAbilityWithAccount`|Function||||
|`disconnectServiceExtensionAbility0`     |Function||||
|`disconnectServiceExtensionAbility1`     |Function||||
|`setMissionLabel0`                       |Function||||
|`setMissionLabel1`                       |Function||||
|`setMissionIcon0`                        |Function||||
|`setMissionIcon1`                        |Function||||
|`restoreWindowStage`                     |Function||||
|`isTerminating`                          |Function||||
| startRecentAbility0                                  | Function    |                                  |                   |
| startRecentAbility1                                  | Function    |                                  |                   |
| startRecentAbility2                                  | Function    |                                  |                   |
|`reportDrawnCompleted`                   |Function||||
|`startAbilityByType0`                    |Function||||
|`startAbilityByType1`                    |Function||||
|`requestModalUIExtension0`               |Function||||
|`requestModalUIExtension1`               |Function||||
|`openAtomicService`                      |Function||||
|`moveAbilityToBackground`                |Function||||
|`showAbility`                            |Function||||
|`hideAbility`                            |Function||||
| setRestoreEnabled                                    | Function    |                                  |                   |
|`setAbilityInstanceInfo`                 |Function||||
|`revokeDelegator`                        |Function||||
|`setColorMode`                           |Function||||
|`startAppServiceExtensionAbility`        |Function||||
|`stopAppServiceExtensionAbility`         |Function||||
|`connectAppServiceExtensionAbility`      |Function||||
|`disconnectAppServiceExtensionAbility`   |Function||||
|`getAbilityInfo`                         |Property||||
|`setAbilityInfo`                         |Property||||
|`getCurrentHapModuleInfo`                |Property||||
|`setCurrentHapModuleInfo`                |Property||||
|`getConfig`                              |Property||||
|`setConfig`                              |Property||||
|`getWindowStage`                         |Property||||
|`setWindowStage`                         |Property||||
|*UICommonEvent*| *Class* | Andrey Khudenkikh | testskipped | | |
|`construct`| Function | Andrey Khudenkikh | done | test blocked | Compilation error: Cannot find type 'BuilderNode' |
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
|*UIContext*| *Class* | | out of scope | | |
|`construct`                         |Function|| out of scope || external object |
|`getFont`                           |Function|| out of scope || external object |
|`isAvailable`                       |Function|| out of scope || external object |
|`getMediaQuery`                     |Function|| out of scope || external object |
|`getUIInspector`                    |Function|| out of scope || external object |
|`getFilteredInspectorTree`          |Function|| out of scope || external object |
|`getFilteredInspectorTreeById`      |Function|| out of scope || external object |
|`getRouter`                         |Function|| out of scope || external object |
|`getPromptAction`                   |Function|| out of scope || external object |
|`getComponentUtils`                 |Function|| out of scope || external object |
|`getUIObserver`                     |Function|| out of scope || external object |
|`getOverlayManager`                 |Function|| out of scope || external object |
|`setOverlayManagerOptions`          |Function|| out of scope || external object |
|`getOverlayManagerOptions`          |Function|| out of scope || external object |
|`createAnimator`                    |Function|| out of scope || external object |
|`animateTo`                         |Function|| out of scope || external object |
|`showAlertDialog`                   |Function|| out of scope || external object |
|`showActionSheet`                   |Function|| out of scope || external object |
|`showDatePickerDialog`              |Function|| out of scope || external object |
|`showTimePickerDialog`              |Function|| out of scope || external object |
|`showTextPickerDialog`              |Function|| out of scope || external object |
|`runScopedTask`                     |Function|| out of scope || external object |
|`setKeyboardAvoidMode`              |Function|| out of scope || external object |
|`getKeyboardAvoidMode`              |Function|| out of scope || external object |
|`setPixelRoundMode`                 |Function|| out of scope || external object |
|`getPixelRoundMode`                 |Function|| out of scope || external object |
|`dispatchKeyEvent`                  |Function|| out of scope || external object |
|`getAtomicServiceBar`               |Function|| out of scope || external object |
|`getDragController`                 |Function|| out of scope || external object |
|`getMeasureUtils`                   |Function|| out of scope || external object |
|`keyframeAnimateTo`                 |Function|| out of scope || external object |
|`getFocusController`                |Function|| out of scope || external object |
|`animateToImmediately`              |Function|| out of scope || external object |
|`getFrameNodeById`                  |Function|| out of scope || external object |
|`getAttachedFrameNodeById`          |Function|| out of scope || external object |
|`getFrameNodeByUniqueId`            |Function|| out of scope || external object |
|`getPageInfoByUniqueId`             |Function|| out of scope || external object |
|`getNavigationInfoByUniqueId`       |Function|| out of scope || external object |
|`setDynamicDimming`                 |Function|| out of scope || external object |
|`getCursorController`               |Function|| out of scope || external object |
|`getContextMenuController`          |Function|| out of scope || external object |
|`getComponentSnapshot`              |Function|| out of scope || external object |
|`vp2px`                             |Function|| out of scope || external object |
|`px2vp`                             |Function|| out of scope || external object |
|`fp2px`                             |Function|| out of scope || external object |
|`px2fp`                             |Function|| out of scope || external object |
|`lpx2px`                            |Function|| out of scope || external object |
|`px2lpx`                            |Function|| out of scope || external object |
|`getSharedLocalStorage`             |Function|| out of scope || external object |
|`getHostContext`                    |Function|| out of scope || external object |
|`getWindowName`                     |Function|| out of scope || external object |
|`getWindowWidthBreakpoint`          |Function|| out of scope || external object |
|`getWindowHeightBreakpoint`         |Function|| out of scope || external object |
|`openBindSheet`                     |Function|| out of scope || external object |
|`updateBindSheet`                   |Function|| out of scope || external object |
|`closeBindSheet`                    |Function|| out of scope || external object |
|`postFrameCallback`                 |Function|| out of scope || external object |
|`postDelayedFrameCallback`          |Function|| out of scope || external object |
|`requireDynamicSyncScene`           |Function|| out of scope || external object |
|`clearResourceCache`                |Function|| out of scope || external object |
|`isFollowingSystemFontScale`        |Function|| out of scope || external object |
|`getMaxFontScale`                   |Function|| out of scope || external object |
|`bindTabsToScrollable`              |Function|| out of scope || external object |
|`unbindTabsFromScrollable`          |Function|| out of scope || external object |
|`bindTabsToNestedScrollable`        |Function|| out of scope || external object |
|`unbindTabsFromNestedScrollable`    |Function|| out of scope || external object |
|`enableSwipeBack`                   |Function|| out of scope || external object |
|`openBindContentCover`              |Function|| out of scope || external object |
|`freezeUINode0`                     |Function|| out of scope || external object |
|`freezeUINode1`                     |Function|| out of scope || external object |
|`getTextMenuController`             |Function|| out of scope || external object |
|`createUIContextWithoutWindow`      |Function|| out of scope || external object |
|`destroyUIContextWithoutWindow`     |Function|| out of scope || external object |
|`setUIStates`                       |Function|| out of scope || external object |
|`getFocusedUIContext`               |Function|| out of scope || external object |
|*UIContextAtomicServiceBar*| *Class* | | |
|`getBarRect`| Function | | |
|*Filter*|*Class*||||
|`construct`|Function||||
|`pixelStretch`|Function||||
|`blur`|Function||||
|`waterRipple`|Function||||
|`flyInFlyOutEffect`|Function||||
|`distort`|Function||||
|*VisualEffect*| *Class* |  |  |
|`construct`| Function | | |
|`backgroundColorBlender`| Function |  | | | napi, https://gitee.com/rri_opensource/koala_projects/issues/IC36Y3 |
|*UIExtensionProxy*| *Class* | Tuzhilkin Ivan | blocked IDL|  | |
|`construct`| Function | Tuzhilkin Ivan | testskipped |  | |
|`send`| Function | Tuzhilkin Ivan | blocked |  | blocked Arkoala. Want processing |
|`sendSync`| Function | Tuzhilkin Ivan | blocked |  | blocked Arkoala. Want processing |
|`onAsyncReceiverRegisterAsyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|`onSyncReceiverRegisterSyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|`offAsyncReceiverRegisterAsyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|`offSyncReceiverRegisterSyncReceiverRegister`| Function | Tuzhilkin Ivan | testskipped |  | |
|*UIInspector*         |*Class*||||
|`construct`           |Function||||
|`createComponentObserver`|Function||||
|*UIObserver*|*Class*||||
|`construct`                        |Function||||
|`onNavDestinationUpdate0`          |Function||||
|`offNavDestinationUpdate0`         |Function||||
|`onNavDestinationUpdate1`          |Function||||
|`offNavDestinationUpdate1`         |Function||||
|`onScrollEvent0`                   |Function||||
|`offScrollEvent0`                  |Function||||
|`onScrollEvent1`                   |Function||||
|`offScrollEvent1`                  |Function||||
|`onRouterPageUpdate`               |Function||||
|`offRouterPageUpdate`              |Function||||
|`onDensityUpdate`                  |Function||||
|`offDensityUpdate`                 |Function||||
|`onWillDraw`                       |Function||||
|`offWillDraw`                      |Function||||
|`onDidLayout`                      |Function||||
|`offDidLayout`                     |Function||||
|`onNavDestinationSwitch0`          |Function||||
|`offNavDestinationSwitch0`         |Function||||
|`onNavDestinationSwitch1`          |Function||||
|`offNavDestinationSwitch1`         |Function||||
|`onWillClick0`                     |Function||||
|`offWillClick0`                    |Function||||
|`onDidClick0`                      |Function||||
|`offDidClick0`                     |Function||||
|`onWillClick1`                     |Function||||
|`offWillClick1`                    |Function||||
|`onDidClick1`                      |Function||||
|`offDidClick1`                     |Function||||
|`onBeforePanStart`                 |Function||||
|`offBeforePanStart`                |Function||||
|`onBeforePanEnd`                   |Function||||
|`offBeforePanEnd`                  |Function||||
|`onAfterPanStart`                  |Function||||
|`offAfterPanStart`                 |Function||||
|`onAfterPanEnd`                    |Function||||
|`offAfterPanEnd`                   |Function||||
|`onNodeRenderState`                |Function||||
|`offNodeRenderState`               |Function||||
|`onTabContentUpdate0`              |Function||||
|`offTabContentUpdate0`             |Function||||
|`onTabContentUpdate1`              |Function||||
|`offTabContentUpdate1`             |Function||||
|`addGlobalGestureListener`         |Function||||
|`removeGlobalGestureListener`      |Function||||
| *DensityInfo*                                        | *Class*     |                                  |                   |
| construct                                            | Function    |                                  |                   |
| getContext                                           | Property    |                                  |                   |
| setContext                                           | Property    |                                  |                   |
| getDensity                                           | Property    |                                  |                   |
| setDensity                                           | Property    |                                  |                   |
|*RouterPageInfo*| *Class* | | |
|`construct`| Function | | |
|`getContext`|Property||||
|`setContext`|Property||||
|`getIndex`| Property | | |
|`setIndex`| Property | | |
|`getName`| Property | | |
|`setName`| Property | | |
|`getPath`| Property | | |
|`setPath`| Property | | |
|`getState`| Property | | |
|`setState`| Property | | |
|`getPageId`| Property | | |
|`setPageId`| Property | | |
|*Summary*|*Class*||||
|`construct`|Function||||
|`getSummary`|Property||||
|`getTotalSize`|Property||||
|*UnifiedData*| *Class* | Tuzhilkin Ivan | blocked IDL |  | |
|`construct0`| Function | Tuzhilkin Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY|
|`construct1`| Function | Tuzhilkin Ivan | blocked IDL |  | https://gitee.com/nikolay-igotti/idlize/issues/IBDHFY|
|`addRecord`|Function||||
|`getRecords`|Function||||
|*UnifiedRecord*|*Class*||||
|`construct0`       |Function||||
|`construct1`       |Function||||
|`getType`          |Function||||
|`getValue`         |Function||||
|*UrlStyle*| *Class* | Politov Mikhail | done |  | |
|`construct`| Function | Politov Mikhail | done |  | |
|`getUrl`| Function | Politov Mikhail | done |  | |
|*UserDataSpan*| *Class* | Pavelyev Ivan | |
|`construct`| Function | Pavelyev Ivan | in progress |
|*VideoController*| *Class* | Erokhin Ilya | done |  |  |
|`construct`| Function |Erokhin Ilya | done |  |  |
|`start`| Function | Erokhin Ilya | done |  |  |
|`pause`| Function | Erokhin Ilya | done |  |  |
|`stop`| Function | Erokhin Ilya | done |  |  |
|`requestFullscreen`| Function | Erokhin Ilya | done |  |  |
|`exitFullscreen`| Function | Erokhin Ilya | done |  |  |
|`setCurrentTimeDefault`|Function||||
|`setCurrentTimeWithMode`|Function||||
|`reset`| Function | Erokhin Ilya | done |  |  |
|*Want*|*Class*||||
|`construct`             |Function||||
|`getBundleName`         |Property||||
|`setBundleName`         |Property||||
|`getAbilityName`        |Property||||
|`setAbilityName`        |Property||||
|`getDeviceId`           |Property||||
|`setDeviceId`           |Property||||
|`getUri`                |Property||||
|`setUri`                |Property||||
|`getType`               |Property||||
|`setType`               |Property||||
|`getFlags`              |Property||||
|`setFlags`              |Property||||
|`getAction`             |Property||||
|`setAction`             |Property||||
|`getParameters`         |Property||||
|`setParameters`         |Property||||
|`getEntities`           |Property||||
|`setEntities`           |Property||||
|`getModuleName`         |Property||||
|`setModuleName`         |Property||||
|`getFds`                |Property||||
|*WaterFlowSections*| *Class* | Kovalev Sergey | done |  | |
|`construct`| Function |Kovalev Sergey | done |  | |
|`splice`| Function | Kovalev Sergey | done |  | |
|`push`| Function | Kovalev Sergey | done |  | |
|`update`| Function | Kovalev Sergey | done |  | |
|`values`| Function | Kovalev Sergey | done |  |  |
|`length`| Function | Kovalev Sergey | done |  | |
|*WebContextMenuParam*|*Class*| Erokhin Ilya | done ||
|`construct`          |Function| Erokhin Ilya | done ||
|`x`                  |Function| Erokhin Ilya | done ||
|`y`                  |Function| Erokhin Ilya | done ||
|`getLinkUrl`         |Function| Erokhin Ilya | done ||
|`getUnfilteredLinkUrl`|Function| Erokhin Ilya | done ||
|`getSourceUrl`       |Function| Erokhin Ilya | done ||
|`existsImageContents`|Function| Erokhin Ilya | done ||
|`getMediaType`       |Function| Erokhin Ilya | done ||
|`getSelectionText`   |Function| Erokhin Ilya | done ||
|`getSourceType`      |Function| Erokhin Ilya | done ||
|`getInputFieldType`  |Function| Erokhin Ilya | done ||
|`isEditable`         |Function| Erokhin Ilya | done ||
|`getEditStateFlags`  |Function| Erokhin Ilya | done ||
|`getPreviewWidth`    |Function| Erokhin Ilya | done ||
|`getPreviewHeight`   |Function| Erokhin Ilya | done ||
|*WebContextMenuResult*|*Class*||||
|`construct`           |Function||||
|`closeContextMenu`    |Function||||
|`copyImage`          |Function||||
|`copy`               |Function||||
|`paste`              |Function||||
|`cut`                |Function||||
|`selectAll`          |Function||||
|*WebCookie*| *Class* | Erokhin Ilya | done |  | |
|`construct`| Function |Erokhin Ilya | done |  |  |
|`setCookie`| Function | Erokhin Ilya | done |  |deprecated |
|`saveCookie`| Function | Erokhin Ilya | done |  |deprecated |
|*WebKeyboardController*|*Class*||||
|`construct`          |Function||||
|`insertText`         |Function||||
|`deleteForward`      |Function||||
|`deleteBackward`     |Function||||
|`sendFunctionKey`    |Function||||
|`close`              |Function||||
|*WebResourceError*|*Class*| Erokhin Ilya | done ||
|`construct`        |Function| Erokhin Ilya | done ||
|`getErrorInfo`     |Function| Erokhin Ilya | done ||
|`getErrorCode`     |Function| Erokhin Ilya | done ||
|*WebResourceRequest*|*Class*||||
|`construct`          |Function||||
|`getRequestHeader`   |Function||||
|`getRequestUrl`      |Function||||
|`isRequestGesture`   |Function||||
|`isMainFrame`        |Function||||
|`isRedirect`         |Function||||
|`getRequestMethod`   |Function||||
|*WebResourceResponse*|*Class*||||
|`construct`           |Function||||
|`getResponseData`    |Function||||
|`getResponseDataEx`  |Function||||
|`getResponseEncoding`|Function||||
|`getResponseMimeType`|Function||||
|`getReasonMessage`   |Function||||
|`getResponseHeader`  |Function||||
|`getResponseCode`    |Function||||
|`setResponseData`    |Function||||
|`setResponseEncoding`|Function||||
|`setResponseMimeType`|Function||||
|`setReasonMessage`   |Function||||
|`setResponseHeader`  |Function||||
|`setResponseCode`    |Function||||
|`setResponseIsReady` |Function||||
|`getResponseIsReady`|Function||||
|*BackForwardCacheOptions*          |*Class*||||
|`construct`                        |Function||||
|`getSize`                          |Property||||
|`setSize`                          |Property||||
|`getTimeToLive`                    |Property||||
|`setTimeToLive`                    |Property||||
|*BackForwardCacheSupportedFeatures*|*Class*||||
|`construct`                        |Function||||
|`getNativeEmbed`                   |Property||||
|`setNativeEmbed`                   |Property||||
|`getMediaTakeOver`                 |Property||||
|`setMediaTakeOver`                 |Property||||
|*BackForwardList*|*Class*||||
|`construct`        |Function||||
|`getItemAtIndex`   |Function||||
|`getCurrentIndex`  |Property||||
|`setCurrentIndex`  |Property||||
|`getSize`         |Property||||
|`setSize`          |Property||||
|*JsMessageExt*|*Class*||||
|`construct`    |Function||||
|`getType`      |Function||||
|`getString`    |Function||||
|`getNumber`    |Function||||
|`getBoolean`   |Function||||
|`getArrayBuffer`|Function||||
|`getArray`     |Function||||
|*MediaSourceInfo*         |*Class*||||
|`construct`               |Function||||
|`getType`                 |Property||||
|`setType`                 |Property||||
|`getSource`               |Property||||
|`setSource`               |Property||||
|`getFormat`               |Property||||
|`setFormat`               |Property||||
|*NativeMediaPlayerBridge*  |*Class*||||
|`construct`               |Function||||
|`updateRect`              |Function||||
|`play`                    |Function||||
|`pause`                   |Function||||
|`seek`                    |Function||||
|`setVolume`               |Function||||
|`setMuted`                |Function||||
|`setPlaybackRate`         |Function||||
|`release`                 |Function||||
|`enterFullscreen`         |Function||||
|`exitFullscreen`          |Function||||
|`getResumePlayer`|Property||||
|`setResumePlayer`|Property||||
|`getSuspendPlayer`|Property||||
|`setSuspendPlayer`|Property||||
|*NativeMediaPlayerHandler*|*Class*||||
|`construct`               |Function||||
|`handleStatusChanged`     |Function||||
|`handleVolumeChanged`     |Function||||
|`handleMutedChanged`      |Function||||
|`handlePlaybackRateChanged`|Function||||
|`handleDurationChanged`   |Function||||
|`handleTimeUpdate`        |Function||||
|`handleBufferedEndTimeChanged`|Function||||
|`handleEnded`             |Function||||
|`handleNetworkStateChanged`|Function||||
|`handleReadyStateChanged` |Function||||
|`handleFullscreenChanged` |Function||||
|`handleSeeking`           |Function||||
|`handleSeekFinished`      |Function||||
|`handleError`             |Function||||
|`handleVideoSizeChanged`  |Function||||
|*NativeMediaPlayerSurfaceInfo*|*Class*||||
|`construct`               |Function||||
|`getId`                   |Property||||
|`setId`                   |Property||||
|`getRect`                 |Property||||
|`setRect`                 |Property||||
|*PdfData*|*Class*||||
|`construct`      |Function||||
|`pdfArrayBuffer` |Function||||
|*WebDownloadDelegate*      |*Class*||||
|`construct`               |Function||||
|`onBeforeDownload`        |Function||||
|`onDownloadUpdated`       |Function||||
|`onDownloadFinish`        |Function||||
|`onDownloadFailed`        |Function||||
|*WebDownloadItem*          |*Class*||||
|`construct`               |Function||||
|`getGuid`                 |Function||||
|`getCurrentSpeed`         |Function||||
|`getPercentComplete`      |Function||||
|`getTotalBytes`           |Function||||
|`getState`                |Function||||
|`getLastErrorCode`        |Function||||
|`getMethod`               |Function||||
|`getMimeType`             |Function||||
|`getUrl`                  |Function||||
|`getSuggestedFileName`    |Function||||
|`start`                   |Function||||
|`cancel`                  |Function||||
|`pause`                   |Function||||
|`resume`                  |Function||||
|`getReceivedBytes`        |Function||||
|`getFullPath`             |Function||||
|`serialize`               |Function||||
|`deserialize`             |Function||||
|*WebHttpBodyStream*        |*Class*||||
|`construct`               |Function||||
|`initialize`              |Function||||
|`read`                    |Function||||
|`getSize`                  |Function||||
|`getPosition`             |Function||||
|`isChunked`               |Function||||
|`isEof`                   |Function||||
|`isInMemory`              |Function||||
|*WebMessageExt*|*Class*||||
|`construct`       |Function||||
|`getType`         |Function||||
|`getString`       |Function||||
|`getNumber`       |Function||||
|`getBoolean`      |Function||||
|`getArrayBuffer`  |Function||||
|`getArray`        |Function||||
|`getError`        |Function||||
|`setType`         |Function||||
|`setString`       |Function||||
|`setNumber`       |Function||||
|`setBoolean`      |Function||||
|`setArrayBuffer`  |Function||||
|`setArray`        |Function||||
|`setError`        |Function||||
|*WebMessagePort*|*Class*||||
|`construct`             |Function||||
|`close`                 |Function||||
|`postMessageEvent`      |Function||||
|`onMessageEvent`        |Function||||
|`postMessageEventExt`   |Function||||
|`onMessageEventExt`     |Function||||
|`getIsExtentionType`    |Property||||
|`setIsExtentionType`    |Property||||
|*WebResourceHandler*      |*Class*||||
|`construct`               |Function||||
|`didReceiveResponse`      |Function||||
|`didReceiveResponseBody`  |Function||||
|`didFinish`               |Function||||
|`didFail0`                 |Function||||
|`didFail1`                 |Function||||
|*WebSchemeHandler*        |*Class*||||
|`construct`               |Function||||
|`onRequestStart`          |Function||||
|`onRequestStop`           |Function||||
|*WebSchemeHandlerRequest*  |*Class*||||
|`construct`               |Function||||
|`getHeader`               |Function||||
|`getRequestUrl`           |Function||||
|`getRequestMethod`        |Function||||
|`getReferrer`             |Function||||
|`isMainFrame`             |Function||||
|`hasGesture`              |Function||||
|`getHttpBodyStream`       |Function||||
|`getRequestResourceType`  |Function||||
|`getFrameUrl`             |Function||||
|*WebSchemeHandlerResponse*|*Class*||||
|`construct`               |Function||||
|`setUrl`                  |Function||||
|`getUrl`                  |Function||||
|`setNetErrorCode`         |Function||||
|`getNetErrorCode`         |Function||||
|`setStatus`               |Function||||
|`getStatus`               |Function||||
|`setStatusText`           |Function||||
|`getStatusText`           |Function||||
|`setMimeType`             |Function||||
|`getMimeType`             |Function||||
|`setEncoding`             |Function||||
|`getEncoding`             |Function||||
|`setHeaderByName`         |Function||||
|`getHeaderByName`         |Function||||
|*WebviewController*|*Class*||||
|`construct`                         |Function||||
|`initializeWebEngine`               |Function||||
|`setHttpDns`                        |Function||||
|`setWebDebuggingAccess0`            |Function||||
|`enableSafeBrowsing`                |Function||||
|`isSafeBrowsingEnabled`             |Function||||
|`accessForward`                     |Function||||
|`accessBackward`                    |Function||||
|`accessStep`                        |Function||||
|`forward`                           |Function||||
|`backward`                          |Function||||
|`clearHistory`                      |Function||||
|`onActive`                          |Function||||
|`onInactive`                        |Function||||
|`refresh`                           |Function||||
|`loadData`                          |Function||||
|`loadUrl`                           |Function||||
|`storeWebArchive0`                  |Function||||
|`storeWebArchive1`                  |Function||||
|`zoom`                              |Function||||
|`zoomIn`                            |Function||||
|`zoomOut`                           |Function||||
|`getWebId`                          |Function||||
|`getUserAgent`                      |Function||||
|`getTitle`                          |Function||||
|`getPageHeight`                     |Function||||
|`backOrForward`                     |Function||||
|`requestFocus`                      |Function||||
|`createWebMessagePorts`             |Function||||
|`postMessage`                       |Function||||
|`stop`                              |Function||||
|`registerJavaScriptProxy`           |Function||||
|`deleteJavaScriptRegister`          |Function||||
|`searchAllAsync`                    |Function||||
|`clearMatches`                      |Function||||
|`searchNext`                        |Function||||
|`clearSslCache`                     |Function||||
|`clearClientAuthenticationCache`    |Function||||
|`runJavaScript0`                    |Function||||
|`runJavaScript1`                    |Function||||
|`runJavaScriptExt0`                 |Function||||
|`runJavaScriptExt1`                 |Function||||
|`createPdf0`                        |Function||||
|`createPdf1`                        |Function||||
|`getUrl`                            |Function||||
|`pageUp`                            |Function||||
|`pageDown`                          |Function||||
|`getOriginalUrl`                    |Function||||
|`getFavicon`                        |Function||||
|`setNetworkAvailable`               |Function||||
|`hasImage0`                         |Function||||
|`hasImage1`                         |Function||||
|`getBackForwardEntries`             |Function||||
|`removeCache`                       |Function||||
|`removeAllCache`                    |Function||||
|`scrollTo`                          |Function||||
|`scrollBy`                          |Function||||
|`slideScroll`                       |Function||||
|`serializeWebState`                 |Function||||
|`restoreWebState`                   |Function||||
|`customizeSchemes`                  |Function||||
|`getCertificate0`                   |Function||||
|`getCertificate1`                   |Function||||
|`setAudioMuted`                     |Function||||
|`prefetchPage`                      |Function||||
|`prepareForPageLoad`                |Function||||
|`setCustomUserAgent`                |Function||||
|`getCustomUserAgent`                |Function||||
|`setConnectionTimeout`              |Function||||
|`setDownloadDelegate`               |Function||||
|`startDownload`                     |Function||||
|`postUrl`                           |Function||||
|`createWebPrintDocumentAdapter`     |Function||||
|`getSecurityLevel`                  |Function||||
|`isIncognitoMode`                   |Function||||
|`setScrollable`                     |Function||||
|`getScrollable`                     |Function||||
|`setPrintBackground`                |Function||||
|`getPrintBackground`                |Function||||
|`getLastJavascriptProxyCallingFrameUrl`|Function||||
|`startCamera`                       |Function||||
|`stopCamera`                        |Function||||
|`closeCamera`                       |Function||||
|`pauseAllTimers`                    |Function||||
|`resumeAllTimers`                   |Function||||
|`stopAllMedia`                      |Function||||
|`resumeAllMedia`                    |Function||||
|`pauseAllMedia`                     |Function||||
|`closeAllMediaPresentations`        |Function||||
|`getMediaPlaybackState`             |Function||||
|`setWebSchemeHandler`               |Function||||
|`clearWebSchemeHandler`             |Function||||
|`setServiceWorkerWebSchemeHandler`  |Function||||
|`clearServiceWorkerWebSchemeHandler`|Function||||
|`enableIntelligentTrackingPrevention`|Function||||
|`isIntelligentTrackingPreventionEnabled`|Function||||
|`addIntelligentTrackingPreventionBypassingList`|Function||||
|`removeIntelligentTrackingPreventionBypassingList`|Function||||
|`clearIntelligentTrackingPreventionBypassingList`|Function||||
|`getDefaultUserAgent`              |Function||||
|`onCreateNativeMediaPlayer`         |Function||||
|`enableWholeWebPageDrawing`         |Function||||
|`webPageSnapshot`                   |Function||||
|`prefetchResource`                  |Function||||
|`clearPrefetchedResource`           |Function||||
|`setRenderProcessMode`              |Function||||
|`getRenderProcessMode`              |Function||||
|`terminateRenderProcess`            |Function||||
|`precompileJavaScript`              |Function||||
|`setHostIP`                         |Function||||
|`clearHostIP`                       |Function||||
|`warmupServiceWorker`               |Function||||
|`injectOfflineResources`            |Function||||
|`enableAdsBlock`                    |Function||||
|`isAdsBlockEnabled`                 |Function||||
|`isAdsBlockEnabledForCurPage`       |Function||||
|`getSurfaceId`                      |Function||||
|`setUrlTrustList`                   |Function||||
|`setPathAllowingUniversalAccess`    |Function||||
|`trimMemoryByPressureLevel`         |Function||||
|`enableBackForwardCache`            |Function||||
|`setBackForwardCacheOptions`        |Function||||
|`getScrollOffset`                   |Function||||
|`scrollByWithResult`                |Function||||
|`getLastHitTest`                    |Function||||
| setAppCustomUserAgent                                | Function    |                                  |                   |
| setUserAgentForHosts                                 | Function    |                                  |                   |
|`setWebDebuggingAccess1`            |Function||||
| getProgress                                          | Function    |                                  |                   |
|*Window*                           |*Class*||||
|`construct`                        |Function||||
|`hideWithAnimation0`               |Function||||
|`hideWithAnimation1`               |Function||||
|`showWindow0`                      |Function||||
|`showWindow1`                      |Function||||
|`showWithAnimation0`               |Function||||
|`showWithAnimation1`               |Function||||
|`destroyWindow0`                   |Function||||
|`destroyWindow1`                   |Function||||
|`moveWindowTo0`                    |Function||||
|`moveWindowTo1`                    |Function||||
|`resize0`                          |Function||||
|`resize1`                          |Function||||
|`getGlobalRect`                    |Function||||
|`getWindowProperties`              |Function||||
| getWindowDensityInfo                                 | Function    |                                  |                   |
|`getWindowAvoidArea`               |Function||||
| setSystemAvoidAreaEnabled                            | Function    |                                  |                   |
| isSystemAvoidAreaEnabled                             | Function    |                                  |                   |
|`setWindowLayoutFullScreen`        |Function||||
|`setWindowSystemBarEnable`         |Function||||
|`setSpecificSystemBarEnabled`      |Function||||
|`setWindowSystemBarProperties`     |Function||||
| getWindowSystemBarProperties                         | Function    |                                  |                   |
| setStatusBarColor                                    | Function    |                                  |                   |
| getStatusBarProperty                                 | Function    |                                  |                   |
| setGestureBackEnabled                                | Function    |                                  |                   |
| isGestureBackEnabled                                 | Function    |                                  |                   |
|`setPreferredOrientation0`         |Function||||
|`setPreferredOrientation1`         |Function||||
| getPreferredOrientation                              | Function    |                                  |                   |
|`loadContent0`                     |Function||||
|`loadContent1`                     |Function||||
|`getUIContext`                     |Function||||
|`setUIContent0`                    |Function||||
|`setUIContent1`                    |Function||||
|`isWindowShowing`                  |Function||||
|`onWindowSizeChange`               |Function||||
|`offWindowSizeChange`              |Function||||
|`onAvoidAreaChange`                |Function||||
|`offAvoidAreaChange`               |Function||||
|`onKeyboardHeightChange`           |Function||||
|`offKeyboardHeightChange`          |Function||||
|`onKeyboardDidShow`                |Function||||
|`offKeyboardDidShow`               |Function||||
|`onKeyboardDidHide`                |Function||||
|`offKeyboardDidHide`               |Function||||
|`onTouchOutside`                   |Function||||
|`offTouchOutside`                  |Function||||
|`onDisplayIdChange`                |Function||||
|`offDisplayIdChange`               |Function||||
|`onWindowVisibilityChange`         |Function||||
|`offWindowVisibilityChange`        |Function||||
|`onSystemDensityChange`            |Function||||
|`offSystemDensityChange`           |Function||||
|`onNoInteractionDetected`          |Function||||
|`offNoInteractionDetected`         |Function||||
|`onScreenshot`                     |Function||||
|`offScreenshot`                    |Function||||
|`onDialogTargetTouch`              |Function||||
|`offDialogTargetTouch`             |Function||||
|`onWindowEvent`                    |Function||||
|`offWindowEvent`                   |Function||||
|`onWindowStatusChange`             |Function||||
|`offWindowStatusChange`            |Function||||
|`onSubWindowClose`                 |Function||||
|`offSubWindowClose`                |Function||||
|`onWindowWillClose`                |Function||||
|`offWindowWillClose`               |Function||||
|`onWindowHighlightChange`          |Function||||
|`offWindowHighlightChange`         |Function||||
| setDialogBackGestureEnabled                          | Function    |                                  |                   |
|`isWindowSupportWideGamut0`        |Function||||
|`isWindowSupportWideGamut1`        |Function||||
|`setWindowColorSpace0`             |Function||||
|`setWindowColorSpace1`             |Function||||
| getWindowColorSpace                                  | Function    |                                  |                   |
|`setWindowBackgroundColor`         |Function||||
| setTopmost                                           | Function    |                                  |                   |
| setWindowTopmost                                     | Function    |                                  |                   |
| setWindowBrightness0                                 | Function    |                                  |                   |
| setWindowBrightness1                                 | Function    |                                  |                   |
|`setWindowFocusable0`              |Function||||
|`setWindowFocusable1`              |Function||||
| requestFocus                                         | Function    |                                  |                   |
| setExclusivelyHighlighted                            | Function    |                                  |                   |
| isWindowHighlighted                                  | Function    |                                  |                   |
|`setWindowKeepScreenOn0`           |Function||||
|`setWindowKeepScreenOn1`           |Function||||
| setWakeUpScreen                                      | Function    |                                  |                   |
|`setWindowPrivacyMode0`            |Function||||
|`setWindowPrivacyMode1`            |Function||||
| setSnapshotSkip                                      | Function    |                                  |                   |
|`setWindowTouchable0`              |Function||||
|`setWindowTouchable1`              |Function||||
| setHandwritingFlag                                   | Function    |                                  |                   |
|`snapshot0`                        |Function||||
|`snapshot1`                        |Function||||
| snapshotIgnorePrivacy                                | Function    |                                  |                   |
|`opacity`                          |Function||||
|`scale`                            |Function||||
|`rotate`                           |Function||||
|`translate`                        |Function||||
| setBlur                                              | Function    |                                  |                   |
| setBackdropBlur                                      | Function    |                                  |                   |
| setBackdropBlurStyle                                 | Function    |                                  |                   |
|`setShadow`                        |Function||||
| setWindowShadowRadius                                | Function    |                                  |                   |
| setCornerRadius                                      | Function    |                                  |                   |
| setWindowCornerRadius                                | Function    |                                  |                   |
| getWindowCornerRadius                                | Function    |                                  |                   |
| raiseToAppTop0                                       | Function    |                                  |                   |
| raiseToAppTop1                                       | Function    |                                  |                   |
|`setWaterMarkFlag0`                |Function||||
|`setWaterMarkFlag1`                |Function||||
| raiseAboveTarget0                                    | Function    |                                  |                   |
| raiseAboveTarget1                                    | Function    |                                  |                   |
| setRaiseByClickEnabled0                              | Function    |                                  |                   |
| setRaiseByClickEnabled1                              | Function    |                                  |                   |
|`minimize0`                        |Function||||
|`minimize1`                        |Function||||
|`maximize`                         |Function||||
|`hideNonSystemFloatingWindows0`    |Function||||
|`hideNonSystemFloatingWindows1`    |Function||||
| setSingleFrameComposerEnabled                        | Function    |                                  |                   |
|`keepKeyboardOnFocus`              |Function||||
|`recover`                          |Function||||
|`setWindowDecorVisible`            |Function||||
| getWindowDecorVisible                                | Function    |                                  |                   |
| setWindowTitleMoveEnabled                            | Function    |                                  |                   |
| setWindowTitle                                       | Function    |                                  |                   |
| setSubWindowModal0                                   | Function    |                                  |                   |
| setSubWindowModal1                                   | Function    |                                  |                   |
|`setWindowDecorHeight`             |Function||||
|`getWindowDecorHeight`             |Function||||
|`setDecorButtonStyle`              |Function||||
| getDecorButtonStyle                                  | Function    |                                  |                   |
| setTouchableAreas                                    | Function    |                                  |                   |
| getTitleButtonRect                                   | Function    |                                  |                   |
| setTitleButtonVisible                                | Function    |                                  |                   |
|`setWindowTitleButtonVisible`      |Function||||
|`startMoving0`                     |Function||||
|`startMoving1`                     |Function||||
|`onWindowTitleButtonRectChange`    |Function||||
|`offWindowTitleButtonRectChange`   |Function||||
| setWindowMask                                        | Function    |                                  |                   |
|`onWindowRectChange`               |Function||||
|`offWindowRectChange`              |Function||||
| onRotationChange                                     | Function    |                                  |                   |
| offRotationChange                                    | Function    |                                  |                   |
| setWindowGrayScale                                   | Function    |                                  |                   |
|`setImmersiveModeEnabledState`     |Function||||
| getImmersiveModeEnabledState                         | Function    |                                  |                   |
|`getWindowStatus`                  |Function||||
| isFocused                                            | Function    |                                  |                   |
| setParentWindow                                      | Function    |                                  |                   |
| setTitleAndDockHoverShown                            | Function    |                                  |                   |
| setWindowDelayRaiseOnDrag                            | Function    |                                  |                   |
| setSubWindowZLevel                                   | Function    |                                  |                   |
| getSubWindowZLevel                                   | Function    |                                  |                   |
|*WindowStage*                      |*Class*||||
|`construct`                        |Function||||
|`getMainWindow0`                   |Function||||
|`getMainWindow1`                   |Function||||
|`getMainWindowSync`                |Function||||
|`createSubWindow0`                 |Function||||
|`createSubWindow1`                 |Function||||
|`loadContent0`                     |Function||||
|`loadContent1`                     |Function||||
|`loadContent2`                     |Function||||
|`loadContentByName0`               |Function||||
|`loadContentByName1`               |Function||||
|`loadContentByName2`               |Function||||
|`onWindowStageEvent`               |Function||||
|`offWindowStageEvent`              |Function||||
|`onWindowStageClose`               |Function||||
|`offWindowStageClose`              |Function||||
|`disableWindowDecor`               |Function||||
|`setShowOnLockScreen`              |Function||||
| setDefaultDensityEnabled                             | Function    |                                  |                   |
| setCustomDensity                                     | Function    |                                  |                   |
| removeStartingWindow                                 | Function    |                                  |                   |
| setWindowModal                                       | Function    |                                  |                   |
| setWindowRectAutoSave0                               | Function    |                                  |                   |
| setWindowRectAutoSave1                               | Function    |                                  |                   |
| isWindowRectAutoSave                                 | Function    |                                  |                   |
|*WindowSize*|*Class*||||
|`construct`   |Function||||
|`getMaxWindowRatio`|Property||||
|`getMinWindowRatio`|Property||||
|`getMaxWindowWidth`|Property||||
|`getMinWindowWidth`|Property||||
|`getMaxWindowHeight`|Property||||
|`getMinWindowHeight`|Property||||
|*XComponentController*| *Class* | Tuzhilkin Ivan | blocked IDL |  | |
|`construct`| Function |Tuzhilkin Ivan | testskipped | pass | |
|`getXComponentSurfaceId`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setXComponentSurfaceRect`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getXComponentSurfaceRect`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`setXComponentSurfaceRotation`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getXComponentSurfaceRotation`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`startImageAnalyzer`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`stopImageAnalyzer`| Function | Tuzhilkin Ivan | testskipped | test blocked | demo blocked by https://gitee.com/nikolay-igotti/idlize/issues/IC4WKA |
|`getOnSurfaceCreated`| Property | | |
|`setOnSurfaceCreated`| Property | | |
|`getOnSurfaceChanged`| Property | | |
|`setOnSurfaceChanged`| Property | | |
|`getOnSurfaceDestroyed`| Property | | |
|`setOnSurfaceDestroyed`| Property | | |
| *GlobalScope*                                        | *Class*     |                                  |                   |
| $r                                                   | Function    |                                  |                   |
| $rawfile                                             | Function    |                                  |                   |
| animateTo                                            | Function    |                                  |                   |
| animateToImmediately                                 | Function    |                                  |                   |
| cursorControl_restoreDefault                         | Function    |                                  |                   |
| cursorControl_setCursor                              | Function    |                                  |                   |
| focusControl_requestFocus                            | Function    |                                  |                   |
| getRectangleById                                     | Function    |                                  |                   |
| postCardAction                                       | Function    |                                  |                   |
| Profiler_registerVsyncCallback                       | Function    |                                  |                   |
| Profiler_unregisterVsyncCallback                     | Function    |                                  |                   |
| setAppBgColor                                        | Function    |                                  |                   |
