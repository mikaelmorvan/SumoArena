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

// Type 
typedef std::vector<Sphere> t_SphereList;

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

	const t_SphereList& getSphereList() const;
	int getCurrentArenaRadius() const;

protected:
	t_SphereList m_sphereList;
	int m_currentArenaRadius;

};

#endif // PLAYING_INFO_H

