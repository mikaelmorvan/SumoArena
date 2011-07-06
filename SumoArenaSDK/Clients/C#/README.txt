SumoArena C# Example Client


This client was written with Visual Studio 10 and uses .NET 4.0 and json.NET
external library.

json.NET is a wonderful piece of software and is embedded as a binary
dependency. Please find information about it (web site, licence, etc.) in
json.Net-Licence.txt file.

It aims at giving a simple but complete implementation, so it can be used as
an example of socket and protocol handling, or as copiable base for your own
C# client.

You may notice several suboptimal C# cases in this code, as I'm not familiar
with C# language. To keep thing easy, it is made a single source code file.


To use this code to make your own client, you just have to:

1.  Update the following variable in the code:

    clientName     = 'C# Dummy Client' // <-- Put your client name here.
    avatarUrl      = ''                // <-- Put a URL (PNG), if any.

    clientName must be provided.
    avatarUrl may stay empty.

2.  Put your gaming code between

        // --------------------------------------------------------------
        // Your code begins here
        // --------------------------------------------------------------

    and

        // --------------------------------------------------------------
        // Your code ends here.
	// --------------------------------------------------------------

    comment tags in the code.


This client accepts command line arguments:

    SumoArenaClient.exe <hostname>:<port>

where

    <host_name> is the game server hostname (default: localhost)
    <port_name> is the game server port (default: 9090)

For example:

    SumoArenaClient.exe r-lnx-contest:5432

