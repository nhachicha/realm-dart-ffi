#include "database.h"

#include <realm/group_shared.hpp>
#include <results.hpp>

#include <iostream>
#include <json.hpp>

using json = nlohmann::json;

Database::Database(const char *name, const char* schema)
{
	std::cout << "received json: " << schema << std::endl;
	auto json = json::parse(schema);

	// TODO create schema using the parsed JSON array
	for (auto it : json)
	{
		std::cout << "Table name: " << it["name"] << std::endl;
		std::cout << "Properties: " << std::endl;
		for (auto& el : it["properties"].items()) {
			std::cout << el.key() << " : " << el.value() << std::endl;
		}		
	}

	// dummy schema 
	Realm::Config config;
	config.schema_version = 1;
	config.schema = Schema{
		//{"Dog", {{"name", PropertyType::String, Property::IsPrimary{true}}, {"value", PropertyType::String}}},
		{"Dog", {{"name", PropertyType::String}}},
	};
	config.path = name;
	this->m_realm = Realm::get_shared_realm(config);
}