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
- stop server before exiting application
- added stop command in server tab
- handle client disconnection
- corrected bug in JS demo client: unexpected message sent in response to AcknowledgeConnect

