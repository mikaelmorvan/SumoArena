#ifndef GAME_MANAGER_H
#define GAME_MANAGER_H

#include <string>

class IAlgoClient;


class GameManager
{
public:
	GameManager(const std::string & serverName, const std::string & serverPort);
	virtual ~GameManager();

	void startLoop( const std::string & playerName, IAlgoClient & algo );

private:
	std::string m_serverName;
	std::string m_serverPort;

};


#endif // GAME_MANAGER_H
