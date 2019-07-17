#ifndef __WRAPPER_H__
#define __WRAPPER_H__

#ifdef __cplusplus
extern "C"
{
#endif

    struct database;
    struct realm_object;
    struct realm_results;
    typedef struct database database_t;
    typedef struct realm_object realm_object_t;
    typedef struct realm_results realm_results_t;

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

    // ***********       QUERY     *********** //
    realm_results_t* query(database_t *db_ptr, const char *object_type, const char* query);
    size_t realmresults_size(realm_results_t *realm_results_ptr);
    realm_object_t* realmresults_get(realm_results_t *realm_results_ptr, const char* object_type, size_t row_ndx);

#ifdef __cplusplus
}
#endif

#endif /* __WRAPPER_H__ */