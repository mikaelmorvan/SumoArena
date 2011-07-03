#include "Sphere.h"


Sphere::Sphere( const Json::Value & msg)
{
	m_index = msg["index"].asInt();
	m_x = msg["x"].asInt();
	m_y = msg["y"].asInt();
	m_vx = msg["vx"].asInt();
	m_vy = msg["vy"].asInt();
	m_inArena = msg["inArena"].asBool();
}

int Sphere::getIndex() const
{
	return m_index;
}

int Sphere::getX() const
{
	return m_x;
}

int Sphere::getY() const
{
	return m_y;
}

int Sphere::getvX() const
{
	return m_vx;
}

int Sphere::getvY() const
{
	return m_vy;
}

bool Sphere::isInArena() const
{
	return m_inArena;
}

