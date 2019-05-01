#include "database.h"

#include <iostream>

#include <realm/group_shared.hpp>
#include <results.hpp>

Database::Database(const char *name) : db_name(name)
{
	Realm::Config config;
	config.schema_version = 1;
	config.schema = Schema{
		{"object", {{"key", PropertyType::String, Property::IsPrimary{true}}, {"value", PropertyType::String}}},
	};
	config.path = name;
	this->realm = Realm::get_shared_realm(config);

	std::cout << "Creating database " << db_name << std::endl;
}

void Database::put(const char *key, const char *value)
{
	std::cout << "Put key: " << key << " value: " << value << std::endl;

	this->realm->begin_transaction();
	auto table = this->realm->read_group().get_table("class_object");
	auto row_ndx = table->add_empty_row();
	table->set_string(0, row_ndx, key);
	table->set_string(1, row_ndx, value);
	this->realm->commit_transaction();
}

const char *Database::get(const char *key)
{
	std::cout << "Get key: " << key << std::endl;

	Results results(this->realm,
					this->realm->read_group().get_table("class_object")->where().equal(0, key));
	if (results.size() == 1)
	{
		auto row = results.get(0);
		StringData value = row.get_string(1);
		return value.data();
	}
	return nullptr;
}