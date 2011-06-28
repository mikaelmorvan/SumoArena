CMAKE_MINIMUM_REQUIRED(VERSION 2.8)


PROJECT (SumoArena)

# OPTION Parameters ---------------------------------------------------------------------------------------------------------------------------------------------------------------

# ----------------
# Set Output paths
SET(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/Build/_Bin)
SET(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/Build/_Lib)

# ----------------
# Create Directories if not exist
FILE(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/Build)
FILE(MAKE_DIRECTORY ${EXECUTABLE_OUTPUT_PATH})
FILE(MAKE_DIRECTORY ${LIBRARY_OUTPUT_PATH})


#External dependencies inclue and library paths
INCLUDE_DIRECTORIES ( C:/Dev/Library/boost_1_46_1/ )

LINK_DIRECTORIES( C:/Dev/Library/boost_1_46_1/stage/lib/ )
LINK_DIRECTORIES( C:/Dev/Library/boost_1_46_1/ibs/ )


# Don't build anything unless the version of CMake is high enough.
# The matching ELSE/ENDIF should be the last lines in the file.
IF("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" GREATER 2.7)

SET(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS true)
IF(WIN32)
	IF(${CMAKE_SYSTEM_VERSION} EQUAL 6.1)
		SET ( WIN7 1 )
		MESSAGE(STATUS "Running under Windows 7")
	ELSEIF(${CMAKE_SYSTEM_VERSION} EQUAL 5.1)
        SET ( WINXP 1 )
		MESSAGE(STATUS "Running under Windows XP")
	ELSE()	
        SET ( WINVISTA 1 )
		MESSAGE(STATUS "Running under Windows Vista")
	ENDIF()
ELSEIF(APPLE)
	MESSAGE(STATUS "Running under Mac Os X")
    # set _CMAKE_OSX_MACHINE to umame -m
    EXEC_PROGRAM(uname ARGS -m OUTPUT_VARIABLE _CMAKE_OSX_MACHINE)
    # check for Power PC and change to ppc
    IF("${_CMAKE_OSX_MACHINE}" MATCHES "Power Macintosh")
        MESSAGE(STATUS "Running under Power PC")
        SET( POWERPC 1 )
    ELSE()
        MESSAGE(STATUS "Running under Intel")
        SET( POWERPC 0 )
    ENDIF()
ELSEIF(UNIX)
	MESSAGE(STATUS "Running under Linux")
ELSE()
	MESSAGE(STATUS "WARNING : Running under unknow Operating System")
ENDIF()

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
IF(WIN32)
	ADD_DEFINITIONS(-D_CRT_NON_CONFORMING_SWPRINTFS)
	ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS)
	ADD_DEFINITIONS(-D_BIND_TO_CURRENT_VCLIBS_VERSION=1)
	SET(CMAKE_CXX_FLAGS_DEBUG "/MDd /Z7 /Od")
	SET(CMAKE_CXX_FLAGS_RELEASE "/MD /O2")
	IF(WIN7)
		ADD_DEFINITIONS ( -DMBB_ON )
	ENDIF()
ELSEIF(APPLE)
	ADD_DEFINITIONS( -DAPPLE )
#	ADD_DEFINITIONS( -Wno-deprecated )
ELSEIF(UNIX)
	ADD_DEFINITIONS(-DLINUX)
	ADD_DEFINITIONS( -Wno-deprecated)
ENDIF ()
IF(XANDROS)
	ADD_DEFINITIONS(-DXANDROS)
ENDIF()

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Sub-Directories 
ADD_SUBDIRECTORY( 
	Client
	)

# If the version of CMake was too old, complain and build nothing.
# These should be the last lines in this file.
ELSE("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" GREATER 2.7)
  MESSAGE(FATAL_ERROR
          "This version of CMake is too old to build the BEW20 software.  "
          "Please upgrade to CMake 2.8.1")
ENDIF("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" GREATER 2.7)
