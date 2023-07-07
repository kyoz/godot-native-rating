//
//  rating.m
//  rating
//
//  Created by Kyoz on 07/07/2023.
//

#include "rating.h"
#import <Foundation/Foundation.h>


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
}

void Rating::show() {
    emit_signal("completed");
}

