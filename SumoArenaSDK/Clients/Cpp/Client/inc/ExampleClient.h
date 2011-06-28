#ifndef EXAMPLE_CLIENT_H
#define EXAMPLE_CLIENT_H


#include "TurnInfo.h"
#include "IAlgoClient.h"

/**
* Client interface from the GameManager.
* Called each turn to ask algorithm for its next move
*
*/
class ExampleClient : public IAlgoClient
{
public:
	/**
	* Play a round turn and determine the modification to apply to sphere
	* @param turnInfo all necessary information regarding the current turn
	* @param out_dvX [out] set the desired X component of the acceleration vector 
	* @param out_dvY [out] set the desired X component of the acceleration vector 
	*/
	void playTurn( const RoundInfo & roundInfo, const TurnInfo & turnInfo, int & out_dvX, int & out_dvY );
};

#endif // EXAMPLE_CLIENT_H

