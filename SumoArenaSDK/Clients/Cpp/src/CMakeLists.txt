
# Needed Headers
INCLUDE_DIRECTORIES (	
	${PROJECT_SOURCE_DIR}/inc
	${CMAKE_SOURCE_DIR}
)

ADD_DEFINITIONS(-D_UNICODE -DUNICODE)
ADD_DEFINITIONS(-DJSON_IS_AMALGAMATION)

ADD_DEFINITIONS(-DBOOST_DATE_TIME_NO_LIB)
ADD_DEFINITIONS(-DBOOST_REGEX_NO_LIB )


SET( SumoArenaClient_HEADERS 
	${PROJECT_SOURCE_DIR}/inc/GameManager.h
	${PROJECT_SOURCE_DIR}/inc/IAlgoClient.h
	${PROJECT_SOURCE_DIR}/inc/ExampleClient.h
	${PROJECT_SOURCE_DIR}/inc/TurnInfo.h
	${PROJECT_SOURCE_DIR}/inc/RoundInfo.h
	${PROJECT_SOURCE_DIR}/inc/Player.h
)

SET(SumoArenaClient_SOURCES
	main.cpp
	jsoncpp.cpp
	GameManager.cpp
	TurnInfo.cpp
	RoundInfo.cpp
	ExampleClient.cpp
	Player.cpp
	
)

SOURCE_GROUP(Headers FILES ${SumoArenaClient_HEADERS})
SOURCE_GROUP(Sources FILES ${SumoArenaClient_SOURCES})

	 
# Executable creation	
ADD_EXECUTABLE (SumoArenaClient 
	${SumoArenaClient_HEADERS}	
	${SumoArenaClient_SOURCES}
)

TARGET_LINK_LIBRARIES (SumoArenaClient Ws2_32 )

