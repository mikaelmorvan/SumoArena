#include "GameManager.h"

#include "IPlayer.h"
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

void GameManager::startLoop( IPlayer & player, const std::string & playerName, const std::string & avatarUrl /* = "" */ )
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
	connectValue["parameters"]["avatarUrl"] = avatarUrl;
	std::string text = connectValue.toStyledString();

	// Send welcome message
	boost::asio::write( socket, boost::asio::buffer(text.c_str(), text.size()+1) );

	// wait for the server ack
	boost::array<char, 2048> buf;

	// Loop on listening to socket messages
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

		if (res && !msg.isNull() && !msg["action"].isNull() )
		{
			// Interpret action
			if( msg["action"].asString() == "play" )
			{
				int dX(0);
				int dY(0);

				// Call the playAction
				player.playRequest( PlayingInfo(msg), dX, dY );

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
				// Initialize round information
				player.onRoundStart( RoundStartInfo(msg) );
			}
			else if( msg["action"].asString() == "finishRound" )
			{
				player.onRoundStop(RoundEndInfo(msg) );
			}
			else
			{
				std::cout << "Unhandled action (" << msg["action"].asString() << "). Ignoring action" << std::endl;
			}

		}
		else
		{
			std::cout << "Incorrect message received" << std::endl;
		}

	}
}



