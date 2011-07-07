#include "ExampleClient.h"
#include "RoundInfo.h"


/*virtual*/ void ExampleClient::onRoundStart(const RoundStartInfo & roundInfo)
{
	m_currentRoundInfo = roundInfo;

	std::cout << "Round: " << roundInfo.getCurrentRound() << " started." << std::endl;
}

/*virtual*/ void ExampleClient::onRoundStop(const RoundEndInfo & roundInfo)
{
	std::cout << "Round " << roundInfo.getCurrentRound() << " finished:" << std::endl;
	std::cout << "- Round winner is " << roundInfo.getRoundWinnerIndex() << std::endl;
	std::cout << "- Game winner is " << roundInfo.getGameWinnerIndex() << std::endl;
}

/*
* Example of a client implementation
*
* Modify out_dvX and out_dvY to affect player acceleration
*/
void ExampleClient::playRequest( const PlayingInfo & playingInfo, int & out_dvX, int & out_dvY )
{	
	// Retrieve my own sphere
	const Sphere & me = playingInfo.getSphere(m_currentRoundInfo.getAlgoIndex());

	// Retrieve all spheres list
	const std::vector<Sphere> & sphereList = playingInfo.getSphereList();

	// Retrieve current arena radius (that reduces over time)
	int arenaRadius = playingInfo.getCurrentArenaRadius();

	// Set an acceleration across X and Y
	out_dvX = 3;
	out_dvY = 1;

}
