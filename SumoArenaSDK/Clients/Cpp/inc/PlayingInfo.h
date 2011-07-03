/**
* Round information
*  Object  transmitted to client to compute its algorithm
*/
#ifndef PLAYING_INFO_H
#define PLAYING_INFO_H

#include <vector>
#include "Sphere.h"
// Json management
#include "json.h"

/**
* Represent information sent to the player to compute a round
* 
*/
class PlayingInfo
{
public:
	/**
	* Initialize the object from a Json message
	*/
	PlayingInfo(Json::Value & msg);

	/**
	* Return information for a specific sphere
	*/
	const Sphere& getSphere(int index) const;

	const std::vector<Sphere>& getSphereList() const;
	int getCurrentArenaRadius() const;

protected:
	std::vector<Sphere> m_sphereList;
	int m_currentArenaRadius;

};

#endif // PLAYING_INFO_H

