#ifndef __DATABASE_H__
#define __DATABASE_H__

#include <shared_realm.hpp>

using namespace realm;

class Database
{
public:
	// Database(const char *name);
	Database(const char *name, const char* schema);
	void put(const char *key, const char *value);
	const char *get(const char *key);
	SharedRealm const& realm() const { return m_realm; }
	
private:
	// const char *db_name;
	SharedRealm m_realm;
};

#endif // __DATABASE_H__