#include "SkoalaDeserializerBase.h"

class Deserializer : public SkoalaDeserializerBase {
public:
    Deserializer(uint8_t* data, int32_t length) : SkoalaDeserializerBase(data, length) {}

    Skoala_Paint readPaint() {
        Skoala_Paint value = {};
        return value;
    }

    Skoala_Rect readRect() {
        Skoala_Rect value = {};
        value.coordinates = this->readFloat32Array();
        value.left = this->readSkoala_Float32();
        value.top = this->readSkoala_Float32();
        value.right = this->readSkoala_Float32();
        value.bottom = this->readSkoala_Float32();
        value.width = this->readSkoala_Float32();
        value.height = this->readSkoala_Float32();
        value.isEmpty = this->readSkoala_Boolean();
        return value;
    }

    Skoala_RRect readRRect() {
        Skoala_RRect value = {};
        value.radii = this->readFloat32Array();
        return value;
    }

    Skoala_Canvas readCanvas() {
        Skoala_Canvas value = {};
        value.xscale = this->readSkoala_Float32();
        value.yscale = this->readSkoala_Float32();
        value.saveCount = this->readSkoala_Int32();
        return value;
    }

};
