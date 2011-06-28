SumoArena C++ Client
--------------------

This client uses CMake to build a C++ client for the SumoArena game.

An algorithm implements IAlgoClient interface, and is passed to the GameManager from main.cpp.


Dependencies:
* CMake build system
* boost::asio for socket communication. This library is header-only, but basic boost libraries have to be generated(bootstrap.bat)
The root CMakeList contains the path to these libraries