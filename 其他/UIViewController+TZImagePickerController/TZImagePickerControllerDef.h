//
//  TZImagePickerControllerDef.h
//  Shooting
//
//  Created by Jobs on 2021/4/21.
//  Copyright © 2021 Jobs. All rights reserved.
//

#ifndef TZImagePickerControllerDef_h
#define TZImagePickerControllerDef_h

///分别对应 TZLocationManager 的五种初始化方法
typedef enum : NSInteger {
    TZLocationManagerType_1,//startLocation
    TZLocationManagerType_2,//startLocationWithSuccessBlock/failureBlock
    TZLocationManagerType_3,//startLocationWithGeocoderBlock
    TZLocationManagerType_4,//startLocationWithSuccessBlock/failureBlock/geocoderBlock
} TZLocationManagerType;

///分别对应 TZImagePickerController 的五种初始化方法
typedef enum : NSInteger {
    TZImagePickerControllerType_1,//initWithMaxImagesCount/delegate/
    TZImagePickerControllerType_2,//initWithMaxImagesCount/columnNumber/delegate
    TZImagePickerControllerType_3,//initWithMaxImagesCount/columnNumber/delegate/pushPhotoPickerVc
    TZImagePickerControllerType_4,//initWithSelectedAssets/selectedPhotos/index
    TZImagePickerControllerType_5//initCropTypeWithAsset/photo/completion
} TZImagePickerControllerType;

#endif /* TZImagePickerControllerDef_h */
