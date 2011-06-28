#include "TurnInfo.h"

// Json management
#include "json.h"

TurnInfo::TurnInfo(Json::Value & msg)
{
	// Retrieve current arena value
	m_currentArenaRadius = msg["parameters"]["arenaRadius"].asInt();
	// Iterate parameters
	const Json::Value players = msg["parameters"]["players"];
	for( unsigned int i = 0 ; i<players.size() ; ++i )
	{
		m_playerList.push_back( Player( players[i] ) );
	}

}

const std::vector<Player>& TurnInfo::getPlayerList() const
{
	return m_playerList;
}

int TurnInfo::getCurrentArenaRadius() const
{
	return m_currentArenaRadius;
}

const Player& TurnInfo::getPlayer(int index) const
{
	if( index < m_playerList.size() )
	{
		return m_playerList.at(index);
	}
	else
	{
		throw std::exception("Incorrect player index");
	}
}


