// #include <stdlib.h>
#include <iostream>
#include "wrapper.h"
#include "database.h"

#define typeof __typeof__

struct database {
	void *db;
};

database_t *wrapper_create(const char* db_name)
{
	database_t *db_ptr;
	Database *db;

	db_ptr      = (typeof(db_ptr))malloc(sizeof(*db_ptr));
	db    = new Database(db_name);
	db_ptr->db = db;

	return db_ptr;
}

void wrapper_destroy(database_t *db_ptr)
{
	if (db_ptr == NULL)
		return;
	std::cout << "Closing database " << std::endl;	 
	delete static_cast<Database *>(db_ptr->db);
	free(db_ptr);
}

void wrapper_put(database_t *db_ptr, const char* key, const char* value)
{
	Database *db;

	if (db_ptr == NULL)
		return;

	db = static_cast<Database *>(db_ptr->db);
	db->put(key, value);
}

const char* wrapper_get(database_t *db_ptr, const char* key)
{
	Database *db;

	if (db_ptr == NULL)
		return 0;

	db = static_cast<Database *>(db_ptr->db);
	return db->get(key);
}