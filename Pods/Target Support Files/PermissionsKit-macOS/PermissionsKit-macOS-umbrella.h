#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MPAuthorizationStatus.h"
#import "MPPermissionsKit.h"
#import "MPPermissionType.h"
#import "PermissionsKit.h"

FOUNDATION_EXPORT double PermissionsKitVersionNumber;
FOUNDATION_EXPORT const unsigned char PermissionsKitVersionString[];

