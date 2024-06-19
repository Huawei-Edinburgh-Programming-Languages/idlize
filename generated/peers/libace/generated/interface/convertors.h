template <>
inline void convertor(const Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Int32* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Position* value) {
  // Ark_Length
  convertor(&value->x);
  // Ark_Length
  convertor(&value->y);
}
template <>
inline void convertor(const Opt_Position* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length* value) {
  // Ark_Length
  convertor(&value->topLeft);
  // Ark_Length
  convertor(&value->topRight);
  // Ark_Length
  convertor(&value->bottomLeft);
  // Ark_Length
  convertor(&value->bottomRight);
}
template <>
inline void convertor(const Opt_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length* value) {
  // Ark_Length
  convertor(&value->top);
  // Ark_Length
  convertor(&value->right);
  // Ark_Length
  convertor(&value->bottom);
  // Ark_Length
  convertor(&value->left);
}
template <>
inline void convertor(const Opt_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Tuple_Ark_Length_Ark_Length* value) {
  // Ark_Length
  convertor(&value->value0);
  // Ark_Length
  convertor(&value->value1);
}
template <>
inline void convertor(const Opt_Tuple_Ark_Length_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Color* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ColoringStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FontWeight* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Area* value) {
  // Ark_Length
  convertor(&value->width);
  // Ark_Length
  convertor(&value->height);
  // Position
  convertor(&value->position);
  // Position
  convertor(&value->globalPosition);
}
template <>
inline void convertor(const Opt_Area* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LeadingMarginPlaceholder* value) {
  // Ark_CustomObject
  convertor(&value->pixelMap);
  // Tuple_Ark_Length_Ark_Length
  convertor(&value->size);
}
template <>
inline void convertor(const Opt_LeadingMarginPlaceholder* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  // Ark_Color
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Ark_Resource
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextDecorationType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_CustomObject_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length* value) {
  // Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_CustomObject_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_CustomObject_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length* value) {
  // Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_CustomObject_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ICurve* value) {
}
template <>
inline void convertor(const Opt_ICurve* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Curve* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_CommonMethod* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextBaseController* value) {
}
template <>
inline void convertor(const Opt_TextBaseController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Function* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridRowSizeOption* value) {
  // Ark_Length
  convertor(&value->xs);
  // Ark_Length
  convertor(&value->sm);
  // Ark_Length
  convertor(&value->md);
  // Ark_Length
  convertor(&value->lg);
  // Ark_Length
  convertor(&value->xl);
  // Ark_Length
  convertor(&value->xxl);
}
template <>
inline void convertor(const Opt_GridRowSizeOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CanvasPattern* value) {
}
template <>
inline void convertor(const Opt_CanvasPattern* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CanvasGradient* value) {
}
template <>
inline void convertor(const Opt_CanvasGradient* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SheetSize* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Ark_Resource* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Color_Ark_String_Ark_Resource_Ark_ColoringStrategy* value) {
  // Ark_Color
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Ark_ColoringStrategy
  if (value->selector == 3) {
    convertor(value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Color_Ark_String_Ark_Resource_Ark_ColoringStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ShadowType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FontStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_Resource* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_FontWeight_Ark_Number_Ark_String* value) {
  // Ark_FontWeight
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_FontWeight_Ark_Number_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SourceTool* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SourceType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const EventTarget* value) {
  // Area
  convertor(&value->area);
}
template <>
inline void convertor(const Opt_EventTarget* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorLayoutStyle* value) {
  // Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  convertor(&value->margin);
  // Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  convertor(&value->borderRadius);
}
template <>
inline void convertor(const Opt_RichEditorLayoutStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ImageFit* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ImageSpanAlignment* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Tuple_Ark_Number_Ark_Number* value) {
  // Ark_Number
  convertor(&value->value0);
  // Ark_Number
  convertor(&value->value1);
}
template <>
inline void convertor(const Opt_Tuple_Ark_Number_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LineBreakStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_WordBreak* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_LeadingMarginPlaceholder* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // LeadingMarginPlaceholder
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_LeadingMarginPlaceholder* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SymbolRenderingStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SymbolEffectStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Ark_FontWeight_Ark_String* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_FontWeight
  if (value->selector == 1) {
    convertor(value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Ark_FontWeight_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const ResourceColor* value);
inline void generateStdArrayDefinition(string* result, const Array_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  int32_t count = value->length;
  result->append("std::array<ResourceColor, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const ResourceColor*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const ResourceColor*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Ark_String_Ark_Resource* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_type_Ark_TextDecorationType_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  // Ark_TextDecorationType
  convertor(value->type);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
}
template <>
inline void convertor(const Opt_Literal_type_Ark_TextDecorationType_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_LeadingMarginPlaceholder* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // LeadingMarginPlaceholder
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_LeadingMarginPlaceholder* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextOverflow* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ImageAttachmentLayoutStyle* value) {
  // Union_Ark_CustomObject_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  convertor(&value->margin);
  // Union_Ark_CustomObject_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  convertor(&value->padding);
  // Union_Ark_CustomObject_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  convertor(&value->borderRadius);
}
template <>
inline void convertor(const Opt_ImageAttachmentLayoutStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SizeOptions* value) {
  // Ark_Length
  convertor(&value->width);
  // Ark_Length
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_SizeOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const ShadowOptions* value);
inline void generateStdArrayDefinition(string* result, const Array_ShadowOptions* value) {
  int32_t count = value->length;
  result->append("std::array<ShadowOptions, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const ShadowOptions*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_ShadowOptions* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const ShadowOptions*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_ShadowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextDecorationStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Curve_ICurve* value) {
  // Ark_Curve
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // ICurve
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Curve_ICurve* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_CommonShapeMethod* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextEditControllerEx* value) {
}
template <>
inline void convertor(const Opt_TextEditControllerEx* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_CustomObject* value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_CustomObject* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_CustomObject, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Ark_CustomObject*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_CustomObject* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Ark_CustomObject*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TitleHeight* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Function_Ark_Undefined* value) {
  // Ark_Function
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_GridRowSizeOption* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // GridRowSizeOption
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_GridRowSizeOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number* value);
inline void generateStdArrayDefinition(string* result, const Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number* value) {
  int32_t count = value->length;
  result->append("std::array<Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_GradientDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Ark_String* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Ark_String
  if (value->selector == 3) {
    convertor(&value->value3);
  }
  // Ark_String
  if (value->selector == 4) {
    convertor(&value->value4);
  }
  // Ark_String
  if (value->selector == 5) {
    convertor(&value->value5);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Ark_String
  if (value->selector == 3) {
    convertor(&value->value3);
  }
  // Ark_String
  if (value->selector == 4) {
    convertor(&value->value4);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_String_Ark_String* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_String_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_Number_CanvasGradient_CanvasPattern* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // CanvasGradient
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // CanvasPattern
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_Number_CanvasGradient_CanvasPattern* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CanvasPath* value) {
}
template <>
inline void convertor(const Opt_CanvasPath* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BadgePosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BorderStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_SheetSize_Ark_Length* value) {
  // Ark_SheetSize
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_SheetSize_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TransitionEffect* value) {
}
template <>
inline void convertor(const Opt_TransitionEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MenuPreviewMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ShadowStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ShadowOptions* value) {
  // Union_Ark_Number_Ark_Resource
  convertor(&value->radius);
  // Ark_ShadowType
  convertor(&value->type);
  // Union_Ark_Color_Ark_String_Ark_Resource_Ark_ColoringStrategy
  convertor(&value->color);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetX);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetY);
  // Ark_Boolean
  convertor(&value->fill);
}
template <>
inline void convertor(const Opt_ShadowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
}
template <>
inline void convertor(const Opt_Literal_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Font* value) {
  // Ark_Length
  convertor(&value->size);
  // Union_Ark_FontWeight_Ark_Number_Ark_String
  convertor(&value->weight);
  // Union_Ark_String_Ark_Resource
  convertor(&value->family);
  // Ark_FontStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_Font* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_OutlineStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const TouchObject* value);
inline void generateStdArrayDefinition(string* result, const Array_TouchObject* value) {
  int32_t count = value->length;
  result->append("std::array<TouchObject, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const TouchObject*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_TouchObject* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const TouchObject*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_TouchObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TouchType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BaseEvent* value) {
  // EventTarget
  convertor(&value->target);
  // Ark_Number
  convertor(&value->timestamp);
  // Ark_SourceType
  convertor(value->source);
  // Ark_Number
  convertor(&value->axisHorizontal);
  // Ark_Number
  convertor(&value->axisVertical);
  // Ark_Number
  convertor(&value->pressure);
  // Ark_Number
  convertor(&value->tiltX);
  // Ark_Number
  convertor(&value->tiltY);
  // Ark_SourceTool
  convertor(value->sourceTool);
}
template <>
inline void convertor(const Opt_BaseEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_String* value);
template <>
inline void WriteToString(string* result, const Ark_String* value);
template <>
inline void WriteToString(string* result, const Map_Ark_String_Ark_String* value) {
  result->append("{");
  int32_t count = value->size;
  for (int i = 0; i < count; i++) {
    if (i > 0) result->append(", ");
    WriteToString(result, (const Ark_String*)&value->keys[i]);
    result->append(": ");
    WriteToString(result, (const Ark_String*)&value->values[i]);
  }
  result->append("}");
}
template <>
inline void convertor(const Opt_Map_Ark_String_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WebResourceRequest* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorImageSpanStyleResult* value) {
  // Tuple_Ark_Number_Ark_Number
  convertor(&value->size);
  // Ark_ImageSpanAlignment
  convertor(value->verticalAlign);
  // Ark_ImageFit
  convertor(value->objectFit);
  // RichEditorLayoutStyle
  convertor(&value->layoutStyle);
}
template <>
inline void convertor(const Opt_RichEditorImageSpanStyleResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorSpanPosition* value) {
  // Ark_Number
  convertor(&value->spanIndex);
  // Tuple_Ark_Number_Ark_Number
  convertor(&value->spanRange);
}
template <>
inline void convertor(const Opt_RichEditorSpanPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorParagraphStyle* value) {
  // Ark_TextAlign
  convertor(&value->textAlign);
  // Union_Ark_Length_LeadingMarginPlaceholder
  convertor(&value->leadingMargin);
  // Ark_WordBreak
  convertor(&value->wordBreak);
  // Ark_LineBreakStrategy
  convertor(&value->lineBreakStrategy);
}
template <>
inline void convertor(const Opt_RichEditorParagraphStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorSymbolSpanStyle* value) {
  // Union_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->fontSize);
  // Array_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->fontColor);
  // Union_Ark_Number_Ark_FontWeight_Ark_String
  convertor(&value->fontWeight);
  // Ark_SymbolEffectStrategy
  convertor(&value->effectStrategy);
  // Ark_SymbolRenderingStrategy
  convertor(&value->renderingStrategy);
}
template <>
inline void convertor(const Opt_RichEditorSymbolSpanStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorTextStyleResult* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->fontColor);
  // Ark_Number
  convertor(&value->fontSize);
  // Ark_FontStyle
  convertor(value->fontStyle);
  // Ark_Number
  convertor(&value->fontWeight);
  // Ark_String
  convertor(&value->fontFamily);
  // Literal_type_Ark_TextDecorationType_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->decoration);
  // Ark_Number
  convertor(&value->letterSpacing);
  // Ark_Number
  convertor(&value->lineHeight);
  // Ark_String
  convertor(&value->fontFeature);
}
template <>
inline void convertor(const Opt_RichEditorTextStyleResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CustomSpan* value) {
}
template <>
inline void convertor(const Opt_CustomSpan* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LineHeightStyle* value) {
  // Ark_Number
  convertor(&value->lineHeight);
}
template <>
inline void convertor(const Opt_LineHeightStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ParagraphStyle* value) {
  // Ark_TextAlign
  convertor(&value->textAlign);
  // Ark_Number
  convertor(&value->textIndent);
  // Ark_Number
  convertor(&value->maxLines);
  // Ark_TextOverflow
  convertor(&value->overflow);
  // Ark_WordBreak
  convertor(&value->wordBreak);
  // Union_Ark_Number_LeadingMarginPlaceholder
  convertor(&value->leadingMargin);
}
template <>
inline void convertor(const Opt_ParagraphStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ImageAttachment* value) {
  // Ark_CustomObject
  convertor(&value->value);
  // SizeOptions
  convertor(&value->size);
  // Ark_ImageSpanAlignment
  convertor(&value->verticalAlign);
  // Ark_ImageFit
  convertor(&value->objectFit);
  // ImageAttachmentLayoutStyle
  convertor(&value->layoutStyle);
}
template <>
inline void convertor(const Opt_ImageAttachment* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GestureStyle* value) {
}
template <>
inline void convertor(const Opt_GestureStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextShadowStyle* value) {
  // Array_ShadowOptions
  convertor(&value->textShadow);
}
template <>
inline void convertor(const Opt_TextShadowStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LetterSpacingStyle* value) {
  // Ark_Number
  convertor(&value->letterSpacing);
}
template <>
inline void convertor(const Opt_LetterSpacingStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BaselineOffsetStyle* value) {
  // Ark_Number
  convertor(&value->baselineOffset);
}
template <>
inline void convertor(const Opt_BaselineOffsetStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DecorationStyle* value) {
  // Ark_TextDecorationType
  convertor(value->type);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_TextDecorationStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_DecorationStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextStyle* value) {
  // Ark_WordBreak
  convertor(&value->wordBreak);
}
template <>
inline void convertor(const Opt_TextStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollAnimationOptions* value) {
  // Ark_Number
  convertor(&value->duration);
  // Union_Ark_Curve_ICurve
  convertor(&value->curve);
  // Ark_Boolean
  convertor(&value->canOverScroll);
}
template <>
inline void convertor(const Opt_ScrollAnimationOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_CustomObject_Ark_Resource* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_CustomObject_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_ImageAnalyzerController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_ImageAnalyzerType* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_ImageAnalyzerType* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_ImageAnalyzerType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WebController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PlaybackSpeed* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Number* value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_Number* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Number, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Ark_Number*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_Number* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Ark_Number*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_String* value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_String* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_String, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Ark_String*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_String* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Ark_String*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const TextCascadePickerRangeContent* value);
inline void generateStdArrayDefinition(string* result, const Array_TextCascadePickerRangeContent* value) {
  int32_t count = value->length;
  result->append("std::array<TextCascadePickerRangeContent, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const TextCascadePickerRangeContent*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_TextCascadePickerRangeContent* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const TextCascadePickerRangeContent*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_TextCascadePickerRangeContent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const TextPickerRangeContent* value);
inline void generateStdArrayDefinition(string* result, const Array_TextPickerRangeContent* value) {
  int32_t count = value->length;
  result->append("std::array<TextPickerRangeContent, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const TextPickerRangeContent*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_TextPickerRangeContent* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const TextPickerRangeContent*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_TextPickerRangeContent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Array_Ark_String* value);
inline void generateStdArrayDefinition(string* result, const Array_Array_Ark_String* value) {
  int32_t count = value->length;
  result->append("std::array<Array_Ark_String, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Array_Ark_String*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Array_Ark_String* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Array_Ark_String*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Array_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Undefined* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextContentControllerBase* value) {
}
template <>
inline void convertor(const Opt_TextContentControllerBase* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MarqueeStartPolicy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_Number* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Indicator* value) {
}
template <>
inline void convertor(const Opt_Indicator* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RectAttribute* value) {
}
template <>
inline void convertor(const Opt_RectAttribute* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PathAttribute* value) {
}
template <>
inline void convertor(const Opt_PathAttribute* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const EllipseAttribute* value) {
}
template <>
inline void convertor(const Opt_EllipseAttribute* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CircleAttribute* value) {
}
template <>
inline void convertor(const Opt_CircleAttribute* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DividerOptions* value) {
  // Ark_Length
  convertor(&value->strokeWidth);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_Length
  convertor(&value->startMargin);
  // Ark_Length
  convertor(&value->endMargin);
}
template <>
inline void convertor(const Opt_DividerOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Length* value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_Length* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Length, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Ark_Length*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_Length* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Ark_Length*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const StyledStringController* value) {
}
template <>
inline void convertor(const Opt_StyledStringController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorBaseController* value) {
}
template <>
inline void convertor(const Opt_RichEditorBaseController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Ark_String_Array_Ark_CustomObject* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Array_Ark_CustomObject
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Ark_String_Array_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_TitleHeight_Ark_Length* value) {
  // Ark_TitleHeight
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_TitleHeight_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SwipeActionItem* value) {
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->builder);
  // Ark_Length
  convertor(&value->actionAreaDistance);
  // Ark_Function
  convertor(&value->onAction);
  // Ark_Function
  convertor(&value->onEnterActionArea);
  // Ark_Function
  convertor(&value->onExitActionArea);
  // Ark_Function
  convertor(&value->onStateChange);
}
template <>
inline void convertor(const Opt_SwipeActionItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BreakpointsReference* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridRowColumnOption* value) {
  // Ark_Number
  convertor(&value->xs);
  // Ark_Number
  convertor(&value->sm);
  // Ark_Number
  convertor(&value->md);
  // Ark_Number
  convertor(&value->lg);
  // Ark_Number
  convertor(&value->xl);
  // Ark_Number
  convertor(&value->xxl);
}
template <>
inline void convertor(const Opt_GridRowColumnOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GutterOption* value) {
  // Union_Ark_Length_GridRowSizeOption
  convertor(&value->x);
  // Union_Ark_Length_GridRowSizeOption
  convertor(&value->y);
}
template <>
inline void convertor(const Opt_GutterOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridColColumnOption* value) {
  // Ark_Number
  convertor(&value->xs);
  // Ark_Number
  convertor(&value->sm);
  // Ark_Number
  convertor(&value->md);
  // Ark_Number
  convertor(&value->lg);
  // Ark_Number
  convertor(&value->xl);
  // Ark_Number
  convertor(&value->xxl);
}
template <>
inline void convertor(const Opt_GridColColumnOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LinearGradient* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->angle);
  // Ark_GradientDirection
  convertor(&value->direction);
  // Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number
  convertor(&value->colors);
  // Ark_Boolean
  convertor(&value->repeating);
}
template <>
inline void convertor(const Opt_LinearGradient* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CanvasRenderer* value) {
  // Ark_Number
  convertor(&value->globalAlpha);
  // Ark_String
  convertor(&value->globalCompositeOperation);
  // Union_Ark_String_Ark_Number_CanvasGradient_CanvasPattern
  convertor(&value->fillStyle);
  // Union_Ark_String_Ark_Number_CanvasGradient_CanvasPattern
  convertor(&value->strokeStyle);
  // Ark_String
  convertor(&value->filter);
  // Ark_Boolean
  convertor(value->imageSmoothingEnabled);
  // Union_Ark_String_Ark_String_Ark_String
  convertor(&value->imageSmoothingQuality);
  // Union_Ark_String_Ark_String_Ark_String
  convertor(&value->lineCap);
  // Ark_Number
  convertor(&value->lineDashOffset);
  // Union_Ark_String_Ark_String_Ark_String
  convertor(&value->lineJoin);
  // Ark_Number
  convertor(&value->lineWidth);
  // Ark_Number
  convertor(&value->miterLimit);
  // Ark_Number
  convertor(&value->shadowBlur);
  // Ark_String
  convertor(&value->shadowColor);
  // Ark_Number
  convertor(&value->shadowOffsetX);
  // Ark_Number
  convertor(&value->shadowOffsetY);
  // Union_Ark_String_Ark_String_Ark_String
  convertor(&value->direction);
  // Ark_String
  convertor(&value->font);
  // Union_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String
  convertor(&value->textAlign);
  // Union_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String_Ark_String
  convertor(&value->textBaseline);
}
template <>
inline void convertor(const Opt_CanvasRenderer* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const CalendarDay* value);
inline void generateStdArrayDefinition(string* result, const Array_CalendarDay* value) {
  int32_t count = value->length;
  result->append("std::array<CalendarDay, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const CalendarDay*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_CalendarDay* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const CalendarDay*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_CalendarDay* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BadgeStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Union_Ark_Number_Ark_String
  convertor(&value->fontSize);
  // Union_Ark_Number_Ark_String
  convertor(&value->badgeSize);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->badgeColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->borderColor);
  // Ark_Length
  convertor(&value->borderWidth);
  // Union_Ark_Number_Ark_FontWeight_Ark_String
  convertor(&value->fontWeight);
}
template <>
inline void convertor(const Opt_BadgeStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_BadgePosition_Position* value) {
  // Ark_BadgePosition
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Position
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_BadgePosition_Position* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle* value) {
  // Ark_BorderStyle
  convertor(&value->top);
  // Ark_BorderStyle
  convertor(&value->right);
  // Ark_BorderStyle
  convertor(&value->bottom);
  // Ark_BorderStyle
  convertor(&value->left);
}
template <>
inline void convertor(const Opt_Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedEdgeColors* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->top);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->end);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->bottom);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->start);
}
template <>
inline void convertor(const Opt_LocalizedEdgeColors* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->top);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->right);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->bottom);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->left);
}
template <>
inline void convertor(const Opt_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedEdgeWidths* value) {
  // Ark_CustomObject
  convertor(&value->top);
  // Ark_CustomObject
  convertor(&value->end);
  // Ark_CustomObject
  convertor(&value->bottom);
  // Ark_CustomObject
  convertor(&value->start);
}
template <>
inline void convertor(const Opt_LocalizedEdgeWidths* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SheetTitleOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->title);
  // Union_Ark_String_Ark_Resource
  convertor(&value->subtitle);
}
template <>
inline void convertor(const Opt_SheetTitleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BlurStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ContextMenuAnimationOptions* value) {
  // Ark_CustomObject
  convertor(&value->scale);
  // TransitionEffect
  convertor(&value->transition);
  // Ark_CustomObject
  convertor(&value->hoverScale);
}
template <>
inline void convertor(const Opt_ContextMenuAnimationOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_MenuPreviewMode_Union_Ark_Function_Ark_Undefined* value) {
  // Ark_MenuPreviewMode
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_MenuPreviewMode_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Placement* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Boolean_Ark_Function* value) {
  // Ark_Boolean
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Function
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Boolean_Ark_Function* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_ShadowOptions_Ark_ShadowStyle* value) {
  // ShadowOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_ShadowStyle
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_ShadowOptions_Ark_ShadowStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ArrowPointPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Boolean_Literal_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  // Ark_Boolean
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Literal_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Boolean_Literal_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Color_Ark_String_Ark_Resource_Ark_Number* value) {
  // Ark_Color
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Ark_Number
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Color_Ark_String_Ark_Resource_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PopupMessageOptions* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->textColor);
  // Font
  convertor(&value->font);
}
template <>
inline void convertor(const Opt_PopupMessageOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_value_Ark_String_action_Ark_Function* value) {
  // Ark_String
  convertor(&value->value);
  // Ark_Function
  convertor(&value->action);
}
template <>
inline void convertor(const Opt_Literal_value_Ark_String_action_Ark_Function* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_DragPreviewMode* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_DragPreviewMode* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_DragPreviewMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_DragPreviewMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ClickEffectLevel* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_VerticalAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_HorizontalAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_span_Ark_Number_offset_Ark_Number* value) {
  // Ark_Number
  convertor(&value->span);
  // Ark_Number
  convertor(&value->offset);
}
template <>
inline void convertor(const Opt_Literal_span_Ark_Number_offset_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GestureInterface* value) {
}
template <>
inline void convertor(const Opt_GestureInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RotateOptions* value) {
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
  // Ark_Number
  convertor(&value->z);
  // Union_Ark_Number_Ark_String
  convertor(&value->centerX);
  // Union_Ark_Number_Ark_String
  convertor(&value->centerY);
  // Ark_Number
  convertor(&value->centerZ);
  // Ark_Number
  convertor(&value->perspective);
  // Union_Ark_Number_Ark_String
  convertor(&value->angle);
}
template <>
inline void convertor(const Opt_RotateOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScaleOptions* value) {
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
  // Ark_Number
  convertor(&value->z);
  // Union_Ark_Number_Ark_String
  convertor(&value->centerX);
  // Union_Ark_Number_Ark_String
  convertor(&value->centerY);
}
template <>
inline void convertor(const Opt_ScaleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TranslateOptions* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->x);
  // Union_Ark_Number_Ark_String
  convertor(&value->y);
  // Union_Ark_Number_Ark_String
  convertor(&value->z);
}
template <>
inline void convertor(const Opt_TranslateOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TransitionType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle* value) {
  // Ark_OutlineStyle
  convertor(&value->top);
  // Ark_OutlineStyle
  convertor(&value->right);
  // Ark_OutlineStyle
  convertor(&value->bottom);
  // Ark_OutlineStyle
  convertor(&value->left);
}
template <>
inline void convertor(const Opt_Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedBorderRadiuses* value) {
  // Ark_CustomObject
  convertor(&value->topStart);
  // Ark_CustomObject
  convertor(&value->topEnd);
  // Ark_CustomObject
  convertor(&value->bottomStart);
  // Ark_CustomObject
  convertor(&value->bottomEnd);
}
template <>
inline void convertor(const Opt_LocalizedBorderRadiuses* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BlurOptions* value) {
  // Tuple_Ark_Number_Ark_Number
  convertor(&value->grayscale);
}
template <>
inline void convertor(const Opt_BlurOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_AdaptiveColor* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ThemeColorMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WebKeyboardController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RenderProcessNotRespondingReason* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_EventResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TouchEvent* value) {
  // EventTarget
  convertor(&value->target);
  // Ark_Number
  convertor(&value->timestamp);
  // Ark_SourceType
  convertor(value->source);
  // Ark_Number
  convertor(&value->axisHorizontal);
  // Ark_Number
  convertor(&value->axisVertical);
  // Ark_Number
  convertor(&value->pressure);
  // Ark_Number
  convertor(&value->tiltX);
  // Ark_Number
  convertor(&value->tiltY);
  // Ark_SourceTool
  convertor(value->sourceTool);
  // Ark_TouchType
  convertor(value->type);
  // Array_TouchObject
  convertor(&value->touches);
  // Array_TouchObject
  convertor(&value->changedTouches);
  // Ark_Function
  convertor(&value->stopPropagation);
  // Ark_Function
  convertor(&value->preventDefault);
}
template <>
inline void convertor(const Opt_TouchEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NativeEmbedInfo* value) {
  // Ark_String
  convertor(&value->id);
  // Ark_String
  convertor(&value->type);
  // Ark_String
  convertor(&value->src);
  // Position
  convertor(&value->position);
  // Ark_Number
  convertor(&value->width);
  // Ark_Number
  convertor(&value->height);
  // Ark_String
  convertor(&value->url);
  // Ark_String
  convertor(&value->tag);
  // Map_Ark_String_Ark_String
  convertor(&value->params);
}
template <>
inline void convertor(const Opt_NativeEmbedInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NativeEmbedStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_WebNavigationType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_DataResubmissionHandler* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_ControllerHandler* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_ClientAuthenticationHandler* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SslError* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_SslErrorHandler* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WebContextMenuResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WebContextMenuParam* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_ScreenCaptureHandler* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_PermissionRequest* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_HttpAuthHandler* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_FullScreenExitHandler* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_FileSelectorParam* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_FileSelectorResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_WebResourceRequest* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // WebResourceRequest
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_WebResourceRequest* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WebResourceResponse* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WebResourceError* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_ConsoleMessage* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_JsResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_JsGeolocation* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextDeleteDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const RichEditorTextSpanResult* value);
inline void generateStdArrayDefinition(string* result, const Array_RichEditorTextSpanResult* value) {
  int32_t count = value->length;
  result->append("std::array<RichEditorTextSpanResult, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const RichEditorTextSpanResult*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_RichEditorTextSpanResult* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const RichEditorTextSpanResult*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_RichEditorTextSpanResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const RichEditorImageSpanResult* value);
inline void generateStdArrayDefinition(string* result, const Array_RichEditorImageSpanResult* value) {
  int32_t count = value->length;
  result->append("std::array<RichEditorImageSpanResult, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const RichEditorImageSpanResult*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_RichEditorImageSpanResult* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const RichEditorImageSpanResult*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_RichEditorImageSpanResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextRange* value) {
  // Ark_Number
  convertor(&value->start);
  // Ark_Number
  convertor(&value->end);
}
template <>
inline void convertor(const Opt_TextRange* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorImageSpanResult* value) {
  // RichEditorSpanPosition
  convertor(&value->spanPosition);
  // Ark_CustomObject
  convertor(&value->valuePixelMap);
  // Union_Ark_String_Ark_Resource
  convertor(&value->valueResourceStr);
  // RichEditorImageSpanStyleResult
  convertor(&value->imageStyle);
  // Tuple_Ark_Number_Ark_Number
  convertor(&value->offsetInSpan);
}
template <>
inline void convertor(const Opt_RichEditorImageSpanResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorTextSpanResult* value) {
  // RichEditorSpanPosition
  convertor(&value->spanPosition);
  // Ark_String
  convertor(&value->value);
  // RichEditorTextStyleResult
  convertor(&value->textStyle);
  // Tuple_Ark_Number_Ark_Number
  convertor(&value->offsetInSpan);
  // RichEditorSymbolSpanStyle
  convertor(&value->symbolSpanStyle);
  // Ark_Resource
  convertor(&value->valueResource);
  // RichEditorParagraphStyle
  convertor(&value->paragraphStyle);
  // Ark_String
  convertor(&value->previewText);
}
template <>
inline void convertor(const Opt_RichEditorTextSpanResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Union_RichEditorTextSpanResult_RichEditorImageSpanResult* value);
inline void generateStdArrayDefinition(string* result, const Array_Union_RichEditorTextSpanResult_RichEditorImageSpanResult* value) {
  int32_t count = value->length;
  result->append("std::array<Union_RichEditorTextSpanResult_RichEditorImageSpanResult, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Union_RichEditorTextSpanResult_RichEditorImageSpanResult*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Union_RichEditorTextSpanResult_RichEditorImageSpanResult* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Union_RichEditorTextSpanResult_RichEditorImageSpanResult*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Union_RichEditorTextSpanResult_RichEditorImageSpanResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RichEditorDeleteDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Object* value) {
}
template <>
inline void convertor(const Opt_Object* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NavDestinationMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ListItemGroupArea* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_AppRotation* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FoldStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const FingerInfo* value);
inline void generateStdArrayDefinition(string* result, const Array_FingerInfo* value) {
  int32_t count = value->length;
  result->append("std::array<FingerInfo, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const FingerInfo*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_FingerInfo* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const FingerInfo*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_FingerInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_GestureControl_GestureType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_DragBehavior* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_KeySource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_KeyType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MouseAction* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MouseButton* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RectResult* value) {
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
  // Ark_Number
  convertor(&value->width);
  // Ark_Number
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_RectResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SelectStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length* value) {
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_WebCaptureMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ArrayBuffer* value) {
}
template <>
inline void convertor(const Opt_ArrayBuffer* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Header* value);
inline void generateStdArrayDefinition(string* result, const Array_Header* value) {
  int32_t count = value->length;
  result->append("std::array<Header, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Header*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Header* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Header*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Header* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedPadding* value) {
  // Ark_CustomObject
  convertor(&value->top);
  // Ark_CustomObject
  convertor(&value->end);
  // Ark_CustomObject
  convertor(&value->bottom);
  // Ark_CustomObject
  convertor(&value->start);
}
template <>
inline void convertor(const Opt_LocalizedPadding* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TabBarSymbol* value) {
  // Ark_CustomObject
  convertor(&value->normal);
  // Ark_CustomObject
  convertor(&value->selected);
}
template <>
inline void convertor(const Opt_TabBarSymbol* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MenuPolicy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_TextStyle_DecorationStyle_BaselineOffsetStyle_LetterSpacingStyle_TextShadowStyle_GestureStyle_ImageAttachment_ParagraphStyle_LineHeightStyle_CustomSpan* value) {
  // TextStyle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // DecorationStyle
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // BaselineOffsetStyle
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // LetterSpacingStyle
  if (value->selector == 3) {
    convertor(&value->value3);
  }
  // TextShadowStyle
  if (value->selector == 4) {
    convertor(&value->value4);
  }
  // GestureStyle
  if (value->selector == 5) {
    convertor(&value->value5);
  }
  // ImageAttachment
  if (value->selector == 6) {
    convertor(&value->value6);
  }
  // ParagraphStyle
  if (value->selector == 7) {
    convertor(&value->value7);
  }
  // LineHeightStyle
  if (value->selector == 8) {
    convertor(&value->value8);
  }
  // CustomSpan
  if (value->selector == 9) {
    convertor(&value->value9);
  }
}
template <>
inline void convertor(const Opt_Union_TextStyle_DecorationStyle_BaselineOffsetStyle_LetterSpacingStyle_TextShadowStyle_GestureStyle_ImageAttachment_ParagraphStyle_LineHeightStyle_CustomSpan* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_StyledStringKey* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Axis* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_ScrollAnimationOptions_Ark_Boolean* value) {
  // ScrollAnimationOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Boolean
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_ScrollAnimationOptions_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PanDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_DpiFollowStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_WaterFlowLayoutMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_WaterFlowSections* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Scroller* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RRect* value) {
  // Ark_Number
  convertor(&value->left);
  // Ark_Number
  convertor(&value->top);
  // Ark_Number
  convertor(&value->width);
  // Ark_Number
  convertor(&value->height);
  // Ark_Number
  convertor(&value->radius);
}
template <>
inline void convertor(const Opt_RRect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DividerStyle* value) {
  // Ark_Length
  convertor(&value->strokeWidth);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_Length
  convertor(&value->startMargin);
  // Ark_Length
  convertor(&value->endMargin);
}
template <>
inline void convertor(const Opt_DividerStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_shown_Union_Ark_String_Ark_CustomObject_Ark_Resource_hidden_Union_Ark_String_Ark_CustomObject_Ark_Resource_switching_Opt_Union_Ark_String_Ark_CustomObject_Ark_Resource* value) {
  // Union_Ark_String_Ark_CustomObject_Ark_Resource
  convertor(&value->shown);
  // Union_Ark_String_Ark_CustomObject_Ark_Resource
  convertor(&value->hidden);
  // Union_Ark_String_Ark_CustomObject_Ark_Resource
  convertor(&value->switching);
}
template <>
inline void convertor(const Opt_Literal_shown_Union_Ark_String_Ark_CustomObject_Ark_Resource_hidden_Union_Ark_String_Ark_CustomObject_Ark_Resource_switching_Opt_Union_Ark_String_Ark_CustomObject_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_XComponentController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ImageAIOptions* value) {
  // Array_Ark_ImageAnalyzerType
  convertor(&value->types);
  // ImageAnalyzerController
  convertor(&value->aiController);
}
template <>
inline void convertor(const Opt_ImageAIOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_XComponentType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_WebController_Ark_CustomObject* value) {
  // WebController
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_WebController_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RenderMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_VideoController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Ark_String_Ark_PlaybackSpeed* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_PlaybackSpeed
  if (value->selector == 2) {
    convertor(value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Ark_String_Ark_PlaybackSpeed* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ToggleType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TimePickerFormat* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_TextTimerController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Array_Ark_Number* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Array_Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Array_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Array_Ark_String* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Array_Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Array_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Array_Ark_String_Array_Array_Ark_String_Ark_Resource_Array_TextPickerRangeContent_Array_TextCascadePickerRangeContent* value) {
  // Array_Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Array_Array_Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Array_TextPickerRangeContent
  if (value->selector == 3) {
    convertor(&value->value3);
  }
  // Array_TextCascadePickerRangeContent
  if (value->selector == 4) {
    convertor(&value->value4);
  }
}
template <>
inline void convertor(const Opt_Union_Array_Ark_String_Array_Array_Ark_String_Ark_Resource_Array_TextPickerRangeContent_Array_TextCascadePickerRangeContent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const IconOptions* value) {
  // Ark_Length
  convertor(&value->size);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Union_Ark_String_Ark_Resource
  convertor(&value->src);
}
template <>
inline void convertor(const Opt_IconOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_CancelButtonStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const UnderlineColor* value) {
  // Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Undefined
  convertor(&value->typing);
  // Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Undefined
  convertor(&value->normal);
  // Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Undefined
  convertor(&value->error);
  // Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Undefined
  convertor(&value->disable);
}
template <>
inline void convertor(const Opt_UnderlineColor* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextContentStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextInputStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_TextInputController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_TextClockController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_TextAreaController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MarqueeOptions* value) {
  // Ark_Boolean
  convertor(value->start);
  // Ark_Number
  convertor(&value->step);
  // Ark_Number
  convertor(&value->loop);
  // Ark_Boolean
  convertor(&value->fromStart);
  // Ark_Number
  convertor(&value->delay);
  // Ark_Boolean
  convertor(&value->fadeout);
  // Ark_MarqueeStartPolicy
  convertor(&value->marqueeStartPolicy);
}
template <>
inline void convertor(const Opt_MarqueeOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextController* value) {
}
template <>
inline void convertor(const Opt_TextController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_BottomTabBarStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_SubTabBarStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_icon_Opt_Union_Ark_String_Ark_Resource_text_Opt_Union_Ark_String_Ark_Resource* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->icon);
  // Union_Ark_String_Ark_Resource
  convertor(&value->text);
}
template <>
inline void convertor(const Opt_Literal_icon_Opt_Union_Ark_String_Ark_Resource_text_Opt_Union_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_AnimationMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LayoutStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_TabsController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BarPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_minSize_Union_Ark_String_Ark_Number* value) {
  // Union_Ark_String_Ark_Number
  convertor(&value->minSize);
}
template <>
inline void convertor(const Opt_Literal_minSize_Union_Ark_String_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ArrowStyle* value) {
  // Ark_Boolean
  convertor(&value->showBackground);
  // Ark_Boolean
  convertor(&value->isSidebarMiddle);
  // Ark_Length
  convertor(&value->backgroundSize);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_Length
  convertor(&value->arrowSize);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->arrowColor);
}
template <>
inline void convertor(const Opt_ArrowStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_DigitIndicator* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_DotIndicator* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Alignment* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_CircleAttribute_EllipseAttribute_PathAttribute_RectAttribute* value) {
  // CircleAttribute
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // EllipseAttribute
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // PathAttribute
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // RectAttribute
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_CircleAttribute_EllipseAttribute_PathAttribute_RectAttribute* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SliderBlockType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SliderStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_OptionWidthMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_SearchController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BarState* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ScrollBarDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_Array_Ark_Length* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Array_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_Array_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ScrollSnapAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ButtonType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SaveDescription* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SaveIconStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_TextDataDetectorType* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_TextDataDetectorType* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_TextDataDetectorType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RichEditorResponseType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ResponseType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorStyledStringController* value) {
}
template <>
inline void convertor(const Opt_RichEditorStyledStringController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorController* value) {
}
template <>
inline void convertor(const Opt_RichEditorController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LocalizedBarrierDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BarrierDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GuideLinePosition* value) {
  // Ark_Length
  convertor(&value->start);
  // Ark_Length
  convertor(&value->end);
}
template <>
inline void convertor(const Opt_GuideLinePosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radiusWidth_Opt_Union_Ark_Number_Ark_String_radiusHeight_Opt_Union_Ark_Number_Ark_String* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->width);
  // Union_Ark_Number_Ark_String
  convertor(&value->height);
  // Union_Ark_Number_Ark_String
  convertor(&value->radiusWidth);
  // Union_Ark_Number_Ark_String
  convertor(&value->radiusHeight);
}
template <>
inline void convertor(const Opt_Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radiusWidth_Opt_Union_Ark_Number_Ark_String_radiusHeight_Opt_Union_Ark_Number_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radius_Opt_Union_Ark_Number_Ark_String_Array_Ark_CustomObject* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->width);
  // Union_Ark_Number_Ark_String
  convertor(&value->height);
  // Union_Ark_Number_Ark_String_Array_Ark_CustomObject
  convertor(&value->radius);
}
template <>
inline void convertor(const Opt_Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radius_Opt_Union_Ark_Number_Ark_String_Array_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RadioIndicatorType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PluginComponentTemplate* value) {
  // Ark_String
  convertor(&value->source);
  // Ark_String
  convertor(&value->bundleName);
}
template <>
inline void convertor(const Opt_PluginComponentTemplate* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CircleStyleOptions* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_CustomObject
  convertor(&value->radius);
  // Ark_Boolean
  convertor(&value->enableWaveEffect);
}
template <>
inline void convertor(const Opt_CircleStyleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PasteDescription* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PasteIconStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PanelHeight* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NavigationType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ToolbarItemStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const ToolbarItem* value);
inline void generateStdArrayDefinition(string* result, const Array_ToolbarItem* value) {
  int32_t count = value->length;
  result->append("std::array<ToolbarItem, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const ToolbarItem*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_ToolbarItem* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const ToolbarItem*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_ToolbarItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const NavigationMenuItem* value);
inline void generateStdArrayDefinition(string* result, const Array_NavigationMenuItem* value) {
  int32_t count = value->length;
  result->append("std::array<NavigationMenuItem, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const NavigationMenuItem*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_NavigationMenuItem* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const NavigationMenuItem*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_NavigationMenuItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavigationCustomTitle* value) {
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->builder);
  // Union_Ark_TitleHeight_Ark_Length
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_NavigationCustomTitle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavigationCommonTitle* value) {
  // Ark_String
  convertor(&value->main);
  // Ark_String
  convertor(&value->sub);
}
template <>
inline void convertor(const Opt_NavigationCommonTitle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BarStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavDestinationCustomTitle* value) {
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->builder);
  // Union_Ark_TitleHeight_Ark_Length
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_NavDestinationCustomTitle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavDestinationCommonTitle* value) {
  // Ark_String
  convertor(&value->main);
  // Ark_String
  convertor(&value->sub);
}
template <>
inline void convertor(const Opt_NavDestinationCommonTitle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined* value) {
  // Union_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MenuItemOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->startIcon);
  // Ark_CustomObject
  convertor(&value->symbolStartIcon);
  // Union_Ark_String_Ark_Resource
  convertor(&value->content);
  // Union_Ark_String_Ark_Resource
  convertor(&value->endIcon);
  // Ark_CustomObject
  convertor(&value->symbolEndIcon);
  // Union_Ark_String_Ark_Resource
  convertor(&value->labelInfo);
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->builder);
}
template <>
inline void convertor(const Opt_MenuItemOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DividerStyleOptions* value) {
  // Ark_CustomObject
  convertor(&value->strokeWidth);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_CustomObject
  convertor(&value->startMargin);
  // Ark_CustomObject
  convertor(&value->endMargin);
}
template <>
inline void convertor(const Opt_DividerStyleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ASTCResource* value) {
  // Array_Ark_String
  convertor(&value->sources);
  // Ark_Number
  convertor(&value->column);
}
template <>
inline void convertor(const Opt_ASTCResource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LocationDescription* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LocationIconStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_strokeWidth_Ark_Length_color_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_startMargin_Opt_Ark_Length_endMargin_Opt_Ark_Length* value) {
  // Ark_Length
  convertor(&value->strokeWidth);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_Length
  convertor(&value->startMargin);
  // Ark_Length
  convertor(&value->endMargin);
}
template <>
inline void convertor(const Opt_Literal_strokeWidth_Ark_Length_color_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_startMargin_Opt_Ark_Length_endMargin_Opt_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ListItemGroupStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SwipeEdgeEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Function_Ark_Undefined_SwipeActionItem* value) {
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // SwipeActionItem
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Function_Ark_Undefined_SwipeActionItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_EditMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ListItemStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ChainEdgeEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_minLength_Ark_Length_maxLength_Ark_Length* value) {
  // Ark_Length
  convertor(&value->minLength);
  // Ark_Length
  convertor(&value->maxLength);
}
template <>
inline void convertor(const Opt_Literal_minLength_Ark_Length_maxLength_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_CustomObject
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ColorFilter* value) {
}
template <>
inline void convertor(const Opt_ColorFilter* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_GridRowDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BreakPoints* value) {
  // Array_Ark_String
  convertor(&value->value);
  // Ark_BreakpointsReference
  convertor(&value->reference);
}
template <>
inline void convertor(const Opt_BreakPoints* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_GridRowColumnOption* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // GridRowColumnOption
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_GridRowColumnOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_GutterOption* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // GutterOption
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_GutterOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SizeType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_GridColColumnOption* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // GridColColumnOption
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_GridColColumnOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_GridItemStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NestedScrollMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MultiShadowOptions* value) {
  // Union_Ark_Number_Ark_Resource
  convertor(&value->radius);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetX);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetY);
}
template <>
inline void convertor(const Opt_MultiShadowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // LinearGradient
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value);
inline void generateStdArrayDefinition(string* result, const Array_Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value) {
  int32_t count = value->length;
  result->append("std::array<Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FormShape* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FormRenderingMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FormDimension* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FlexSpaceOptions* value) {
  // Ark_CustomObject
  convertor(&value->main);
  // Ark_CustomObject
  convertor(&value->cross);
}
template <>
inline void convertor(const Opt_FlexSpaceOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FlexAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ItemAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FlexWrap* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FlexDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient* value);
inline void generateStdArrayDefinition(string* result, const Array_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient* value) {
  int32_t count = value->length;
  result->append("std::array<Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_DataPanelType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ModelType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Resource_Ark_CustomObject* value) {
  // Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Resource_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ColumnSplitDividerStyle* value) {
  // Ark_Length
  convertor(&value->startMargin);
  // Ark_Length
  convertor(&value->endMargin);
}
template <>
inline void convertor(const Opt_ColumnSplitDividerStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_IlluminatedType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LightSource* value) {
  // Ark_Length
  convertor(&value->positionX);
  // Ark_Length
  convertor(&value->positionY);
  // Ark_Length
  convertor(&value->positionZ);
  // Ark_Number
  convertor(&value->intensity);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
}
template <>
inline void convertor(const Opt_LightSource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_DrawingRenderingContext* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_CanvasRenderingContext2D* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_CalendarController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MonthData* value) {
  // Ark_Number
  convertor(&value->year);
  // Ark_Number
  convertor(&value->month);
  // Array_CalendarDay
  convertor(&value->data);
}
template <>
inline void convertor(const Opt_MonthData* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_year_Ark_Number_month_Ark_Number_day_Ark_Number* value) {
  // Ark_Number
  convertor(&value->year);
  // Ark_Number
  convertor(&value->month);
  // Ark_Number
  convertor(&value->day);
}
template <>
inline void convertor(const Opt_Literal_year_Ark_Number_month_Ark_Number_day_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextHeightAdaptivePolicy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Union_Ark_String_Ark_Resource* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_String_Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Union_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ButtonRole* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ControlSize* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ButtonStyleMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BadgeParam* value) {
  // Union_Ark_BadgePosition_Position
  convertor(&value->position);
  // BadgeStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_BadgeParam* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollMotion* value) {
}
template <>
inline void convertor(const Opt_ScrollMotion* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FrictionMotion* value) {
}
template <>
inline void convertor(const Opt_FrictionMotion* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SpringMotion* value) {
}
template <>
inline void convertor(const Opt_SpringMotion* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FunctionKey* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ScrollSizeMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SheetMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_BorderStyle_Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle* value) {
  // Ark_BorderStyle
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_BorderStyle_Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LocalizedEdgeColors* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedEdgeColors
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LocalizedEdgeColors* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_LocalizedEdgeWidths* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedEdgeWidths
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_LocalizedEdgeWidths* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_SheetTitleOptions_Union_Ark_Function_Ark_Undefined* value) {
  // SheetTitleOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_SheetTitleOptions_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SheetType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Boolean_Ark_Resource* value) {
  // Ark_Boolean
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Boolean_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Tuple_Union_Ark_SheetSize_Ark_Length_Opt_Union_Ark_SheetSize_Ark_Length_Opt_Union_Ark_SheetSize_Ark_Length* value) {
  // Union_Ark_SheetSize_Ark_Length
  convertor(&value->value0);
  // Opt_Union_Ark_SheetSize_Ark_Length
  convertor(&value->value1);
  // Opt_Union_Ark_SheetSize_Ark_Length
  convertor(&value->value2);
}
template <>
inline void convertor(const Opt_Tuple_Union_Ark_SheetSize_Ark_Length_Opt_Union_Ark_SheetSize_Ark_Length_Opt_Union_Ark_SheetSize_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BindOptions* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_Function
  convertor(&value->onAppear);
  // Ark_Function
  convertor(&value->onDisappear);
  // Ark_Function
  convertor(&value->onWillAppear);
  // Ark_Function
  convertor(&value->onWillDisappear);
}
template <>
inline void convertor(const Opt_BindOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ModalTransition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const MenuElement* value);
inline void generateStdArrayDefinition(string* result, const Array_MenuElement* value) {
  int32_t count = value->length;
  result->append("std::array<MenuElement, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const MenuElement*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_MenuElement* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const MenuElement*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_MenuElement* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ContextMenuOptions* value) {
  // Position
  convertor(&value->offset);
  // Ark_Placement
  convertor(&value->placement);
  // Ark_Boolean
  convertor(&value->enableArrow);
  // Ark_Length
  convertor(&value->arrowOffset);
  // Union_Ark_MenuPreviewMode_Union_Ark_Function_Ark_Undefined
  convertor(&value->preview);
  // Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  convertor(&value->borderRadius);
  // Ark_Function
  convertor(&value->onAppear);
  // Ark_Function
  convertor(&value->onDisappear);
  // Ark_Function
  convertor(&value->aboutToAppear);
  // Ark_Function
  convertor(&value->aboutToDisappear);
  // ContextMenuAnimationOptions
  convertor(&value->previewAnimationOptions);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_BlurStyle
  convertor(&value->backgroundBlurStyle);
  // TransitionEffect
  convertor(&value->transition);
}
template <>
inline void convertor(const Opt_ContextMenuOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CustomPopupOptions* value) {
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->builder);
  // Ark_Placement
  convertor(&value->placement);
  // Union_Ark_Color_Ark_String_Ark_Resource_Ark_Number
  convertor(&value->maskColor);
  // Union_Ark_Color_Ark_String_Ark_Resource_Ark_Number
  convertor(&value->popupColor);
  // Ark_Boolean
  convertor(&value->enableArrow);
  // Ark_Boolean
  convertor(&value->autoCancel);
  // Ark_Function
  convertor(&value->onStateChange);
  // Ark_Length
  convertor(&value->arrowOffset);
  // Ark_Boolean
  convertor(&value->showInSubWindow);
  // Union_Ark_Boolean_Literal_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->mask);
  // Ark_Length
  convertor(&value->targetSpace);
  // Position
  convertor(&value->offset);
  // Ark_Length
  convertor(&value->width);
  // Ark_ArrowPointPosition
  convertor(&value->arrowPointPosition);
  // Ark_Length
  convertor(&value->arrowWidth);
  // Ark_Length
  convertor(&value->arrowHeight);
  // Ark_Length
  convertor(&value->radius);
  // Union_ShadowOptions_Ark_ShadowStyle
  convertor(&value->shadow);
  // Ark_BlurStyle
  convertor(&value->backgroundBlurStyle);
  // Ark_Boolean
  convertor(&value->focusable);
  // TransitionEffect
  convertor(&value->transition);
  // Union_Ark_Boolean_Ark_Function
  convertor(&value->onWillDismiss);
}
template <>
inline void convertor(const Opt_CustomPopupOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PopupOptions* value) {
  // Ark_String
  convertor(&value->message);
  // Ark_Boolean
  convertor(&value->placementOnTop);
  // Ark_Placement
  convertor(&value->placement);
  // Literal_value_Ark_String_action_Ark_Function
  convertor(&value->primaryButton);
  // Literal_value_Ark_String_action_Ark_Function
  convertor(&value->secondaryButton);
  // Ark_Function
  convertor(&value->onStateChange);
  // Ark_Length
  convertor(&value->arrowOffset);
  // Ark_Boolean
  convertor(&value->showInSubWindow);
  // Union_Ark_Boolean_Literal_color_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->mask);
  // PopupMessageOptions
  convertor(&value->messageOptions);
  // Ark_Length
  convertor(&value->targetSpace);
  // Ark_Boolean
  convertor(&value->enableArrow);
  // Position
  convertor(&value->offset);
  // Union_Ark_Color_Ark_String_Ark_Resource_Ark_Number
  convertor(&value->popupColor);
  // Ark_Boolean
  convertor(&value->autoCancel);
  // Ark_Length
  convertor(&value->width);
  // Ark_ArrowPointPosition
  convertor(&value->arrowPointPosition);
  // Ark_Length
  convertor(&value->arrowWidth);
  // Ark_Length
  convertor(&value->arrowHeight);
  // Ark_Length
  convertor(&value->radius);
  // Union_ShadowOptions_Ark_ShadowStyle
  convertor(&value->shadow);
  // Ark_BlurStyle
  convertor(&value->backgroundBlurStyle);
  // TransitionEffect
  convertor(&value->transition);
  // Union_Ark_Boolean_Ark_Function
  convertor(&value->onWillDismiss);
}
template <>
inline void convertor(const Opt_PopupOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_ProgressMask* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_x_Opt_Ark_Number_y_Opt_Ark_Number* value) {
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
}
template <>
inline void convertor(const Opt_Literal_x_Opt_Ark_Number_y_Opt_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Boolean_Ark_Number* value) {
  // Ark_Boolean
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Boolean_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_DragPreviewMode_Array_Ark_DragPreviewMode* value) {
  // Ark_DragPreviewMode
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Array_Ark_DragPreviewMode
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_DragPreviewMode_Array_Ark_DragPreviewMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DragItemInfo* value) {
  // Ark_CustomObject
  convertor(&value->pixelMap);
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->builder);
  // Ark_String
  convertor(&value->extraInfo);
}
template <>
inline void convertor(const Opt_DragItemInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ClickEffect* value) {
  // Ark_ClickEffectLevel
  convertor(value->level);
  // Ark_Number
  convertor(&value->scale);
}
template <>
inline void convertor(const Opt_ClickEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Bias* value) {
  // Ark_Number
  convertor(&value->horizontal);
  // Ark_Number
  convertor(&value->vertical);
}
template <>
inline void convertor(const Opt_Bias* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedVerticalAlignParam* value) {
  // Ark_String
  convertor(&value->anchor);
  // Ark_VerticalAlign
  convertor(value->align);
}
template <>
inline void convertor(const Opt_LocalizedVerticalAlignParam* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedHorizontalAlignParam* value) {
  // Ark_String
  convertor(&value->anchor);
  // Ark_HorizontalAlign
  convertor(value->align);
}
template <>
inline void convertor(const Opt_LocalizedHorizontalAlignParam* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_anchor_Ark_String_align_Ark_VerticalAlign* value) {
  // Ark_String
  convertor(&value->anchor);
  // Ark_VerticalAlign
  convertor(value->align);
}
template <>
inline void convertor(const Opt_Literal_anchor_Ark_String_align_Ark_VerticalAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_anchor_Ark_String_align_Ark_HorizontalAlign* value) {
  // Ark_String
  convertor(&value->anchor);
  // Ark_HorizontalAlign
  convertor(value->align);
}
template <>
inline void convertor(const Opt_Literal_anchor_Ark_String_align_Ark_HorizontalAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_span_Ark_Number_offset_Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedEdges* value) {
  // Ark_CustomObject
  convertor(&value->top);
  // Ark_CustomObject
  convertor(&value->start);
  // Ark_CustomObject
  convertor(&value->bottom);
  // Ark_CustomObject
  convertor(&value->end);
}
template <>
inline void convertor(const Opt_LocalizedEdges* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Edges* value) {
  // Ark_Length
  convertor(&value->top);
  // Ark_Length
  convertor(&value->left);
  // Ark_Length
  convertor(&value->bottom);
  // Ark_Length
  convertor(&value->right);
}
template <>
inline void convertor(const Opt_Edges* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedPosition* value) {
  // Ark_CustomObject
  convertor(&value->start);
  // Ark_CustomObject
  convertor(&value->top);
}
template <>
inline void convertor(const Opt_LocalizedPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SharedTransitionEffectType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MotionPathOptions* value) {
  // Ark_String
  convertor(&value->path);
  // Ark_Number
  convertor(&value->from);
  // Ark_Number
  convertor(&value->to);
  // Ark_Boolean
  convertor(&value->rotatable);
}
template <>
inline void convertor(const Opt_MotionPathOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Curve_Ark_String_ICurve* value) {
  // Ark_Curve
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // ICurve
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Curve_Ark_String_ICurve* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const InvertOptions* value) {
  // Ark_Number
  convertor(&value->low);
  // Ark_Number
  convertor(&value->high);
  // Ark_Number
  convertor(&value->threshold);
  // Ark_Number
  convertor(&value->thresholdRange);
}
template <>
inline void convertor(const Opt_InvertOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MotionBlurAnchor* value) {
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
}
template <>
inline void convertor(const Opt_MotionBlurAnchor* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const FractionStop* value);
inline void generateStdArrayDefinition(string* result, const Array_Tuple_Ark_Number_Ark_Number* value) {
  int32_t count = value->length;
  result->append("std::array<FractionStop, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const FractionStop*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Tuple_Ark_Number_Ark_Number* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const FractionStop*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Tuple_Ark_Number_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GestureGroupInterface* value) {
}
template <>
inline void convertor(const Opt_GestureGroupInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RotationGestureInterface* value) {
}
template <>
inline void convertor(const Opt_RotationGestureInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SwipeGestureInterface* value) {
}
template <>
inline void convertor(const Opt_SwipeGestureInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PinchGestureInterface* value) {
}
template <>
inline void convertor(const Opt_PinchGestureInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PanGestureInterface* value) {
}
template <>
inline void convertor(const Opt_PanGestureInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LongPressGestureInterface* value) {
}
template <>
inline void convertor(const Opt_LongPressGestureInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TapGestureInterface* value) {
}
template <>
inline void convertor(const Opt_TapGestureInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TransitionOptions* value) {
  // Ark_TransitionType
  convertor(&value->type);
  // Ark_Number
  convertor(&value->opacity);
  // TranslateOptions
  convertor(&value->translate);
  // ScaleOptions
  convertor(&value->scale);
  // RotateOptions
  convertor(&value->rotate);
}
template <>
inline void convertor(const Opt_TransitionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ExpectedFrameRateRange* value) {
  // Ark_Number
  convertor(&value->min);
  // Ark_Number
  convertor(&value->max);
  // Ark_Number
  convertor(&value->expected);
}
template <>
inline void convertor(const Opt_ExpectedFrameRateRange* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FinishCallbackType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PlayMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle_Ark_OutlineStyle* value) {
  // Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_OutlineStyle
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle_Ark_OutlineStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_Ark_Length* value) {
  // Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LocalizedEdgeColors* value) {
  // Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedEdgeColors
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LocalizedEdgeColors* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_Resource_LinearGradient* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LinearGradient
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_Resource_LinearGradient* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RepeatMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_CustomObject_LocalizedEdgeWidths* value) {
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedEdgeWidths
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_CustomObject_LocalizedEdgeWidths* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle_Ark_BorderStyle* value) {
  // Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_BorderStyle
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle_Ark_BorderStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_Ark_Length_LocalizedBorderRadiuses* value) {
  // Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedBorderRadiuses
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_Ark_Length_LocalizedBorderRadiuses* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length_LocalizedEdgeWidths* value) {
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedEdgeWidths
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length_LocalizedEdgeWidths* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BlurStyleOptions* value) {
  // Ark_ThemeColorMode
  convertor(&value->colorMode);
  // Ark_AdaptiveColor
  convertor(&value->adaptiveColor);
  // Ark_Number
  convertor(&value->scale);
  // BlurOptions
  convertor(&value->blurOptions);
}
template <>
inline void convertor(const Opt_BlurStyleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BlurType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BlurStyleActivePolicy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ImageSize* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PixelRoundCalcPolicy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Rectangle* value) {
  // Ark_Length
  convertor(&value->x);
  // Ark_Length
  convertor(&value->y);
  // Ark_Length
  convertor(&value->width);
  // Ark_Length
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_Rectangle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Rectangle* value);
inline void generateStdArrayDefinition(string* result, const Array_Rectangle* value) {
  int32_t count = value->length;
  result->append("std::array<Rectangle, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const Rectangle*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Rectangle* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const Rectangle*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Rectangle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DrawModifier* value) {
}
template <>
inline void convertor(const Opt_DrawModifier* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TerminationInfo* value) {
  // Ark_Number
  convertor(&value->code);
  // Ark_CustomObject
  convertor(&value->want);
}
template <>
inline void convertor(const Opt_TerminationInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const AdsBlockedDetails* value) {
  // Ark_String
  convertor(&value->url);
  // Array_Ark_String
  convertor(&value->adsBlocked);
}
template <>
inline void convertor(const Opt_AdsBlockedDetails* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const WebKeyboardCallbackInfo* value) {
  // WebKeyboardController
  convertor(&value->controller);
  // Ark_CustomObject
  convertor(&value->attributes);
}
template <>
inline void convertor(const Opt_WebKeyboardCallbackInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ViewportFit* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RenderProcessNotRespondingData* value) {
  // Ark_String
  convertor(&value->jsStack);
  // Ark_Number
  convertor(&value->pid);
  // Ark_RenderProcessNotRespondingReason
  convertor(value->reason);
}
template <>
inline void convertor(const Opt_RenderProcessNotRespondingData* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NativeEmbedTouchInfo* value) {
  // Ark_String
  convertor(&value->embedId);
  // TouchEvent
  convertor(&value->touchEvent);
  // EventResult
  convertor(&value->result);
}
template <>
inline void convertor(const Opt_NativeEmbedTouchInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NativeEmbedDataInfo* value) {
  // Ark_NativeEmbedStatus
  convertor(&value->status);
  // Ark_String
  convertor(&value->surfaceId);
  // Ark_String
  convertor(&value->embedId);
  // NativeEmbedInfo
  convertor(&value->info);
}
template <>
inline void convertor(const Opt_NativeEmbedDataInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const IntelligentTrackingPreventionDetails* value) {
  // Ark_String
  convertor(&value->host);
  // Ark_String
  convertor(&value->trackerHost);
}
template <>
inline void convertor(const Opt_IntelligentTrackingPreventionDetails* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LoadCommittedDetails* value) {
  // Ark_Boolean
  convertor(value->isMainFrame);
  // Ark_Boolean
  convertor(value->isSameDocument);
  // Ark_Boolean
  convertor(value->didReplaceEntry);
  // Ark_WebNavigationType
  convertor(value->navigationType);
  // Ark_String
  convertor(&value->url);
}
template <>
inline void convertor(const Opt_LoadCommittedDetails* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ThreatType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnOverScrollEvent* value) {
  // Ark_Number
  convertor(&value->xOffset);
  // Ark_Number
  convertor(&value->yOffset);
}
template <>
inline void convertor(const Opt_OnOverScrollEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnLoadInterceptEvent* value) {
  // WebResourceRequest
  convertor(&value->data);
}
template <>
inline void convertor(const Opt_OnLoadInterceptEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LargestContentfulPaint* value) {
  // Ark_Number
  convertor(&value->navigationStartTime);
  // Ark_Number
  convertor(&value->largestImagePaintTime);
  // Ark_Number
  convertor(&value->largestTextPaintTime);
  // Ark_Number
  convertor(&value->imageBPP);
  // Ark_Number
  convertor(&value->largestImageLoadStartTime);
  // Ark_Number
  convertor(&value->largestImageLoadEndTime);
}
template <>
inline void convertor(const Opt_LargestContentfulPaint* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FirstMeaningfulPaint* value) {
  // Ark_Number
  convertor(&value->navigationStartTime);
  // Ark_Number
  convertor(&value->firstMeaningfulPaintTime);
}
template <>
inline void convertor(const Opt_FirstMeaningfulPaint* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnFirstContentfulPaintEvent* value) {
  // Ark_Number
  convertor(&value->navigationStartTick);
  // Ark_Number
  convertor(&value->firstContentfulPaintMs);
}
template <>
inline void convertor(const Opt_OnFirstContentfulPaintEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnAudioStateChangedEvent* value) {
  // Ark_Boolean
  convertor(value->playing);
}
template <>
inline void convertor(const Opt_OnAudioStateChangedEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnDataResubmittedEvent* value) {
  // DataResubmissionHandler
  convertor(&value->handler);
}
template <>
inline void convertor(const Opt_OnDataResubmittedEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnPageVisibleEvent* value) {
  // Ark_String
  convertor(&value->url);
}
template <>
inline void convertor(const Opt_OnPageVisibleEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnFaviconReceivedEvent* value) {
  // Ark_CustomObject
  convertor(&value->favicon);
}
template <>
inline void convertor(const Opt_OnFaviconReceivedEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnTouchIconUrlReceivedEvent* value) {
  // Ark_String
  convertor(&value->url);
  // Ark_Boolean
  convertor(value->precomposed);
}
template <>
inline void convertor(const Opt_OnTouchIconUrlReceivedEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnWindowNewEvent* value) {
  // Ark_Boolean
  convertor(value->isAlert);
  // Ark_Boolean
  convertor(value->isUserTrigger);
  // Ark_String
  convertor(&value->targetUrl);
  // ControllerHandler
  convertor(&value->handler);
}
template <>
inline void convertor(const Opt_OnWindowNewEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnClientAuthenticationEvent* value) {
  // ClientAuthenticationHandler
  convertor(&value->handler);
  // Ark_String
  convertor(&value->host);
  // Ark_Number
  convertor(&value->port);
  // Array_Ark_String
  convertor(&value->keyTypes);
  // Array_Ark_String
  convertor(&value->issuers);
}
template <>
inline void convertor(const Opt_OnClientAuthenticationEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SslErrorEvent* value) {
  // SslErrorHandler
  convertor(&value->handler);
  // Ark_SslError
  convertor(value->error);
  // Ark_String
  convertor(&value->url);
  // Ark_String
  convertor(&value->originalUrl);
  // Ark_String
  convertor(&value->referrer);
  // Ark_Boolean
  convertor(value->isFatalError);
  // Ark_Boolean
  convertor(value->isMainFrame);
}
template <>
inline void convertor(const Opt_SslErrorEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnSslErrorEventReceiveEvent* value) {
  // SslErrorHandler
  convertor(&value->handler);
  // Ark_SslError
  convertor(value->error);
}
template <>
inline void convertor(const Opt_OnSslErrorEventReceiveEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnScrollEvent* value) {
  // Ark_Number
  convertor(&value->xOffset);
  // Ark_Number
  convertor(&value->yOffset);
}
template <>
inline void convertor(const Opt_OnScrollEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnSearchResultReceiveEvent* value) {
  // Ark_Number
  convertor(&value->activeMatchOrdinal);
  // Ark_Number
  convertor(&value->numberOfMatches);
  // Ark_Boolean
  convertor(value->isDoneCounting);
}
template <>
inline void convertor(const Opt_OnSearchResultReceiveEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnContextMenuShowEvent* value) {
  // WebContextMenuParam
  convertor(&value->param);
  // WebContextMenuResult
  convertor(&value->result);
}
template <>
inline void convertor(const Opt_OnContextMenuShowEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnScreenCaptureRequestEvent* value) {
  // ScreenCaptureHandler
  convertor(&value->handler);
}
template <>
inline void convertor(const Opt_OnScreenCaptureRequestEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnPermissionRequestEvent* value) {
  // PermissionRequest
  convertor(&value->request);
}
template <>
inline void convertor(const Opt_OnPermissionRequestEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnInterceptRequestEvent* value) {
  // WebResourceRequest
  convertor(&value->request);
}
template <>
inline void convertor(const Opt_OnInterceptRequestEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnHttpAuthRequestEvent* value) {
  // HttpAuthHandler
  convertor(&value->handler);
  // Ark_String
  convertor(&value->host);
  // Ark_String
  convertor(&value->realm);
}
template <>
inline void convertor(const Opt_OnHttpAuthRequestEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnScaleChangeEvent* value) {
  // Ark_Number
  convertor(&value->oldScale);
  // Ark_Number
  convertor(&value->newScale);
}
template <>
inline void convertor(const Opt_OnScaleChangeEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FullScreenEnterEvent* value) {
  // FullScreenExitHandler
  convertor(&value->handler);
  // Ark_Number
  convertor(&value->videoWidth);
  // Ark_Number
  convertor(&value->videoHeight);
}
template <>
inline void convertor(const Opt_FullScreenEnterEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnResourceLoadEvent* value) {
  // Ark_String
  convertor(&value->url);
}
template <>
inline void convertor(const Opt_OnResourceLoadEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_callback_Ark_Function_fileSelector_Ark_CustomObject* value) {
  // Ark_Function
  convertor(&value->callback);
  // Ark_CustomObject
  convertor(&value->fileSelector);
}
template <>
inline void convertor(const Opt_Literal_callback_Ark_Function_fileSelector_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnShowFileSelectorEvent* value) {
  // FileSelectorResult
  convertor(&value->result);
  // FileSelectorParam
  convertor(&value->fileSelector);
}
template <>
inline void convertor(const Opt_OnShowFileSelectorEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_handler_Ark_Function_error_Ark_CustomObject* value) {
  // Ark_Function
  convertor(&value->handler);
  // Ark_CustomObject
  convertor(&value->error);
}
template <>
inline void convertor(const Opt_Literal_handler_Ark_Function_error_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_data_Union_Ark_String_WebResourceRequest* value) {
  // Union_Ark_String_WebResourceRequest
  convertor(&value->data);
}
template <>
inline void convertor(const Opt_Literal_data_Union_Ark_String_WebResourceRequest* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnRefreshAccessedHistoryEvent* value) {
  // Ark_String
  convertor(&value->url);
  // Ark_Boolean
  convertor(value->isRefreshed);
}
template <>
inline void convertor(const Opt_OnRefreshAccessedHistoryEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnDownloadStartEvent* value) {
  // Ark_String
  convertor(&value->url);
  // Ark_String
  convertor(&value->userAgent);
  // Ark_String
  convertor(&value->contentDisposition);
  // Ark_String
  convertor(&value->mimetype);
  // Ark_Number
  convertor(&value->contentLength);
}
template <>
inline void convertor(const Opt_OnDownloadStartEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnHttpErrorReceiveEvent* value) {
  // WebResourceRequest
  convertor(&value->request);
  // WebResourceResponse
  convertor(&value->response);
}
template <>
inline void convertor(const Opt_OnHttpErrorReceiveEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnErrorReceiveEvent* value) {
  // WebResourceRequest
  convertor(&value->request);
  // WebResourceError
  convertor(&value->error);
}
template <>
inline void convertor(const Opt_OnErrorReceiveEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnConsoleEvent* value) {
  // ConsoleMessage
  convertor(&value->message);
}
template <>
inline void convertor(const Opt_OnConsoleEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnPromptEvent* value) {
  // Ark_String
  convertor(&value->url);
  // Ark_String
  convertor(&value->message);
  // Ark_String
  convertor(&value->value);
  // JsResult
  convertor(&value->result);
}
template <>
inline void convertor(const Opt_OnPromptEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnConfirmEvent* value) {
  // Ark_String
  convertor(&value->url);
  // Ark_String
  convertor(&value->message);
  // JsResult
  convertor(&value->result);
}
template <>
inline void convertor(const Opt_OnConfirmEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnBeforeUnloadEvent* value) {
  // Ark_String
  convertor(&value->url);
  // Ark_String
  convertor(&value->message);
  // JsResult
  convertor(&value->result);
}
template <>
inline void convertor(const Opt_OnBeforeUnloadEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnAlertEvent* value) {
  // Ark_String
  convertor(&value->url);
  // Ark_String
  convertor(&value->message);
  // JsResult
  convertor(&value->result);
}
template <>
inline void convertor(const Opt_OnAlertEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnGeolocationShowEvent* value) {
  // Ark_String
  convertor(&value->origin);
  // JsGeolocation
  convertor(&value->geolocation);
}
template <>
inline void convertor(const Opt_OnGeolocationShowEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnTitleReceiveEvent* value) {
  // Ark_String
  convertor(&value->title);
}
template <>
inline void convertor(const Opt_OnTitleReceiveEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnProgressChangeEvent* value) {
  // Ark_Number
  convertor(&value->newProgress);
}
template <>
inline void convertor(const Opt_OnProgressChangeEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnPageBeginEvent* value) {
  // Ark_String
  convertor(&value->url);
}
template <>
inline void convertor(const Opt_OnPageBeginEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OnPageEndEvent* value) {
  // Ark_String
  convertor(&value->url);
}
template <>
inline void convertor(const Opt_OnPageEndEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_time_Ark_Number* value) {
  // Ark_Number
  convertor(&value->time);
}
template <>
inline void convertor(const Opt_Literal_time_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_duration_Ark_Number* value) {
  // Ark_Number
  convertor(&value->duration);
}
template <>
inline void convertor(const Opt_Literal_duration_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_fullscreen_Ark_Boolean* value) {
  // Ark_Boolean
  convertor(value->fullscreen);
}
template <>
inline void convertor(const Opt_Literal_fullscreen_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TimePickerResult* value) {
  // Ark_Number
  convertor(&value->hour);
  // Ark_Number
  convertor(&value->minute);
  // Ark_Number
  convertor(&value->second);
}
template <>
inline void convertor(const Opt_TimePickerResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MarqueeState* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TabsAnimationEvent* value) {
  // Ark_Number
  convertor(&value->currentOffset);
  // Ark_Number
  convertor(&value->targetOffset);
  // Ark_Number
  convertor(&value->velocity);
}
template <>
inline void convertor(const Opt_TabsAnimationEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SwiperAnimationEvent* value) {
  // Ark_Number
  convertor(&value->currentOffset);
  // Ark_Number
  convertor(&value->targetOffset);
  // Ark_Number
  convertor(&value->velocity);
}
template <>
inline void convertor(const Opt_SwiperAnimationEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SliderChangeMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DeleteValue* value) {
  // Ark_Number
  convertor(&value->deleteOffset);
  // Ark_TextDeleteDirection
  convertor(value->direction);
  // Ark_String
  convertor(&value->deleteValue);
}
template <>
inline void convertor(const Opt_DeleteValue* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const InsertValue* value) {
  // Ark_Number
  convertor(&value->insertOffset);
  // Ark_String
  convertor(&value->insertValue);
}
template <>
inline void convertor(const Opt_InsertValue* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SaveButtonOnClickResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CopyEvent* value) {
  // Ark_Function
  convertor(&value->preventDefault);
}
template <>
inline void convertor(const Opt_CopyEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CutEvent* value) {
  // Ark_Function
  convertor(&value->preventDefault);
}
template <>
inline void convertor(const Opt_CutEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorChangeValue* value) {
  // TextRange
  convertor(&value->rangeBefore);
  // Array_RichEditorTextSpanResult
  convertor(&value->replacedSpans);
  // Array_RichEditorImageSpanResult
  convertor(&value->replacedImageSpans);
  // Array_RichEditorTextSpanResult
  convertor(&value->replacedSymbolSpans);
}
template <>
inline void convertor(const Opt_RichEditorChangeValue* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SubmitEvent* value) {
  // Ark_String
  convertor(&value->text);
}
template <>
inline void convertor(const Opt_SubmitEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PasteEvent* value) {
  // Ark_Function
  convertor(&value->preventDefault);
}
template <>
inline void convertor(const Opt_PasteEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_RichEditorTextSpanResult_RichEditorImageSpanResult* value) {
  // RichEditorTextSpanResult
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // RichEditorImageSpanResult
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_RichEditorTextSpanResult_RichEditorImageSpanResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorDeleteValue* value) {
  // Ark_Number
  convertor(&value->offset);
  // Ark_RichEditorDeleteDirection
  convertor(value->direction);
  // Ark_Number
  convertor(&value->length);
  // Array_Union_RichEditorTextSpanResult_RichEditorImageSpanResult
  convertor(&value->richEditorDeleteSpans);
}
template <>
inline void convertor(const Opt_RichEditorDeleteValue* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorInsertValue* value) {
  // Ark_Number
  convertor(&value->insertOffset);
  // Ark_String
  convertor(&value->insertValue);
  // Ark_String
  convertor(&value->previewText);
}
template <>
inline void convertor(const Opt_RichEditorInsertValue* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorRange* value) {
  // Ark_Number
  convertor(&value->start);
  // Ark_Number
  convertor(&value->end);
}
template <>
inline void convertor(const Opt_RichEditorRange* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorSelection* value) {
  // Tuple_Ark_Number_Ark_Number
  convertor(&value->selection);
  // Array_Union_RichEditorTextSpanResult_RichEditorImageSpanResult
  convertor(&value->spans);
}
template <>
inline void convertor(const Opt_RichEditorSelection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RefreshStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_errcode_Ark_Number_msg_Ark_String* value) {
  // Ark_Number
  convertor(&value->errcode);
  // Ark_String
  convertor(&value->msg);
}
template <>
inline void convertor(const Opt_Literal_errcode_Ark_Number_msg_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PasteButtonOnClickResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NavigationOperation* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavContentInfo* value) {
  // Ark_String
  convertor(&value->name);
  // Ark_Number
  convertor(&value->index);
  // Ark_NavDestinationMode
  convertor(&value->mode);
  // Object
  convertor(&value->param);
  // Ark_String
  convertor(&value->navDestinationId);
}
template <>
inline void convertor(const Opt_NavContentInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LocationButtonOnClickResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const VisibleListContentInfo* value) {
  // Ark_Number
  convertor(&value->index);
  // Ark_ListItemGroupArea
  convertor(&value->itemGroupArea);
  // Ark_Number
  convertor(&value->itemIndexInGroup);
}
template <>
inline void convertor(const Opt_VisibleListContentInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ImageLoadResult* value) {
  // Ark_Number
  convertor(&value->width);
  // Ark_Number
  convertor(&value->height);
  // Ark_Number
  convertor(&value->componentWidth);
  // Ark_Number
  convertor(&value->componentHeight);
  // Ark_Number
  convertor(&value->loadingStatus);
  // Ark_Number
  convertor(&value->contentWidth);
  // Ark_Number
  convertor(&value->contentHeight);
  // Ark_Number
  convertor(&value->contentOffsetX);
  // Ark_Number
  convertor(&value->contentOffsetY);
}
template <>
inline void convertor(const Opt_ImageLoadResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ImageError* value) {
  // Ark_Number
  convertor(&value->componentWidth);
  // Ark_Number
  convertor(&value->componentHeight);
  // Ark_String
  convertor(&value->message);
}
template <>
inline void convertor(const Opt_ImageError* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_width_Ark_Number_height_Ark_Number_componentWidth_Ark_Number_componentHeight_Ark_Number_loadingStatus_Ark_Number_contentWidth_Ark_Number_contentHeight_Ark_Number_contentOffsetX_Ark_Number_contentOffsetY_Ark_Number* value) {
  // Ark_Number
  convertor(&value->width);
  // Ark_Number
  convertor(&value->height);
  // Ark_Number
  convertor(&value->componentWidth);
  // Ark_Number
  convertor(&value->componentHeight);
  // Ark_Number
  convertor(&value->loadingStatus);
  // Ark_Number
  convertor(&value->contentWidth);
  // Ark_Number
  convertor(&value->contentHeight);
  // Ark_Number
  convertor(&value->contentOffsetX);
  // Ark_Number
  convertor(&value->contentOffsetY);
}
template <>
inline void convertor(const Opt_Literal_width_Ark_Number_height_Ark_Number_componentWidth_Ark_Number_componentHeight_Ark_Number_loadingStatus_Ark_Number_contentWidth_Ark_Number_contentHeight_Ark_Number_contentOffsetX_Ark_Number_contentOffsetY_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ItemDragInfo* value) {
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
}
template <>
inline void convertor(const Opt_ItemDragInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FormCallbackInfo* value) {
  // Ark_Number
  convertor(&value->id);
  // Ark_String
  convertor(&value->idString);
}
template <>
inline void convertor(const Opt_FormCallbackInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const HoverEventParam* value) {
  // Ark_FoldStatus
  convertor(value->foldStatus);
  // Ark_Boolean
  convertor(value->isHoverMode);
  // Ark_AppRotation
  convertor(value->appRotation);
  // Ark_CustomObject
  convertor(&value->windowMode);
}
template <>
inline void convertor(const Opt_HoverEventParam* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_foldStatus_Ark_FoldStatus* value) {
  // Ark_FoldStatus
  convertor(value->foldStatus);
}
template <>
inline void convertor(const Opt_Literal_foldStatus_Ark_FoldStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DatePickerResult* value) {
  // Ark_Number
  convertor(&value->year);
  // Ark_Number
  convertor(&value->month);
  // Ark_Number
  convertor(&value->day);
}
template <>
inline void convertor(const Opt_DatePickerResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ScrollState* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const GestureRecognizer* value);
inline void generateStdArrayDefinition(string* result, const Array_GestureRecognizer* value) {
  int32_t count = value->length;
  result->append("std::array<GestureRecognizer, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const GestureRecognizer*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_GestureRecognizer* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const GestureRecognizer*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_GestureRecognizer* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GestureRecognizer* value) {
}
template <>
inline void convertor(const Opt_GestureRecognizer* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FingerInfo* value) {
  // Ark_Number
  convertor(&value->id);
  // Ark_Number
  convertor(&value->globalX);
  // Ark_Number
  convertor(&value->globalY);
  // Ark_Number
  convertor(&value->localX);
  // Ark_Number
  convertor(&value->localY);
  // Ark_Number
  convertor(&value->displayX);
  // Ark_Number
  convertor(&value->displayY);
}
template <>
inline void convertor(const Opt_FingerInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BaseGestureEvent* value) {
  // EventTarget
  convertor(&value->target);
  // Ark_Number
  convertor(&value->timestamp);
  // Ark_SourceType
  convertor(value->source);
  // Ark_Number
  convertor(&value->axisHorizontal);
  // Ark_Number
  convertor(&value->axisVertical);
  // Ark_Number
  convertor(&value->pressure);
  // Ark_Number
  convertor(&value->tiltX);
  // Ark_Number
  convertor(&value->tiltY);
  // Ark_SourceTool
  convertor(value->sourceTool);
  // Array_FingerInfo
  convertor(&value->fingerList);
}
template <>
inline void convertor(const Opt_BaseGestureEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GestureInfo* value) {
  // Ark_String
  convertor(&value->tag);
  // Ark_GestureControl_GestureType
  convertor(value->type);
  // Ark_Boolean
  convertor(value->isSystemGesture);
}
template <>
inline void convertor(const Opt_GestureInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PreDragStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DragEvent* value) {
  // Ark_DragBehavior
  convertor(value->dragBehavior);
  // Ark_Boolean
  convertor(value->useCustomDropAnimation);
}
template <>
inline void convertor(const Opt_DragEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const KeyEvent* value) {
  // Ark_KeyType
  convertor(value->type);
  // Ark_Number
  convertor(&value->keyCode);
  // Ark_String
  convertor(&value->keyText);
  // Ark_KeySource
  convertor(value->keySource);
  // Ark_Number
  convertor(&value->deviceId);
  // Ark_Number
  convertor(&value->metaKey);
  // Ark_Number
  convertor(&value->timestamp);
  // Ark_Function
  convertor(&value->stopPropagation);
  // Ark_CustomObject
  convertor(&value->intentionCode);
}
template <>
inline void convertor(const Opt_KeyEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TouchObject* value) {
  // Ark_TouchType
  convertor(value->type);
  // Ark_Number
  convertor(&value->id);
  // Ark_Number
  convertor(&value->displayX);
  // Ark_Number
  convertor(&value->displayY);
  // Ark_Number
  convertor(&value->windowX);
  // Ark_Number
  convertor(&value->windowY);
  // Ark_Number
  convertor(&value->screenX);
  // Ark_Number
  convertor(&value->screenY);
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
}
template <>
inline void convertor(const Opt_TouchObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MouseEvent* value) {
  // EventTarget
  convertor(&value->target);
  // Ark_Number
  convertor(&value->timestamp);
  // Ark_SourceType
  convertor(value->source);
  // Ark_Number
  convertor(&value->axisHorizontal);
  // Ark_Number
  convertor(&value->axisVertical);
  // Ark_Number
  convertor(&value->pressure);
  // Ark_Number
  convertor(&value->tiltX);
  // Ark_Number
  convertor(&value->tiltY);
  // Ark_SourceTool
  convertor(value->sourceTool);
  // Ark_MouseButton
  convertor(value->button);
  // Ark_MouseAction
  convertor(value->action);
  // Ark_Number
  convertor(&value->displayX);
  // Ark_Number
  convertor(&value->displayY);
  // Ark_Number
  convertor(&value->windowX);
  // Ark_Number
  convertor(&value->windowY);
  // Ark_Number
  convertor(&value->screenX);
  // Ark_Number
  convertor(&value->screenY);
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
  // Ark_Function
  convertor(&value->stopPropagation);
}
template <>
inline void convertor(const Opt_MouseEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const HoverEvent* value) {
  // EventTarget
  convertor(&value->target);
  // Ark_Number
  convertor(&value->timestamp);
  // Ark_SourceType
  convertor(value->source);
  // Ark_Number
  convertor(&value->axisHorizontal);
  // Ark_Number
  convertor(&value->axisVertical);
  // Ark_Number
  convertor(&value->pressure);
  // Ark_Number
  convertor(&value->tiltX);
  // Ark_Number
  convertor(&value->tiltY);
  // Ark_SourceTool
  convertor(value->sourceTool);
  // Ark_Function
  convertor(&value->stopPropagation);
}
template <>
inline void convertor(const Opt_HoverEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ClickEvent* value) {
  // EventTarget
  convertor(&value->target);
  // Ark_Number
  convertor(&value->timestamp);
  // Ark_SourceType
  convertor(value->source);
  // Ark_Number
  convertor(&value->axisHorizontal);
  // Ark_Number
  convertor(&value->axisVertical);
  // Ark_Number
  convertor(&value->pressure);
  // Ark_Number
  convertor(&value->tiltX);
  // Ark_Number
  convertor(&value->tiltY);
  // Ark_SourceTool
  convertor(value->sourceTool);
  // Ark_Number
  convertor(&value->displayX);
  // Ark_Number
  convertor(&value->displayY);
  // Ark_Number
  convertor(&value->windowX);
  // Ark_Number
  convertor(&value->windowY);
  // Ark_Number
  convertor(&value->screenX);
  // Ark_Number
  convertor(&value->screenY);
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
  // Ark_Function
  convertor(&value->preventDefault);
}
template <>
inline void convertor(const Opt_ClickEvent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TouchTestInfo* value) {
  // Ark_Number
  convertor(&value->windowX);
  // Ark_Number
  convertor(&value->windowY);
  // Ark_Number
  convertor(&value->parentX);
  // Ark_Number
  convertor(&value->parentY);
  // Ark_Number
  convertor(&value->x);
  // Ark_Number
  convertor(&value->y);
  // RectResult
  convertor(&value->rect);
  // Ark_String
  convertor(&value->id);
}
template <>
inline void convertor(const Opt_TouchTestInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const TouchTestInfo* value);
inline void generateStdArrayDefinition(string* result, const Array_TouchTestInfo* value) {
  int32_t count = value->length;
  result->append("std::array<TouchTestInfo, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const TouchTestInfo*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_TouchTestInfo* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const TouchTestInfo*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_TouchTestInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CheckboxGroupResult* value) {
  // Array_Ark_String
  convertor(&value->name);
  // Ark_SelectStatus
  convertor(value->status);
}
template <>
inline void convertor(const Opt_CheckboxGroupResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CalendarRequestedData* value) {
  // Ark_Number
  convertor(&value->year);
  // Ark_Number
  convertor(&value->month);
  // Ark_Number
  convertor(&value->currentYear);
  // Ark_Number
  convertor(&value->currentMonth);
  // Ark_Number
  convertor(&value->monthState);
}
template <>
inline void convertor(const Opt_CalendarRequestedData* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CalendarSelectedDate* value) {
  // Ark_Number
  convertor(&value->year);
  // Ark_Number
  convertor(&value->month);
  // Ark_Number
  convertor(&value->day);
}
template <>
inline void convertor(const Opt_CalendarSelectedDate* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SectionOptions* value) {
  // Ark_Number
  convertor(&value->itemsCount);
  // Ark_Number
  convertor(&value->crossCount);
  // Ark_Function
  convertor(&value->onGetItemMainSizeByIndex);
  // Ark_Length
  convertor(&value->columnsGap);
  // Ark_Length
  convertor(&value->rowsGap);
  // Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length
  convertor(&value->margin);
}
template <>
inline void convertor(const Opt_SectionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const SectionOptions* value);
inline void generateStdArrayDefinition(string* result, const Array_SectionOptions* value) {
  int32_t count = value->length;
  result->append("std::array<SectionOptions, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const SectionOptions*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_SectionOptions* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const SectionOptions*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_SectionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SurfaceRotationOptions* value) {
  // Ark_Boolean
  convertor(&value->lock);
}
template <>
inline void convertor(const Opt_SurfaceRotationOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SurfaceRect* value) {
  // Ark_Number
  convertor(&value->offsetX);
  // Ark_Number
  convertor(&value->offsetY);
  // Ark_Number
  convertor(&value->surfaceWidth);
  // Ark_Number
  convertor(&value->surfaceHeight);
}
template <>
inline void convertor(const Opt_SurfaceRect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_surfaceWidth_Ark_Number_surfaceHeight_Ark_Number* value) {
  // Ark_Number
  convertor(&value->surfaceWidth);
  // Ark_Number
  convertor(&value->surfaceHeight);
}
template <>
inline void convertor(const Opt_Literal_surfaceWidth_Ark_Number_surfaceHeight_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScreenCaptureConfig* value) {
  // Ark_WebCaptureMode
  convertor(value->captureMode);
}
template <>
inline void convertor(const Opt_ScreenCaptureConfig* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_Number_Ark_Resource_ArrayBuffer* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // ArrayBuffer
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_Number_Ark_Resource_ArrayBuffer* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MessageLevel* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_object_Ark_CustomObject_name_Ark_String_methodList_Array_Ark_String* value) {
  // Ark_CustomObject
  convertor(&value->object);
  // Ark_String
  convertor(&value->name);
  // Array_Ark_String
  convertor(&value->methodList);
}
template <>
inline void convertor(const Opt_Literal_object_Ark_CustomObject_name_Ark_String_methodList_Array_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Header* value) {
  // Ark_String
  convertor(&value->headerKey);
  // Ark_String
  convertor(&value->headerValue);
}
template <>
inline void convertor(const Opt_Header* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_url_Union_Ark_String_Ark_Resource_headers_Opt_Array_Header* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->url);
  // Array_Header
  convertor(&value->headers);
}
template <>
inline void convertor(const Opt_Literal_url_Union_Ark_String_Ark_Resource_headers_Opt_Array_Header* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_data_Ark_String_mimeType_Ark_String_encoding_Ark_String_baseUrl_Opt_Ark_String_historyUrl_Opt_Ark_String* value) {
  // Ark_String
  convertor(&value->data);
  // Ark_String
  convertor(&value->mimeType);
  // Ark_String
  convertor(&value->encoding);
  // Ark_String
  convertor(&value->baseUrl);
  // Ark_String
  convertor(&value->historyUrl);
}
template <>
inline void convertor(const Opt_Literal_data_Ark_String_mimeType_Ark_String_encoding_Ark_String_baseUrl_Opt_Ark_String_historyUrl_Opt_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_script_Ark_String_callback_Opt_Ark_Function* value) {
  // Ark_String
  convertor(&value->script);
  // Ark_Function
  convertor(&value->callback);
}
template <>
inline void convertor(const Opt_Literal_script_Ark_String_callback_Opt_Ark_Function* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SeekMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TabBarIconStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->selectedColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->unselectedColor);
}
template <>
inline void convertor(const Opt_TabBarIconStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LayoutMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length_LocalizedPadding* value) {
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedPadding
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length_LocalizedPadding* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_String_Ark_Resource_TabBarSymbol* value) {
  // Union_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // TabBarSymbol
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_String_Ark_Resource_TabBarSymbol* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BoardStyle* value) {
  // Ark_Length
  convertor(&value->borderRadius);
}
template <>
inline void convertor(const Opt_BoardStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SelectedMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  // Union_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SelectionOptions* value) {
  // Ark_MenuPolicy
  convertor(&value->menuPolicy);
}
template <>
inline void convertor(const Opt_SelectionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_StyledString* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const StyleOptions* value) {
  // Ark_Number
  convertor(&value->start);
  // Ark_Number
  convertor(&value->length);
  // Ark_StyledStringKey
  convertor(value->styledKey);
  // Union_TextStyle_DecorationStyle_BaselineOffsetStyle_LetterSpacingStyle_TextShadowStyle_GestureStyle_ImageAttachment_ParagraphStyle_LineHeightStyle_CustomSpan
  convertor(&value->styledValue);
}
template <>
inline void convertor(const Opt_StyleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const StyleOptions* value);
inline void generateStdArrayDefinition(string* result, const Array_StyleOptions* value) {
  int32_t count = value->length;
  result->append("std::array<StyleOptions, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const StyleOptions*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_StyleOptions* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const StyleOptions*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_StyleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_ImageAttachment_CustomSpan* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // ImageAttachment
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // CustomSpan
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_ImageAttachment_CustomSpan* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PatternLockChallengeResult* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollToIndexOptions* value) {
  // Ark_CustomObject
  convertor(&value->extraOffset);
}
template <>
inline void convertor(const Opt_ScrollToIndexOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ScrollAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_next_Ark_Boolean_direction_Opt_Ark_Axis* value) {
  // Ark_Boolean
  convertor(value->next);
  // Ark_Axis
  convertor(&value->direction);
}
template <>
inline void convertor(const Opt_Literal_next_Ark_Boolean_direction_Opt_Ark_Axis* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollPageOptions* value) {
  // Ark_Boolean
  convertor(value->next);
  // Ark_Boolean
  convertor(&value->animation);
}
template <>
inline void convertor(const Opt_ScrollPageOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollEdgeOptions* value) {
  // Ark_Number
  convertor(&value->velocity);
}
template <>
inline void convertor(const Opt_ScrollEdgeOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Edge* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_xOffset_Union_Ark_Number_Ark_String_yOffset_Union_Ark_Number_Ark_String_animation_Opt_Union_ScrollAnimationOptions_Ark_Boolean* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->xOffset);
  // Union_Ark_Number_Ark_String
  convertor(&value->yOffset);
  // Union_ScrollAnimationOptions_Ark_Boolean
  convertor(&value->animation);
}
template <>
inline void convertor(const Opt_Literal_xOffset_Union_Ark_Number_Ark_String_yOffset_Union_Ark_Number_Ark_String_animation_Opt_Union_ScrollAnimationOptions_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Matrix2D* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Path2D* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RenderingContextSettings* value) {
  // Ark_Boolean
  convertor(&value->antialias);
}
template <>
inline void convertor(const Opt_RenderingContextSettings* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_fingers_Opt_Ark_Number_direction_Opt_Ark_PanDirection_distance_Opt_Ark_Number* value) {
  // Ark_Number
  convertor(&value->fingers);
  // Ark_PanDirection
  convertor(&value->direction);
  // Ark_Number
  convertor(&value->distance);
}
template <>
inline void convertor(const Opt_Literal_fingers_Opt_Ark_Number_direction_Opt_Ark_PanDirection_distance_Opt_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const UIExtensionOptions* value) {
  // Ark_Boolean
  convertor(&value->isTransferringCaller);
  // Ark_CustomObject
  convertor(&value->placeholder);
  // Ark_DpiFollowStrategy
  convertor(&value->dpiFollowStrategy);
}
template <>
inline void convertor(const Opt_UIExtensionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const WaterFlowOptions* value) {
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->footer);
  // Scroller
  convertor(&value->scroller);
  // WaterFlowSections
  convertor(&value->sections);
  // Ark_WaterFlowLayoutMode
  convertor(&value->layoutMode);
}
template <>
inline void convertor(const Opt_WaterFlowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const WindowAnimationTarget* value) {
  // Ark_String
  convertor(&value->bundleName);
  // Ark_String
  convertor(&value->abilityName);
  // RRect
  convertor(&value->windowBounds);
  // Ark_Number
  convertor(&value->missionId);
}
template <>
inline void convertor(const Opt_WindowAnimationTarget* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_DividerStyle_Ark_Undefined* value) {
  // DividerStyle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_DividerStyle_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SideBarPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ButtonStyle* value) {
  // Ark_Number
  convertor(&value->left);
  // Ark_Number
  convertor(&value->top);
  // Ark_Number
  convertor(&value->width);
  // Ark_Number
  convertor(&value->height);
  // Literal_shown_Union_Ark_String_Ark_CustomObject_Ark_Resource_hidden_Union_Ark_String_Ark_CustomObject_Ark_Resource_switching_Opt_Union_Ark_String_Ark_CustomObject_Ark_Resource
  convertor(&value->icons);
}
template <>
inline void convertor(const Opt_ButtonStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SideBarContainerType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_id_Ark_String_type_Ark_XComponentType_imageAIOptions_ImageAIOptions_libraryname_Opt_Ark_String_controller_Opt_XComponentController* value) {
  // Ark_String
  convertor(&value->id);
  // Ark_XComponentType
  convertor(value->type);
  // ImageAIOptions
  convertor(&value->imageAIOptions);
  // Ark_String
  convertor(&value->libraryname);
  // XComponentController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_Literal_id_Ark_String_type_Ark_XComponentType_imageAIOptions_ImageAIOptions_libraryname_Opt_Ark_String_controller_Opt_XComponentController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_id_Ark_String_type_Ark_XComponentType_libraryname_Opt_Ark_String_controller_Opt_XComponentController* value) {
  // Ark_String
  convertor(&value->id);
  // Ark_XComponentType
  convertor(value->type);
  // Ark_String
  convertor(&value->libraryname);
  // XComponentController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_Literal_id_Ark_String_type_Ark_XComponentType_libraryname_Opt_Ark_String_controller_Opt_XComponentController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_id_Ark_String_type_Ark_String_libraryname_Opt_Ark_String_controller_Opt_XComponentController* value) {
  // Ark_String
  convertor(&value->id);
  // Ark_String
  convertor(&value->type);
  // Ark_String
  convertor(&value->libraryname);
  // XComponentController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_Literal_id_Ark_String_type_Ark_String_libraryname_Opt_Ark_String_controller_Opt_XComponentController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const ExpandedMenuItemOptions* value);
inline void generateStdArrayDefinition(string* result, const Array_ExpandedMenuItemOptions* value) {
  int32_t count = value->length;
  result->append("std::array<ExpandedMenuItemOptions, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const ExpandedMenuItemOptions*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_ExpandedMenuItemOptions* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const ExpandedMenuItemOptions*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_ExpandedMenuItemOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NativeMediaPlayerConfig* value) {
  // Ark_Boolean
  convertor(value->enable);
  // Ark_Boolean
  convertor(value->shouldOverlay);
}
template <>
inline void convertor(const Opt_NativeMediaPlayerConfig* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_WebLayoutMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const ScriptItem* value);
inline void generateStdArrayDefinition(string* result, const Array_ScriptItem* value) {
  int32_t count = value->length;
  result->append("std::array<ScriptItem, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const ScriptItem*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_ScriptItem* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const ScriptItem*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_ScriptItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScriptItem* value) {
  // Ark_String
  convertor(&value->script);
  // Array_Ark_String
  convertor(&value->scriptRules);
}
template <>
inline void convertor(const Opt_ScriptItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_OverScrollMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const WebMediaOptions* value) {
  // Ark_Number
  convertor(&value->resumeInterval);
  // Ark_Boolean
  convertor(&value->audioExclusive);
}
template <>
inline void convertor(const Opt_WebMediaOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_WebDarkMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_CacheMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const JavaScriptProxy* value) {
  // Ark_CustomObject
  convertor(&value->object);
  // Ark_String
  convertor(&value->name);
  // Array_Ark_String
  convertor(&value->methodList);
  // Union_WebController_Ark_CustomObject
  convertor(&value->controller);
  // Array_Ark_String
  convertor(&value->asyncMethodList);
}
template <>
inline void convertor(const Opt_JavaScriptProxy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MixedMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const WebOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->src);
  // Union_WebController_Ark_CustomObject
  convertor(&value->controller);
  // Ark_RenderMode
  convertor(&value->renderMode);
  // Ark_Boolean
  convertor(&value->incognitoMode);
  // Ark_String
  convertor(&value->sharedRenderProcessToken);
}
template <>
inline void convertor(const Opt_WebOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const VideoOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->src);
  // Union_Ark_Number_Ark_String_Ark_PlaybackSpeed
  convertor(&value->currentProgressRate);
  // Union_Ark_String_Ark_CustomObject_Ark_Resource
  convertor(&value->previewUri);
  // VideoController
  convertor(&value->controller);
  // ImageAIOptions
  convertor(&value->imageAIOptions);
}
template <>
inline void convertor(const Opt_VideoOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SwitchStyle* value) {
  // Union_Ark_Number_Ark_Resource
  convertor(&value->pointRadius);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->unselectedColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->pointColor);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->trackBorderRadius);
}
template <>
inline void convertor(const Opt_SwitchStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_type_Ark_ToggleType_isOn_Opt_Ark_Boolean* value) {
  // Ark_ToggleType
  convertor(value->type);
  // Ark_Boolean
  convertor(&value->isOn);
}
template <>
inline void convertor(const Opt_Literal_type_Ark_ToggleType_isOn_Opt_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TimePickerOptions* value) {
  // Ark_CustomObject
  convertor(&value->selected);
  // Ark_TimePickerFormat
  convertor(&value->format);
}
template <>
inline void convertor(const Opt_TimePickerOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_ShadowOptions_Array_ShadowOptions* value) {
  // ShadowOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Array_ShadowOptions
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_ShadowOptions_Array_ShadowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextTimerOptions* value) {
  // Ark_Boolean
  convertor(&value->isCountDown);
  // Ark_Number
  convertor(&value->count);
  // TextTimerController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_TextTimerOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_DividerOptions_Ark_Undefined* value) {
  // DividerOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_DividerOptions_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextCascadePickerRangeContent* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->text);
  // Array_TextCascadePickerRangeContent
  convertor(&value->children);
}
template <>
inline void convertor(const Opt_TextCascadePickerRangeContent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextPickerRangeContent* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->icon);
  // Union_Ark_String_Ark_Resource
  convertor(&value->text);
}
template <>
inline void convertor(const Opt_TextPickerRangeContent* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextPickerOptions* value) {
  // Union_Array_Ark_String_Array_Array_Ark_String_Ark_Resource_Array_TextPickerRangeContent_Array_TextCascadePickerRangeContent
  convertor(&value->range);
  // Union_Ark_String_Array_Ark_String
  convertor(&value->value);
  // Union_Ark_Number_Array_Ark_Number
  convertor(&value->selected);
}
template <>
inline void convertor(const Opt_TextPickerOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_style_Opt_Ark_CancelButtonStyle_icon_Opt_IconOptions* value) {
  // Ark_CancelButtonStyle
  convertor(&value->style);
  // IconOptions
  convertor(&value->icon);
}
template <>
inline void convertor(const Opt_Literal_style_Opt_Ark_CancelButtonStyle_icon_Opt_IconOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_UnderlineColor_Ark_Undefined* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // UnderlineColor
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Undefined
  if (value->selector == 2) {
    convertor(value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_UnderlineColor_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_String_Ark_Resource_Ark_Undefined* value) {
  // Union_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_String_Ark_Resource_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PasswordIcon* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->onIconSrc);
  // Union_Ark_String_Ark_Resource
  convertor(&value->offIconSrc);
}
template <>
inline void convertor(const Opt_PasswordIcon* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_TextInputStyle_Ark_TextContentStyle* value) {
  // Ark_TextInputStyle
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_TextContentStyle
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_TextInputStyle_Ark_TextContentStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_InputType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextInputOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->placeholder);
  // Union_Ark_String_Ark_Resource
  convertor(&value->text);
  // TextInputController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_TextInputOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_timeZoneOffset_Opt_Ark_Number_controller_Opt_TextClockController* value) {
  // Ark_Number
  convertor(&value->timeZoneOffset);
  // TextClockController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_Literal_timeZoneOffset_Opt_Ark_Number_controller_Opt_TextClockController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ContentType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextAreaType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const InputCounterOptions* value) {
  // Ark_Number
  convertor(&value->thresholdPercentage);
  // Ark_Boolean
  convertor(&value->highlightBorder);
}
template <>
inline void convertor(const Opt_InputCounterOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextAreaOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->placeholder);
  // Union_Ark_String_Ark_Resource
  convertor(&value->text);
  // TextAreaController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_TextAreaOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextSelectableMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextResponseType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextSpanType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_EllipsisMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_overflow_Ark_TextOverflow* value) {
  // Ark_TextOverflow
  convertor(value->overflow);
}
template <>
inline void convertor(const Opt_Literal_overflow_Ark_TextOverflow* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextOptions* value) {
  // TextController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_TextOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_SubTabBarStyle_BottomTabBarStyle* value) {
  // SubTabBarStyle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // BottomTabBarStyle
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_SubTabBarStyle_BottomTabBarStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined_Literal_icon_Opt_Union_Ark_String_Ark_Resource_text_Opt_Union_Ark_String_Ark_Resource* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Literal_icon_Opt_Union_Ark_String_Ark_Resource_text_Opt_Union_Ark_String_Ark_Resource
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined_Literal_icon_Opt_Union_Ark_String_Ark_Resource_text_Opt_Union_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BarGridColumnOptions* value) {
  // Ark_Number
  convertor(&value->sm);
  // Ark_Number
  convertor(&value->md);
  // Ark_Number
  convertor(&value->lg);
  // Ark_Length
  convertor(&value->margin);
  // Ark_Length
  convertor(&value->gutter);
}
template <>
inline void convertor(const Opt_BarGridColumnOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollableBarModeOptions* value) {
  // Ark_Length
  convertor(&value->margin);
  // Ark_LayoutStyle
  convertor(&value->nonScrollableLayoutStyle);
}
template <>
inline void convertor(const Opt_ScrollableBarModeOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BarMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_barPosition_Opt_Ark_BarPosition_index_Opt_Ark_Number_controller_Opt_TabsController* value) {
  // Ark_BarPosition
  convertor(&value->barPosition);
  // Ark_Number
  convertor(&value->index);
  // TabsController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_Literal_barPosition_Opt_Ark_BarPosition_index_Opt_Ark_Number_controller_Opt_TabsController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SymbolEffect* value) {
}
template <>
inline void convertor(const Opt_SymbolEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SwiperContentAnimatedTransition* value) {
  // Ark_Number
  convertor(&value->timeout);
  // Ark_Function
  convertor(&value->transition);
}
template <>
inline void convertor(const Opt_SwiperContentAnimatedTransition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SwiperNestedScrollMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const IndicatorStyle* value) {
  // Ark_Length
  convertor(&value->left);
  // Ark_Length
  convertor(&value->top);
  // Ark_Length
  convertor(&value->right);
  // Ark_Length
  convertor(&value->bottom);
  // Ark_Length
  convertor(&value->size);
  // Ark_Boolean
  convertor(&value->mask);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->selectedColor);
}
template <>
inline void convertor(const Opt_IndicatorStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Ark_String_Literal_minSize_Union_Ark_String_Ark_Number* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Literal_minSize_Union_Ark_String_Ark_Number
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Ark_String_Literal_minSize_Union_Ark_String_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SwiperDisplayMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_ArrowStyle_Ark_Boolean* value) {
  // ArrowStyle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Boolean
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_ArrowStyle_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_DotIndicator_DigitIndicator_Ark_Boolean* value) {
  // DotIndicator
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // DigitIndicator
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Boolean
  if (value->selector == 2) {
    convertor(value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_DotIndicator_DigitIndicator_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_SwiperController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ItemState* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_index_Opt_Ark_Number* value) {
  // Ark_Number
  convertor(&value->index);
}
template <>
inline void convertor(const Opt_Literal_index_Opt_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_alignContent_Opt_Ark_Alignment* value) {
  // Ark_Alignment
  convertor(&value->alignContent);
}
template <>
inline void convertor(const Opt_Literal_alignContent_Opt_Ark_Alignment* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextCase* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DecorationStyleInterface* value) {
  // Ark_TextDecorationType
  convertor(value->type);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_TextDecorationStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_DecorationStyleInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SlideRange* value) {
  // Ark_Number
  convertor(&value->from);
  // Ark_Number
  convertor(&value->to);
}
template <>
inline void convertor(const Opt_SlideRange* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SliderInteraction* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SliderBlockStyle* value) {
  // Ark_SliderBlockType
  convertor(value->type);
  // Union_Ark_String_Ark_Resource
  convertor(&value->image);
  // Union_CircleAttribute_EllipseAttribute_PathAttribute_RectAttribute
  convertor(&value->shape);
}
template <>
inline void convertor(const Opt_SliderBlockStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SliderOptions* value) {
  // Ark_Number
  convertor(&value->value);
  // Ark_Number
  convertor(&value->min);
  // Ark_Number
  convertor(&value->max);
  // Ark_Number
  convertor(&value->step);
  // Ark_SliderStyle
  convertor(&value->style);
  // Ark_Axis
  convertor(&value->direction);
  // Ark_Boolean
  convertor(&value->reverse);
}
template <>
inline void convertor(const Opt_SliderOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_x_Opt_Union_Ark_Number_Ark_String_y_Opt_Union_Ark_Number_Ark_String_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->x);
  // Union_Ark_Number_Ark_String
  convertor(&value->y);
  // Union_Ark_Number_Ark_String
  convertor(&value->width);
  // Union_Ark_Number_Ark_String
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_Literal_x_Opt_Union_Ark_Number_Ark_String_y_Opt_Union_Ark_Number_Ark_String_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Opt_DividerOptions_Ark_Undefined* value) {
  // Opt_DividerOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Opt_DividerOptions_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_Ark_OptionWidthMode* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_OptionWidthMode
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_Ark_OptionWidthMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MenuAlignType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ArrowPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SelectOption* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->value);
  // Union_Ark_String_Ark_Resource
  convertor(&value->icon);
  // Ark_CustomObject
  convertor(&value->symbolIcon);
}
template <>
inline void convertor(const Opt_SelectOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const SelectOption* value);
inline void generateStdArrayDefinition(string* result, const Array_SelectOption* value) {
  int32_t count = value->length;
  result->append("std::array<SelectOption, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const SelectOption*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_SelectOption* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const SelectOption*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_SelectOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SearchType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextDecorationOptions* value) {
  // Ark_TextDecorationType
  convertor(value->type);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_TextDecorationStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_TextDecorationOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CaretStyle* value) {
  // Ark_Length
  convertor(&value->width);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
}
template <>
inline void convertor(const Opt_CaretStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SearchButtonOptions* value) {
  // Ark_Length
  convertor(&value->fontSize);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->fontColor);
}
template <>
inline void convertor(const Opt_SearchButtonOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_value_Opt_Ark_String_placeholder_Opt_Union_Ark_String_Ark_Resource_icon_Opt_Ark_String_controller_Opt_SearchController* value) {
  // Ark_String
  convertor(&value->value);
  // Union_Ark_String_Ark_Resource
  convertor(&value->placeholder);
  // Ark_String
  convertor(&value->icon);
  // SearchController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_Literal_value_Opt_Ark_String_placeholder_Opt_Union_Ark_String_Ark_Resource_icon_Opt_Ark_String_controller_Opt_SearchController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollBarOptions* value) {
  // Scroller
  convertor(&value->scroller);
  // Ark_ScrollBarDirection
  convertor(&value->direction);
  // Ark_BarState
  convertor(&value->state);
}
template <>
inline void convertor(const Opt_ScrollBarOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OffsetOptions* value) {
  // Ark_Length
  convertor(&value->xOffset);
  // Ark_Length
  convertor(&value->yOffset);
}
template <>
inline void convertor(const Opt_OffsetOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ScrollSnapOptions* value) {
  // Ark_ScrollSnapAlign
  convertor(value->snapAlign);
  // Union_Ark_Length_Array_Ark_Length
  convertor(&value->snapPagination);
  // Ark_Boolean
  convertor(&value->enableSnapToStart);
  // Ark_Boolean
  convertor(&value->enableSnapToEnd);
}
template <>
inline void convertor(const Opt_ScrollSnapOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Color_Ark_Number_Ark_String* value) {
  // Ark_Color
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_Number
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Color_Ark_Number_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ScrollDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SaveButtonOptions* value) {
  // Ark_SaveIconStyle
  convertor(&value->icon);
  // Ark_SaveDescription
  convertor(&value->text);
  // Ark_ButtonType
  convertor(&value->buttonType);
}
template <>
inline void convertor(const Opt_SaveButtonOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_space_Opt_Union_Ark_String_Ark_Number* value) {
  // Union_Ark_String_Ark_Number
  convertor(&value->space);
}
template <>
inline void convertor(const Opt_Literal_space_Opt_Union_Ark_String_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RootSceneSession* value) {
}
template <>
inline void convertor(const Opt_RootSceneSession* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ExpandedMenuItemOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->content);
  // Union_Ark_String_Ark_Resource
  convertor(&value->startIcon);
  // Ark_Function
  convertor(&value->action);
}
template <>
inline void convertor(const Opt_ExpandedMenuItemOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_EnterKeyType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PlaceholderStyle* value) {
  // Font
  convertor(&value->font);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->fontColor);
}
template <>
inline void convertor(const Opt_PlaceholderStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_TextDataDetectorType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextDataDetectorConfig* value) {
  // Array_Ark_TextDataDetectorType
  convertor(&value->types);
  // Ark_Function
  convertor(&value->onDetectResultUpdate);
}
template <>
inline void convertor(const Opt_TextDataDetectorConfig* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const KeyboardOptions* value) {
  // Ark_Boolean
  convertor(&value->supportAvoidance);
}
template <>
inline void convertor(const Opt_KeyboardOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SelectionMenuOptions* value) {
  // Ark_Function
  convertor(&value->onAppear);
  // Ark_Function
  convertor(&value->onDisappear);
}
template <>
inline void convertor(const Opt_SelectionMenuOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_ResponseType_Ark_RichEditorResponseType* value) {
  // Ark_ResponseType
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_RichEditorResponseType
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_ResponseType_Ark_RichEditorResponseType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RichEditorSpanType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorStyledStringOptions* value) {
  // RichEditorStyledStringController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_RichEditorStyledStringOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RichEditorOptions* value) {
  // RichEditorController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_RichEditorOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedBarrierStyle* value) {
  // Ark_String
  convertor(&value->id);
  // Ark_LocalizedBarrierDirection
  convertor(value->localizedDirection);
  // Array_Ark_String
  convertor(&value->referencedId);
}
template <>
inline void convertor(const Opt_LocalizedBarrierStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const LocalizedBarrierStyle* value);
inline void generateStdArrayDefinition(string* result, const Array_LocalizedBarrierStyle* value) {
  int32_t count = value->length;
  result->append("std::array<LocalizedBarrierStyle, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const LocalizedBarrierStyle*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_LocalizedBarrierStyle* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const LocalizedBarrierStyle*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_LocalizedBarrierStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BarrierStyle* value) {
  // Ark_String
  convertor(&value->id);
  // Ark_BarrierDirection
  convertor(value->direction);
  // Array_Ark_String
  convertor(&value->referencedId);
}
template <>
inline void convertor(const Opt_BarrierStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const BarrierStyle* value);
inline void generateStdArrayDefinition(string* result, const Array_BarrierStyle* value) {
  int32_t count = value->length;
  result->append("std::array<BarrierStyle, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const BarrierStyle*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_BarrierStyle* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const BarrierStyle*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_BarrierStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GuideLineStyle* value) {
  // Ark_String
  convertor(&value->id);
  // Ark_Axis
  convertor(value->direction);
  // GuideLinePosition
  convertor(&value->position);
}
template <>
inline void convertor(const Opt_GuideLineStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const GuideLineStyle* value);
inline void generateStdArrayDefinition(string* result, const Array_GuideLineStyle* value) {
  int32_t count = value->length;
  result->append("std::array<GuideLineStyle, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const GuideLineStyle*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_GuideLineStyle* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const GuideLineStyle*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_GuideLineStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RefreshOptions* value) {
  // Ark_Boolean
  convertor(value->refreshing);
  // Union_Ark_Number_Ark_String
  convertor(&value->offset);
  // Union_Ark_Number_Ark_String
  convertor(&value->friction);
  // Union_Ark_String_Ark_Resource
  convertor(&value->promptText);
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->builder);
}
template <>
inline void convertor(const Opt_RefreshOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radius_Opt_Union_Ark_Number_Ark_String_Array_Ark_CustomObject_Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radiusWidth_Opt_Union_Ark_Number_Ark_String_radiusHeight_Opt_Union_Ark_Number_Ark_String* value) {
  // Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radius_Opt_Union_Ark_Number_Ark_String_Array_Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radiusWidth_Opt_Union_Ark_Number_Ark_String_radiusHeight_Opt_Union_Ark_Number_Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radius_Opt_Union_Ark_Number_Ark_String_Array_Ark_CustomObject_Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_radiusWidth_Opt_Union_Ark_Number_Ark_String_radiusHeight_Opt_Union_Ark_Number_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_backgroundUri_Ark_String_foregroundUri_Ark_String_secondaryUri_Opt_Ark_String* value) {
  // Ark_String
  convertor(&value->backgroundUri);
  // Ark_String
  convertor(&value->foregroundUri);
  // Ark_String
  convertor(&value->secondaryUri);
}
template <>
inline void convertor(const Opt_Literal_backgroundUri_Ark_String_foregroundUri_Ark_String_secondaryUri_Opt_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_rating_Ark_Number_indicator_Opt_Ark_Boolean* value) {
  // Ark_Number
  convertor(&value->rating);
  // Ark_Boolean
  convertor(&value->indicator);
}
template <>
inline void convertor(const Opt_Literal_rating_Ark_Number_indicator_Opt_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RadioStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->checkedBackgroundColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->uncheckedBorderColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->indicatorColor);
}
template <>
inline void convertor(const Opt_RadioStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RadioOptions* value) {
  // Ark_String
  convertor(&value->group);
  // Ark_String
  convertor(&value->value);
  // Ark_RadioIndicatorType
  convertor(&value->indicatorType);
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->indicatorBuilder);
}
template <>
inline void convertor(const Opt_RadioOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_width_Opt_Union_Ark_String_Ark_Number_height_Opt_Union_Ark_String_Ark_Number* value) {
  // Union_Ark_String_Ark_Number
  convertor(&value->width);
  // Union_Ark_String_Ark_Number
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_Literal_width_Opt_Union_Ark_String_Ark_Number_height_Opt_Union_Ark_String_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_template_PluginComponentTemplate_data_Ark_CustomObject* value) {
  // PluginComponentTemplate
  convertor(&value->template_);
  // Ark_CustomObject
  convertor(&value->data);
}
template <>
inline void convertor(const Opt_Literal_template_PluginComponentTemplate_data_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_PatternLockController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_commands_Opt_Ark_String* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->width);
  // Union_Ark_Number_Ark_String
  convertor(&value->height);
  // Ark_String
  convertor(&value->commands);
}
template <>
inline void convertor(const Opt_Literal_width_Opt_Union_Ark_Number_Ark_String_height_Opt_Union_Ark_Number_Ark_String_commands_Opt_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PasteButtonOptions* value) {
  // Ark_PasteIconStyle
  convertor(&value->icon);
  // Ark_PasteDescription
  convertor(&value->text);
  // Ark_ButtonType
  convertor(&value->buttonType);
}
template <>
inline void convertor(const Opt_PasteButtonOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_Ark_PanelHeight* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_PanelHeight
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_Ark_PanelHeight* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PanelType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_PanelMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_target_Ark_String_type_Opt_Ark_NavigationType* value) {
  // Ark_String
  convertor(&value->target);
  // Ark_NavigationType
  convertor(&value->type);
}
template <>
inline void convertor(const Opt_Literal_target_Ark_String_type_Opt_Ark_NavigationType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_LayoutSafeAreaEdge* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_LayoutSafeAreaEdge* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_LayoutSafeAreaEdge* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_LayoutSafeAreaType* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_LayoutSafeAreaType* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_LayoutSafeAreaType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavigationToolbarOptions* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_BlurStyle
  convertor(&value->backgroundBlurStyle);
}
template <>
inline void convertor(const Opt_NavigationToolbarOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ToolbarItem* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->value);
  // Union_Ark_String_Ark_Resource
  convertor(&value->icon);
  // Ark_CustomObject
  convertor(&value->symbolIcon);
  // Ark_Function
  convertor(&value->action);
  // Ark_ToolbarItemStatus
  convertor(&value->status);
  // Union_Ark_String_Ark_Resource
  convertor(&value->activeIcon);
  // Ark_CustomObject
  convertor(&value->activeSymbolIcon);
}
template <>
inline void convertor(const Opt_ToolbarItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Array_ToolbarItem_Union_Ark_Function_Ark_Undefined* value) {
  // Array_ToolbarItem
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Array_ToolbarItem_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_CustomObject_Union_Ark_Function_Ark_Undefined* value) {
  // Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_CustomObject_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Array_NavigationMenuItem_Union_Ark_Function_Ark_Undefined* value) {
  // Array_NavigationMenuItem
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Array_NavigationMenuItem_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NavigationTitleMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined_NavigationCommonTitle_NavigationCustomTitle* value) {
  // Union_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // NavigationCommonTitle
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // NavigationCustomTitle
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined_NavigationCommonTitle_NavigationCustomTitle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_CustomObject_Ark_Resource_Ark_CustomObject* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Ark_CustomObject
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_CustomObject_Ark_Resource_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NavigationMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NavBarPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavPathStack* value) {
}
template <>
inline void convertor(const Opt_NavPathStack* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_NavRouteMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const RouteInfo* value) {
  // Ark_String
  convertor(&value->name);
  // Ark_CustomObject
  convertor(&value->param);
}
template <>
inline void convertor(const Opt_RouteInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LayoutSafeAreaEdge* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LayoutSafeAreaType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavigationMenuItem* value) {
  // Ark_String
  convertor(&value->value);
  // Ark_String
  convertor(&value->icon);
  // Ark_CustomObject
  convertor(&value->symbolIcon);
  // Ark_Boolean
  convertor(&value->isEnabled);
  // Ark_Function
  convertor(&value->action);
}
template <>
inline void convertor(const Opt_NavigationMenuItem* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_String_Ark_Resource_Ark_CustomObject_Ark_CustomObject* value) {
  // Union_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_CustomObject
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_String_Ark_Resource_Ark_CustomObject_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NavigationTitleOptions* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_BlurStyle
  convertor(&value->backgroundBlurStyle);
  // Ark_BarStyle
  convertor(&value->barStyle);
}
template <>
inline void convertor(const Opt_NavigationTitleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Union_Ark_Function_Ark_Undefined_NavDestinationCommonTitle_NavDestinationCustomTitle* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // NavDestinationCommonTitle
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // NavDestinationCustomTitle
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Union_Ark_Function_Ark_Undefined_NavDestinationCommonTitle_NavDestinationCustomTitle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MenuItemGroupOptions* value) {
  // Union_Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined
  convertor(&value->header);
  // Union_Union_Ark_String_Ark_Resource_Union_Ark_Function_Ark_Undefined
  convertor(&value->footer);
}
template <>
inline void convertor(const Opt_MenuItemGroupOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Boolean_Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  // Ark_Boolean
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Union_Ark_String_Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_CustomObject
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Boolean_Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_MenuItemOptions_Union_Ark_Function_Ark_Undefined* value) {
  // MenuItemOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_MenuItemOptions_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SubMenuExpandingMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_DividerStyleOptions_Ark_Undefined* value) {
  // DividerStyleOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_DividerStyleOptions_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_CustomObject_Union_Ark_String_Ark_Resource_Ark_CustomObject_ASTCResource* value) {
  // Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_String_Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_CustomObject
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // ASTCResource
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_CustomObject_Union_Ark_String_Ark_Resource_Ark_CustomObject_ASTCResource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_MarqueeUpdateStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_start_Ark_Boolean_step_Opt_Ark_Number_loop_Opt_Ark_Number_fromStart_Opt_Ark_Boolean_src_Ark_String* value) {
  // Ark_Boolean
  convertor(value->start);
  // Ark_Number
  convertor(&value->step);
  // Ark_Number
  convertor(&value->loop);
  // Ark_Boolean
  convertor(&value->fromStart);
  // Ark_String
  convertor(&value->src);
}
template <>
inline void convertor(const Opt_Literal_start_Ark_Boolean_step_Opt_Ark_Number_loop_Opt_Ark_Number_fromStart_Opt_Ark_Boolean_src_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocationButtonOptions* value) {
  // Ark_LocationIconStyle
  convertor(&value->icon);
  // Ark_LocationDescription
  convertor(&value->text);
  // Ark_ButtonType
  convertor(&value->buttonType);
}
template <>
inline void convertor(const Opt_LocationButtonOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SecurityComponentLayoutDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Literal_strokeWidth_Ark_Length_color_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_startMargin_Opt_Ark_Length_endMargin_Opt_Ark_Length_Ark_Undefined* value) {
  // Literal_strokeWidth_Ark_Length_color_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_startMargin_Opt_Ark_Length_endMargin_Opt_Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Literal_strokeWidth_Ark_Length_color_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_startMargin_Opt_Ark_Length_endMargin_Opt_Ark_Length_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ListItemGroupOptions* value) {
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->header);
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->footer);
  // Union_Ark_Number_Ark_String
  convertor(&value->space);
  // Ark_ListItemGroupStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_ListItemGroupOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SwipeActionOptions* value) {
  // Union_Union_Ark_Function_Ark_Undefined_SwipeActionItem
  convertor(&value->start);
  // Union_Union_Ark_Function_Ark_Undefined_SwipeActionItem
  convertor(&value->end);
  // Ark_SwipeEdgeEffect
  convertor(&value->edgeEffect);
  // Ark_Function
  convertor(&value->onOffsetChange);
}
template <>
inline void convertor(const Opt_SwipeActionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Boolean_Ark_EditMode* value) {
  // Ark_Boolean
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_EditMode
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Boolean_Ark_EditMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Sticky* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ListItemOptions* value) {
  // Ark_ListItemStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_ListItemOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_ChildrenMainSize* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_StickyStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ChainAnimationOptions* value) {
  // Ark_Length
  convertor(&value->minSpace);
  // Ark_Length
  convertor(&value->maxSpace);
  // Ark_Number
  convertor(&value->conductivity);
  // Ark_Number
  convertor(&value->intensity);
  // Ark_ChainEdgeEffect
  convertor(&value->edgeEffect);
  // Ark_Number
  convertor(&value->stiffness);
  // Ark_Number
  convertor(&value->damping);
}
template <>
inline void convertor(const Opt_ChainAnimationOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ListItemAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_Literal_minLength_Ark_Length_maxLength_Ark_Length* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_minLength_Ark_Length_maxLength_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_Literal_minLength_Ark_Length_maxLength_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_initialIndex_Opt_Ark_Number_space_Opt_Union_Ark_Number_Ark_String_scroller_Opt_Scroller* value) {
  // Ark_Number
  convertor(&value->initialIndex);
  // Union_Ark_Number_Ark_String
  convertor(&value->space);
  // Scroller
  convertor(&value->scroller);
}
template <>
inline void convertor(const Opt_Literal_initialIndex_Opt_Ark_Number_space_Opt_Union_Ark_Number_Ark_String_scroller_Opt_Scroller* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ImageFrameInfo* value) {
  // Union_Ark_String_Ark_Resource_Ark_CustomObject
  convertor(&value->src);
  // Union_Ark_Number_Ark_String
  convertor(&value->width);
  // Union_Ark_Number_Ark_String
  convertor(&value->height);
  // Union_Ark_Number_Ark_String
  convertor(&value->top);
  // Union_Ark_Number_Ark_String
  convertor(&value->left);
  // Ark_Number
  convertor(&value->duration);
}
template <>
inline void convertor(const Opt_ImageFrameInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const ImageFrameInfo* value);
inline void generateStdArrayDefinition(string* result, const Array_ImageFrameInfo* value) {
  int32_t count = value->length;
  result->append("std::array<ImageFrameInfo, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, (const ImageFrameInfo*)&value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_ImageFrameInfo* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, (const ImageFrameInfo*)&value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_ImageFrameInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ImageAnalyzerConfig* value) {
  // Array_Ark_ImageAnalyzerType
  convertor(&value->types);
}
template <>
inline void convertor(const Opt_ImageAnalyzerConfig* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_CopyOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_ColorFilter_Ark_CustomObject* value) {
  // ColorFilter
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_ColorFilter_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_width_Ark_Number_height_Ark_Number* value) {
  // Ark_Number
  convertor(&value->width);
  // Ark_Number
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_Literal_width_Ark_Number_height_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ImageInterpolation* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_DynamicRangeMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ImageRenderMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_CustomObject_Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  // Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_String_Ark_Resource
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_CustomObject
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_CustomObject_Union_Ark_String_Ark_Resource_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridRowOptions* value) {
  // Union_Ark_Length_GutterOption
  convertor(&value->gutter);
  // Union_Ark_Number_GridRowColumnOption
  convertor(&value->columns);
  // BreakPoints
  convertor(&value->breakpoints);
  // Ark_GridRowDirection
  convertor(&value->direction);
}
template <>
inline void convertor(const Opt_GridRowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridContainerOptions* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->columns);
  // Ark_SizeType
  convertor(&value->sizeType);
  // Union_Ark_Number_Ark_String
  convertor(&value->gutter);
  // Union_Ark_Number_Ark_String
  convertor(&value->margin);
}
template <>
inline void convertor(const Opt_GridContainerOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridColOptions* value) {
  // Union_Ark_Number_GridColColumnOption
  convertor(&value->span);
  // Union_Ark_Number_GridColColumnOption
  convertor(&value->offset);
  // Union_Ark_Number_GridColColumnOption
  convertor(&value->order);
}
template <>
inline void convertor(const Opt_GridColOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridItemOptions* value) {
  // Ark_GridItemStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_GridItemOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_GridDirection* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GridLayoutOptions* value) {
  // Tuple_Ark_Number_Ark_Number
  convertor(&value->regularSize);
  // Array_Ark_Number
  convertor(&value->irregularIndexes);
  // Ark_Function
  convertor(&value->onGetIrregularSizeByIndex);
  // Ark_Function
  convertor(&value->onGetRectByIndex);
}
template <>
inline void convertor(const Opt_GridLayoutOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NestedScrollOptions* value) {
  // Ark_NestedScrollMode
  convertor(value->scrollForward);
  // Ark_NestedScrollMode
  convertor(value->scrollBackward);
}
template <>
inline void convertor(const Opt_NestedScrollOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const EdgeEffectOptions* value) {
  // Ark_Boolean
  convertor(value->alwaysEnabled);
}
template <>
inline void convertor(const Opt_EdgeEffectOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_EdgeEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GaugeIndicatorOptions* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->icon);
  // Ark_Length
  convertor(&value->space);
}
template <>
inline void convertor(const Opt_GaugeIndicatorOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GaugeShadowOptions* value) {
  // Union_Ark_Number_Ark_Resource
  convertor(&value->radius);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetX);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetY);
}
template <>
inline void convertor(const Opt_GaugeShadowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value) {
  // Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient
  convertor(&value->value0);
  // Ark_Number
  convertor(&value->value1);
}
template <>
inline void convertor(const Opt_Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Array_Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // LinearGradient
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Array_Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Array_Tuple_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_value_Ark_Number_min_Opt_Ark_Number_max_Opt_Ark_Number* value) {
  // Ark_Number
  convertor(&value->value);
  // Ark_Number
  convertor(&value->min);
  // Ark_Number
  convertor(&value->max);
}
template <>
inline void convertor(const Opt_Literal_value_Ark_Number_min_Opt_Ark_Number_max_Opt_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FormLinkOptions* value) {
  // Ark_String
  convertor(&value->action);
  // Ark_String
  convertor(&value->moduleName);
  // Ark_String
  convertor(&value->bundleName);
  // Ark_String
  convertor(&value->abilityName);
  // Ark_String
  convertor(&value->uri);
  // Object
  convertor(&value->params);
}
template <>
inline void convertor(const Opt_FormLinkOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FormInfo* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->id);
  // Ark_String
  convertor(&value->name);
  // Ark_String
  convertor(&value->bundle);
  // Ark_String
  convertor(&value->ability);
  // Ark_String
  convertor(&value->module);
  // Ark_FormDimension
  convertor(&value->dimension);
  // Ark_Boolean
  convertor(&value->temporary);
  // Ark_CustomObject
  convertor(&value->want);
  // Ark_FormRenderingMode
  convertor(&value->renderingMode);
  // Ark_FormShape
  convertor(&value->shape);
}
template <>
inline void convertor(const Opt_FormInfo* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_upperItems_Opt_Array_Ark_String* value) {
  // Array_Ark_String
  convertor(&value->upperItems);
}
template <>
inline void convertor(const Opt_Literal_upperItems_Opt_Array_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FlexOptions* value) {
  // Ark_FlexDirection
  convertor(&value->direction);
  // Ark_FlexWrap
  convertor(&value->wrap);
  // Ark_FlexAlign
  convertor(&value->justifyContent);
  // Ark_ItemAlign
  convertor(&value->alignItems);
  // Ark_FlexAlign
  convertor(&value->alignContent);
  // FlexSpaceOptions
  convertor(&value->space);
}
template <>
inline void convertor(const Opt_FlexOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_EmbeddedType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DatePickerOptions* value) {
  // Ark_CustomObject
  convertor(&value->start);
  // Ark_CustomObject
  convertor(&value->end);
  // Ark_CustomObject
  convertor(&value->selected);
}
template <>
inline void convertor(const Opt_DatePickerOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DataPanelShadowOptions* value) {
  // Union_Ark_Number_Ark_Resource
  convertor(&value->radius);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetX);
  // Union_Ark_Number_Ark_Resource
  convertor(&value->offsetY);
  // Array_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LinearGradient
  convertor(&value->colors);
}
template <>
inline void convertor(const Opt_DataPanelShadowOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DataPanelOptions* value) {
  // Array_Ark_Number
  convertor(&value->values);
  // Ark_Number
  convertor(&value->max);
  // Ark_DataPanelType
  convertor(&value->type);
}
template <>
inline void convertor(const Opt_DataPanelOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TextBackgroundStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  convertor(&value->radius);
}
template <>
inline void convertor(const Opt_TextBackgroundStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SceneOptions* value) {
  // Union_Ark_Resource_Ark_CustomObject
  convertor(&value->scene);
  // Ark_ModelType
  convertor(&value->modelType);
}
template <>
inline void convertor(const Opt_SceneOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_ColumnSplitDividerStyle_Ark_Undefined* value) {
  // ColumnSplitDividerStyle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_ColumnSplitDividerStyle_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PointLightStyle* value) {
  // LightSource
  convertor(&value->lightSource);
  // Ark_IlluminatedType
  convertor(&value->illuminated);
  // Ark_Number
  convertor(&value->bloom);
}
template <>
inline void convertor(const Opt_PointLightStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CircleOptions* value) {
  // Union_Ark_String_Ark_Number
  convertor(&value->width);
  // Union_Ark_String_Ark_Number
  convertor(&value->height);
}
template <>
inline void convertor(const Opt_CircleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LineJoinStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_LineCapStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CheckboxGroupOptions* value) {
  // Ark_String
  convertor(&value->group);
}
template <>
inline void convertor(const Opt_CheckboxGroupOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MarkStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->strokeColor);
  // Ark_Length
  convertor(&value->size);
  // Ark_Length
  convertor(&value->strokeWidth);
}
template <>
inline void convertor(const Opt_MarkStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_CheckBoxShape* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CheckboxOptions* value) {
  // Ark_String
  convertor(&value->name);
  // Ark_String
  convertor(&value->group);
  // Union_Ark_Function_Ark_Undefined
  convertor(&value->indicatorBuilder);
}
template <>
inline void convertor(const Opt_CheckboxOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ImageAnalyzerType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_CanvasRenderingContext2D_DrawingRenderingContext* value) {
  // CanvasRenderingContext2D
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // DrawingRenderingContext
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_CanvasRenderingContext2D_DrawingRenderingContext* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PickerTextStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Font
  convertor(&value->font);
}
template <>
inline void convertor(const Opt_PickerTextStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_dx_Ark_Length_dy_Ark_Length* value) {
  // Ark_Length
  convertor(&value->dx);
  // Ark_Length
  convertor(&value->dy);
}
template <>
inline void convertor(const Opt_Literal_dx_Ark_Length_dy_Ark_Length* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_CalendarAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CalendarOptions* value) {
  // Union_Ark_Number_Ark_Resource
  convertor(&value->hintRadius);
  // Ark_CustomObject
  convertor(&value->selected);
}
template <>
inline void convertor(const Opt_CalendarOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const WorkStateStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->workDayMarkColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->offDayMarkColor);
  // Ark_Number
  convertor(&value->workDayMarkSize);
  // Ark_Number
  convertor(&value->offDayMarkSize);
  // Ark_Number
  convertor(&value->workStateWidth);
  // Ark_Number
  convertor(&value->workStateHorizontalMovingDistance);
  // Ark_Number
  convertor(&value->workStateVerticalMovingDistance);
}
template <>
inline void convertor(const Opt_WorkStateStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const WeekStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->weekColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->weekendDayColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->weekendLunarColor);
  // Ark_Number
  convertor(&value->weekFontSize);
  // Ark_Number
  convertor(&value->weekHeight);
  // Ark_Number
  convertor(&value->weekWidth);
  // Ark_Number
  convertor(&value->weekAndDayRowSpace);
}
template <>
inline void convertor(const Opt_WeekStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const TodayStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->focusedDayColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->focusedLunarColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->focusedAreaBackgroundColor);
  // Ark_Number
  convertor(&value->focusedAreaRadius);
}
template <>
inline void convertor(const Opt_TodayStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const NonCurrentDayStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->nonCurrentMonthDayColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->nonCurrentMonthLunarColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->nonCurrentMonthWorkDayMarkColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->nonCurrentMonthOffDayMarkColor);
}
template <>
inline void convertor(const Opt_NonCurrentDayStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CurrentDayStyle* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->dayColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->lunarColor);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->markLunarColor);
  // Ark_Number
  convertor(&value->dayFontSize);
  // Ark_Number
  convertor(&value->lunarDayFontSize);
  // Ark_Number
  convertor(&value->dayHeight);
  // Ark_Number
  convertor(&value->dayWidth);
  // Ark_Number
  convertor(&value->gregorianCalendarHeight);
  // Ark_Number
  convertor(&value->dayYAxisOffset);
  // Ark_Number
  convertor(&value->lunarDayYAxisOffset);
  // Ark_Number
  convertor(&value->underscoreXAxisOffset);
  // Ark_Number
  convertor(&value->underscoreYAxisOffset);
  // Ark_Number
  convertor(&value->scheduleMarkerXAxisOffset);
  // Ark_Number
  convertor(&value->scheduleMarkerYAxisOffset);
  // Ark_Number
  convertor(&value->colSpace);
  // Ark_Number
  convertor(&value->dailyFiveRowSpace);
  // Ark_Number
  convertor(&value->dailySixRowSpace);
  // Ark_Number
  convertor(&value->lunarHeight);
  // Ark_Number
  convertor(&value->underscoreWidth);
  // Ark_Number
  convertor(&value->underscoreLength);
  // Ark_Number
  convertor(&value->scheduleMarkerRadius);
  // Ark_Number
  convertor(&value->boundaryRowOffset);
  // Ark_Number
  convertor(&value->boundaryColOffset);
}
template <>
inline void convertor(const Opt_CurrentDayStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const CalendarDay* value) {
  // Ark_Number
  convertor(&value->index);
  // Ark_String
  convertor(&value->lunarMonth);
  // Ark_String
  convertor(&value->lunarDay);
  // Ark_String
  convertor(&value->dayMark);
  // Ark_String
  convertor(&value->dayMarkValue);
  // Ark_Number
  convertor(&value->year);
  // Ark_Number
  convertor(&value->month);
  // Ark_Number
  convertor(&value->day);
  // Ark_Boolean
  convertor(value->isFirstOfLunar);
  // Ark_Boolean
  convertor(value->hasSchedule);
  // Ark_Boolean
  convertor(value->markLunarDay);
}
template <>
inline void convertor(const Opt_CalendarDay* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_date_Literal_year_Ark_Number_month_Ark_Number_day_Ark_Number_currentData_MonthData_preData_MonthData_nextData_MonthData_controller_Opt_CalendarController* value) {
  // Literal_year_Ark_Number_month_Ark_Number_day_Ark_Number
  convertor(&value->date);
  // MonthData
  convertor(&value->currentData);
  // MonthData
  convertor(&value->preData);
  // MonthData
  convertor(&value->nextData);
  // CalendarController
  convertor(&value->controller);
}
template <>
inline void convertor(const Opt_Literal_date_Literal_year_Ark_Number_month_Ark_Number_day_Ark_Number_currentData_MonthData_preData_MonthData_nextData_MonthData_controller_Opt_CalendarController* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LabelStyle* value) {
  // Ark_TextOverflow
  convertor(&value->overflow);
  // Ark_Number
  convertor(&value->maxLines);
  // Union_Ark_Number_Union_Ark_String_Ark_Resource
  convertor(&value->minFontSize);
  // Union_Ark_Number_Union_Ark_String_Ark_Resource
  convertor(&value->maxFontSize);
  // Ark_TextHeightAdaptivePolicy
  convertor(&value->heightAdaptivePolicy);
  // Font
  convertor(&value->font);
}
template <>
inline void convertor(const Opt_LabelStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ButtonOptions* value) {
  // Ark_ButtonType
  convertor(&value->type);
  // Ark_Boolean
  convertor(&value->stateEffect);
  // Ark_ButtonStyleMode
  convertor(&value->buttonStyle);
  // Ark_ControlSize
  convertor(&value->controlSize);
  // Ark_ButtonRole
  convertor(&value->role);
}
template <>
inline void convertor(const Opt_ButtonOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BadgeParamWithString* value) {
  // Union_Ark_BadgePosition_Position
  convertor(&value->position);
  // BadgeStyle
  convertor(&value->style);
  // Ark_String
  convertor(&value->value);
}
template <>
inline void convertor(const Opt_BadgeParamWithString* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BadgeParamWithNumber* value) {
  // Union_Ark_BadgePosition_Position
  convertor(&value->position);
  // BadgeStyle
  convertor(&value->style);
  // Ark_Number
  convertor(&value->count);
  // Ark_Number
  convertor(&value->maxCount);
}
template <>
inline void convertor(const Opt_BadgeParamWithNumber* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_SpringMotion_FrictionMotion_ScrollMotion* value) {
  // SpringMotion
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // FrictionMotion
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // ScrollMotion
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_SpringMotion_FrictionMotion_ScrollMotion* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FillMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_AnimationStatus* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_IndexerAlign* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_arrayValue_Array_Ark_String_selected_Ark_Number* value) {
  // Array_Ark_String
  convertor(&value->arrayValue);
  // Ark_Number
  convertor(&value->selected);
}
template <>
inline void convertor(const Opt_Literal_arrayValue_Array_Ark_String_selected_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_want_Ark_CustomObject* value) {
  // Ark_CustomObject
  convertor(&value->want);
}
template <>
inline void convertor(const Opt_Literal_want_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BackgroundBrightnessOptions* value) {
  // Ark_Number
  convertor(&value->rate);
  // Ark_Number
  convertor(&value->lightUpDegree);
}
template <>
inline void convertor(const Opt_BackgroundBrightnessOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GestureModifier* value) {
}
template <>
inline void convertor(const Opt_GestureModifier* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_RenderFit* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ObscuredReasons* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_ObscuredReasons* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_ObscuredReasons* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_ObscuredReasons* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ModifierKey* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_ModifierKey* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_ModifierKey* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_ModifierKey* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Ark_FunctionKey* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_FunctionKey
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Ark_FunctionKey* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PixelStretchEffectOptions* value) {
  // Ark_Length
  convertor(&value->top);
  // Ark_Length
  convertor(&value->bottom);
  // Ark_Length
  convertor(&value->left);
  // Ark_Length
  convertor(&value->right);
}
template <>
inline void convertor(const Opt_PixelStretchEffectOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const StateStyles* value) {
  // Ark_CustomObject
  convertor(&value->normal);
  // Ark_CustomObject
  convertor(&value->pressed);
  // Ark_CustomObject
  convertor(&value->disabled);
  // Ark_CustomObject
  convertor(&value->focused);
  // Ark_CustomObject
  convertor(&value->clicked);
  // Ark_CustomObject
  convertor(&value->selected);
}
template <>
inline void convertor(const Opt_StateStyles* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const SheetOptions* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_Function
  convertor(&value->onAppear);
  // Ark_Function
  convertor(&value->onDisappear);
  // Ark_Function
  convertor(&value->onWillAppear);
  // Ark_Function
  convertor(&value->onWillDisappear);
  // Union_Ark_SheetSize_Ark_Length
  convertor(&value->height);
  // Ark_Boolean
  convertor(&value->dragBar);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->maskColor);
  // Tuple_Union_Ark_SheetSize_Ark_Length_Opt_Union_Ark_SheetSize_Ark_Length_Opt_Union_Ark_SheetSize_Ark_Length
  convertor(&value->detents);
  // Ark_BlurStyle
  convertor(&value->blurStyle);
  // Union_Ark_Boolean_Ark_Resource
  convertor(&value->showClose);
  // Ark_SheetType
  convertor(&value->preferType);
  // Union_SheetTitleOptions_Union_Ark_Function_Ark_Undefined
  convertor(&value->title);
  // Ark_Function
  convertor(&value->shouldDismiss);
  // Ark_Function
  convertor(&value->onWillDismiss);
  // Ark_Function
  convertor(&value->onWillSpringBackWhenDismiss);
  // Ark_Boolean
  convertor(&value->enableOutsideInteractive);
  // Ark_Length
  convertor(&value->width);
  // Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_LocalizedEdgeWidths
  convertor(&value->borderWidth);
  // Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LocalizedEdgeColors
  convertor(&value->borderColor);
  // Union_Ark_BorderStyle_Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle
  convertor(&value->borderStyle);
  // Union_ShadowOptions_Ark_ShadowStyle
  convertor(&value->shadow);
  // Ark_Function
  convertor(&value->onHeightDidChange);
  // Ark_SheetMode
  convertor(&value->mode);
  // Ark_ScrollSizeMode
  convertor(&value->scrollSizeMode);
  // Ark_Function
  convertor(&value->onDetentsDidChange);
  // Ark_Function
  convertor(&value->onWidthDidChange);
  // Ark_Function
  convertor(&value->onTypeDidChange);
  // Ark_CustomObject
  convertor(&value->uiContext);
}
template <>
inline void convertor(const Opt_SheetOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ContentCoverOptions* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_Function
  convertor(&value->onAppear);
  // Ark_Function
  convertor(&value->onDisappear);
  // Ark_Function
  convertor(&value->onWillAppear);
  // Ark_Function
  convertor(&value->onWillDisappear);
  // Ark_ModalTransition
  convertor(&value->modalTransition);
  // Ark_Function
  convertor(&value->onWillDismiss);
  // TransitionEffect
  convertor(&value->transition);
}
template <>
inline void convertor(const Opt_ContentCoverOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Array_MenuElement_Union_Ark_Function_Ark_Undefined* value) {
  // Array_MenuElement
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Array_MenuElement_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MenuOptions* value) {
  // Position
  convertor(&value->offset);
  // Ark_Placement
  convertor(&value->placement);
  // Ark_Boolean
  convertor(&value->enableArrow);
  // Ark_Length
  convertor(&value->arrowOffset);
  // Union_Ark_MenuPreviewMode_Union_Ark_Function_Ark_Undefined
  convertor(&value->preview);
  // Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  convertor(&value->borderRadius);
  // Ark_Function
  convertor(&value->onAppear);
  // Ark_Function
  convertor(&value->onDisappear);
  // Ark_Function
  convertor(&value->aboutToAppear);
  // Ark_Function
  convertor(&value->aboutToDisappear);
  // ContextMenuAnimationOptions
  convertor(&value->previewAnimationOptions);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->backgroundColor);
  // Ark_BlurStyle
  convertor(&value->backgroundBlurStyle);
  // TransitionEffect
  convertor(&value->transition);
  // Union_Ark_String_Ark_Resource
  convertor(&value->title);
  // Ark_Boolean
  convertor(&value->showInSubWindow);
}
template <>
inline void convertor(const Opt_MenuOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MenuElement* value) {
  // Union_Ark_String_Ark_Resource
  convertor(&value->value);
  // Union_Ark_String_Ark_Resource
  convertor(&value->icon);
  // Ark_CustomObject
  convertor(&value->symbolIcon);
  // Ark_Boolean
  convertor(&value->enabled);
  // Ark_Function
  convertor(&value->action);
}
template <>
inline void convertor(const Opt_MenuElement* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_PopupOptions_CustomPopupOptions* value) {
  // PopupOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // CustomPopupOptions
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_PopupOptions_CustomPopupOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const GeometryTransitionOptions* value) {
  // Ark_Boolean
  convertor(&value->follow);
}
template <>
inline void convertor(const Opt_GeometryTransitionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_CustomObject_Ark_CustomObject_Ark_CustomObject_Ark_CustomObject* value) {
  // Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_CustomObject
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_CustomObject
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // Ark_CustomObject
  if (value->selector == 3) {
    convertor(&value->value3);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_CustomObject_Ark_CustomObject_Ark_CustomObject_Ark_CustomObject* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_CircleAttribute_EllipseAttribute_PathAttribute_RectAttribute_ProgressMask* value) {
  // CircleAttribute
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // EllipseAttribute
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // PathAttribute
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // RectAttribute
  if (value->selector == 3) {
    convertor(&value->value3);
  }
  // ProgressMask
  if (value->selector == 4) {
    convertor(&value->value4);
  }
}
template <>
inline void convertor(const Opt_Union_CircleAttribute_EllipseAttribute_PathAttribute_RectAttribute_ProgressMask* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Boolean_CircleAttribute_EllipseAttribute_PathAttribute_RectAttribute* value) {
  // Ark_Boolean
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // CircleAttribute
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // EllipseAttribute
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // PathAttribute
  if (value->selector == 3) {
    convertor(&value->value3);
  }
  // RectAttribute
  if (value->selector == 4) {
    convertor(&value->value4);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Boolean_CircleAttribute_EllipseAttribute_PathAttribute_RectAttribute* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BlendApplyType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_BlendMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->value0);
  // Ark_Number
  convertor(&value->value1);
}
template <>
inline void convertor(const Opt_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_center_Tuple_Ark_Length_Ark_Length_radius_Union_Ark_Number_Ark_String_colors_Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number_repeating_Opt_Ark_Boolean* value) {
  // Tuple_Ark_Length_Ark_Length
  convertor(&value->center);
  // Union_Ark_Number_Ark_String
  convertor(&value->radius);
  // Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number
  convertor(&value->colors);
  // Ark_Boolean
  convertor(&value->repeating);
}
template <>
inline void convertor(const Opt_Literal_center_Tuple_Ark_Length_Ark_Length_radius_Union_Ark_Number_Ark_String_colors_Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number_repeating_Opt_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_center_Tuple_Ark_Length_Ark_Length_start_Opt_Union_Ark_Number_Ark_String_end_Opt_Union_Ark_Number_Ark_String_rotation_Opt_Union_Ark_Number_Ark_String_colors_Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number_repeating_Opt_Ark_Boolean* value) {
  // Tuple_Ark_Length_Ark_Length
  convertor(&value->center);
  // Union_Ark_Number_Ark_String
  convertor(&value->start);
  // Union_Ark_Number_Ark_String
  convertor(&value->end);
  // Union_Ark_Number_Ark_String
  convertor(&value->rotation);
  // Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number
  convertor(&value->colors);
  // Ark_Boolean
  convertor(&value->repeating);
}
template <>
inline void convertor(const Opt_Literal_center_Tuple_Ark_Length_Ark_Length_start_Opt_Union_Ark_Number_Ark_String_end_Opt_Union_Ark_Number_Ark_String_rotation_Opt_Union_Ark_Number_Ark_String_colors_Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number_repeating_Opt_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_angle_Opt_Union_Ark_Number_Ark_String_direction_Opt_Ark_GradientDirection_colors_Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number_repeating_Opt_Ark_Boolean* value) {
  // Union_Ark_Number_Ark_String
  convertor(&value->angle);
  // Ark_GradientDirection
  convertor(&value->direction);
  // Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number
  convertor(&value->colors);
  // Ark_Boolean
  convertor(&value->repeating);
}
template <>
inline void convertor(const Opt_Literal_angle_Opt_Union_Ark_Number_Ark_String_direction_Opt_Ark_GradientDirection_colors_Array_Tuple_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_Number_repeating_Opt_Ark_Boolean* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_align_Opt_Ark_Alignment_offset_Opt_Literal_x_Opt_Ark_Number_y_Opt_Ark_Number* value) {
  // Ark_Alignment
  convertor(&value->align);
  // Literal_x_Opt_Ark_Number_y_Opt_Ark_Number
  convertor(&value->offset);
}
template <>
inline void convertor(const Opt_Literal_align_Opt_Ark_Alignment_offset_Opt_Literal_x_Opt_Ark_Number_y_Opt_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_String_Union_Ark_Function_Ark_Undefined* value) {
  // Ark_String
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_String_Union_Ark_Function_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DragInteractionOptions* value) {
  // Ark_Boolean
  convertor(&value->isMultiSelectionEnabled);
  // Ark_Boolean
  convertor(&value->defaultAnimationBeforeLifting);
}
template <>
inline void convertor(const Opt_DragInteractionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const DragPreviewOptions* value) {
  // Union_Ark_DragPreviewMode_Array_Ark_DragPreviewMode
  convertor(&value->mode);
  // Ark_CustomObject
  convertor(&value->modifier);
  // Union_Ark_Boolean_Ark_Number
  convertor(&value->numberBadge);
}
template <>
inline void convertor(const Opt_DragPreviewOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Function_Ark_Undefined_DragItemInfo_Ark_String* value) {
  // Union_Ark_Function_Ark_Undefined
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // DragItemInfo
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_String
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Function_Ark_Undefined_DragItemInfo_Ark_String* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Array_Ark_CustomObject_Ark_Undefined* value) {
  // Array_Ark_CustomObject
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Array_Ark_CustomObject_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_ClickEffect_Ark_Undefined* value) {
  // ClickEffect
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_ClickEffect_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ChainStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LocalizedAlignRuleOptions* value) {
  // LocalizedHorizontalAlignParam
  convertor(&value->start);
  // LocalizedHorizontalAlignParam
  convertor(&value->end);
  // LocalizedHorizontalAlignParam
  convertor(&value->middle);
  // LocalizedVerticalAlignParam
  convertor(&value->top);
  // LocalizedVerticalAlignParam
  convertor(&value->bottom);
  // LocalizedVerticalAlignParam
  convertor(&value->center);
  // Bias
  convertor(&value->bias);
}
template <>
inline void convertor(const Opt_LocalizedAlignRuleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const AlignRuleOption* value) {
  // Literal_anchor_Ark_String_align_Ark_HorizontalAlign
  convertor(&value->left);
  // Literal_anchor_Ark_String_align_Ark_HorizontalAlign
  convertor(&value->right);
  // Literal_anchor_Ark_String_align_Ark_HorizontalAlign
  convertor(&value->middle);
  // Literal_anchor_Ark_String_align_Ark_VerticalAlign
  convertor(&value->top);
  // Literal_anchor_Ark_String_align_Ark_VerticalAlign
  convertor(&value->bottom);
  // Literal_anchor_Ark_String_align_Ark_VerticalAlign
  convertor(&value->center);
  // Bias
  convertor(&value->bias);
}
template <>
inline void convertor(const Opt_AlignRuleOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_xs_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number_sm_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number_md_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number_lg_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number* value) {
  // Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number
  convertor(&value->xs);
  // Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number
  convertor(&value->sm);
  // Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number
  convertor(&value->md);
  // Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number
  convertor(&value->lg);
}
template <>
inline void convertor(const Opt_Literal_xs_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number_sm_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number_md_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number_lg_Opt_Union_Ark_Number_Literal_span_Ark_Number_offset_Ark_Number* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Position_Edges_LocalizedEdges* value) {
  // Position
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Edges
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedEdges
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Position_Edges_LocalizedEdges* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Position_LocalizedPosition* value) {
  // Position
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // LocalizedPosition
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Position_LocalizedPosition* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Direction* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const sharedTransitionOptions* value) {
  // Ark_Number
  convertor(&value->duration);
  // Union_Ark_Curve_Ark_String_ICurve
  convertor(&value->curve);
  // Ark_Number
  convertor(&value->delay);
  // MotionPathOptions
  convertor(&value->motionPath);
  // Ark_Number
  convertor(&value->zIndex);
  // Ark_SharedTransitionEffectType
  convertor(&value->type);
}
template <>
inline void convertor(const Opt_sharedTransitionOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_Visibility* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Number_InvertOptions* value) {
  // Ark_Number
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // InvertOptions
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Number_InvertOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Color_Ark_String_Ark_Resource* value) {
  // Ark_Color
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Ark_String
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // Ark_Resource
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Color_Ark_String_Ark_Resource* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const MotionBlurOptions* value) {
  // Ark_Number
  convertor(&value->radius);
  // MotionBlurAnchor
  convertor(&value->anchor);
}
template <>
inline void convertor(const Opt_MotionBlurOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const LinearGradientBlurOptions* value) {
  // Array_Tuple_Ark_Number_Ark_Number
  convertor(&value->fractionStops);
  // Ark_GradientDirection
  convertor(value->direction);
}
template <>
inline void convertor(const Opt_LinearGradientBlurOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_GestureMask* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_TapGestureInterface_LongPressGestureInterface_PanGestureInterface_PinchGestureInterface_SwipeGestureInterface_RotationGestureInterface_GestureGroupInterface* value) {
  // TapGestureInterface
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // LongPressGestureInterface
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // PanGestureInterface
  if (value->selector == 2) {
    convertor(&value->value2);
  }
  // PinchGestureInterface
  if (value->selector == 3) {
    convertor(&value->value3);
  }
  // SwipeGestureInterface
  if (value->selector == 4) {
    convertor(&value->value4);
  }
  // RotationGestureInterface
  if (value->selector == 5) {
    convertor(&value->value5);
  }
  // GestureGroupInterface
  if (value->selector == 6) {
    convertor(&value->value6);
  }
}
template <>
inline void convertor(const Opt_Union_TapGestureInterface_LongPressGestureInterface_PanGestureInterface_PinchGestureInterface_SwipeGestureInterface_RotationGestureInterface_GestureGroupInterface* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_TransitionOptions_TransitionEffect* value) {
  // TransitionOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // TransitionEffect
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_TransitionOptions_TransitionEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const AnimateParam* value) {
  // Ark_Number
  convertor(&value->duration);
  // Ark_Number
  convertor(&value->tempo);
  // Union_Ark_Curve_Ark_String_ICurve
  convertor(&value->curve);
  // Ark_Number
  convertor(&value->delay);
  // Ark_Number
  convertor(&value->iterations);
  // Ark_PlayMode
  convertor(&value->playMode);
  // Ark_Function
  convertor(&value->onFinish);
  // Ark_FinishCallbackType
  convertor(&value->finishCallbackType);
  // ExpectedFrameRateRange
  convertor(&value->expectedFrameRateRange);
}
template <>
inline void convertor(const Opt_AnimateParam* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_FocusPriority* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const FocusBoxStyle* value) {
  // Ark_CustomObject
  convertor(&value->margin);
  // Ark_CustomObject
  convertor(&value->strokeColor);
  // Ark_CustomObject
  convertor(&value->strokeWidth);
}
template <>
inline void convertor(const Opt_FocusBoxStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_HoverEffect* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_ColoringStrategy* value) {
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_ColoringStrategy
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Ark_ColoringStrategy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_OutlineStyle_Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle* value) {
  // Ark_OutlineStyle
  if (value->selector == 0) {
    convertor(value->value0);
  }
  // Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_OutlineStyle_Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const OutlineOptions* value) {
  // Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length
  convertor(&value->width);
  // Union_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LocalizedEdgeColors
  convertor(&value->color);
  // Union_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_Ark_Length
  convertor(&value->radius);
  // Union_Literal_top_Opt_Ark_OutlineStyle_right_Opt_Ark_OutlineStyle_bottom_Opt_Ark_OutlineStyle_left_Opt_Ark_OutlineStyle_Ark_OutlineStyle
  convertor(&value->style);
}
template <>
inline void convertor(const Opt_OutlineOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BorderImageOption* value) {
  // Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_LocalizedEdgeWidths
  convertor(&value->slice);
  // Ark_RepeatMode
  convertor(&value->repeat);
  // Union_Ark_String_Ark_Resource_LinearGradient
  convertor(&value->source);
  // Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_LocalizedEdgeWidths
  convertor(&value->width);
  // Union_Ark_Length_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_LocalizedEdgeWidths
  convertor(&value->outset);
  // Ark_Boolean
  convertor(&value->fill);
}
template <>
inline void convertor(const Opt_BorderImageOption* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_LocalizedBorderRadiuses* value) {
  // Ark_Length
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length
  if (value->selector == 1) {
    convertor(&value->value1);
  }
  // LocalizedBorderRadiuses
  if (value->selector == 2) {
    convertor(&value->value2);
  }
}
template <>
inline void convertor(const Opt_Union_Ark_Length_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_LocalizedBorderRadiuses* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BorderOptions* value) {
  // Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_Length_LocalizedEdgeWidths
  convertor(&value->width);
  // Union_Literal_top_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_right_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_bottom_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_left_Opt_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource_LocalizedEdgeColors
  convertor(&value->color);
  // Union_Literal_topLeft_Opt_Ark_Length_topRight_Opt_Ark_Length_bottomLeft_Opt_Ark_Length_bottomRight_Opt_Ark_Length_Ark_Length_LocalizedBorderRadiuses
  convertor(&value->radius);
  // Union_Literal_top_Opt_Ark_BorderStyle_right_Opt_Ark_BorderStyle_bottom_Opt_Ark_BorderStyle_left_Opt_Ark_BorderStyle_Ark_BorderStyle
  convertor(&value->style);
  // Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_CustomObject_LocalizedEdgeWidths
  convertor(&value->dashGap);
  // Union_Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length_Ark_CustomObject_LocalizedEdgeWidths
  convertor(&value->dashWidth);
}
template <>
inline void convertor(const Opt_BorderOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ForegroundBlurStyleOptions* value) {
  // Ark_ThemeColorMode
  convertor(&value->colorMode);
  // Ark_AdaptiveColor
  convertor(&value->adaptiveColor);
  // Ark_Number
  convertor(&value->scale);
  // BlurOptions
  convertor(&value->blurOptions);
}
template <>
inline void convertor(const Opt_ForegroundBlurStyleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ForegroundEffectOptions* value) {
  // Ark_Number
  convertor(&value->radius);
}
template <>
inline void convertor(const Opt_ForegroundEffectOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ResizableOptions* value) {
  // Literal_top_Opt_Ark_Length_right_Opt_Ark_Length_bottom_Opt_Ark_Length_left_Opt_Ark_Length
  convertor(&value->slice);
}
template <>
inline void convertor(const Opt_ResizableOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BackgroundEffectOptions* value) {
  // Ark_Number
  convertor(&value->radius);
  // Ark_Number
  convertor(&value->saturation);
  // Ark_Number
  convertor(&value->brightness);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->color);
  // Ark_AdaptiveColor
  convertor(&value->adaptiveColor);
  // BlurOptions
  convertor(&value->blurOptions);
  // Ark_BlurStyleActivePolicy
  convertor(&value->policy);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->inactiveColor);
  // Ark_BlurType
  convertor(&value->type);
}
template <>
inline void convertor(const Opt_BackgroundEffectOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const BackgroundBlurStyleOptions* value) {
  // Ark_ThemeColorMode
  convertor(&value->colorMode);
  // Ark_AdaptiveColor
  convertor(&value->adaptiveColor);
  // Ark_Number
  convertor(&value->scale);
  // BlurOptions
  convertor(&value->blurOptions);
  // Ark_BlurStyleActivePolicy
  convertor(&value->policy);
  // Union_Ark_Color_Ark_Number_Ark_String_Ark_Resource
  convertor(&value->inactiveColor);
  // Ark_BlurType
  convertor(&value->type);
}
template <>
inline void convertor(const Opt_BackgroundBlurStyleOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Position_Ark_Alignment* value) {
  // Position
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Alignment
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Position_Ark_Alignment* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_SizeOptions_Ark_ImageSize* value) {
  // SizeOptions
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_ImageSize
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_SizeOptions_Ark_ImageSize* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_ImageRepeat* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const PixelRoundPolicy* value) {
  // Ark_PixelRoundCalcPolicy
  convertor(&value->start);
  // Ark_PixelRoundCalcPolicy
  convertor(&value->top);
  // Ark_PixelRoundCalcPolicy
  convertor(&value->end);
  // Ark_PixelRoundCalcPolicy
  convertor(&value->bottom);
}
template <>
inline void convertor(const Opt_PixelRoundPolicy* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Literal_align_Opt_Ark_Alignment* value) {
  // Ark_Alignment
  convertor(&value->align);
}
template <>
inline void convertor(const Opt_Literal_align_Opt_Ark_Alignment* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_HitTestMode* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const ConstraintSizeOptions* value) {
  // Ark_Length
  convertor(&value->minWidth);
  // Ark_Length
  convertor(&value->maxWidth);
  // Ark_Length
  convertor(&value->minHeight);
  // Ark_Length
  convertor(&value->maxHeight);
}
template <>
inline void convertor(const Opt_ConstraintSizeOptions* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_Array_Rectangle_Rectangle* value) {
  // Array_Rectangle
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Rectangle
  if (value->selector == 1) {
    convertor(&value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_Array_Rectangle_Rectangle* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SafeAreaEdge* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_SafeAreaEdge* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_SafeAreaEdge* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_SafeAreaEdge* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Opt_Ark_SafeAreaType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void WriteToString(string* result, const Ark_Int32 value);
inline void generateStdArrayDefinition(string* result, const Array_Ark_SafeAreaType* value) {
  int32_t count = value->length;
  result->append("std::array<Ark_Int32, " + std::to_string(count) + ">{{");
  for (int i = 0; i < count; i++) {
    std::string tmp;
    WriteToString(result, value->array[i]);
    result->append(tmp);
    result->append(", ");
  }
  result->append("}}");
}
inline void WriteToString(string* result, const Array_Ark_SafeAreaType* value, const std::string& ptrName = std::string()) {
  result->append("{");
  if (ptrName.empty()) {
    int32_t count = value->length;
    if (count > 0) result->append("{");
    for (int i = 0; i < count; i++) {
      if (i > 0) result->append(", ");
      WriteToString(result, value->array[i]);
    }
    if (count == 0) result->append("{}");
    if (count > 0) result->append("}");
  } else {
    result->append(ptrName + ".data()");
  }
  result->append(", ");
  result->append(std::to_string(value->length));
  result->append("}");
}
template <>
inline void convertor(const Opt_Array_Ark_SafeAreaType* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}
template <>
inline void convertor(const Union_DrawModifier_Ark_Undefined* value) {
  // DrawModifier
  if (value->selector == 0) {
    convertor(&value->value0);
  }
  // Ark_Undefined
  if (value->selector == 1) {
    convertor(value->value1);
  }
}
template <>
inline void convertor(const Opt_Union_DrawModifier_Ark_Undefined* value) {
  if (value->tag != ARK_TAG_UNDEFINED) {
    convertor(&value->value);
  } else {
    Ark_Undefined undefined = { 0 };
    convertor(undefined);
  }
}