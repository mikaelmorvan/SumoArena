/**
* Round information
*  Object  transmitted to client to compute its algorithm
*/
#ifndef ROUND_INFO_H
#define ROUND_INFO_H

#include <list>
// Json management
#include "json.h"

/**
* Represent information sent to the player to compute a round
* 
*/
class RoundInfo
{
public:
	RoundInfo();
	RoundInfo( Json::Value & msg );

	int getAlgoIndex() const;
	int getPlayerCount() const;
	int getSphereRadius() const;
	int getMaxSpeedVariation() const;
	int getArenaInitialRadius() const;
	int getCurrentRound() const;
	int getRoundForVictory() const;

protected:
	int m_index;
	int m_playerCount;
	int m_sphereRadius;
	int m_maxSpeedVariation;
	int m_arenaInitialRadius;
	int m_currentRound;
	int m_roundForVictory;
};

/**
* Information received at the end of a round
*/
class EndRoundInfo
{
public:
	EndRoundInfo();
	EndRoundInfo( Json::Value & msg );

	int getCurrentRound() const;
	int getRoundWinnerIndex() const;
	int getGameWinnerIndex() const;

protected:
	int m_currentRound;
	int m_roundWinnerIndex;
	int m_gameWinnerIndex;
};

#endif // ROUND_INFO_H

