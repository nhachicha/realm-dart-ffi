#ifndef __DATABASE_H__
#define __DATABASE_H__

#include <shared_realm.hpp>

using namespace realm;

class Database
{
	public:
		Database(const char* name);
		void put(const char* key, const char* value);
		const char* get(const char* key);
        	// int value;
	private:		
        	const char* db_name;
		SharedRealm realm;
};

#endif // __DATABASE_H__