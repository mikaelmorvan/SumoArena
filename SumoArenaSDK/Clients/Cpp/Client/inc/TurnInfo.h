/**
* Round information
*  Object  transmitted to client to compute its algorithm
*/
#ifndef TURN_INFO_H
#define TURN_INFO_H

#include <list>
#include "Player.h"
// Json management
#include "json.h"

/**
* Represent information sent to the player to compute a round
* 
*/
class TurnInfo
{
public:
	/**
	* Initialize the object from a Json message
	*/
	TurnInfo(Json::Value & msg);

	const std::list<Player>& getPlayerList() const;
	int getCurrentArenaRadius() const;

protected:
	std::list<Player> m_playerList;
	int m_currentArenaRadius;

};

#endif // TURN_INFO_H

