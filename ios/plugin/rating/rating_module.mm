//
//  rating_module.m
//  rating
//
//  Created by Kyoz on 10/07/2023.
//


#ifdef VERSION_4_0
#include "core/config/engine.h"
#else
#include "core/engine.h"
#endif


#include "rating_module.h"

Rating * rating;

void register_rating_types() {
    rating = memnew(Rating);
    Engine::get_singleton()->add_singleton(Engine::Singleton("Rating", rating));
};

void unregister_rating_types() {
    if (rating) {
        memdelete(rating);
    }
}
