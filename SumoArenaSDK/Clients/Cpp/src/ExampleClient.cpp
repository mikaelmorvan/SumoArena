#include "ExampleClient.h"
#include "RoundInfo.h"


/*virtual*/ void ExampleClient::onRoundStart(const RoundStartInfo & roundInfo)
{
	m_currentRoundInfo = roundInfo;
}

/*virtual*/ void ExampleClient::onRoundStop(const RoundEndInfo & roundInfo)
{
	// 
}


/*
* Example of a client implementation
*
*/
void ExampleClient::playRequest( const PlayingInfo & playingInfo, int & out_dvX, int & out_dvY )
{
	// Set a X acceleration of 10
	out_dvX = 2;

	const Sphere & me = playingInfo.getSphere(m_currentRoundInfo.getAlgoIndex());



}