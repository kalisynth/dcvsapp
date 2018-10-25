part of dcvsapp;

class RadioScreen extends StatefulWidget{
  @override
  State createState() => new RadioState();
}

//DCVS_RADIO_URL = {"http://thassos.cdnstream.com:5046/stream"};
//NAC_RADIO_URL = {"http://thassos.cdnstream.com:5049/live"};

class RadioState extends State<RadioScreen>{
  double buttonHeight;
  double buttonMinWidth;

  String tag = "RADIOSCREEN";

  Color bgColor = DefaultSettings().radioBGColor;
  Color fntColor = DefaultSettings().radioFontColor;

  String dcvsUrl = "http://thassos.cdnstream.com:5046/stream";
  String nacUrl = "http://thassos.cdnstream.com:5049/live";
  String currentUrl;

  bool isPlaying = false;
  bool isDcvs;

  PlaybackState _playbackState;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentUrl = dcvsUrl;
    isDcvs = true;
    _playbackState = PlaybackState.paused;
  }

  void playRadio(){

  }

  void changeStation(){
    if(isDcvs){
      currentUrl = nacUrl;
      isDcvs = false;
    } else {
      currentUrl = dcvsUrl;
      isDcvs = true;
    }
  }

  Widget _buildButton(String title, VoidCallback onPressed) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: new RaisedButton(
        child: new Text(
          title,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context){

    return new Audio(
      audioUrl: currentUrl,
      child: new Column(
          children: <Widget>[
      new AudioComponent(
      updateMe: [
          WatchableAudioProperties.audioPlayerState,
          ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
    return _buildButton('LOAD AUDIO', player.state == AudioPlayerState.idle
    || player.state == AudioPlayerState.stopped ? () {
      player.loadMedia(Uri.parse(currentUrl));
    } : null);
    },
      ),

    new AudioComponent(
    updateMe: [
    WatchableAudioProperties.audioPlayerState,
    ],
    playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
    return _buildButton('PLAY AUDIO', player.state == AudioPlayerState.paused
    || player.state == AudioPlayerState.completed ? () {
    player.play();
    } : null);
    },
    ),

    new AudioComponent(
    updateMe: [
    WatchableAudioProperties.audioPlayerState,
    ],
    playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
    return _buildButton('PAUSE AUDIO', player.state == AudioPlayerState.playing ? () {
    player.pause();
    } : null);
    },
    ),
      new AudioComponent(
        updateMe: [
          WatchableAudioProperties.audioPlayerState,
        ],
        playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
          return _buildButton(isDcvs ? 'Change to NAC Easy listening' : 'Change to DCVS', (){
            changeStation();
          });
        },
      ),
      new AudioComponent(
        updateMe: [
          WatchableAudioProperties.audioPlayerState,
        ],
        playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
          return new Text(isDcvs ? "DCVS" : "NAC Easy Listening");
        },
      ),
    ],
    ),
    );
    }
}

    /*return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Radio"),
        backgroundColor: bgColor,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: fntColor,
        ),
      ),
      backgroundColor: bgColor,
      body: new Container(
          child: new Column(
              children: <Widget>[
                new Text('Radio goes Here'),
                new Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: new AudioComponent(
                    updateMe: [
                      WatchableAudioProperties.audioPlayerState,
                    ],
                    playerBuilder: (BuildContext context, AudioPlayer audioPlayer, Widget child){
                      IconData playPauseIcon = Icons.music_note;
                      Function onPressed;
                      if (audioPlayer.state == AudioPlayerState.paused
                          || audioPlayer.state == AudioPlayerState.completed) {
                        playPauseIcon = Icons.play_arrow;
                        onPressed = audioPlayer.play;
                      } else if (audioPlayer.state == AudioPlayerState.playing) {
                        playPauseIcon = Icons.pause;
                        onPressed = audioPlayer.pause;
                      }

                      return new IconButton(
                        icon: new Icon(
                          playPauseIcon,
                          size: 35.0,
                        ),
                        onPressed: onPressed,
                      );
                    },
                  ),
                ),
                new FlatButton(
                  child: new Text("PLAY"),
                  onPressed:(){
                    playRadio();
                  }
                ),
                new FlatButton(
                    child: new Text("Change Station"),
                    onPressed:(){
                      changeStation();
                    }
                ),
              ]
          )
      ),
    );
  }
}
*/