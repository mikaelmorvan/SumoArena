#include "Player.h"


Player::Player( const Json::Value & msg)
{
	m_index = msg["index"].asInt();
	m_x = msg["x"].asInt();
	m_y = msg["y"].asInt();
	m_vx = msg["vx"].asInt();
	m_vy = msg["vy"].asInt();
	m_inArena = msg["inArena"].asBool();
}

int Player::getIndex() const
{
	return m_index;
}

int Player::getX() const
{
	return m_x;
}

int Player::getY() const
{
	return m_y;
}

int Player::getvX() const
{
	return m_vx;
}

int Player::getvY() const
{
	return m_vy;
}

bool Player::isInArena() const
{
	return m_inArena;
}

