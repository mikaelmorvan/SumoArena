#include "RoundInfo.h"


RoundStartInfo::RoundStartInfo():
m_index(0),
m_playerCount(0),
m_sphereRadius(0),
m_maxSpeedVariation(0),
m_arenaInitialRadius(0),
m_currentRound(0),
m_roundForVictory(0)
{
}

RoundStartInfo::RoundStartInfo( Json::Value & msg)
{
	m_index = msg["parameters"]["yourIndex"].asInt();
	m_playerCount = msg["parameters"]["playerCount"].asInt();
	m_sphereRadius = msg["parameters"]["sphereRadius"].asInt();
	m_maxSpeedVariation = msg["parameters"]["maxSpeedVariation"].asInt();
	m_arenaInitialRadius = msg["parameters"]["arenaInitialRadius"].asInt();
	m_currentRound = msg["parameters"]["currentRound"].asInt();
	m_roundForVictory = msg["parameters"]["roundForVictory"].asInt();
}

int RoundStartInfo::getAlgoIndex() const
{
	return m_index;
}

int RoundStartInfo::getPlayerCount() const
{
	return m_playerCount;
}

int RoundStartInfo::getSphereRadius() const
{
	return m_sphereRadius;
}

int RoundStartInfo::getMaxSpeedVariation() const
{
	return m_maxSpeedVariation;
}

int RoundStartInfo::getArenaInitialRadius() const
{
	return m_arenaInitialRadius;
}

int RoundStartInfo::getCurrentRound() const
{
	return m_currentRound;
}

int RoundStartInfo::getRoundForVictory() const
{
	return m_roundForVictory;
}

///////////////////////////////////////////////////////
// RoundEndInfo
///////////////////////////////////////////////////////
RoundEndInfo::RoundEndInfo():
m_currentRound(0),
m_roundWinnerIndex(0),
m_gameWinnerIndex(0)
{
}

RoundEndInfo::RoundEndInfo( Json::Value & msg)
{
	m_currentRound = msg["parameters"]["currentRound"].asInt();
	m_roundWinnerIndex = msg["parameters"]["roundWinnerIndex"].asInt();
	m_gameWinnerIndex = msg["parameters"]["gameWinnerIndex"].asInt();

}

int RoundEndInfo::getCurrentRound() const
{
	return m_currentRound;
}

int RoundEndInfo::getRoundWinnerIndex() const
{
	return m_roundWinnerIndex;
}

int RoundEndInfo::getGameWinnerIndex() const
{
	return m_gameWinnerIndex;
}
