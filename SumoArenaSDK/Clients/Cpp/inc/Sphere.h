/**
* Round information
*  Object  transmitted to client to compute its algorithm
*/
#ifndef SPHERE_H
#define SPHERE_H

// Json management
#include "json.h"

/**
* Represents a Sphere in the arena.
* Has properties for its position, speed, direction, etc.
*/
class Sphere
{
public:
	/**
	* Initialize the object from a Json message
	* @param SphereMsg internal Sphere specific infor from the Json message
	*/
	Sphere(const Json::Value & sphereMsg);

	// Accessors
	int getIndex() const;
	int getX() const;
	int getY() const;
	int getvX() const;
	int getvY() const;
	bool isInArena() const;
protected:
	int m_index; ///< index of the Sphere
	int m_x; ///< x position of the Sphere
	int m_y; ///< y position of the Sphere
	int m_vx; ///< horizontal speed of the Sphere
	int m_vy; ///< vertical speed of the Sphere
	bool m_inArena; ///< indicate whether the Sphere is in the arena or not

};

#endif // SPHERE_H

