/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @file
 * @kit ImageKit
 */
import { AsyncCallback } from './@ohos.base';
import type colorSpaceManager from './@ohos.graphics.colorSpaceManager';
import type resourceManager from './@ohos.resourceManager';
import type rpc from './@ohos.rpc';


/**
 * This module provides the capability of image codec and access
 * @namespace image
 * @syscap SystemCapability.Multimedia.Image.Core
 * @since 20
 */
declare namespace image {
    
    
    
    /**
     * Enumerates pixel map formats.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum PixelMapFormat {
        
        
        
        /**
         * Indicates an unknown format.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        UNKNOWN = 0,
        /**
         * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：R(8bits), G(8bits), B(8bits), A(8bits)
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ARGB_8888 = 1,
        
        
        
        /**
         * Indicates that each pixel is stored on 16 bits. Only the R, G, and B components are encoded
         * from the higher-order to the lower-order bits: red is stored with 5 bits of precision,
         * green is stored with 6 bits of precision, and blue is stored with 5 bits of precision.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RGB_565 = 2,
        
        
        
        /**
         * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits), A(8bits)
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RGBA_8888 = 3,
        
        
        
        /**
         * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits), A(8bits)
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        BGRA_8888 = 4,
        
        
        
        /**
         * Indicates that each pixel is stored on 24 bits. Each pixel contains 3 components：R(8bits), G(8bits), B(8bits)
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RGB_888 = 5,
        
        
        
        /**
         * Indicates that each pixel is stored on 8 bits. Each pixel contains 1 component：ALPHA(8bits)
         * and is stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ALPHA_8 = 6,
        
        
        
        /**
         * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：B(8bits), G(8bits), R(8bits), A(8bits)
         * and are stored from the higher-order to the lower-order bits in F16.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RGBA_F16 = 7,
        
        
        
        /**
         * Indicates that the storage order is to store Y first and then V U alternately each occupies 8 bits
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        NV21 = 8,
        
        
        
        /**
         * Indicates that the storage order is to store Y first and then U V alternately each occupies 8 bits
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        NV12 = 9,
        /**
         * Indicates that each pixel is stored on 32 bits. Each pixel contains 4 components：
         * R(10bits), G(10bits), B(10bits), A(2bits) and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RGBA_1010102 = 10,
        /**
         * Indicates that the storage order is to store Y first and then U V alternately each occupies 10 bits
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        YCBCR_P010 = 11,
        /**
         * Indicates that the storage order is to store Y first and then V U alternately each occupies 10 bits
         * and are stored from the higher-order to the lower-order bits.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        YCRCB_P010 = 12,
        /**
         * The storage format is ASTC 4x4 format, and the memory usage is only 1/4 of RGBA_8888.
         * This format is only used for direct display scenes and does not support pixel access or post-
         * processing editing.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ASTC_4x4 = 102
    }
    /**
     * Enumerates image resolution quality.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @systemapi
     * @since 20
     */
    enum ResolutionQuality {
        /**
         * Low quality images, short decoding time.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @systemapi
         * @since 20
         */
        LOW = 1,
        /**
         * Medium quality images, moderate decoding time.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @systemapi
         * @since 20
         */
        MEDIUM = 2,
        /**
         * High quality images, longer decoding time.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @systemapi
         * @since 20
         */
        HIGH = 3
    }
    
    
    
    /**
     * Describes the size of an image.
     *
     * @typedef Size
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface Size {
        
        
        
        /**
         * Height
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        height: int;
        
        
        
        /**
         * Width
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        width: int;
    }
    
    /**
     * Enumerates exchangeable image file format (Exif) information types of an image. This enumeration follows the EXIF
     * standard. Please refer to the EXIF specification for more details.
     *
     * @enum { string }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum PropertyKey {
        
        /**
         * The number of bits per image component. In this standard each component of the image is 8 bits, so the value for
         * this tag is 8. In JPEG compressed data a JPEG marker is used instead of this tag.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        BITS_PER_SAMPLE = 'BitsPerSample',
        
        /**
         * Image orientation.
         * 1. "Top-left"       - The image is not rotated.
         * 2. "Top-right"      - The image is mirrored horizontally.
         * 3. "Bottom-right"   - The image is rotated 180 degrees.
         * 4. "Bottom-left"    - The image is mirrored vertically.
         * 5. "Left-top"       - The image is mirrored horizontally, then rotated 270 degrees clockwise.
         * 6. "Right-top"      - The image is rotated 90 degrees clockwise.
         * 7. "Right-bottom"   - The image is mirrored horizontally, then rotated 90 degrees clockwise.
         * 8. "Left-bottom"    - The image is rotated 270 degrees clockwise.
         * If an undefined value is read, the result will be "Unknown Value <number>".
         * When retrieving the Orientation property, the value is returned as a string.
         * When setting the Orientation property, both numeric values (1–8) and string labels are supported.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ORIENTATION = 'Orientation',
        
        /**
         * Image length.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        IMAGE_LENGTH = 'ImageLength',
        
        /**
         * Image width.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        IMAGE_WIDTH = 'ImageWidth',
        
        /**
         * GPS latitude. The latitude is expressed as three RATIONAL values giving the degrees, minutes, and
         * seconds, respectively. If latitude is expressed as degrees, minutes and seconds, a typical format
         * would be dd/1,mm/1,ss/1. When degrees and minutes are used and, for example, fractions of minutes
         * are given up to two decimal places, the format would be dd/1,mmmm/100,0/1.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_LATITUDE = 'GPSLatitude',
        
        /**
         * GPS longitude. The longitude is expressed as three RATIONAL values giving the degrees, minutes, and
         * seconds, respectively. If longitude is expressed as degrees, minutes and seconds, a typical format
         * would be dd/1,mm/1,ss/1. When degrees and minutes are used and, for example, fractions of minutes
         * are given up to two decimal places, the format would be dd/1,mmmm/100,0/1.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_LONGITUDE = 'GPSLongitude',
        
        /**
         * GPS latitude reference. For example, N indicates north latitude and S indicates south latitude.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_LATITUDE_REF = 'GPSLatitudeRef',
        
        /**
         * GPS longitude reference. For example, E indicates east longitude and W indicates west longitude.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_LONGITUDE_REF = 'GPSLongitudeRef',
        
        /**
         * The date and time when the original image data was generated. For a DSC the date and time the picture was taken
         * are recorded. The format is "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DATE_TIME_ORIGINAL = 'DateTimeOriginal',
        
        /**
         * Exposure time
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        EXPOSURE_TIME = 'ExposureTime',
        
        /**
         * Scene type
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_TYPE = 'SceneType',
        
        /**
         * Indicates the ISO Speed and ISO Latitude of the camera or input device as specified in ISO 12232.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ISO_SPEED_RATINGS = 'ISOSpeedRatings',
        
        /**
         * Aperture value, such as f/1.8.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        F_NUMBER = 'FNumber',
        /**
         * The date and time of image creation. In this standard it is the date and time the file was changed. The format
         * is "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DATE_TIME = 'DateTime',
        /**
         * GPS time stamp
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_TIME_STAMP = 'GPSTimeStamp',
        /**
         * GPS date stamp
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DATE_STAMP = 'GPSDateStamp',
        /**
         * Image description
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        IMAGE_DESCRIPTION = 'ImageDescription',
        /**
         * Make
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        MAKE = 'Make',
        /**
         * Model
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        MODEL = 'Model',
        /**
         * Photo mode
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PHOTO_MODE = 'PhotoMode',
        /**
         * Sensitivity type
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SENSITIVITY_TYPE = 'SensitivityType',
        /**
         * Standard output sensitivity
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        STANDARD_OUTPUT_SENSITIVITY = 'StandardOutputSensitivity',
        /**
         * Recommended exposure index
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RECOMMENDED_EXPOSURE_INDEX = 'RecommendedExposureIndex',
        /**
         * Indicates the ISO Speed and ISO Latitude of the camera or input device as specified in ISO 12232.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ISO_SPEED = 'ISOSpeedRatings',
        /**
         * The lens aperture. The unit is the APEX((Additive System of Photographic Exposure) value.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        APERTURE_VALUE = 'ApertureValue',
        /**
         * Exposure bias value
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        EXPOSURE_BIAS_VALUE = 'ExposureBiasValue',
        /**
         * Metering mode
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        METERING_MODE = 'MeteringMode',
        /**
         * Light source
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        LIGHT_SOURCE = 'LightSource',
        /**
         * Flash
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FLASH = 'Flash',
        /**
         * Focal length
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FOCAL_LENGTH = 'FocalLength',
        /**
         * User comment
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        USER_COMMENT = 'UserComment',
        /**
         * Pixel x dimension
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PIXEL_X_DIMENSION = 'PixelXDimension',
        /**
         * Pixel y dimension
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PIXEL_Y_DIMENSION = 'PixelYDimension',
        /**
         * White balance
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        WHITE_BALANCE = 'WhiteBalance',
        /**
         * Focal length in 35mm film
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FOCAL_LENGTH_IN_35_MM_FILM = 'FocalLengthIn35mmFilm',
        /**
         * Capture mode
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CAPTURE_MODE = 'HwMnoteCaptureMode',
        /**
         * Physical aperture
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PHYSICAL_APERTURE = 'HwMnotePhysicalAperture',
        /**
         * Roll Angle
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ROLL_ANGLE = 'HwMnoteRollAngle',
        /**
         * Pitch Angle
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PITCH_ANGLE = 'HwMnotePitchAngle',
        /**
         * Capture Scene: Food
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_FOOD_CONF = 'HwMnoteSceneFoodConf',
        /**
         * Capture Scene: Stage
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_STAGE_CONF = 'HwMnoteSceneStageConf',
        /**
         * Capture Scene: Blue Sky
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_BLUE_SKY_CONF = 'HwMnoteSceneBlueSkyConf',
        /**
         * Capture Scene: Green Plant
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_GREEN_PLANT_CONF = 'HwMnoteSceneGreenPlantConf',
        /**
         * Capture Scene: Beach
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_BEACH_CONF = 'HwMnoteSceneBeachConf',
        /**
         * Capture Scene: Snow
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_SNOW_CONF = 'HwMnoteSceneSnowConf',
        /**
         * Capture Scene: Sunset
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_SUNSET_CONF = 'HwMnoteSceneSunsetConf',
        /**
         * Capture Scene: Flowers
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_FLOWERS_CONF = 'HwMnoteSceneFlowersConf',
        /**
         * Capture Scene: Night
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_NIGHT_CONF = 'HwMnoteSceneNightConf',
        /**
         * Capture Scene: Text
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_TEXT_CONF = 'HwMnoteSceneTextConf',
        /**
         * Face Count
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_COUNT = 'HwMnoteFaceCount',
        /**
         * Focus Mode
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FOCUS_MODE = 'HwMnoteFocusMode',
        /**
         * The scheme used for image compression.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        COMPRESSION = 'Compression',
        /**
         * Pixel composition, such as RGB or YCbCr.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PHOTOMETRIC_INTERPRETATION = 'PhotometricInterpretation',
        /**
         * For each strip, the byte offset of that strip.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        STRIP_OFFSETS = 'StripOffsets',
        /**
         * The number of components per pixel. As the standard applies to both RGB and YCbCr images, the tag value is set
         * to 3. For JPEG-compressed images, this tag is replaced by corresponding JPEG markers.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SAMPLES_PER_PIXEL = 'SamplesPerPixel',
        /**
         * The number of rows per strip of image data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ROWS_PER_STRIP = 'RowsPerStrip',
        /**
         * The total number of bytes in each strip of image data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        STRIP_BYTE_COUNTS = 'StripByteCounts',
        /**
         * The image resolution in the width direction.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        X_RESOLUTION = 'XResolution',
        /**
         * The image resolution in the height direction.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        Y_RESOLUTION = 'YResolution',
        /**
         * Indicates whether pixel components are recorded in a chunky or planar format.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PLANAR_CONFIGURATION = 'PlanarConfiguration',
        /**
         * The unit used to measure XResolution and YResolution.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RESOLUTION_UNIT = 'ResolutionUnit',
        /**
         * The transfer function for the image, typically used for color correction.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        TRANSFER_FUNCTION = 'TransferFunction',
        /**
         * The name and version of the software used to generate the image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SOFTWARE = 'Software',
        /**
         * The name of the person who created the image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ARTIST = 'Artist',
        /**
         * The chromaticity of the white point of the image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        WHITE_POINT = 'WhitePoint',
        /**
         * The chromaticity of the primary colors of the image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PRIMARY_CHROMATICITIES = 'PrimaryChromaticities',
        /**
         * The matrix coefficients for transformation from RGB to YCbCr image data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        YCBCR_COEFFICIENTS = 'YCbCrCoefficients',
        /**
         * The sampling ratio of chrominance components to the luminance component.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        YCBCR_SUB_SAMPLING = 'YCbCrSubSampling',
        /**
         * The position of chrominance components in relation to the luminance component.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        YCBCR_POSITIONING = 'YCbCrPositioning',
        /**
         * The reference black point value and reference white point value.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        REFERENCE_BLACK_WHITE = 'ReferenceBlackWhite',
        /**
         * Copyright information for the image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        COPYRIGHT = 'Copyright',
        /**
         * The offset to the start byte (SOI) of JPEG compressed thumbnail data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        JPEG_INTERCHANGE_FORMAT = 'JPEGInterchangeFormat',
        /**
         * The number of bytes of JPEG compressed thumbnail data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        JPEG_INTERCHANGE_FORMAT_LENGTH = 'JPEGInterchangeFormatLength',
        /**
         * The class of the program used by the camera to set exposure when the picture is taken.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        EXPOSURE_PROGRAM = 'ExposureProgram',
        /**
         * Indicates the spectral sensitivity of each channel of the camera used.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SPECTRAL_SENSITIVITY = 'SpectralSensitivity',
        /**
         * Indicates the Opto-Electric Conversion Function (OECF) specified in ISO 14524.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        OECF = 'OECF',
        /**
         * The version of the Exif standard supported.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        EXIF_VERSION = 'ExifVersion',
        /**
         * The date and time when the image was stored as digital data. If, for example, an image was captured by DSC and
         * at the same time the file was recorded, then the DateTimeOriginal and DateTimeDigitized will have the same
         * contents. The format is "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DATE_TIME_DIGITIZED = 'DateTimeDigitized',
        /**
         * Information specific to compressed data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        COMPONENTS_CONFIGURATION = 'ComponentsConfiguration',
        /**
         * The shutter speed, expressed as an APEX (Additive System of Photographic Exposure) value.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SHUTTER_SPEED = 'ShutterSpeedValue',
        /**
         * The brightness value of the image, in APEX units.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        BRIGHTNESS_VALUE = 'BrightnessValue',
        /**
         * The smallest F number of lens.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        MAX_APERTURE_VALUE = 'MaxApertureValue',
        /**
         * The distance to the subject, measured in meters.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBJECT_DISTANCE = 'SubjectDistance',
        /**
         * This tag indicate the location and area of the main subject in the overall scene.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBJECT_AREA = 'SubjectArea',
        /**
         * A tag for manufacturers of Exif/DCF writers to record any desired information.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        MAKER_NOTE = 'MakerNote',
        /**
         * A tag for record fractions of seconds for the DateTime tag.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBSEC_TIME = 'SubsecTime',
        /**
         * A tag used to record fractions of seconds for the DateTimeOriginal tag.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBSEC_TIME_ORIGINAL = 'SubsecTimeOriginal',
        /**
         * A tag used to record fractions of seconds for the DateTimeDigitized tag.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBSEC_TIME_DIGITIZED = 'SubsecTimeDigitized',
        /**
         * This tag denotes the Flashpix format version supported by an FPXR file, enhancing device compatibility.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FLASHPIX_VERSION = 'FlashpixVersion',
        /**
         * The color space information tag, often recorded as the color space specifier.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        COLOR_SPACE = 'ColorSpace',
        /**
         * The name of an audio file related to the image data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        RELATED_SOUND_FILE = 'RelatedSoundFile',
        /**
         * Strobe energy at image capture, in BCPS.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FLASH_ENERGY = 'FlashEnergy',
        /**
         * Camera or input device spatial frequency table.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SPATIAL_FREQUENCY_RESPONSE = 'SpatialFrequencyResponse',
        /**
         * Pixels per FocalPlaneResolutionUnit in the image width.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FOCAL_PLANE_X_RESOLUTION = 'FocalPlaneXResolution',
        /**
         * Pixels per FocalPlaneResolutionUnit in the image height.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FOCAL_PLANE_Y_RESOLUTION = 'FocalPlaneYResolution',
        /**
         * Unit for measuring FocalPlaneXResolution and FocalPlaneYResolution.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FOCAL_PLANE_RESOLUTION_UNIT = 'FocalPlaneResolutionUnit',
        /**
         * Location of the main subject, relative to the left edge.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBJECT_LOCATION = 'SubjectLocation',
        /**
         * Selected exposure index at capture.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        EXPOSURE_INDEX = 'ExposureIndex',
        /**
         * Image sensor type on the camera.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SENSING_METHOD = 'SensingMethod',
        /**
         * Indicates the image source.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FILE_SOURCE = 'FileSource',
        /**
         * Color filter array (CFA) geometric pattern of the image sensor.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CFA_PATTERN = 'CFAPattern',
        /**
         * Indicates special processing on image data.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CUSTOM_RENDERED = 'CustomRendered',
        /**
         * Exposure mode set when the image was shot.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        EXPOSURE_MODE = 'ExposureMode',
        /**
         * Digital zoom ratio at the time of capture.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DIGITAL_ZOOM_RATIO = 'DigitalZoomRatio',
        /**
         * Type of scene captured.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_CAPTURE_TYPE = 'SceneCaptureType',
        /**
         * Degree of overall image gain adjustment.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GAIN_CONTROL = 'GainControl',
        /**
         * Direction of contrast processing applied by the camera.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CONTRAST = 'Contrast',
        /**
         * Direction of saturation processing applied by the camera.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SATURATION = 'Saturation',
        /**
         * The direction of sharpness processing applied by the camera.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SHARPNESS = 'Sharpness',
        /**
         * Information on picture-taking conditions for a specific camera model.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DEVICE_SETTING_DESCRIPTION = 'DeviceSettingDescription',
        /**
         * Indicates the distance range to the subject.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBJECT_DISTANCE_RANGE = 'SubjectDistanceRange',
        /**
         * An identifier uniquely assigned to each image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        IMAGE_UNIQUE_ID = 'ImageUniqueID',
        /**
         * The version of the GPSInfoIFD.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_VERSION_ID = 'GPSVersionID',
        /**
         * Reference altitude used for GPS altitude.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_ALTITUDE_REF = 'GPSAltitudeRef',
        /**
         * The altitude based on the reference in GPSAltitudeRef.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_ALTITUDE = 'GPSAltitude',
        /**
         * The GPS satellites used for measurements.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_SATELLITES = 'GPSSatellites',
        /**
         * The status of the GPS receiver when the image is recorded.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_STATUS = 'GPSStatus',
        /**
         * The GPS measurement mode.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_MEASURE_MODE = 'GPSMeasureMode',
        /**
         * The GPS DOP (data degree of precision).
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DOP = 'GPSDOP',
        /**
         * The unit used to express the GPS receiver speed of movement.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_SPEED_REF = 'GPSSpeedRef',
        /**
         * The speed of GPS receiver movement.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_SPEED = 'GPSSpeed',
        /**
         * The reference for giving the direction of GPS receiver movement.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_TRACK_REF = 'GPSTrackRef',
        /**
         * The direction of GPS receiver movement.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_TRACK = 'GPSTrack',
        /**
         * The reference for the image's direction.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_IMG_DIRECTION_REF = 'GPSImgDirectionRef',
        /**
         * The direction of the image when captured.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_IMG_DIRECTION = 'GPSImgDirection',
        /**
         * Geodetic survey data used by the GPS receiver.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_MAP_DATUM = 'GPSMapDatum',
        /**
         * Indicates the latitude reference of the destination point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_LATITUDE_REF = 'GPSDestLatitudeRef',
        /**
         * The latitude of the destination point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_LATITUDE = 'GPSDestLatitude',
        /**
         * Indicates the longitude reference of the destination point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_LONGITUDE_REF = 'GPSDestLongitudeRef',
        /**
         * The longitude of the destination point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_LONGITUDE = 'GPSDestLongitude',
        /**
         * The reference for the bearing to the destination point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_BEARING_REF = 'GPSDestBearingRef',
        /**
         * The bearing to the destination point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_BEARING = 'GPSDestBearing',
        /**
         * The measurement unit for the distance to the target point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_DISTANCE_REF = 'GPSDestDistanceRef',
        /**
         * The distance to the destination point.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DEST_DISTANCE = 'GPSDestDistance',
        /**
         * A character string recording the name of the method used for location finding.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_PROCESSING_METHOD = 'GPSProcessingMethod',
        /**
         * A character string recording the name of the GPS area.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_AREA_INFORMATION = 'GPSAreaInformation',
        /**
         * This field denotes if differential correction was applied to GPS data, crucial for precise location accuracy.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_DIFFERENTIAL = 'GPSDifferential',
        /**
         * The serial number of the camera body.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        BODY_SERIAL_NUMBER = 'BodySerialNumber',
        /**
         * The name of the camera owner.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CAMERA_OWNER_NAME = 'CameraOwnerName',
        /**
         * Indicates whether the image is a composite image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        COMPOSITE_IMAGE = 'CompositeImage',
        /**
         * The compression mode used for a compressed image, in unit bits per pixel.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        COMPRESSED_BITS_PER_PIXEL = 'CompressedBitsPerPixel',
        /**
         * The DNGVersion tag encodes the four-tier version number for DNG specification compliance.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DNG_VERSION = 'DNGVersion',
        /**
         * DefaultCropSize specifies the final image size in raw coordinates, accounting for extra edge pixels.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DEFAULT_CROP_SIZE = 'DefaultCropSize',
        /**
         * Indicates the value of coefficient gamma.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GAMMA = 'Gamma',
        /**
         * The tag indicate the ISO speed latitude yyy value of the camera or input device that is defined in ISO 12232.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ISO_SPEED_LATITUDE_YYY = 'ISOSpeedLatitudeyyy',
        /**
         * The tag indicate the ISO speed latitude zzz value of the camera or input device that is defined in ISO 12232.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ISO_SPEED_LATITUDE_ZZZ = 'ISOSpeedLatitudezzz',
        /**
         * The manufacturer of the lens.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        LENS_MAKE = 'LensMake',
        /**
         * The model name of the lens.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        LENS_MODEL = 'LensModel',
        /**
         * The serial number of the lens.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        LENS_SERIAL_NUMBER = 'LensSerialNumber',
        /**
         * Specifications of the lens used.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        LENS_SPECIFICATION = 'LensSpecification',
        /**
         * This tag provides a broad description of the data type in this subfile.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        NEW_SUBFILE_TYPE = 'NewSubfileType',
        /**
         * This tag records the UTC offset for the DateTime tag, ensuring accurate timestamps regardless of location.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        OFFSET_TIME = 'OffsetTime',
        /**
         * This tag records the UTC offset when the image was digitized, aiding in accurate timestamp adjustment.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        OFFSET_TIME_DIGITIZED = 'OffsetTimeDigitized',
        /**
         * This tag records the UTC offset when the original image was created, crucial for time-sensitive applications.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        OFFSET_TIME_ORIGINAL = 'OffsetTimeOriginal',
        /**
         * Exposure times of source images for a composite image, such as 1/33 sec.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SOURCE_EXPOSURE_TIMES_OF_COMPOSITE_IMAGE = 'SourceExposureTimesOfCompositeImage',
        /**
         * The number of source images used for a composite image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SOURCE_IMAGE_NUMBER_OF_COMPOSITE_IMAGE = 'SourceImageNumberOfCompositeImage',
        /**
         * This deprecated tag indicates the data type in this subfile. Use NewSubfileType instead.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SUBFILE_TYPE = 'SubfileType',
        /**
         * This tag indicates horizontal positioning errors in meters.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GPS_H_POSITIONING_ERROR = 'GPSHPositioningError',
        /**
         * This tag indicates the sensitivity of the camera or input device when the image was shot.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PHOTOGRAPHIC_SENSITIVITY = 'PhotographicSensitivity',
        /**
         * Burst Number
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        BURST_NUMBER = 'HwMnoteBurstNumber',
        /**
         * Face Conf
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_CONF = 'HwMnoteFaceConf',
        /**
         * Face Leye Center
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_LEYE_CENTER = 'HwMnoteFaceLeyeCenter',
        /**
         * Face Mouth Center
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_MOUTH_CENTER = 'HwMnoteFaceMouthCenter',
        /**
         * Face Pointer
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_POINTER = 'HwMnoteFacePointer',
        /**
         * Face Rect
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_RECT = 'HwMnoteFaceRect',
        /**
         * Face Reye Center
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_REYE_CENTER = 'HwMnoteFaceReyeCenter',
        /**
         * Face Smile Score
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_SMILE_SCORE = 'HwMnoteFaceSmileScore',
        /**
         * Face Version
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FACE_VERSION = 'HwMnoteFaceVersion',
        /**
         * Front Camera
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FRONT_CAMERA = 'HwMnoteFrontCamera',
        /**
         * Scene Pointer
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_POINTER = 'HwMnoteScenePointer',
        /**
         * Scene Version
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCENE_VERSION = 'HwMnoteSceneVersion',
        /**
         * Is Xmage Supported
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        IS_XMAGE_SUPPORTED = 'HwMnoteIsXmageSupported',
        /**
         * Xmage Mode
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        XMAGE_MODE = 'HwMnoteXmageMode',
        /**
         * Xmage X1 Coordinate
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        XMAGE_LEFT = 'HwMnoteXmageLeft',
        /**
         * Xmage Y1 Coordinate
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        XMAGE_TOP = 'HwMnoteXmageTop',
        /**
         * Xmage X2 Coordinate
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        XMAGE_RIGHT = 'HwMnoteXmageRight',
        /**
         * Xmage Y2 Coordinate
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        XMAGE_BOTTOM = 'HwMnoteXmageBottom',
        /**
         * Cloud Enhancement Mode
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CLOUD_ENHANCEMENT_MODE = 'HwMnoteCloudEnhancementMode',
        /**
         * Wind Snapshot Mode
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        WIND_SNAPSHOT_MODE = 'HwMnoteWindSnapshotMode',
        /**
         * GIF LOOP COUNT
         * If infinite loop returns 0, other values represent the number of loops
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GIF_LOOP_COUNT = 'GIFLoopCount'
    }
    /**
     * Enum for image formats.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum ImageFormat {
        /**
         * YCBCR422 semi-planar format.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        YCBCR_422_SP = 1000,
        /**
         * JPEG encoding format.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        JPEG = 2000
    }
    
    
    
    /**
     * Enumerates alpha types.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum AlphaType {
        
        
        
        /**
         * Indicates an unknown alpha type.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        UNKNOWN = 0,
        
        
        
        /**
         * Indicates that the image has no alpha channel, or all pixels in the image are fully opaque.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        OPAQUE = 1,
        
        
        
        /**
         * Indicates that RGB components of each pixel in the image are premultiplied by alpha.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        PREMUL = 2,
        
        
        
        /**
         * Indicates that RGB components of each pixel in the image are independent of alpha and are not premultiplied by alpha.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        UNPREMUL = 3
    }
    /**
     * Enumerates decoding dynamic range.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum DecodingDynamicRange {
        /**
         * Decoding according to the content of the image. If the image is an HDR image, it will be decoded as HDR content;
         * otherwise, it will be decoded as SDR content.
         * Imagesources created via {@link CreateIncrementalSource} will be decoded as SDR content.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        AUTO = 0,
        /**
         * Decoding to standard dynamic range.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SDR = 1,
        /**
         * Decoding to high dynamic range. Imagesources created via {@link CreateIncrementalSource} will be decoded as SDR content.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        HDR = 2
    }
    /**
     * Enumerates packing dynamic range.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum PackingDynamicRange {
        /**
         * Packing according to the content of the image. If the image is an HDR image, it will be encoded as HDR content;
         * otherwise, it will be encoded as SDR content.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        AUTO = 0,
        /**
         * Packing to standard dynamic range.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SDR = 1
    }
    
    /**
     * Enumerates the anti-aliasing level.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum AntiAliasingLevel {
        
        /**
         * Nearest-neighbor interpolation algorithm.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        NONE = 0,
        
        /**
         * Bilinear interpolation algorithm.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        LOW = 1,
        
        /**
         * Bilinear interpolation algorithm with mipmap linear filtering.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        MEDIUM = 2,
        
        /**
         * Cubic interpolation algorithm.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        HIGH = 3
    }
    
    
    
    /**
     * Enum for image scale mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum ScaleMode {
        
        
        
        /**
         * Indicates the effect that fits the image into the target size.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FIT_TARGET_SIZE = 0,
        
        
        
        /**
         * Indicates the effect that scales an image to fill the target image area and center-crops the part outside the area.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CENTER_CROP = 1
    }
    /**
     * The component type of image.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.ImageReceiver
     * @since 20
     */
    enum ComponentType {
        /**
         * Luma info.
         *
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        YUV_Y = 1,
        /**
         * Chrominance info.
         *
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        YUV_U = 2,
        /**
         * Chroma info.
         *
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        YUV_V = 3,
        /**
         * Jpeg type.
         *
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        JPEG = 4
    }
    /**
     * Enumerates the HDR metadata types that need to be stored in Pixelmap.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum HdrMetadataKey {
        /**
         * Indicate the types of metadata that image needs to use.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        HDR_METADATA_TYPE = 0,
        /**
         * Static metadata key.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        HDR_STATIC_METADATA = 1,
        /**
         * Dynamic metadata key.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        HDR_DYNAMIC_METADATA = 2,
        /**
         * Gainmap metadata key.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        HDR_GAINMAP_METADATA = 3
    }
    /**
     * Value for HDR_METADATA_TYPE.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum HdrMetadataType {
        /**
         * No metadata.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        NONE = 0,
        /**
         * Indicates that metadata will be used for the base image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        BASE = 1,
        /**
         * Indicates that metadata will be used for the gainmap image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GAINMAP = 2,
        /**
         * Indicates that metadata will be used for the alternate image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        ALTERNATE = 3
    }
    /**
     * Type of allocator used to allocate memory of a PixelMap.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum AllocatorType {
        /**
         * The system determines which memory to use to create the PixelMap.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        AUTO = 0,
        /**
         * Use DMA buffer to create the PixelMap.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DMA = 1,
        /**
         * Use share memory to create the PixelMap.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SHARE_MEMORY = 2
    }
    
    
    
    /**
     * Describes region information.
     *
     * @typedef Region
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface Region {
        
        
        
        /**
         * Image size.
         *
         * @type { Size }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        size: Size;
        
        
        
        /**
         * x-coordinate at the upper left corner of the image.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        x: int;
        
        
        
        /**
         * y-coordinate at the upper left corner of the image.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        y: int;
    }
    
    
    
    /**
     * Describes area information in an image.
     *
     * @typedef PositionArea
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface PositionArea {
        
        
        
        /**
         * Image data that will be read or written.
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        pixels: ArrayBuffer;
        
        
        
        /**
         * Offset for data reading.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        offset: int;
        
        
        
        /**
         * Number of bytes to read.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        stride: int;
        
        
        
        /**
         * Region to read.
         *
         * @type { Region }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        region: Region;
    }
    
    
    
    /**
     * Describes image information.
     *
     * @typedef ImageInfo
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface ImageInfo {
        
        
        
        /**
         * Indicates image dimensions specified by a {@link Size} interface.
         *
         * @type { Size }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        size: Size;
        
        
        
        /**
         * Indicates image default density.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        density: int;
        
        /**
         * The number of byte per row.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        stride: int;
        /**
         * Indicates image format.
         *
         * @type { PixelMapFormat }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        pixelFormat: PixelMapFormat;
        /**
         * Indicates image alpha type.
         *
         * @type { AlphaType }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        alphaType: AlphaType;
        /**
         * Indicates image mime type.
         *
         * @type { string }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        mimeType: string;
        /**
         * Indicates whether the image high dynamic range
         *
         * @type { boolean }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        isHdr: boolean;
    }
    /**
     * Enumerates the strategies for executing the cropping and scaling operations when both desiredSize and desiredRegion are specified.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum CropAndScaleStrategy {
        /**
         * Scales and then crops the image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        SCALE_FIRST = 1,
        /**
         * Crops and then scales the image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        CROP_FIRST = 2
    }
    
    
    /**
     * Describes the option for image packing.
     *
     * @typedef PackingOption
     * @syscap SystemCapability.Multimedia.Image.ImagePacker
     * @since 20
     */
    interface PackingOption {
        
        
        /**
         * Multipurpose Internet Mail Extensions (MIME) format of the target image, for example, image/jpeg.
         *
         * @type { string }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        format: string;
        
        
        /**
         * Quality of the target image. The value is an integer ranging from 0 to 100. A larger value indicates better.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        quality: int;
        
        
        /**
         * BufferSize of the target image.
         * If this bufferSize is less than or equal to 0, it will be converted to 10MB.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        bufferSize?: int;
        /**
         * The desired dynamic range of the target image.
         *
         * @type { ?PackingDynamicRange }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        desiredDynamicRange?: PackingDynamicRange;
        /**
         * Whether the image properties can be saved, like Exif.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        needsPackProperties?: boolean;
    }
    /**
     * Describes the options for image sequence packing.
     *
     * @typedef PackingOptionsForSequence
     * @syscap SystemCapability.Multimedia.Image.ImagePacker
     * @since 20
     */
    interface PackingOptionsForSequence {
        /**
         * Specify the number of frames.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        frameCount: int;
        /**
         * Specify the delay time for each frame of the dynamic image.
         * If the length is less than frameCount, the missing parts will be filling with the last value
         *
         * @type { Array<int> }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        delayTimeList: Array<int>;
        /**
         * Specify the disposal types of each frame in the image sequence packing.
         *
         * @type { ?Array<int> }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        disposalTypes?: Array<int>;
        /**
         * Specify the number of times the loop should, the range is [0, 65535]
         * If this loop is equal to 0, it will be infinite loop.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        loopCount?: int;
    }
    /**
     * Describes image properties.
     *
     * @typedef ImagePropertyOptions
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    interface ImagePropertyOptions {
        /**
         * Index of an image.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        index?: int;
        /**
         * Default property value.
         *
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        defaultValue?: string;
    }
    
    
    
    /**
     * Describes image decoding parameters.
     *
     * @typedef DecodingOptions
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    interface DecodingOptions {
        
        
        
        /**
         * Number of image frames.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        index?: int;
        
        
        
        /**
         * Sampling ratio of the image pixel map.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        sampleSize?: int;
        
        
        
        /**
         * Rotation angle of the image pixel map. The value ranges from 0 to 360.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        rotate?: int;
        
        
        
        /**
         * Whether the image pixel map is editable.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        editable?: boolean;
        
        
        
        /**
         * Width and height of the image pixel map. The value (0, 0) indicates that the pixels are decoded
         * based on the original image size.
         *
         * @type { ?Size }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        desiredSize?: Size;
        
        
        
        /**
         * Cropping region of the image pixel map.
         *
         * @type { ?Region }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        desiredRegion?: Region;
        
        
        
        /**
         * Data format of the image pixel map.
         *
         * @type { ?PixelMapFormat }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        desiredPixelFormat?: PixelMapFormat;
        
        
        
        /**
         * The density for image pixel map.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        fitDensity?: int;
        /**
         * Color space of the image pixel map.
         *
         * @type { ?colorSpaceManager.ColorSpaceManager }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        desiredColorSpace?: colorSpaceManager.ColorSpaceManager;
        /**
         * The desired dynamic range of the image pixelmap.
         *
         * @type { ?DecodingDynamicRange }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        desiredDynamicRange?: DecodingDynamicRange;
        /**
         * Resolution Quality of the image.
         *
         * @type { ?ResolutionQuality }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @systemapi
         * @since 20
         */
        resolutionQuality?: ResolutionQuality;
        /**
         * Describes the strategy for executing the cropping and scaling operations when both desiredSize and desiredRegion are specified.
         *
         * @type { ?CropAndScaleStrategy }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        cropAndScaleStrategy?: CropAndScaleStrategy;
    }
    /**
     * Describes image color components.
     *
     * @typedef Component
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface Component {
        /**
         * Component type.
         *
         * @type { ComponentType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly componentType: ComponentType;
        /**
         * Row stride.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly rowStride: int;
        /**
         * Pixel stride.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly pixelStride: int;
        /**
         * Component buffer.
         *
         * @type { ArrayBuffer }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly byteBuffer: ArrayBuffer;
    }
    
    
    
    /**
     * Initialization options for pixelmap.
     *
     * @typedef InitializationOptions
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface InitializationOptions {
        
        
        
        /**
         * PixelMap size.
         *
         * @type { Size }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        size: Size;
        /**
         * PixelMap source format.
         *
         * @type { ?PixelMapFormat }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        srcPixelFormat?: PixelMapFormat;
        
        
        
        /**
         * PixelMap expected format.
         *
         * @type { ?PixelMapFormat }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        pixelFormat?: PixelMapFormat;
        
        
        
        /**
         * Editable or not.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        editable?: boolean;
        
        
        
        /**
         * PixelMap expected alpha type.
         *
         * @type { ?AlphaType }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        alphaType?: AlphaType;
        
        
        
        /**
         * PixelMap expected scaling effect.
         *
         * @type { ?ScaleMode }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        scaleMode?: ScaleMode;
    }
    
    
    
    /**
     * Initialization options for ImageSource.
     *
     * @typedef SourceOptions
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface SourceOptions {
        
        
        
        /**
         * The density for ImageSource.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        sourceDensity: int;
        
        
        
        /**
         * PixelMap expected format.
         *
         * @type { ?PixelMapFormat }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        sourcePixelFormat?: PixelMapFormat;
        
        
        
        /**
         * PixelMap size.
         *
         * @type { ?Size }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        sourceSize?: Size;
    }
    /**
     * Value for HDR_STATIC_METADATA.
     *
     * @typedef HdrStaticMetadata
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface HdrStaticMetadata {
        /**
         * The X-coordinate of the primary colors. Specifies the normalized X-coordinates of the display device's three
         * primary colors. The values are stored in an array of length 3, in the order of red, green, and blue (r, g, b).
         * Each value is represented in units of 0.00002 and must fall within the range [0.0, 1.0].
         *
         * @type { Array<double> }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        displayPrimariesX: Array<double>;
        /**
         * The Y-coordinate of the primary colors. Specifies the normalized Y-coordinates of the display device's three
         * primary colors. The values are stored in an array of length 3, in the order of red, green, and blue (r, g, b).
         * Each value is represented in units of 0.00002 and must fall within the range [0.0, 1.0].
         *
         * @type { Array<double> }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        displayPrimariesY: Array<double>;
        /**
         * The X-coordinate of the white point value. Specifies the normalized X-coordinate of the white point.
         * The value is represented in units of 0.00002 and must fall within the range [0.0, 1.0].
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        whitePointX: double;
        /**
         * The Y-coordinate of the white point value. Specifies the normalized Y-coordinate of the white point.
         * The value is represented in units of 0.00002 and must fall within the range [0.0, 1.0].
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        whitePointY: double;
        /**
         * Maximum luminance of the image's primary display.
         * The value is measured in units of 1, with a maximum allowed value of 65,535.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        maxLuminance: double;
        /**
         * Minimum luminance of the image's primary display.
         * The value is measured in units of 0.0001, with a maximum allowed value of 6.55535.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        minLuminance: double;
        /**
         * Maximum brightness of displayed content.
         * The value is measured in units of 1, with a maximum allowed value of 65,535.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        maxContentLightLevel: double;
        /**
         * Maximum average brightness of displayed content.
         * The value is measured in units of 1, with a maximum allowed value of 65,535.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        maxFrameAverageLightLevel: double;
    }
    /**
     * The per-component metadata.
     *
     * @typedef GainmapChannel
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface GainmapChannel {
        /**
         * The per-component max gain map values.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        gainmapMax: double;
        /**
         * The per-component min gain map values.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        gainmapMin: double;
        /**
         * The per-component gamma values.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        gamma: double;
        /**
         * The per-component baseline offset.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        baseOffset: double;
        /**
         * The per-component alternate offset.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        alternateOffset: double;
    }
    /**
     * Values for HDR_GAINMAP_METADATA.
     *
     * @typedef HdrGainmapMetadata
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface HdrGainmapMetadata {
        /**
         * The version used by the writer.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writerVersion: int;
        /**
         * The minimum version a parser needs to understand.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        miniVersion: int;
        /**
         * The number of gain map channels, with a value of 1 or 3.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        gainmapChannelCount: int;
        /**
         * Indicate whether to use the color space of the base image.
         *
         * @type { boolean }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        useBaseColorFlag: boolean;
        /**
         * The baseline hdr headroom.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        baseHeadroom: double;
        /**
         * The alternate hdr headroom.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        alternateHeadroom: double;
        /**
         * The per-channel metadata.
         *
         * @type { Array<GainmapChannel> }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        channels: Array<GainmapChannel>;
    }
    /**
     * Defines the hdr metadata value.
     *
     * @typedef {HdrMetadataType | HdrStaticMetadata | ArrayBuffer | HdrGainmapMetadata} HdrMetadataValue
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    type HdrMetadataValue = HdrMetadataType | HdrStaticMetadata | ArrayBuffer | HdrGainmapMetadata;
    
    /**
     * Create pixelmap by data buffer.
     *
     * @param { ArrayBuffer } colors The image color buffer.
     * @param { InitializationOptions } options Initialization options for pixelmap.
     * @param { AsyncCallback<PixelMap> } callback Callback used to return the PixelMap object.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPixelMap(colors: ArrayBuffer, options: InitializationOptions, callback: AsyncCallback<PixelMap>): void;
    
    /**
     * Create pixelmap by data buffer.
     *
     * @param { ArrayBuffer } colors The image color buffer.
     * @param { InitializationOptions } options Initialization options for pixelmap.
     * @returns { Promise<PixelMap> } A Promise instance used to return the PixelMap object.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPixelMap(colors: ArrayBuffer, options: InitializationOptions): Promise<PixelMap>;
    /**
     * Create pixelmap by data buffer.
     *
     * @param { ArrayBuffer } colors The image color buffer.
     * @param { InitializationOptions } options Initialization options for pixelmap.
     * @returns { PixelMap } Returns the instance if the operation is successful;Otherwise, return undefined.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPixelMapSync(colors: ArrayBuffer, options: InitializationOptions): PixelMap;
    /**
     * Create an empty pixelmap.
     *
     * @param { InitializationOptions } options Initialization options for pixelmap.
     * @returns { PixelMap } Returns the instance if the operation is successful;Otherwise, return undefined.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPixelMapSync(options: InitializationOptions): PixelMap;
    /**
     * Creates a PixelMap object based on MessageSequence parameter.
     *
     * @param { rpc.MessageSequence } sequence - rpc.MessageSequence parameter.
     * @returns { PixelMap } Returns the instance if the operation is successful;Otherwise, an exception will be thrown.
     * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
     * 2. Decoding process exception. 3. Insufficient memory.
     * @throws { BusinessError } 62980097 - IPC error. Possible cause: 1.IPC communication failed. 2. Image upload exception.
     * 3. Decode process exception. 4. Insufficient memory.
     * @throws { BusinessError } 62980115 - Invalid input parameter.
     * @throws { BusinessError } 62980105 - Failed to get the data.
     * @throws { BusinessError } 62980177 - Abnormal API environment.
     * @throws { BusinessError } 62980178 - Failed to create the PixelMap.
     * @throws { BusinessError } 62980179 - Abnormal buffer size.
     * @throws { BusinessError } 62980180 - FD mapping failed.
     * Possible cause: 1. Size and address does not match. 2. Memory map in memalloc failed.
     * @throws { BusinessError } 62980246 - Failed to read the PixelMap.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPixelMapFromParcel(sequence: rpc.MessageSequence): PixelMap;
    /**
     * Creates a PixelMap object from surface id.
     *
     * @param { string } surfaceId - surface id.
     * @param { Region } region - The region to surface.
     * @returns { PixelMap } Returns the instance if the operation is successful;Otherwise, an exception will be thrown.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     *     2.Incorrect parameter types. 3.Parameter verification failed.
     * @throws { BusinessError } 62980105 - Failed to get the data.
     * @throws { BusinessError } 62980178 - Failed to create the PixelMap.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPixelMapFromSurfaceSync(surfaceId: string, region: Region): PixelMap;
    /**
     * Creates a PixelMap object from surface id.
     *
     * @param { string } surfaceId - surface id.
     * @returns { PixelMap } Returns the instance if the operation is successful;Otherwise, an exception will be thrown.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     *     2.Incorrect parameter types. 3.Parameter verification failed.
     * @throws { BusinessError } 62980105 - Failed to get the data.
     * @throws { BusinessError } 62980178 - Failed to create the PixelMap.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPixelMapFromSurfaceSync(surfaceId: string): PixelMap;
    
    
    /**
     * Creates an ImageSource instance based on the URI.
     *
     * @param { string } uri Image source URI.
     * @returns { ImageSource } returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function createImageSource(uri: string): ImageSource;
    
    
    
    /**
     * Creates an ImageSource instance based on the URI.
     *
     * @param { string } uri Image source URI.
     * @param { SourceOptions } options The config of Image source.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function createImageSource(uri: string, options: SourceOptions): ImageSource;
    
    
    /**
     * Creates an ImageSource instance based on the file descriptor.
     *
     * @param { int } fd ID of a file descriptor.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function createImageSource(fd: int): ImageSource;
    
    
    
    /**
     * Creates an ImageSource instance based on the file descriptor.
     *
     * @param { int } fd ID of a file descriptor.
     * @param { SourceOptions } options The config of Image source.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function createImageSource(fd: int, options: SourceOptions): ImageSource;
    
    
    
    /**
     * Creates an ImageSource instance based on the buffer.
     *
     * @param { ArrayBuffer } buf The buffer of the image.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function createImageSource(buf: ArrayBuffer): ImageSource;
    
    
    
    /**
     * Creates an ImageSource instance based on the buffer.
     *
     * @param { ArrayBuffer } buf The buffer of the image.
     * @param { SourceOptions } options The config of Image source.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function createImageSource(buf: ArrayBuffer, options: SourceOptions): ImageSource;
    /**
     * Creates an ImageSource instance based on the raw file descriptor.
     *
     * @param { resourceManager.RawFileDescriptor } rawfile The raw file descriptor of the image.
     * @param { SourceOptions } options The config of Image source.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function createImageSource(rawfile: resourceManager.RawFileDescriptor, options?: SourceOptions): ImageSource;
    
    /**
     * Creates an ImageSource instance based on the buffer in incremental.
     *
     * @param { ArrayBuffer } buf The buffer of the image.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function CreateIncrementalSource(buf: ArrayBuffer): ImageSource;
    
    /**
     * Creates an ImageSource instance based on the buffer in incremental.
     *
     * @param { ArrayBuffer } buf The buffer of the image.
     * @param { SourceOptions } options The config of source.
     * @returns { ImageSource } Returns the ImageSource instance if the operation is successful; returns undefined otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    function CreateIncrementalSource(buf: ArrayBuffer, options?: SourceOptions): ImageSource;
    
    
    /**
     * Creates an ImagePacker instance.
     *
     * @returns { ImagePacker } Returns the ImagePacker instance if the operation is successful; returns null otherwise.
     * @syscap SystemCapability.Multimedia.Image.ImagePacker
     * @since 20
     */
    function createImagePacker(): ImagePacker;
    /**
     * Creates an ImageReceiver instance.
     *
     * @param { Size } size - The default {@link Size} in pixels of the Images that this receiver will produce.
     * @param { ImageFormat } format - The format of the Image that this receiver will produce. This must be one of the
     *            {@link ImageFormat} constants.
     * @param { int } capacity - The maximum number of images the user will want to access simultaneously.
     * @returns { ImageReceiver } Returns the ImageReceiver instance if the operation is successful; returns null otherwise.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types;
     * @syscap SystemCapability.Multimedia.Image.ImageReceiver
     * @since 20
     */
    function createImageReceiver(size: Size, format: ImageFormat, capacity: int): ImageReceiver;
    /**
     * Creates an ImageCreator instance.
     *
     * @param { Size } size - The default {@link Size} in pixels of the Images that this creator will produce.
     * @param { ImageFormat } format - The format of the Image that this creator will produce. This must be one of the
     *            {@link ImageFormat} constants.
     * @param { int } capacity - The maximum number of images the user will want to access simultaneously.
     * @returns { ImageCreator } Returns the ImageCreator instance if the operation is successful; returns null otherwise.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types;
     * @syscap SystemCapability.Multimedia.Image.ImageCreator
     * @since 20
     */
    function createImageCreator(size: Size, format: ImageFormat, capacity: int): ImageCreator;
    
    
    
    /**
     * PixelMap instance.
     *
     * @typedef PixelMap
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface PixelMap {
        
        
        
        /**
         * Whether the image pixel map can be edited.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly isEditable: boolean;
        
        
        
        /**
         * Reads image pixel map data and writes the data to an ArrayBuffer. This method uses
         * a promise to return the result.
         *
         * @param { ArrayBuffer } dst A buffer to which the image pixel map data will be written.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readPixelsToBuffer(dst: ArrayBuffer): Promise<void>;
        
        
        
        /**
         * Reads image pixel map data and writes the data to an ArrayBuffer. This method uses
         * a callback to return the result.
         *
         * @param { ArrayBuffer } dst A buffer to which the image pixel map data will be written.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readPixelsToBuffer(dst: ArrayBuffer, callback: AsyncCallback<void>): void;
        /**
         * Reads image pixel map data and writes the data to an ArrayBuffer.
         *
         * @param { ArrayBuffer } dst A buffer to which the image pixel map data will be written.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readPixelsToBufferSync(dst: ArrayBuffer): void;
        
        
        
        /**
         * Reads image pixel map data in an area. This method uses a promise to return the data read.
         *
         * @param { PositionArea } area Area from which the image pixel map data will be read.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readPixels(area: PositionArea): Promise<void>;
        
        
        
        /**
         * Reads image pixel map data in an area. This method uses a callback to return the data read.
         *
         * @param { PositionArea } area Area from which the image pixel map data will be read.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readPixels(area: PositionArea, callback: AsyncCallback<void>): void;
        /**
         * Reads image pixel map data in an area.
         *
         * @param { PositionArea } area Area from which the image pixel map data will be read.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readPixelsSync(area: PositionArea): void;
        
        
        
        /**
         * Writes image pixel map data to the specified area. This method uses a promise to return
         * the operation result.
         *
         * @param { PositionArea } area Area to which the image pixel map data will be written.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writePixels(area: PositionArea): Promise<void>;
        
        
        
        /**
         * Writes image pixel map data to the specified area. This method uses a callback to return
         * the operation result.
         *
         * @param { PositionArea } area Area to which the image pixel map data will be written.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writePixels(area: PositionArea, callback: AsyncCallback<void>): void;
        /**
         * Writes image pixel map data to the specified area.
         *
         * @param { PositionArea } area Area to which the image pixel map data will be written.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writePixelsSync(area: PositionArea): void;
        
        
        
        /**
         * Reads image data in an ArrayBuffer and writes the data to a PixelMap object. This method
         * uses a promise to return the result.
         *
         * @param { ArrayBuffer } src A buffer from which the image data will be read.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writeBufferToPixels(src: ArrayBuffer): Promise<void>;
        
        
        
        /**
         * Reads image data in an ArrayBuffer and writes the data to a PixelMap object. This method
         * uses a callback to return the result.
         *
         * @param { ArrayBuffer } src A buffer from which the image data will be read.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writeBufferToPixels(src: ArrayBuffer, callback: AsyncCallback<void>): void;
        /**
         * Reads image data in an ArrayBuffer and writes the data to a PixelMap object.
         *
         * @param { ArrayBuffer } src A buffer from which the image data will be read.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writeBufferToPixelsSync(src: ArrayBuffer): void;
        /**
         * Convert pixelmap to standard dynamic range.
         *
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @throws { BusinessError } 62980137 - Invalid image operation.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        toSdr(): Promise<void>;
        
        
        
        /**
         * Obtains pixel map information about this image. This method uses a promise to return the information.
         *
         * @returns { Promise<ImageInfo> } A Promise instance used to return the image pixel map information. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getImageInfo(): Promise<ImageInfo>;
        
        
        
        /**
         * Obtains pixel map information about this image. This method uses a callback to return the information.
         *
         * @param { AsyncCallback<ImageInfo> } callback Callback used to return the image pixel map information.
         * If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getImageInfo(callback: AsyncCallback<ImageInfo>): void;
        /**
         * Get image information from image source.
         *
         * @returns { ImageInfo } the image information.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getImageInfoSync(): ImageInfo;
        
        
        
        /**
         * Obtains the number of bytes in each line of the image pixel map.
         *
         * @returns { int } Number of bytes in each line.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getBytesNumberPerRow(): int;
        
        
        
        /**
         * Obtains the total number of bytes of the image pixel map.
         *
         * @returns { int } Total number of bytes.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getPixelBytesNumber(): int;
        
        
        
        /**
         * Obtains the density of the image pixel map.
         *
         * @returns { int } The number of density.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getDensity(): int;
        
        
        
        /**
         * Set the transparent rate of pixel map. This method uses a callback to return the operation result.
         *
         * @param { double } rate The value of transparent rate.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        opacity(rate: double, callback: AsyncCallback<void>): void;
        
        
        
        /**
         * Set the transparent rate of pixel map. This method uses a promise to return the result.
         *
         * @param { double } rate The value of transparent rate.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        opacity(rate: double): Promise<void>;
        /**
         * Set the transparent rate of pixel map.
         *
         * @param { double } rate The value of transparent rate.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        opacitySync(rate: double): void;
        
        
        
        /**
         * Obtains new pixel map with alpha information. This method uses a promise to return the information.
         *
         * @returns { Promise<PixelMap> } A Promise instance used to return the new image pixel map. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        createAlphaPixelmap(): Promise<PixelMap>;
        
        
        
        /**
         * Obtains new pixel map with alpha information. This method uses a callback to return the information.
         *
         * @param { AsyncCallback<PixelMap> } callback Callback used to return the new image pixel map. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        createAlphaPixelmap(callback: AsyncCallback<PixelMap>): void;
        /**
         * Obtains new pixel map with alpha information.
         *
         * @returns { PixelMap } return the new image pixel map. If the operation fails, an error message is returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        createAlphaPixelmapSync(): PixelMap;
        
        
        
        /**
         * Image zoom in width and height. This method uses a callback to return the operation result.
         *
         * @param { double } x The zoom value of width.
         * @param { double } y The zoom value of height.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        scale(x: double, y: double, callback: AsyncCallback<void>): void;
        
        
        
        /**
         * Image zoom in width and height. This method uses a promise to return the result.
         *
         * @param { double } x The zoom value of width.
         * @param { double } y The zoom value of height.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        scale(x: double, y: double): Promise<void>;
        /**
         * Image zoom in width and height.
         *
         * @param { double } x The zoom value of width.
         * @param { double } y The zoom value of height.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        scaleSync(x: double, y: double): void;
        /**
         * Image zoom in width and height width with anti-aliasing. This method uses a promise to return the result.
         *
         * @param { double } x The zoom value of width.
         * @param { double } y The zoom value of height.
         * @param { AntiAliasingLevel } level The anti-aliasing algorithm to be used.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        scale(x: double, y: double, level: AntiAliasingLevel): Promise<void>;
        /**
         * Image zoom in width and height with anti-aliasing.
         *
         * @param { double } x The zoom value of width.
         * @param { double } y The zoom value of height.
         * @param { AntiAliasingLevel } level The anti-aliasing algorithm to be used.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        scaleSync(x: double, y: double, level: AntiAliasingLevel): void;
        /**
         * Create a new scaled pixelmap based on this image zoom in width and height with anti-aliasing. This method uses a promise to return the information.
         *
         * @param { double } x The zoom value of width.
         * @param { double } y The zoom value of height.
         * @param { AntiAliasingLevel } level The anti-aliasing algorithm to be used.
         * @returns { Promise<PixelMap> } A Promise instance used to return the new scaled pixelmap. If the operation fails, an error message is returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        createScaledPixelMap(x: double, y: double, level?: AntiAliasingLevel): Promise<PixelMap>;
        /**
         * Create a new scaled pixelmap based on this image zoom in width and height with anti-aliasing.
         *
         * @param { double } x The zoom value of width.
         * @param { double } y The zoom value of height.
         * @param { AntiAliasingLevel } level The anti-aliasing algorithm to be used.
         * @returns { PixelMap } return the new scaled pixelmap. If the operation fails, an error message is returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        createScaledPixelMapSync(x: double, y: double, level?: AntiAliasingLevel): PixelMap;
        
        
        
        /**
         * Image position transformation. This method uses a callback to return the operation result.
         *
         * @param { double } x The position value of width.
         * @param { double } y The position value of height.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        translate(x: double, y: double, callback: AsyncCallback<void>): void;
        
        
        
        /**
         * Image position transformation. This method uses a promise to return the result.
         *
         * @param { double } x The position value of width.
         * @param { double } y The position value of height.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        translate(x: double, y: double): Promise<void>;
        /**
         * Image position transformation.
         *
         * @param { double } x The position value of width.
         * @param { double } y The position value of height.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        translateSync(x: double, y: double): void;
        
        
        
        /**
         * Image rotation. This method uses a callback to return the operation result.
         *
         * @param { double } angle The rotation angle.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        rotate(angle: double, callback: AsyncCallback<void>): void;
        
        
        
        /**
         * Image rotation. This method uses a promise to return the result.
         *
         * @param { double } angle The rotation angle.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        rotate(angle: double): Promise<void>;
        /**
         * Image rotation.
         *
         * @param { double } angle The rotation angle.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        rotateSync(angle: double): void;
        
        
        
        /**
         * Image flipping. This method uses a callback to return the operation result.
         *
         * @param { boolean } horizontal Is flip in horizontal.
         * @param { boolean } vertical Is flip in vertical.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        flip(horizontal: boolean, vertical: boolean, callback: AsyncCallback<void>): void;
        
        
        
        /**
         * Image flipping. This method uses a promise to return the result.
         *
         * @param { boolean } horizontal Is flip in horizontal.
         * @param { boolean } vertical Is flip in vertical.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        flip(horizontal: boolean, vertical: boolean): Promise<void>;
        /**
         * Image flipping.
         *
         * @param { boolean } horizontal Is flip in horizontal.
         * @param { boolean } vertical Is flip in vertical.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        flipSync(horizontal: boolean, vertical: boolean): void;
        
        
        
        /**
         * Crop the image. This method uses a callback to return the operation result.
         *
         * @param { Region } region The region to crop.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        crop(region: Region, callback: AsyncCallback<void>): void;
        
        
        
        /**
         * Crop the image. This method uses a promise to return the result.
         *
         * @param { Region } region The region to crop.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        crop(region: Region): Promise<void>;
        /**
         * Crop the image.
         *
         * @param { Region } region The region to crop.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource Unavailable.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        cropSync(region: Region): void;
        
        /**
         * Get color space of pixel map.
         *
         * @returns { colorSpaceManager.ColorSpaceManager } If the operation fails, an error message is returned.
         * @throws { BusinessError } 62980101 - If the image data abnormal.
         * @throws { BusinessError } 62980103 - If the image data unsupport.
         * @throws { BusinessError } 62980115 - If the image parameter invalid.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getColorSpace(): colorSpaceManager.ColorSpaceManager;
        /**
         * Marshalling pixelmap and write into MessageSequence.
         *
         * @param { rpc.MessageSequence } sequence rpc.MessageSequence parameter.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980097 - IPC error. Possible cause: 1.IPC communication failed. 2. Image upload exception.
         * 3. Decode process exception. 4. Insufficient memory.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        marshalling(sequence: rpc.MessageSequence): void;
        /**
         * Creates a PixelMap object based on MessageSequence parameter.
         *
         * @param { rpc.MessageSequence } sequence rpc.MessageSequence parameter.
         * @returns { Promise<PixelMap> } A Promise instance used to return the PixelMap object.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980097 - IPC error. Possible cause: 1.IPC communication failed. 2. Image upload exception.
         * 3. Decode process exception. 4. Insufficient memory.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        unmarshalling(sequence: rpc.MessageSequence): Promise<PixelMap>;
        
        
        /**
        * Set color space of pixel map.
        *
        * This method is only used to set the colorspace property of pixelmap, while all pixel data remains the same after calling this method.
        * If you want to change colorspace for all pixels, use method {@Link #applyColorSpace(colorSpaceManager.ColorSpaceManager)} or
        * {@Link #applyColorSpace(colorSpaceManager.ColorSpaceManager, AsyncCallback<void>)}.
        *
        * @param { colorSpaceManager.ColorSpaceManager } colorSpace The color space for pixel map.
        * @throws { BusinessError } 62980111 - The image source data is incomplete.
        * @throws { BusinessError } 62980115 - If the image parameter invalid.
        * @syscap SystemCapability.Multimedia.Image.Core
        * @since 20
        */
        setColorSpace(colorSpace: colorSpaceManager.ColorSpaceManager): void;
        /**
         * Is it stride Alignment
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly isStrideAlignment: boolean;
        /**
        * Apply color space of pixel map, the pixels will be changed by input color space. This method uses a callback to return the operation result.
        *
        * This method is used to change color space of pixelmap. Pixel data will be changed by calling this method.
        * If you want to set the colorspace property of pixelmap only, use method {@Link #setColorSpace(colorSpaceManager.ColorSpaceManager)}.
        *
        * @param { colorSpaceManager.ColorSpaceManager } targetColorSpace - The color space for pixel map.
        * @param { AsyncCallback<void> } callback - Callback used to return the operation result. If the operation fails, an error message is returned.
        * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
        * 2.Incorrect parameter types. 3.Parameter verification failed.
        * @throws { BusinessError } 62980104 - Failed to initialize the internal object.
        * @throws { BusinessError } 62980108 - Failed to convert the color space.
        * @throws { BusinessError } 62980115 - Invalid image parameter.
        * @syscap SystemCapability.Multimedia.Image.Core
        * @since 20
        */
        applyColorSpace(targetColorSpace: colorSpaceManager.ColorSpaceManager, callback: AsyncCallback<void>): void;
        /**
         * Apply color space of pixel map, the pixels will be changed by input color space. This method uses a promise to return the result.
         *
         * This method is used to change color space of pixelmap. Pixel data will be changed by calling this method.
         * If you want to set the colorspace property of pixelmap only, use method {@Link #setColorSpace(colorSpaceManager.ColorSpaceManager)}.
         *
         * @param { colorSpaceManager.ColorSpaceManager } targetColorSpace - The color space for pixel map.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 62980104 - Failed to initialize the internal object.
         * @throws { BusinessError } 62980108 - Failed to convert the color space.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        applyColorSpace(targetColorSpace: colorSpaceManager.ColorSpaceManager): Promise<void>;
        /**
         * The method is used for the transformation of the image formats. Pixel data will be changed by calling this method.
         *
         * @param { PixelMapFormat } targetPixelFormat - The pixel format for pixelmap conversion.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an error message is returned.
         * @throws { BusinessError } 62980115 - Invalid input parameter.
         * @throws { BusinessError } 62980111 - The image source data is incomplete.
         * @throws { BusinessError } 62980274 - The conversion failed.
         * @throws { BusinessError } 62980276 - The type to be converted is an unsupported target pixel format.
         * @throws { BusinessError } 62980178 - Failed to create the pixelmap.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        convertPixelFormat(targetPixelFormat: PixelMapFormat): Promise<void>;
        
        
        
        /**
         * Releases this PixelMap object. This method uses a callback to return the result.
         *
         * @param { AsyncCallback<void> } callback Callback invoked for instance release. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        
        
        
        /**
         * Releases this PixelMap object. This method uses a promise to return the result.
         *
         * @returns { Promise<void> } A Promise instance used to return the instance release result. If the operation fails, an error message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        release(): Promise<void>;
        /**
         * Set pixelmap memory name.
         *
         * @param { string } name The name of the memory that needs to be set
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.The length of the input parameter is too long.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 501 - Resource unavailable.
         * @throws { BusinessError } 62980286 - Memory format not supported.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        setMemoryNameSync(name: string): void;
    }
    /**
     * Picture instance. It is composed of a main pixelmap, auxiliary pictures and metadata. The main pixelmap contains
     * the main visual content; auxiliary pictures store additional information related to the main pixelmap;
     * and metadata stores other information associated with the image.
     *
     * @typedef Picture
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface Picture {
        /**
         * Obtains the pixel map of the main image.
         *
         * @returns { PixelMap } Returns the pixel map.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getMainPixelmap(): PixelMap;
        /**
         * Obtains the hdr pixel map. This method uses a promise to return the PixelMap object.
         *
         * @returns { Promise<PixelMap> } A Promise instance used to return the PixelMap object.
         * @throws { BusinessError } 7600901 - Inner unknown error. Please check the logs for detailed information.
         * @throws { BusinessError } 7600201 - Unsupported operation. e.g.,1. The picture does not has a gainmap.
         * 2. MainPixelMap's allocator type is not DMA.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getHdrComposedPixelmap(): Promise<PixelMap>;
        /**
         * Obtains the gain map pixel map.
         * @returns { PixelMap | null } Returns the pixel map if the operation is successful; returns null otherwise.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getGainmapPixelmap(): PixelMap | null;
        /**
         * Set auxiliary picture.
         *
         * @param { AuxiliaryPictureType } type The type of auxiliary picture.
         * @param { AuxiliaryPicture } auxiliaryPicture AuxiliaryPicture object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        setAuxiliaryPicture(type: AuxiliaryPictureType, auxiliaryPicture: AuxiliaryPicture): void;
        /**
         * Obtains the auxiliary picture based on type.
         *
         * @param { AuxiliaryPictureType } type The type of auxiliary picture.
         * @returns { AuxiliaryPicture | null } Returns the auxiliary picture object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getAuxiliaryPicture(type: AuxiliaryPictureType): AuxiliaryPicture | null;
        /**
         * Set the metadata of main picture.
         *
         * @param { MetadataType } metadataType The type of metadata.
         * @param { Metadata } metadata The metadata of main picture.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7600202 - Unsupported metadata. Possible causes: 1. Unsupported metadata type. 2. The
         * metadata type does not match the auxiliary picture type.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        setMetadata(metadataType: MetadataType, metadata: Metadata): Promise<void>;
        /**
         * Obtains the metadata of main picture.
         *
         * @param { MetadataType } metadataType The type of metadata.
         * @returns { Promise<Metadata> } Return the metadata of main picture.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7600202 - Unsupported metadata. Possible causes: 1. Unsupported metadata type. 2. The
         * metadata type does not match the auxiliary picture type.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getMetadata(metadataType: MetadataType): Promise<Metadata>;
        /**
         * Marshalling picture and write into MessageSequence.
         *
         * @param { rpc.MessageSequence } sequence rpc.MessageSequence parameter.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 62980097 - IPC error. Possible cause: 1.IPC communication failed. 2. Image upload exception.
         * 3. Decode process exception. 4. Insufficient memory.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        marshalling(sequence: rpc.MessageSequence): void;
        /**
         * Releases this Picture object.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        release(): void;
    }
    /**
     * Create a Picture object by the pixel map of the main image.
     *
     * @param { PixelMap } mainPixelmap The pixel map of the main image.
     * @returns { Picture } Returns the Picture object.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types; 3.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPicture(mainPixelmap: PixelMap): Picture;
    /**
     * Creates a Picture object based on MessageSequence parameter.
     *
     * @param { rpc.MessageSequence } sequence - rpc.MessageSequence parameter.
     * @returns { Picture } Returns the Picture object.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 62980097 - IPC error. Possible cause: 1.IPC communication failed. 2. Image upload exception.
     * 3. Decode process exception. 4. Insufficient memory.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createPictureFromParcel(sequence: rpc.MessageSequence): Picture;
    /**
     * Create a AuxiliaryPicture object by data buffer.
     *
     * @param { ArrayBuffer } buffer The image data buffer.
     * @param { Size } size The size of auxiliary picture.
     * @param { AuxiliaryPictureType } type The type of auxiliary picture.
     * @returns { AuxiliaryPicture } The AuxiliaryPicture object.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types; 3.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    function createAuxiliaryPicture(buffer: ArrayBuffer, size: Size, type: AuxiliaryPictureType): AuxiliaryPicture;
    /**
     * AuxiliaryPicture instance.
     *
     * @typedef AuxiliaryPicture
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface AuxiliaryPicture {
        /**
         * Reads auxiliary picture data in an ArrayBuffer and writes the data to a AuxiliaryPicture object. This method
         * uses a promise to return the result.
         *
         * @param { ArrayBuffer } data A buffer from which the auxiliary picture data will be read.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an
         * error message is returned.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        writePixelsFromBuffer(data: ArrayBuffer): Promise<void>;
        /**
         * Reads image pixel map data and writes the data to an ArrayBuffer. This method uses
         * a promise to return the result.
         *
         * @returns { Promise<ArrayBuffer> } A Promise instance used to return the pixel map data.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readPixelsToBuffer(): Promise<ArrayBuffer>;
        /**
         * Obtains the type of auxiliary picture.
         *
         * @returns { AuxiliaryPictureType } Returns the type of auxiliary picture.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getType(): AuxiliaryPictureType;
        /**
         * Set the metadata of auxiliary picture.
         *
         * @param { MetadataType } metadataType The type of metadata.
         * @param { Metadata } metadata The metadata of auxiliary picture.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7600202 - Unsupported metadata. Possible causes: 1. Unsupported metadata type. 2. The
         * metadata type does not match the auxiliary picture type.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        setMetadata(metadataType: MetadataType, metadata: Metadata): Promise<void>;
        /**
         * Obtains the metadata of auxiliary picture.
         *
         * @param { MetadataType } metadataType The type of metadata.
         * @returns { Promise<Metadata> } Return the metadata of auxiliary picture.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7600202 - Unsupported metadata. Possible causes: 1. Unsupported metadata type. 2. The
         * metadata type does not match the auxiliary picture type.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getMetadata(metadataType: MetadataType): Promise<Metadata>;
        /**
         * Obtains the information about this auxiliary picture.
         *
         * @returns { AuxiliaryPictureInfo } Returns the auxiliary picture information. If the operation fails, an error
         * message is returned.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getAuxiliaryPictureInfo(): AuxiliaryPictureInfo;
        /**
         * Set the information about this auxiliary picture.
         *
         * @param { AuxiliaryPictureInfo } info the auxiliary picture information.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        setAuxiliaryPictureInfo(info: AuxiliaryPictureInfo): void;
        /**
         * Releases this AuxiliaryPicture object.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        release(): void;
    }
    /**
     * Enumerates auxiliary picture type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum AuxiliaryPictureType {
        /**
         * Gain Map, which is an auxiliary image that describes how the brightness of each pixel should be scaled in order
         * to correctly map image luminance between display devices with different dynamic ranges. It is typically used to
         * convert a Standard Dynamic Range (SDR) image into a High Dynamic Range (HDR) image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        GAINMAP = 1,
        /**
         * Depth map, which stores the depth information of an image by capturing the distance between each pixel and
         * the camera. It provides three-dimensional structural information of the scene and is commonly used for 3D
         * reconstruction and scene understanding.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        DEPTH_MAP = 2,
        /**
         * Unrefocus map, representing an original portrait image with unfocused background, which provides a way to
         * emphasize background blur inportrait photography.
         * It helps users select the focus area during post-processing, enhancing creative flexibility.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        UNREFOCUS_MAP = 3,
        /**
         * Linear map, used to provide an additional data perspective or supplementary information, typically for enhancing
         * visual effects. It can contain a linear representation of lighting, color, or other visual elements in the scene.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        LINEAR_MAP = 4,
        /**
         * Fragment map, representing the region in the original image that is covered by a watermark.
         * This image is used to restore or remove the effects of the watermark, helping to recover the image’s integrity
         * and visual clarity.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FRAGMENT_MAP = 5
    }
    /**
     * Enumerates metadata type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum MetadataType {
        /**
         * EXIF metadata.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        EXIF_METADATA = 1,
        /**
         * Fragment metadata.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        FRAGMENT_METADATA = 2
    }
    /**
     * Metadata instance.
     *
     * @typedef Metadata
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface Metadata {
        /**
         * Obtains the value of properties in an image. This method uses a promise to return the property values in array
         * of records.
         *
         * @param { Array<string> } key Name of the properties whose value is to be obtained.
         * @returns { Promise<Record<string, string | null>> } Array of Records instance used to return the property values.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7600202 - Unsupported metadata. Possible causes: 1. Unsupported metadata type. 2. The
         * metadata type does not match the auxiliary picture type.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getProperties(key: Array<string>): Promise<Record<string, string | null>>;
        /**
         * Modify the value of properties in an image with the specified keys.
         *
         * @param { Record<string, string | null> } records Array of the property Records whose values are to
         * be modified.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7600202 - Unsupported metadata. Possible causes: 1. Unsupported metadata type. 2. The
         * metadata type does not match the auxiliary picture type.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        setProperties(records: Record<string, string | null>): Promise<void>;
        /**
         * Obtains the value of all properties in an image. This method uses a promise to return the property values
         * in array of records.
         *
         * @returns { Promise<Record<string, string | null>> } Array of Records instance used to return the property values.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getAllProperties(): Promise<Record<string, string | null>>;
        /**
         * Obtains a clone of metadata. This method uses a promise to return the metadata.
         *
         * @returns { Promise<Metadata> } A Promise instance used to return the metadata.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        clone(): Promise<Metadata>;
    }
    /**
     * Enumerates fragment map information types of an image.
     *
     * @enum { string }
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    enum FragmentMapPropertyKey {
        /**
         * The x-coordinate of the top left corner of the mark cup map in the original image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        X_IN_ORIGINAL = 'XInOriginal',
        /**
         * The y-coordinate of the top left corner of the mark cup map in the original image.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        Y_IN_ORIGINAL = 'YInOriginal',
        /**
         * Mark cut map width.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        WIDTH = 'FragmentImageWidth',
        /**
         * Mark cut map width.
         *
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        HEIGHT = 'FragmentImageHeight'
    }
    /**
     * Describes image decoding parameters.
     *
     * @typedef DecodingOptionsForPicture
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    interface DecodingOptionsForPicture {
        /**
         * Expected set of auxiliary picture types, default to decoding all auxiliary pictures.
         *
         * @type { Array<AuxiliaryPictureType> }
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        desiredAuxiliaryPictures: Array<AuxiliaryPictureType>;
    }
    /**
    * Describes auxiliary picture information.
    *
    * @typedef AuxiliaryPictureInfo
    * @syscap SystemCapability.Multimedia.Image.Core
    * @since 20
    */
    interface AuxiliaryPictureInfo {
        /**
         * Indicates auxiliary picture type.
         *
         * @type { AuxiliaryPictureType }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        auxiliaryPictureType: AuxiliaryPictureType;
        /**
         * Indicates image dimensions specified by a {@link Size} interface.
         *
         * @type { Size }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        size: Size;
        /**
         * The number of byte per row.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        rowStride: int;
        /**
         * Indicates image format.
         *
         * @type { PixelMapFormat }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        pixelFormat: PixelMapFormat;
        /**
         * Indicates color space for pixel map.
         *
         * @type { colorSpaceManager.ColorSpaceManager }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        colorSpace: colorSpaceManager.ColorSpaceManager;
    }
    
    
    
    /**
     * ImageSource instance.
     *
     * @typedef ImageSource
     * @syscap SystemCapability.Multimedia.Image.ImageSource
     * @since 20
     */
    interface ImageSource {
        
        
        
        /**
         * Obtains information about an image with the specified sequence number and uses a callback
         * to return the result.
         *
         * @param { int } index Sequence number of an image. The default value is 0, indicating the first image.
         * When the value is N, it refers to the (N-1)th image. In single-frame image scenarios, the value must be 0.
         * In multi-frame image scenarios such as animations, the valid range is 0 to (frame count - 1).
         * @param { AsyncCallback<ImageInfo> } callback Callback used to return the image information.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getImageInfo(index: int, callback: AsyncCallback<ImageInfo>): void;
        
        
        
        /**
         * Obtains information about this image and uses a callback to return the result.
         *
         * @param { AsyncCallback<ImageInfo> } callback Callback used to return the image information.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getImageInfo(callback: AsyncCallback<ImageInfo>): void;
        
        
        
        /**
         * Get image information from image source.
         *
         * @param { int } index Sequence number of an image. The default value is 0, indicating the first image.
         * When the value is N, it refers to the (N-1)th image. In single-frame image scenarios, the value must be 0.
         * In multi-frame image scenarios such as animations, the valid range is 0 to (frame count - 1).
         * @returns { Promise<ImageInfo> } A Promise instance used to return the image information.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getImageInfo(index?: int): Promise<ImageInfo>;
        /**
         * Get image information from image source synchronously.
         *
         * @param { int } index Sequence number of an image. The default value is 0, indicating the first image.
         * When the value is N, it refers to the (N-1)th image. In single-frame image scenarios, the value must be 0.
         * In multi-frame image scenarios such as animations, the valid range is 0 to (frame count - 1).
         * @returns { ImageInfo } The image information.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getImageInfoSync(index?: int): ImageInfo;
        
        
        
        /**
         * Creates a PixelMap object based on image decoding parameters. This method uses a promise to
         * return the object.
         *
         * @param { DecodingOptions } options Image decoding parameters.
         * @returns { Promise<PixelMap> } A Promise instance used to return the PixelMap object.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMap(options?: DecodingOptions): Promise<PixelMap>;
        
        
        
        /**
         * Creates a PixelMap object. This method uses a callback to return the object.
         *
         * @param { AsyncCallback<PixelMap> } callback Callback used to return the PixelMap object.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMap(callback: AsyncCallback<PixelMap>): void;
        
        
        
        /**
         * Creates a PixelMap object based on image decoding parameters. This method uses a callback to
         * return the object.
         *
         * @param { DecodingOptions } options Image decoding parameters.
         * @param { AsyncCallback<PixelMap> } callback Callback used to return the PixelMap object.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMap(options: DecodingOptions, callback: AsyncCallback<PixelMap>): void;
        /**
         * Creates a PixelMap based on decoding parameters, the memory type used by the PixelMap can be specified by
         * allocatorType. By default, the system selects the memory type based on the image type, image size, platform
         * capability, etc. When processing the PixelMap returned by this interface, please always consider the impact of
         * stride.
         *
         * @param { DecodingOptions } options Image decoding parameters.
         * @param { AllocatorType } allocatorType Indicate which memory type will be used by the returned PixelMap.
         * @returns { Promise<PixelMap> } A Promise instance used to return the PixelMap object.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 7700101 - Bad source. e.g.,1. Image has invalid width or height. 2. Image source incomplete.
         * 3. Read image data failed. 4. Codec create failed.
         * @throws { BusinessError } 7700102 - Unsupported mimetype.
         * @throws { BusinessError } 7700103 - Image too large. This status code is thrown when an error occurs during the process of
         * checking size.
         * @throws { BusinessError } 7700201 - Unsupported allocator type, e.g., use share memory to decode a HDR image as
         * only DMA supported hdr metadata.
         * @throws { BusinessError } 7700203 - Unsupported options, e.g, cannot convert image into desired pixel format.
         * @throws { BusinessError } 7700301 - Failed to decode image.
         * @throws { BusinessError } 7700302 - Failed to allocate memory.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMapUsingAllocator(options?: DecodingOptions, allocatorType?: AllocatorType): Promise<PixelMap>;
        /**
         * Create a PixelMap object based on image decoding parameters synchronously.
         *
         * @param { DecodingOptions } options - Image decoding parameters.
         * @returns { PixelMap } Return the PixelMap. If decoding fails, return undefined.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMapSync(options?: DecodingOptions): PixelMap;
        /**
         * Creates a PixelMap based on decoding parameters synchronously, the memory type used by the PixelMap can be
         * specified by allocatorType. By default, the system selects the memory type based on the image type, image size,
         * platform capability, etc. When processing the PixelMap returned by this interface, please always consider the
         * impact of stride.
         *
         * @param { DecodingOptions } options Image decoding parameters.
         * @param { AllocatorType } allocatorType Indicate which memory type will be used by the returned PixelMap.
         * @returns { PixelMap } Return the PixelMap. If decoding fails, return undefined.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 7700101 - Bad source. e.g.,1. Image has invalid width or height. 2. Image source incomplete.
         * 3. Read image data failed. 4. Codec create failed.
         * @throws { BusinessError } 7700102 - Unsupported mimetype.
         * @throws { BusinessError } 7700103 - Image too large. This status code is thrown when an error occurs during the process of
         * checking size.
         * @throws { BusinessError } 7700201 - Unsupported allocator type, e.g., use share memory to decode a HDR image as
         * only DMA supported hdr metadata.
         * @throws { BusinessError } 7700203 - Unsupported options, e.g, cannot convert image into desired pixel format.
         * @throws { BusinessError } 7700301 - Failed to decode image.
         * @throws { BusinessError } 7700302 - Failed to allocate memory.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMapUsingAllocatorSync(options?: DecodingOptions, allocatorType?: AllocatorType): PixelMap;
        
        /**
        * Creates a PixelMap array based on image decoding parameters. This method uses a promise to
        * return the array. For animated images such as GIF and WebP, this interface returns the image data of each frame.
        * For static images, it returns a single frame of image data.
        *
        * @param { DecodingOptions } options Image decoding parameters.
        * @returns { Promise<Array<PixelMap>> } A Promise instance used to return the PixelMap array.
        * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
        * 2. Decoding process exception. 3. Insufficient memory.
        * @throws { BusinessError } 62980099 - The shared memory data is abnormal.
        * @throws { BusinessError } 62980101 - The image data is abnormal.
        * @throws { BusinessError } 62980103 - The image data is not supported.
        * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
        * @throws { BusinessError } 62980109 - Failed to crop the image.
        * @throws { BusinessError } 62980111 - The image source data is incomplete.
        * @throws { BusinessError } 62980115 - Invalid image parameter.
        * @throws { BusinessError } 62980116 - Failed to decode the image.
        * @throws { BusinessError } 62980118 - Failed to create the image plugin.
        * @throws { BusinessError } 62980137 - Invalid media operation.
        * @throws { BusinessError } 62980173 - The DMA memory does not exist.
        * @throws { BusinessError } 62980174 - The DMA memory data is abnormal.
        * @syscap SystemCapability.Multimedia.Image.ImageSource
        * @since 20
        */
        createPixelMapList(options?: DecodingOptions): Promise<Array<PixelMap>>;
        
        /**
         * Creates a PixelMap array. This method uses a callback to return the array.
         * For animated images such as GIF and WebP, this interface returns the image data of each frame.
         * For static images, it returns a single frame of image data.
         *
         * @param { AsyncCallback<Array<PixelMap>> } callback Callback used to return the PixelMap array.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980099 - The shared memory data is abnormal.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980103 - The image data is not supported.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980109 - Failed to crop the image.
         * @throws { BusinessError } 62980111 - The image source data is incomplete.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980116 - Failed to decode the image.
         * @throws { BusinessError } 62980118 - Failed to create the image plugin.
         * @throws { BusinessError } 62980137 - Invalid media operation.
         * @throws { BusinessError } 62980173 - The DMA memory does not exist.
         * @throws { BusinessError } 62980174 - The DMA memory data is abnormal.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMapList(callback: AsyncCallback<Array<PixelMap>>): void;
        
        /**
         * Creates a PixelMap array based on image decoding parameters. This method uses a callback to
         * return the array. For animated images such as GIF and WebP, this interface returns the image data of each frame.
         * For static images, it returns a single frame of image data.
         *
         * @param { DecodingOptions } options Image decoding parameters.
         * @param { AsyncCallback<Array<PixelMap>> } callback Callback used to return the PixelMap array.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980099 - The shared memory data is abnormal.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980103 - The image data is not supported.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980109 - Failed to crop the image.
         * @throws { BusinessError } 62980111 - The image source data is incomplete.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980116 - Failed to decode the image.
         * @throws { BusinessError } 62980118 - Failed to create the image plugin.
         * @throws { BusinessError } 62980137 - Invalid media operation.
         * @throws { BusinessError } 62980173 - The DMA memory does not exist.
         * @throws { BusinessError } 62980174 - The DMA memory data is abnormal.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPixelMapList(options: DecodingOptions, callback: AsyncCallback<Array<PixelMap>>): void;
        
        /**
         * Obtains the array of delay time in an image. This method uses a promise to return the array.
         *
         * @returns { Promise<Array<int>> } A Promise instance used to return the array.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980110 - The image source data is incorrect.
         * @throws { BusinessError } 62980111 - The image source data is incomplete.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980116 - Failed to decode the image.
         * @throws { BusinessError } 62980118 - Failed to create the image plugin.
         * @throws { BusinessError } 62980122 - Failed to decode the image header.
         * @throws { BusinessError } 62980149 - Invalid MIME type for the image source.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getDelayTimeList(): Promise<Array<int>>;
        
        /**
         * Obtains the array of delay time in an image. This method uses a callback to return the array.
         *
         * @param { AsyncCallback<Array<int>> } callback Callback used to return the array.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980110 - The image source data is incorrect.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980116 - Failed to decode the image.
         * @throws { BusinessError } 62980118 - Failed to create the image plugin.
         * @throws { BusinessError } 62980122 - Failed to decode the image header.
         * @throws { BusinessError } 62980149 - Invalid MIME type for the image source.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getDelayTimeList(callback: AsyncCallback<Array<int>>): void;
        /**
         * Obtains the array of disposal type in a gif image. This method uses a promise to return the array.
         *
         * @returns { Promise<Array<int>> } A Promise instance used to return the array.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980137 - Invalid media operation.
         * @throws { BusinessError } 62980149 - Invalid MIME type for the image source.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getDisposalTypeList(): Promise<Array<int>>;
        
        /**
         * Obtains the count of frame in an image. This method uses a promise to return the number.
         *
         * @returns { Promise<int> } A Promise instance used to return the number.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980111 - The image source data is incomplete.
         * @throws { BusinessError } 62980112 - The image format does not match.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980116 - Failed to decode the image.
         * @throws { BusinessError } 62980118 - Failed to create the image plugin.
         * @throws { BusinessError } 62980122 - Failed to decode the image header.
         * @throws { BusinessError } 62980137 - Invalid media operation.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getFrameCount(): Promise<int>;
        
        /**
         * Obtains the count of frame in an image. This method uses a callback to return the number.
         *
         * @param { AsyncCallback<int> } callback Callback used to return the number.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980111 - The image source data is incomplete.
         * @throws { BusinessError } 62980112 - The image format does not match.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980116 - Failed to decode the image.
         * @throws { BusinessError } 62980118 - Failed to create the image plugin.
         * @throws { BusinessError } 62980122 - Failed to decode the image header.
         * @throws { BusinessError } 62980137 - Invalid media operation.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getFrameCount(callback: AsyncCallback<int>): void;
        
        /**
         * Obtains the value of a property in an image with the specified index. This method uses a
         * promise to return the property value in a string.
         *
         * @param { PropertyKey } key - Name of the property whose value is to be obtained.
         * @param { ImagePropertyOptions } options - Index of the image.
         * @returns { Promise<string> } A Promise instance used to return the property value. If the operation fails, the default value is returned.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types;3.Parameter verification failed;
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980103 - The image data is not supported.
         * @throws { BusinessError } 62980110 - The image source data is incorrect.
         * @throws { BusinessError } 62980111 - The image source data is incomplete.
         * @throws { BusinessError } 62980112 - The image format does not match.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid image parameter.
         * @throws { BusinessError } 62980118 - Failed to create the image plugin.
         * @throws { BusinessError } 62980122 - Failed to decode the image header.
         * @throws { BusinessError } 62980123 - The image does not support EXIF decoding.
         * @throws { BusinessError } 62980135 - The EXIF value is invalid.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getImageProperty(key: PropertyKey, options?: ImagePropertyOptions): Promise<string>;
        /**
         * Obtains the value of properties in an image. This method uses a promise to return the property values in array
         * of records.
         *
         * @param { Array<PropertyKey> } key - Name of the properties whose value is to be obtained.
         * @returns { Promise<Record<PropertyKey, string|null>> } Array of Records instance used to return the
         * property values. If the operation fails, the null is returned.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed;
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980110 - The image source data is incorrect.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980116 - Failed to decode the image.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        getImageProperties(key: Array<PropertyKey>): Promise<Record<PropertyKey, string | null>>;
        
        /**
         * Modify the value of a property in an image with the specified key. This method uses a
         * promise to return the property value in a string.
         *
         * @param { PropertyKey } key - Name of the property whose value is to be modified.
         * @param { string } value - The value to be set to property.
         * @returns { Promise<void> } A Promise instance used to return the property value.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types;
         * @throws { BusinessError } 62980123 - The image does not support EXIF decoding.
         * @throws { BusinessError } 62980133 - The EXIF data is out of range.
         * @throws { BusinessError } 62980135 - The EXIF value is invalid.
         * @throws { BusinessError } 62980146 - The EXIF data failed to be written to the file.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        modifyImageProperty(key: PropertyKey, value: string): Promise<void>;
        /**
         * Modify the value of properties in an image with the specified keys.
         *
         * @param { Record<PropertyKey, string|null> } records - Array of the property Records whose values are to
         * be modified.
         * @returns { Promise<void> } A Promise instance used to return the operation result. If the operation fails, an
         * error message is returned.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed;
         * @throws { BusinessError } 62980123 - The image does not support EXIF decoding.
         * @throws { BusinessError } 62980135 - The EXIF value is invalid.
         * @throws { BusinessError } 62980146 - The EXIF data failed to be written to the file.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        modifyImageProperties(records: Record<PropertyKey, string | null>): Promise<void>;
        
        
        /**
         * Update the data in the incremental ImageSource.
         *
         * @param { ArrayBuffer } buf The data to be updated.
         * @param { boolean } isFinished If is it finished.
         * @param { int } offset The offset of data.
         * @param { int } length The length fo buf.
         * @returns { Promise<void> } A Promise instance used to return the property value.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        updateData(buf: ArrayBuffer, isFinished: boolean, offset: int, length: int): Promise<void>;
        
        
        /**
         * Update the data in the incremental ImageSource.
         *
         * @param { ArrayBuffer } buf The data to be updated.
         * @param { boolean } isFinished If is it finished.
         * @param { int } offset The offset of data.
         * @param { int } length The length fo buf.
         * @param { AsyncCallback<void> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        updateData(buf: ArrayBuffer, isFinished: boolean, offset: int, length: int, callback: AsyncCallback<void>): void;
        
        /**
         * Releases an ImageSource instance and uses a callback to return the result.
         *
         * @param { AsyncCallback<void> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        
        /**
         * Releases an ImageSource instance and uses a promise to return the result.
         *
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        release(): Promise<void>;
        /**
         * Creates a Picture object based on image decoding parameters. This method uses a promise to
         * return the object.
         *
         * @param { DecodingOptionsForPicture } options Image decoding parameters.
         * @returns { Promise<Picture> } A Promise instance used to return the Picture object.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 7700301 - Failed to decode image.
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        createPicture(options?: DecodingOptionsForPicture): Promise<Picture>;
        
        /**
         * Supported image formats.
         *
         * @type { Array<string> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.ImageSource
         * @since 20
         */
        readonly supportedFormats: Array<string>;
    }
    
    
    /**
     * ImagePacker instance.
     *
     * @typedef ImagePacker
     * @syscap SystemCapability.Multimedia.Image.ImagePacker
     * @since 20
     */
    interface ImagePacker {
        /**
         * Compresses or packs an image and uses a promise to return the result.
         *
         * @param { ImageSource } source Image to be processed.
         * @param { PackingOption } options Option for image packing.
         * @returns { Promise<ArrayBuffer> } A Promise instance used to return the compressed or packed data.
         * @throws { BusinessError } 401 - If the parameter is invalid.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980119 - Failed to encode the image.
         * @throws { BusinessError } 62980120 - Add pixelmap out of range.
         * @throws { BusinessError } 62980172 - Failed to encode icc.
         * @throws { BusinessError } 62980252 - Failed to create surface.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToData(source: ImageSource, options: PackingOption): Promise<ArrayBuffer>;
        /**
         * Compresses or packs an image and uses a promise to return the result.
         *
         * @param { PixelMap } source PixelMap to be processed.
         * @param { PackingOption } options Option for image packing.
         * @returns { Promise<ArrayBuffer> } A Promise instance used to return the compressed or packed data.
         * @throws { BusinessError } 401 - If the parameter is invalid.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980119 - Failed to encode the image.
         * @throws { BusinessError } 62980120 - Add pixelmap out of range.
         * @throws { BusinessError } 62980172 - Failed to encode icc.
         * @throws { BusinessError } 62980252 - Failed to create surface.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToData(source: PixelMap, options: PackingOption): Promise<ArrayBuffer>;
        /**
         * Compresses a Pixelmap sequence into gif.
         *
         * @param { Array<PixelMap> } pixelmapSequence PixelMaps to be encoded.
         * @param { PackingOptionsForSequence } options Options for image packing.
         * @returns { Promise<ArrayBuffer> } encoded buffer.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types;3.Parameter verification failed.
         * @throws { BusinessError } 7800301 - Failed to encode image.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToDataFromPixelmapSequence(pixelmapSequence: Array<PixelMap>, options: PackingOptionsForSequence): Promise<ArrayBuffer>;
        /**
         * Compresses or packs an image into a file and uses a callback to return the result.
         *
         * @param { ImageSource } source Image to be processed.
         * @param { int } fd ID of a file descriptor.
         * @param { PackingOption } options Options for image packing.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid input parameter.
         * @throws { BusinessError } 62980119 - Failed to encode the image.
         * @throws { BusinessError } 62980120 - Add pixelmap out of range.
         * @throws { BusinessError } 62980172 - Failed to encode icc.
         * @throws { BusinessError } 62980252 - Failed to create surface.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToFile(source: ImageSource, fd: int, options: PackingOption, callback: AsyncCallback<void>): void;
        /**
         * Compresses or packs an image into a file and uses a promise to return the result.
         *
         * @param { ImageSource } source Image to be processed.
         * @param { int } fd ID of a file descriptor.
         * @param { PackingOption } options Options for image packing.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid input parameter.
         * @throws { BusinessError } 62980119 - Failed to encode the image.
         * @throws { BusinessError } 62980120 - Add pixelmap out of range.
         * @throws { BusinessError } 62980172 - Failed to encode icc.
         * @throws { BusinessError } 62980252 - Failed to create surface.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToFile(source: ImageSource, fd: int, options: PackingOption): Promise<void>;
        /**
         * Compresses or packs an image into a file and uses a callback to return the result.
         *
         * @param { PixelMap } source PixelMap to be processed.
         * @param { int } fd ID of a file descriptor.
         * @param { PackingOption } options Options for image packing.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid input parameter.
         * @throws { BusinessError } 62980119 - Failed to encode the image.
         * @throws { BusinessError } 62980120 - Add pixelmap out of range.
         * @throws { BusinessError } 62980172 - Failed to encode icc.
         * @throws { BusinessError } 62980252 - Failed to create surface.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToFile(source: PixelMap, fd: int, options: PackingOption, callback: AsyncCallback<void>): void;
        /**
         * Compresses or packs an image into a file and uses a promise to return the result.
         *
         * @param { PixelMap } source PixelMap to be processed.
         * @param { int } fd ID of a file descriptor.
         * @param { PackingOption } options Options for image packing.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 62980096 - The operation failed. Possible cause: 1.Image upload exception.
         * 2. Decoding process exception. 3. Insufficient memory.
         * @throws { BusinessError } 62980101 - The image data is abnormal.
         * @throws { BusinessError } 62980106 - The image data is too large. This status code is thrown when an error occurs during the process of checking size.
         * @throws { BusinessError } 62980113 - Unknown image format.
         * The image data provided is not in a recognized or supported format, or it may be occorrupted.
         * @throws { BusinessError } 62980115 - Invalid input parameter.
         * @throws { BusinessError } 62980119 - Failed to encode the image.
         * @throws { BusinessError } 62980120 - Add pixelmap out of range.
         * @throws { BusinessError } 62980172 - Failed to encode icc.
         * @throws { BusinessError } 62980252 - Failed to create surface.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToFile(source: PixelMap, fd: int, options: PackingOption): Promise<void>;
        /**
         * Compresses a Pixelmap sequence into gif.
         *
         * @param { Array<PixelMap> } pixelmapSequence PixelMaps to be encoded.
         * @param { int } fd File descriptor of the output encoded file.
         * @param { PackingOptionsForSequence } options Options for image packing.
         * @returns { Promise<void> } void.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types;3.Parameter verification failed.
         * @throws { BusinessError } 7800301 - Failed to encode image.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToFileFromPixelmapSequence(pixelmapSequence: Array<PixelMap>, fd: int, options: PackingOptionsForSequence): Promise<void>;
        
        /**
         * Releases an ImagePacker instance and uses a callback to return the result.
         *
         * @param { AsyncCallback<void> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        
        /**
         * Releases an ImagePacker instance and uses a promise to return the result.
         *
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        release(): Promise<void>;
        /**
         * Compresses or packs an image and uses a promise to return the result.
         *
         * @param { Picture } picture Picture to be processed.
         * @param { PackingOption } options Option for image packing.
         * @returns { Promise<ArrayBuffer> } A Promise instance used to return the compressed or packed data.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7800301 - Encode failed.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packing(picture: Picture, options: PackingOption): Promise<ArrayBuffer>;
        /**
         * Compresses or packs an image into a file and uses a promise to return the result.
         *
         * @param { Picture } picture Picture to be processed.
         * @param { int } fd ID of a file descriptor.
         * @param { PackingOption } options Options for image packing.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 7800301 - Encode failed.
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        packToFile(picture: Picture, fd: int, options: PackingOption): Promise<void>;
        
        /**
         * Supported image formats.
         *
         * @type { Array<string> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.ImagePacker
         * @since 20
         */
        readonly supportedFormats: Array<string>;
    }
    /**
     * Provides basic image operations, including obtaining image information, and reading and writing image data.
     *
     * @typedef Image
     * @syscap SystemCapability.Multimedia.Image.Core
     * @since 20
     */
    interface Image {
        /**
         * Sets or gets the image area to crop, default is size.
         *
         * @type { Region }
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        clipRect: Region;
        /**
         * Image size.
         *
         * @type { Size }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly size: Size;
        /**
         * Image format.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly format: int;
        /**
         * Image timestamp.
         *
         * @type { long }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        readonly timestamp: long;
        /**
         * Get component buffer from image and uses a callback to return the result.
         *
         * @param { ComponentType } componentType The component type of image.
         * @param { AsyncCallback<Component> } callback Callback used to return the component buffer.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getComponent(componentType: ComponentType, callback: AsyncCallback<Component>): void;
        /**
         * Get component buffer from image and uses a promise to return the result.
         *
         * @param { ComponentType } componentType The component type of image.
         * @returns { Promise<Component> } A Promise instance used to return the component buffer.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        getComponent(componentType: ComponentType): Promise<Component>;
        /**
         * Release current image to receive another and uses a callback to return the result.
         *
         * @param { AsyncCallback<void> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        /**
         * Release current image to receive another and uses a promise to return the result.
         *
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.Core
         * @since 20
         */
        release(): Promise<void>;
    }
    /**
     * Image receiver object.
     *
     * @typedef ImageReceiver
     * @syscap SystemCapability.Multimedia.Image.ImageReceiver
     * @since 20
     */
    interface ImageReceiver {
        /**
         * Image size.
         *
         * @type { Size }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        readonly size: Size;
        /**
         * Image capacity.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        readonly capacity: int;
        /**
         * Image format.
         *
         * @type { ImageFormat }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        readonly format: ImageFormat;
        /**
         * Get an id which indicates a surface and can be used to set to Camera or other component can receive a surface
         * and uses a callback to return the result.
         *
         * @param { AsyncCallback<string> } callback Callback used to return the surface id.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        getReceivingSurfaceId(callback: AsyncCallback<string>): void;
        /**
         * Get an id which indicates a surface and can be used to set to Camera or other component can receive a surface
         * and uses a promise to return the result.
         *
         * @returns { Promise<string> } A Promise instance used to return the surface id.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        getReceivingSurfaceId(): Promise<string>;
        /**
         * Get lasted image from receiver and uses a callback to return the result.
         *
         * @param { AsyncCallback<Image> } callback Callback used to return the latest image.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        readLatestImage(callback: AsyncCallback<Image>): void;
        /**
         * Get lasted image from receiver and uses a promise to return the result.
         *
         * @returns { Promise<Image> } A Promise instance used to return the latest image.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        readLatestImage(): Promise<Image>;
        /**
         * Get next image from receiver and uses a callback to return the result.
         *
         * @param { AsyncCallback<Image> } callback Callback used to return the next image.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        readNextImage(callback: AsyncCallback<Image>): void;
        /**
         * Get next image from receiver and uses a promise to return the result.
         *
         * @returns { Promise<Image> } A Promise instance used to return the next image.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        readNextImage(): Promise<Image>;
        /**
         * Subscribe callback when receiving an image
         *
         * @param { 'imageArrival' } type Callback used to return the next image.
         * @param { AsyncCallback<void> } callback Callback used to return image.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        on(type: 'imageArrival', callback: AsyncCallback<void>): void;
        /**
         * Remove callback subscriptions when releasing buffer
         *
         * @param { 'imageArrival' } type - Event type.
         * @param { AsyncCallback<void> } callback Callback to be removed.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        off(type: 'imageArrival', callback?: AsyncCallback<void>): void;
        /**
         * Release image receiver instance and uses a callback to return the result.
         *
         * @param { AsyncCallback<void> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        /**
         * Release image receiver instance and uses a promise to return the result.
         *
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageReceiver
         * @since 20
         */
        release(): Promise<void>;
    }
    /**
     * Image creator object.
     *
     * @typedef ImageCreator
     * @syscap SystemCapability.Multimedia.Image.ImageCreator
     * @since 20
     */
    interface ImageCreator {
        /**
         * Image capacity.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        readonly capacity: int;
        /**
         * Image format.
         *
         * @type { ImageFormat }
         * @readonly
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        readonly format: ImageFormat;
        /**
         * Apply for new graphic buffer from free queue and use a callback to return the result.
         *
         * @param { AsyncCallback<Image> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        dequeueImage(callback: AsyncCallback<Image>): void;
        /**
         * Apply for new graphic buffer from free queue and uses a promise to return the result.
         *
         * @returns { Promise<Image> } A Promise instance used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        dequeueImage(): Promise<Image>;
        /**
         * Queue buffer to dirty queue and uses a callback to return the result.
         *
         * @param { Image } image
         * @param { AsyncCallback<void> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        queueImage(image: Image, callback: AsyncCallback<void>): void;
        /**
         * Queue buffer to dirty queue and uses a promise to return the result.
         *
         * @param { Image } image
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        queueImage(image: Image): Promise<void>;
        /**
         * Subscribe callback when releasing buffer
         *
         * @param { 'imageRelease' } type Callback used to return the operation result.
         * @param { AsyncCallback<void> } callback Callback used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        on(type: 'imageRelease', callback: AsyncCallback<void>): void;
        /**
         * Remove callback subscriptions when releasing buffer
         *
         * @param { 'imageRelease' } type - Event type.
         * @param { AsyncCallback<void> } callback Callback to be removed.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        off(type: 'imageRelease', callback?: AsyncCallback<void>): void;
        /**
         * Releases buffer in bufferqueue instance and uses a callback to return the result.
         *
         * @param { AsyncCallback<void> } callback Callback to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        /**
         * Releases buffer in bufferqueue instance and uses a promise to return the result.
         *
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @syscap SystemCapability.Multimedia.Image.ImageCreator
         * @since 20
         */
        release(): Promise<void>;
    }
}
export default image;
