#ifndef IPLAYER_H
#define IPLAYER_H


#include "PlayingInfo.h"
#include "RoundInfo.h"

/**
* Client interface from the GameManager.
* Called each turn to ask algorithm for its next move
*
*/
class IPlayer
{
public:

	/**
	* Received at the beginning of a round
	* @param roundInfo general information regarding the current round (arena start radius, sphere radius, etc.)
	*/
	virtual void onRoundStart( const RoundStartInfo & roundInfo ) = 0;
	
	/**
	* Received at the end of a round
	* @param roundInfo general information regarding the round results
	*/
	virtual void onRoundStop( const RoundEndInfo & roundInfo ) = 0;

	/**
	* Play a round turn and determine the modification to apply to sphere
	* @param playingInfo all necessary information regarding the current turn
	* @param out_dvX [out] set the desired X component of the acceleration vector 
	* @param out_dvY [out] set the desired X component of the acceleration vector 
	*/
	virtual void playRequest( const PlayingInfo & playingInfo, int & out_dvX, int & out_dvY ) = 0;

};

#endif // IPLAYER_H
