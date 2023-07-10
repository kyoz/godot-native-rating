//
//  rating.m
//  rating
//
//  Created by Kyoz on 07/07/2023.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#ifdef VERSION_4_0
#include "core/object/class_db.h"
#else
#include "core/class_db.h"
#endif

#include "rating.h"

Rating *Rating::instance = NULL;

Rating::Rating() {
    instance = this;
    NSLog(@"initialize rating");
}

Rating::~Rating() {
    if (instance == this) {
        instance = NULL;
    }
    NSLog(@"deinitialize rating");
}

Rating *Rating::get_singleton() {
    return instance;
};


void Rating::_bind_methods() {
    ADD_SIGNAL(MethodInfo("completed"));
    ADD_SIGNAL(MethodInfo("error", PropertyInfo(Variant::STRING, "error_code")));
    
    ClassDB::bind_method("show", &Rating::show);
}

void Rating::show() {
    if (@available(iOS 14.0, *)) {
        UIWindowScene *scene = nil;
        
        for(UIWindowScene *s in UIApplication.sharedApplication.connectedScenes) {
            if (s.activationState == UISceneActivationStateForegroundActive) {
                scene = s;
                break;
            }
        }
        
        if (scene != nil) {
            [SKStoreReviewController requestReviewInScene:scene];
            emit_signal("completed");
        } else {
            emit_signal("error", "ERROR_NO_ACTIVE_SCENE");
        }
    } else if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
        emit_signal("completed");
    } else {
        emit_signal("error", "ERROR_UNKNOWN");
    }
}

