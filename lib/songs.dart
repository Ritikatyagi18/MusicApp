

import 'package:flutter/material.dart';


import 'details.dart';
import 'main.dart';
void main() {
  runApp(const MyApp());
}
class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}
class SongInfo {
  String title;
  String singer;
  String image;
  String path;
  SongInfo( {required this.title, required this.singer, required this.image, required this.path});


}
class _MusicPlayerState extends State<MusicPlayer> {
  late List song;
  void initState() {
    song = getList();
    super.initState();
  }
  List getList(){
    return[
      SongInfo(title: 'Its you',singer: 'Ali Gatie' ,image:"assets/images/image1.jpg" ,
          path: "audio/song.mp3"),
      SongInfo(title: 'Cold',singer: 'Maroon 5',image:"assets/images/image2.jpg",
          path: "audio/song2.mp3"),
      SongInfo(title: 'Ranjha',singer: 'B praak& Jasleen Royal',image: "assets/images/image3.jpg",
          path: "audio/song3.mp3"),
      SongInfo(title: 'Laree Choote',singer: 'Call',image: "assets/images/image4.jpg",
          path: "audio/laree.mp3"),
      SongInfo(title: 'kina Chir',singer:'PropheC',image: "assets/images/image5.jpg",
          path:"audio/kina_chir.mp3"),
      SongInfo(title: 'Excuses',singer:'AP Dhillon',image: "assets/images/image6.jpg",
          path:"audio/excuses.mp3"),
      SongInfo(title: 'Toxic',singer: 'Cathy Dennis',image: "assets/images/image7.jpg",
          path:"audio/toxic.mp3"),
      SongInfo(title: 'Black Beatles',singer: 'Rae Sremmurd' ,image:"assets/images/image8.jpg",
          path:"audio/black_beatles.mp3"),


    ];
  }
  Widget customListView({
    required String title,
    required String singer,
    required String image,
    required String path,
    onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(children: [
              Container(
                height: 80.0,
                width: 80.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child:Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ),
              ),
              Container(
                height: 80.0,
                width: 80.0,
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white.withOpacity(0.7),
                  size: 42.0,
                ),
              )
            ]),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  singer,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 14.0),
                ),
              ],
            ),
            Spacer(),//maintain space b/w widgets in row/column
            Icon(
              Icons.more_horiz,
              color: Colors.white.withOpacity(0.6),
              size: 32.0,
            ),

            Icon(
              Icons.favorite,
              color: Colors.white.withOpacity(0.6),
              size: 12.0,

            ),

          ],
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text(
            "Playlist",
            style: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                fontSize: 25.0),
          ),
        ),
        body:
          Column(children: [

            Expanded(
              child: ListView.builder(
                  itemCount: getList().length,
                  itemBuilder: (context, index) => customListView(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(msong: song[index]),
                      ),);
                    },
                    title: song[index].title,
                    singer: song[index].singer,
                    image: song[index].image,
                    path: song[index].path,

                  )),
            ),
          ],),
    );

  }
}



