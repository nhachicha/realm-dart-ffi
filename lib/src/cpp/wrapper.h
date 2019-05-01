#ifndef __WRAPPER_H__
#define __WRAPPER_H__

#ifdef __cplusplus
extern "C" {
#endif

struct database;
typedef struct database database_t;

database_t *wrapper_create(const char* db_name);
void wrapper_destroy(database_t *db_ptr);

void wrapper_put(database_t *db_ptr, const char* key, const char* value);
const char* wrapper_get(database_t *db_ptr, const char* key);

#ifdef __cplusplus
}
#endif

#endif /* __WRAPPER_H__ */