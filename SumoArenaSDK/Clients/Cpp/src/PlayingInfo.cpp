#include "PlayingInfo.h"

// Json management
#include "json.h"

PlayingInfo::PlayingInfo(Json::Value & msg)
{
	// Retrieve current arena value
	m_currentArenaRadius = msg["parameters"]["arenaRadius"].asInt();
	// Iterate parameters
	const Json::Value players = msg["parameters"]["players"];
	for( unsigned int i = 0 ; i<players.size() ; ++i )
	{
		m_sphereList.push_back( Sphere( players[i] ) );
	}

}

const std::vector<Sphere>& PlayingInfo::getSphereList() const
{
	return m_sphereList;
}

int PlayingInfo::getCurrentArenaRadius() const
{
	return m_currentArenaRadius;
}

const Sphere& PlayingInfo::getSphere(int index) const
{
	if( index < m_sphereList.size() )
	{
		return m_sphereList.at(index);
	}
	else
	{
		throw std::exception("Incorrect player index");
	}
}


