#ifndef __WRAPPER_H__
#define __WRAPPER_H__

#ifdef __cplusplus
extern "C"
{
#endif

    struct database;
    struct realm_object;
    typedef struct database database_t;
    typedef struct realm_object realm_object_t;

    database_t *create(const char *db_name, const char *schema);
    void destroy(database_t *db_ptr);

    // ***********      REALM      *********** //
    
    void begin_transaction(database_t *db_ptr);
    void commit_transaction(database_t *db_ptr);
    void cancel_transaction(database_t *db_ptr);

    // *********** OBJECT ACCESSOR *********** //

    // create an Object of type 'object_type' and return its pointer 
    realm_object_t* add_object(database_t *db_ptr, const char *object_type);
    
    int8_t object_get_bool(realm_object_t *obj_ptr, const char* property_name);
    int64_t object_get_int64(realm_object_t *obj_ptr, const char* property_name);
    double object_get_double(realm_object_t *obj_ptr, const char* property_name);
    const char* object_get_string(realm_object_t *obj_ptr, const char* property_name);

    void object_set_bool(realm_object_t *obj_ptr, const char* property_name, int8_t value);
    void object_set_int64(realm_object_t *obj_ptr, const char* property_name, int64_t value);
    void object_set_double(realm_object_t *obj_ptr, const char* property_name, double value);
    void object_set_string(realm_object_t *obj_ptr, const char* property_name, const char* value);

#ifdef __cplusplus
}
#endif

#endif /* __WRAPPER_H__ */