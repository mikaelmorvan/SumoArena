/**
* Round information
*  Object  transmitted to client to compute its algorithm
*/
#ifndef ROUND_INFO_H
#define ROUND_INFO_H

#include <list>
// Json management
#include "json/json.h"

/**
* Represent information sent to the player to compute a round
* 
*/
class RoundInfo
{
public:
	RoundInfo();
	RoundInfo( Json::Value & msg );
protected:
	int m_index;
	int m_playerCount;
	int m_sphereRadius;
	int m_maxSpeedVariation;
	int m_arenaInitialRadius;
	int m_currentRound;
	int m_roundForVistory;
};

/**
* Information received at the end of a round
*/
class EndRoundInfo
{
public:
	EndRoundInfo();
	EndRoundInfo( Json::Value & msg );
protected:
	int m_currentRound;
	int m_roundWinnerIndex;
	int m_gameWinnerIndex;
};

#endif // ROUND_INFO_H

