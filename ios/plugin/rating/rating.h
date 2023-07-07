//
//  rating.h
//  rating
//
//  Created by Kyoz on 07/07/2023.
//

#ifndef RATING_H
#define RATING_H

#include "core/version.h"

#if VERSION_MAJOR == 4
#include "core/object/class_db.h"
#else
#include "core/object.h"
#endif

class Rating : public Object {

    GDCLASS(Rating, Object);

    static Rating *instance;

public:
    void show();

    static Rating *get_singleton();
    
    Rating();
    ~Rating();

protected:
    static void _bind_methods();
};

#endif
