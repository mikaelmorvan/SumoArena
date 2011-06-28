/**
* Round information
*  Object  transmitted to client to compute its algorithm
*/
#ifndef TURN_INFO_H
#define TURN_INFO_H

#include <vector>
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

	/**
	* Return information for a specific player
	*/
	const Player& getPlayer(int index) const;

	const std::vector<Player>& getPlayerList() const;
	int getCurrentArenaRadius() const;

protected:
	std::vector<Player> m_playerList;
	int m_currentArenaRadius;

};

#endif // TURN_INFO_H

