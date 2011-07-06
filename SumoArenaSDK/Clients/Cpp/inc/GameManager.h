#ifndef GAME_MANAGER_H
#define GAME_MANAGER_H

#include <string>

class IPlayer;

/**
* Main class managing game loop.
* Handle server communication and running game loop.
*
*/
class GameManager
{
public:
	/**
	* Build a GameManager.
	* @param serverName name of the server (network name: "localhost" for example)
	* @param serverPort port used by the server (ex: 9090)
	*/
	GameManager(const std::string & serverName, const std::string & serverPort);
	virtual ~GameManager();

	/**
	* Starts the game loop, and only returns when the game is over
	* Synchronous method that runs the game loop (listen to server/ send command)
	* @param playerName name of the player sent to the server
	* @param algo instance of the algorithm used for the game
	*/
	void startLoop( const std::string & playerName, IPlayer & algo );

private:
	std::string m_serverName;
	std::string m_serverPort;

};


#endif // GAME_MANAGER_H
