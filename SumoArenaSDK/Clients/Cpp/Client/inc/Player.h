/**
* Round information
*  Object  transmitted to client to compute its algorithm
*/
#ifndef PLAYER_H
#define PLAYER_H

// Json management
#include "json.h"

/**
* Represents a player in the arena.
* Has properties for its position, speed, direction, etc.
*/
class Player
{
public:
	/**
	* Initialize the object from a Json message
	* @param playerMsg internal player specific infor from the Json message
	*/
	Player(const Json::Value & playerMsg);

	// Accessors
	int getIndex() const;
	int getX() const;
	int getY() const;
	int getvX() const;
	int getvY() const;
	bool isInArena() const;
protected:
	int m_index; ///< index of the player
	int m_x; ///< x position of the player
	int m_y; ///< y position of the player
	int m_vx; ///< horizontal speed of the player
	int m_vy; ///< vertical speed of the player
	bool m_inArena; ///< indicate whether the player is in the arena or not

};

#endif // PLAYER_H

