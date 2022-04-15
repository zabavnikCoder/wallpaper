import 'package:flutter/material.dart';
import 'package:wallpapers/pics_api.dart';



class WallpaperScreen extends StatefulWidget {
  

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.blueAccent,
        title: const Text('Wallpapers'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getPics(),
        builder: (context,snapShot){
          Map data =snapShot.data as Map;
          if(snapShot.hasError){
            print(snapShot.error);
            return const Text('failed to connect server',
            style: TextStyle(color: Colors.redAccent),
            );
          }else if(snapShot.hasData){
            return Center(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder:(context,index){
                  return Column(
                    children:[
                        InkWell(
                          onTap: (){},
                          child: Image.network(
                            '${data['hits']['index']['largeImageURL']}'
                          ),
                        ),
                        const Padding(
                        padding: EdgeInsets.all(6.0)
                        ),
                    ],
                  );
                } ,
              ),
            );
          }else if(!snapShot.hasData){
            return const Center(
              child: CircularProgressIndicator());
          }
        }),
    );
  }
}