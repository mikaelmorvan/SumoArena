#include "GameManager.h"

#include "IAlgoClient.h"
#include <iostream>
// Json management
#include "json.h"

// Boos is used for socket i/o operations
#include <boost/array.hpp>
#include <boost/asio.hpp>
using boost::asio::ip::tcp;


GameManager::GameManager(const std::string & serverName, const std::string & serverPort):
m_serverName(serverName),
	m_serverPort(serverPort)
{
}
GameManager::~GameManager()
{
}

void GameManager::startLoop( const std::string & playerName, IAlgoClient & algo )
{
	// Try to use boost::asio to connect to the server
	boost::asio::io_service io_service;
	tcp::resolver resolver( io_service );

	tcp::resolver::query query(tcp::v4(), m_serverName, m_serverPort );

	// Iterate endpoints returnes by the resolver (can contain ipv4 and ipv6 endpoints)
	tcp::resolver::iterator endpoint_iterator = resolver.resolve(query);
	tcp::resolver::iterator end;

	tcp::socket socket(io_service);

	boost::system::error_code error = boost::asio::error::host_not_found;
	while (error && endpoint_iterator != end)
	{
		socket.close();
		socket.connect(*endpoint_iterator++, error);
	}
	if (error)
		throw boost::system::system_error(error);

	// Connected to server
	// send connection information
	Json::Value connectValue;
	connectValue["action"] = "connectPlayer";
	connectValue["parameters"]["name"] = playerName;
	std::string text = connectValue.toStyledString();

	// Send welcome message
	boost::asio::write( socket, boost::asio::buffer(text.c_str(), text.size()+1) );

	// wait for the server ack
	boost::array<char, 2048> buf;

	RoundInfo roundInfo;

	bool keepGoing(true);
	while( keepGoing )
	{
		size_t len = socket.read_some(boost::asio::buffer(buf), error);

		// Discard message if no content
		if( len == 0 )
			continue;

		// Parse server message with Json
		Json::Reader reader;
		Json::Value msg;
		bool res = reader.parse( buf.c_array() , msg ); 

		if (res && !msg.isNull() )
		{
			// Interpret action

			if( msg["action"].asString() == "play" )
			{
				int dX(0);
				int dY(0);

				// Call the playAction
				algo.playTurn( roundInfo, TurnInfo(msg), dX, dY );

				// Playing round, modify vector by sending an "updateVector" message
				Json::Value playValue;
				playValue["action"] = "updateVector";
				playValue["parameters"]["dVx"] = dX;
				playValue["parameters"]["dVy"] = dY;

				std::string text = playValue.toStyledString();

				// send message to server
				boost::asio::write( socket, boost::asio::buffer(text.c_str(), text.size()+1) );

			}
			else if( msg["action"].asString() == "acknowledgeConnection" )
			{
				std::cout << "Connection accepted with name " << msg["parameters"]["yourName"] << std::endl;
			}
			else if( msg["action"].asString() == "prepare" )
			{
				std::cout << "Received round prepare message" << std::endl;

				// Initialize round information
				roundInfo = RoundInfo(msg);
			
			}
			else if( msg["action"].asString() == "finishRound" )
			{
				EndRoundInfo info(msg);
				std::cout << "Round finished." << std::endl;
				std::cout << "- Round winner is " << msg["parameters"]["roundWinnerindex"] << std::endl;
				std::cout << "- Game winner is " << msg["parameters"]["gameWinnerindex"] << std::endl;

			}
			else
			{
				std::cout << "Unhandled action (" << msg["action"].asString() << "). Ignoring action" << std::endl;
			}

		}

		int round = msg["parameters"]["currentRound"].asInt();
	}
}



