//
//  CZMacros.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#ifdef __cplusplus
	#define CZKIT_EXTERN extern "C" __attribute__((visibility ("default")))
#else
	#define CZKIT_EXTERN extern __attribute__((visibility ("default")))
#endif

#define CZKIT_STATIC_INLINE	static inline
#define	CZKIT_EXTERN_CLASS __attribute__((visibility("default")))

#define CGAutorelease(x) (__typeof(x))[NSMakeCollectable(x) autorelease]

#if TARGET_OS_IPHONE
#define CZ_DYNAMIC_TYPE(macType, iOSType) iOSType
#else
#define CZ_DYNAMIC_TYPE(macType, iOSType) macType
#endif