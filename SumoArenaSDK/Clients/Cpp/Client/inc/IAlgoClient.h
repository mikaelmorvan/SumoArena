#ifndef ALGO_CLIENT_H
#define ALGO_CLIENT_H


#include "TurnInfo.h"
#include "RoundInfo.h"

/**
* Client interface from the GameManager.
* Called each turn to ask algorithm for its next move
*
*/
class IAlgoClient
{
public:
	/**
	* Play a round turn and determine the modification to apply to sphere
	* @param roundInfo general information regarding the current round (arena start radius, sphere radius, etc.)
	* @param turnInfo all necessary information regarding the current turn
	* @param out_dvX [out] set the desired X component of the acceleration vector 
	* @param out_dvY [out] set the desired X component of the acceleration vector 
	*/
	virtual void playTurn( const RoundInfo & roundInfo, const TurnInfo & turnInfo, int & out_dvX, int & out_dvY ) = 0;

};

#endif // ALGO_CLIENT_H
