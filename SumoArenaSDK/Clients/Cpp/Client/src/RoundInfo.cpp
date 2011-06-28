#include "RoundInfo.h"


RoundInfo::RoundInfo():
m_index(0),
m_playerCount(0),
m_sphereRadius(0),
m_maxSpeedVariation(0),
m_arenaInitialRadius(0),
m_currentRound(0),
m_roundForVistory(0)
{
}

RoundInfo::RoundInfo( Json::Value & msg)
{
	m_index = msg["parameters"]["yourIndex"].asInt();
	m_playerCount = msg["parameters"]["playerCount"].asInt();
	m_sphereRadius = msg["parameters"]["sphereRadius"].asInt();
	m_maxSpeedVariation = msg["parameters"]["maxSpeedVariation"].asInt();
	m_arenaInitialRadius = msg["parameters"]["arenaInitialRadius"].asInt();
	m_currentRound = msg["parameters"]["currentRound"].asInt();
	m_roundForVistory = msg["parameters"]["roundForVictory"].asInt();
}



EndRoundInfo::EndRoundInfo( Json::Value & msg)
{
	m_currentRound = msg["parameters"]["currentRound"].asInt();
	m_roundWinnerIndex = msg["parameters"]["roundWinnerindex"].asInt();
	m_gameWinnerIndex = msg["parameters"]["galeWinnerindex"].asInt();

}
