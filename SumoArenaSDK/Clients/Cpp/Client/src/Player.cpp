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
