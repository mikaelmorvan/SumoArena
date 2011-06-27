SumoArena is a game engine for a private coding contest.


-------------------------------------------
Release 0.5
- spheres speed is updated synchronously:
	* at t0: the server sends "play" request to clients
	* between t0 and t0 + player request interval, the clients must respond
	* at t0 + player request interval, all spheres speed is updated according to client responses
	  then a new "play" request is sent
- display speed vectors in arena
- corrected bug on round end with no player in arena


-------------------------------------------
Release 0.4

New Features
- stop server before exiting application
- added stop command in server tab
- handle client disconnection

Solved issues
- corrected bug in JS demo client: unexpected message sent in response to AcknowledgeConnect

-------------------------------------------

Release 0.3 

Removed features
- arena initial size modification

New Features
- merged controls and game tabs
- round cancellation
- game cancellation
- in game player list, with color and score for each player
- better player selection / unselection