SumoArena client C++ Implementation
-----------------------------------

This is an example client implemented using C++ language.

A player should implement IPlayer interface and define behavior for the 3 method it provides, corresponding to the start and end of a round and the play request.
An example Player is provided in ExampleClient class.

To modify this client begavior, you should implement the IPlayer interface and instanciate your implementation in the main.cpp file
by replacing the example class ExampleClient by your own class 
main.cpp extract:
		// Concrete client algorithm implementation type
		// Replace ExampleClient by your own implementation class
		////////////////////////////
		ExampleClient algo;
		////////////////////////////
		
As client uses CMake build system, you will also have to add your new file to the src/CMakelists.txt file in the SumoArenaClient_SOURCES variable.

Usage:
Server name and port can be given on the command line:
SumoArenaCppClient.exe <servername> <serverport>

These values default to "localhost" and "9090" when none is provided

Dependencies:
* CMake build system
* boost::asio for socket communication. This library is header-only, but basic boost libraries have to be generated (bootstrap.bat)
You can modify the path to these libraries in the root CMakeLists if not already configured globally in your environment.
CMakeLists.txt extract:
	INCLUDE_DIRECTORIES ( C:/Dev/Library/boost_1_46_1/ )
	LINK_DIRECTORIES( C:/Dev/Library/boost_1_46_1/stage/lib/ )
	LINK_DIRECTORIES( C:/Dev/Library/boost_1_46_1/ibs/ )

