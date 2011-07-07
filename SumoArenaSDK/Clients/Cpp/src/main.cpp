
#include <string>
#include <iostream>

#include "GameManager.h"
#include "ExampleClient.h"


int main(int argc, char * argv[])
{
	std::string serverName("localhost");
	std::string serverPort("9090");

	if (argc == 2 && (strcmp(argv[1],"/?")==0) )
	{
		std::cout << "Usage:" << std::endl << "  " << argv[0] << " <serverName> <port>" << std::endl;
		return 0;
	}
	else if( argc == 3 )
	{
		serverName = argv[1];
		serverPort = argv[2];
	}
	
	std::cout << "Connecting to server " << serverName << ":" << serverPort << std::endl;

	try {

		// Concrete client algorithm implementation type
		// Replace ExampleClient by your own implementation class
		////////////////////////////
		ExampleClient algo;
		////////////////////////////

		// Creation of the game manager, responsible for server communication and game loop
		GameManager game( serverName, serverPort);
		// Start playing
		game.startLoop( algo, "CppClient" );

	}
	catch (std::exception& e)
	{
		std::cerr << e.what() << std::endl;
	}

	return 0;

}