
#include <string>
#include <iostream>

#include "GameManager.h"
#include "ExampleClient.h"


int main(int argc, char argv[])
{
	std::string serverName("localhost");
	std::string serverPort("9090");

	if( argc == 3 )
	{
		serverName = argv[2];
		serverPort = argv[3];
	}
	
	std::cout << "Connecting to server " << serverName << ":" << serverPort << std::endl;

	try {

		ExampleClient algo;

		GameManager game( serverName, serverPort);

		game.startLoop("cppClient", algo );

	}
	catch (std::exception& e)
	{
		std::cerr << e.what() << std::endl;
	}

	return 0;

}