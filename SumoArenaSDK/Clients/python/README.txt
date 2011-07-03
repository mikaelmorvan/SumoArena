SumoArena Python Example Client


This client uses Python 2.6 standard lib and requires no external modules.

It aims at giving a simple but complete implementation, so it can be used as
an example of socket and protocol handling, or as copiable base for your own
Python client.


To keep thing easy, it is made a single source code file.


To use this code to make your own client, you just have to:

1.  Update the following variable in the code:

    CLIENT_NAME     = 'Python Dummy Client' # <-- Put your client name here.
    AVATAR_URL      = ''                    # <-- Put a URL (PNG), if any.

    CLIENT_NAME must be provided.
    AVATAR_URL may stay empty.

2.  Put your gaming code between

        #--------------------------------------------------------------
        # Your code begins here
        #--------------------------------------------------------------

    and

        #--------------------------------------------------------------
        # Your code ends here.
        #--------------------------------------------------------------

    comment tags in the code.


This client accepts command line arguments:

    sumo_arena_client.py <hostname>:<port>

where

    <host_name> is the game server hostname (default: localhost)
    <port_name> is the game server port (default: 9090)

For example:

    sumo_arena_client.py r-lnx-contest:5432

