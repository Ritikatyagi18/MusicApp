import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'songs.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({ required this.msong}) ;
  final SongInfo msong;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var bgColor=  const Color(0xFF03174C);
  var iconHoverColor = const Color(0xFF065BC3);
  bool playing = false;
  IconData playBtn = Icons.play_circle_outline;
  AudioPlayer _player= AudioPlayer();
  AudioCache cache= AudioCache();
  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 300,
      child: Slider.adaptive(
        activeColor: Colors.blueAccent,
        inactiveColor: Colors.grey,
        value: position.inSeconds.toDouble(),
        max:musicLength.inSeconds.toDouble(),
        onChanged: (value)
        {
          seekTosec(value.toInt());
        },),
    );
  }

  void seekTosec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }
  void initState(){
    super.initState();
    _player=AudioPlayer();
    cache=AudioCache(fixedPlayer: _player);
    _player.onDurationChanged.listen((d){
      setState((){
        musicLength=d;
      });

    });
    _player.onAudioPositionChanged.listen((p){
      setState((){
        position=p;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF03174C),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 500.0,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.msong.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [bgColor.withOpacity(0.4), bgColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'PLAYLIST',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6)),
                                  ),
                                  Text('Your favourite music',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Icon(
                                Icons.playlist_add,
                                color: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(
                            height:30.0,
                          ),
                          Text(widget.msong.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0)),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            widget.msong.singer,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                          SizedBox(height: 10.0),

                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          widget.msong.image),
                                      fit: BoxFit.cover),
                                ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  )
                              ),
                            ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),


          Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Container(
                width:500.0,
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text("${position.inMinutes}:${position.inSeconds.remainder(60)}",
                      style: TextStyle(fontSize:18.0,color: Colors.white,),
                    ),
                    slider(),
                    Text("${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                      style: TextStyle(fontSize:18.0,color: Colors.white,),

                    ),
                  ],
                ),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fast_rewind,
                    color: Colors.white54,
                    size: 30.0,
                  ),
                  IconButton(
                    iconSize: 40.0,
                    color:Colors.blue[500],
                    onPressed:(){

                    },
                    icon: Icon(
                      Icons.skip_previous,
                    ),
                  ),
                  IconButton(
                    iconSize: 55.0,
                    color:Colors.blue[800],
                    onPressed:(){
                      if(!playing){
                        cache.play(widget.msong.path);
                        setState((){
                          playBtn=Icons.pause_circle_outline;
                          playing=true;
                        });
                      }
                      else{
                        _player.pause();
                        setState((){
                          playBtn=Icons.play_circle_outline;
                          playing=false;
                        });
                      }

                    },

                    icon: Icon(
                        playBtn
                    ),
                  ),
                  IconButton(
                    iconSize: 40.0,
                    color:Colors.blue[500],
                    onPressed:(){},
                    icon: Icon(
                      Icons.skip_next,
                    ),
                  ),
                  Icon(
                    Icons.fast_forward,
                    color: Colors.white54,
                    size: 30.0,
                  ),



                ],),
            ],),

              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}