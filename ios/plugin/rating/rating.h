//
//  rating.h
//  rating
//
//  Created by Kyoz on 07/07/2023.
//

#ifndef RATING_H
#define RATING_H

#ifdef VERSION_4_0
#include "core/object/object.h"
#endif

#ifdef VERSION_3_X
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
