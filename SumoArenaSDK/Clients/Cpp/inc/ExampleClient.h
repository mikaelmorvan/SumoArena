#ifndef EXAMPLE_CLIENT_H
#define EXAMPLE_CLIENT_H

// Everything needed is already included in IPlayer
#include "IPlayer.h"

/**
* Example of a client algorithm implementation
*
* The implementation must implement playTurn() method to play.
*
*/
class ExampleClient : public IPlayer
{
public:
	/**
	* Received at the beginning of a round
	* @param roundInfo general information regarding the current round (arena start radius, sphere radius, etc.)
	*/
	virtual void onRoundStart( const RoundStartInfo & roundInfo ) ;
	
	/**
	* Received at the end of a round
	* @param roundInfo general information regarding the round results
	*/
	virtual void onRoundStop( const RoundEndInfo & roundInfo ) ;
	
	/**
	* Play a round turn and determine the modification to apply to sphere
	* @param playingInfo all necessary information regarding the current turn
	* @param out_dvX [out] set the desired X component of the acceleration vector 
	* @param out_dvY [out] set the desired X component of the acceleration vector 
	*/
	virtual void playRequest( const PlayingInfo & playingInfo, int & out_dvX, int & out_dvY );

protected:
	RoundStartInfo m_currentRoundInfo;
};

#endif // EXAMPLE_CLIENT_H

