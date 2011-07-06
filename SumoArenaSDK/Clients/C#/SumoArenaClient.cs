using System;
using System.Net;
using System.Net.Sockets;
using System.Collections.Generic;

#region JSON Data structures
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

public class RoundStartInfo
{
    public static RoundStartInfo CreateFromJsonString(String jsonString)
    {
        return JsonConvert.DeserializeObject<RoundStartInfo>(jsonString);
    }

    public int yourIndex { get; set; }
    public int playerCount { get; set; }
    public int sphereRadius { get; set; }
    public int maxSpeedVariation { get; set; }
    public int arenaInitialRadius { get; set; }
    public int currentRound { get; set; }
    public int roundForVictory { get; set; }
}

public class Sphere
{
    public int index { get; set; }
    public int x { get; set; }
    public int y { get; set; }
    public int vx { get; set; }
    public int vy { get; set; }
    public bool inArena { get; set; }
}

public class PlayingdInfo
{
    public static PlayingdInfo CreateFromJsonString(String jsonString)
    {
        return JsonConvert.DeserializeObject<PlayingdInfo>(jsonString);
    }

    public int arenaRadius { get; set; }
    public List<Sphere> players { get; set; }
}

public class RoundEndInfo
{
    public static RoundEndInfo CreateFromJsonString(String jsonString)
    {
        return JsonConvert.DeserializeObject<RoundEndInfo>(jsonString);
    }

    public int currentRound { get; set; }
    public int gameWinnerIndex { get; set; }
    public int roundWinnerIndex { get; set; }
}

#endregion

#region Event-based Player class

public class Player
{
    public class AccelerationVector
    {
        public int dVx;
        public int dVy;
    }
    
    RoundStartInfo roundInfo = null;

    public void OnRoundStart(RoundStartInfo info)
    {
        roundInfo = info;

        Console.WriteLine("A round is about to start.");
    }

    public AccelerationVector OnPlayRequest(PlayingdInfo info)
    {
        if (null == roundInfo || !info.players[roundInfo.yourIndex].inArena)
        {
            return null;
        }

        AccelerationVector result = ChooseAcceleration(info);

        // Quick check.
        if (result.dVx * result.dVx + result.dVy * result.dVy > roundInfo.maxSpeedVariation * roundInfo.maxSpeedVariation)
        {
            Console.WriteLine("*** Acceleration is too big.");
        }

        return result;
    }

    private AccelerationVector ChooseAcceleration(PlayingdInfo info)
    {
        // Get your own sphere.
        //
        // Other sphere information is the same.
        Sphere myself = info.players[roundInfo.yourIndex];

        // Position.
        int x = myself.x;
        int y = myself.y;

        // Velocity.
        int vx = myself.vx;
        int vy = myself.vy;

        // Other information.
        int index    = myself.index;
        bool inArena = myself.inArena;

        // --------------------------------------------------------------
        // Your code begins here.
        // --------------------------------------------------------------

        // You are expected to return an AccelerationVector.
        AccelerationVector result = new AccelerationVector();

        // Return dummy value.
        result.dVx = roundInfo.maxSpeedVariation;
        result.dVy = 0;

        // --------------------------------------------------------------
        // Your code ends here.
        // --------------------------------------------------------------

        return result;
    }

    public void OnRoundStop(RoundEndInfo info)
    {
        if (info.roundWinnerIndex == roundInfo.yourIndex)
        {
            Console.WriteLine("I won this round.");
        }
        else
        {
            Console.WriteLine("I did not win this round.");
        }

        if (info.gameWinnerIndex < 0)
        {
            Console.WriteLine("The game is not over yet.");
            return;
        }

        if (info.gameWinnerIndex == roundInfo.yourIndex)
        {
            Console.WriteLine("I won this game.");
        }
        else
        {
            Console.WriteLine("I did not win this game.");
        }
    }
}

#endregion
#region TCP Socket GameClient class

public class GameClient : TcpClient {

    private String clientName = String.Empty;
    private String avatarUrl  = String.Empty;

    private delegate void ActionMethod(String jsonParamString);
    private  Dictionary<String, ActionMethod> callbacks;

    private Player player;

    public GameClient(String hostname, UInt16 port, String name, String avatarUrl) : base(hostname, port)
    {
        this.clientName = name;
        this.avatarUrl  = avatarUrl;

        callbacks = new Dictionary<String, ActionMethod>() {
            {"acknowledgeConnection", new ActionMethod(OnConnectionAck)},
            {"prepare",               new ActionMethod(OnPrepare)},
            {"play",                  new ActionMethod(OnPlay)},
            {"finishRound",           new ActionMethod(OnFinishRound)}
        };
    }

    private void Run() {

        try
        {
            // Send identification message.
            if (Connected)
            {
                String jsonString = "{\"action\":\"connectPlayer\", \"parameters\": {\"name\":\"" + clientName + "\", \"avatar_url\": \"" + avatarUrl + "\" } }";
                byte[] jsonBytes = System.Text.Encoding.UTF8.GetBytes(jsonString);
                this.GetStream().Write(jsonBytes, 0, jsonBytes.Length);
            }
        
            // Now wait for server messages.
            while (Connected) {
                
                byte[] msgBytes = new byte[1024];
                int byteCount = this.GetStream().Read(msgBytes, 0, msgBytes.Length);

                if (byteCount < 0)
                {
                    continue;
                }

                String msg = System.Text.Encoding.UTF8.GetString(msgBytes);

                JObject o = JObject.Parse(msg);
                String action = o["action"].Value<String>();
                String parameters = o["parameters"].ToString();

                ActionMethod actionMethod = callbacks[action];
                actionMethod(parameters);
            }
            
        } catch (Exception e) {
            Console.WriteLine(e.ToString());
        }
    }

    private void OnConnectionAck(String jsonParamString)
    {
        JToken o = JObject.Parse(jsonParamString);
        Console.WriteLine("Now connected as {0}", o["yourName"].ToString());
        player = new Player();
    }

    private void OnPrepare(String jsonParamString)
    {
        Console.WriteLine("A round is starting.");
        RoundStartInfo info = RoundStartInfo.CreateFromJsonString(jsonParamString);
        player.OnRoundStart(info);
    }

    private void OnPlay(String jsonParamString)
    {
        PlayingdInfo info = PlayingdInfo.CreateFromJsonString(jsonParamString);
        Player.AccelerationVector v = player.OnPlayRequest(info);

        if (null != v)
        {
            String jsonString = String.Format("{{\"action\":\"updateVector\", \"parameters\": {{\"dVx\": {0}, \"dVy\": {1} }} }}", v.dVx, v.dVy);
            byte[] jsonBytes = System.Text.Encoding.UTF8.GetBytes(jsonString);
            this.GetStream().Write(jsonBytes, 0, jsonBytes.Length);
        }
    }

    private void OnFinishRound(String jsonParamString)
    {
        RoundEndInfo info = RoundEndInfo.CreateFromJsonString(jsonParamString);
        player.OnRoundStop(info);
    }

    public static int Main(String[] args) {

        // Default client argument values.
        const String DEFAULT_GAME_SERVER_HOST = "127.0.0.1";
        const UInt16 DEFAULT_GAME_SERVER_PORT = 9090;
        const String clientName = "C# Dummy client"; // <-- Put your client name here. 
	const String avatarUrl  = "";                // <-- Put a URL (PNG), if any.

        // Read information from command-line.
        String serverName = DEFAULT_GAME_SERVER_HOST;
        UInt16 serverPort = DEFAULT_GAME_SERVER_PORT;
        if (args.Length > 0)
        {
            Uri serverUri = new Uri(args[0]);
            serverPort = (UInt16) serverUri.Port;
            serverName = serverUri.Host;
        }

        GameClient gameClient = new GameClient(serverName, serverPort, clientName, avatarUrl);
        gameClient.Run();

        return 0;
    }
}

#endregion
