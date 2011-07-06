-------------------------------------------

Release 1.0

- Added splashscreen
- Added image for arena skin 
- Fixed Framerate
- Pause when waiting for the client response, to allow human clients to play
- Wait 1 second between two messages send, to avoid some reception problems on client side 
 
Issues corrected
- turn duration corrected 
- when a client did not respond, its dVx and dVy remained unchanged instead of being turned to 0
- the arena shinking started immediatelywhatever was the start value

-------------------------------------------
Release 0.9

Model simplification
corrected issue : bad values returned for x and y

-------------------------------------------

Release 0.8

Added crossdomain policy handling for Flash clients
Corrected issue : the sphere do not move when dVx or dVy is 0

-------------------------------------------
Release 0.7
- avatar images are used -instead of colored disks to represent spheres
- corrected the bug which made two players may have the same graphical representation
- added configuration procedure to JS client

-------------------------------------------
Release 0.6
- corrections in protocol:
 "id" replaced with "index"
 "roundWinnerId" replaced with "roundWinnerIndex"
 "gameWinnerId" replaced with "gameWinnerIndex"

-------------------------------------------
release 0.5
- spheres speed is updated synchronously:
	* at t0: the server sends "play" request to clients
	* between t0 and t0 + player request interval, the clients must respond
	* at t0 + player request interval, all spheres speed is updated according to client responses
	  then a new "play" request is sent
- display speed vectors in arena
- corrected bug on round end with no player in arena

-------------------------------------------
release 0.4
- stop server before exiting application
- added stop command in server tab
- handle client disconnection
- corrected bug in JS demo client: unexpected message sent in response to AcknowledgeConnect

