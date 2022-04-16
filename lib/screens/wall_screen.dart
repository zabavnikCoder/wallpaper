import 'package:flutter/material.dart';
import 'package:wallpapers/pics_api.dart';

class WallpaperScreen extends StatefulWidget {
  
  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  
late Future<Map> future;//Future ტიპის ცვლადი future

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    future=getPics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.blueAccent,
        title: const Text('Wallpapers'),
        centerTitle: true,
      ),
      //FutureBuilder-ში ვუსმენთ Future-ის დაბრუნებულ შედეგს
      body: FutureBuilder<Map>(
        future: getPics(),
        builder: (context,snapShot){
          Map data =snapShot.data as Map;
          //თუ დაბრუნდა error-ი გამოიტანს პრინტში არსებულ შეტყობინებას
          //snapShot-ით ვუსმენთ Future-ის შედეგს
          if(snapShot.hasError){
            print(snapShot.error);
            return const Text('failed to connect server',
            style: TextStyle(color: Colors.redAccent),
            );
            //თუ დაბრუნდა result-ი მაშინ გამოიტანს ქვემოთ მოცემულ ვიზუალს
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
            //აქ ვამოწმებ თუ FutureBuilder-ში არ დაბრუნდა result-ი იტრიალებს CircularProgressIndicator-ი
          }else if(!snapShot.hasData){
            return const Center(
              child: CircularProgressIndicator());
          }
        }),
    );
  }
}