#include "RoundInfo.h"


RoundInfo::RoundInfo():
m_index(0),
m_playerCount(0),
m_sphereRadius(0),
m_maxSpeedVariation(0),
m_arenaInitialRadius(0),
m_currentRound(0),
m_roundForVictory(0)
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
	m_roundForVictory = msg["parameters"]["roundForVictory"].asInt();
}

int RoundInfo::getAlgoIndex() const
{
	return m_index;
}

int RoundInfo::getPlayerCount() const
{
	return m_playerCount;
}

int RoundInfo::getSphereRadius() const
{
	return m_sphereRadius;
}

int RoundInfo::getMaxSpeedVariation() const
{
	return m_maxSpeedVariation;
}

int RoundInfo::getArenaInitialRadius() const
{
	return m_arenaInitialRadius;
}

int RoundInfo::getCurrentRound() const
{
	return m_currentRound;
}

int RoundInfo::getRoundForVictory() const
{
	return m_roundForVictory;
}

///////////////////////////////////////////////////////
// EndRoundInfo
///////////////////////////////////////////////////////
EndRoundInfo::EndRoundInfo():
m_currentRound(0),
m_roundWinnerIndex(0),
m_gameWinnerIndex(0)
{
}

EndRoundInfo::EndRoundInfo( Json::Value & msg)
{
	m_currentRound = msg["parameters"]["currentRound"].asInt();
	m_roundWinnerIndex = msg["parameters"]["roundWinnerIndex"].asInt();
	m_gameWinnerIndex = msg["parameters"]["gameWinnerIndex"].asInt();

}

int EndRoundInfo::getCurrentRound() const
{
	return m_currentRound;
}

int EndRoundInfo::getRoundWinnerIndex() const
{
	return m_roundWinnerIndex;
}

int EndRoundInfo::getGameWinnerIndex() const
{
	return m_gameWinnerIndex;
}
