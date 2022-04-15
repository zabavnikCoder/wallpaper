import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


const apiKay='26613151-202fdc8a59df2435587bd2226';

Future <Map> getPics() async{

  http.Response response=await http.get(Uri.parse
  ('https://pixabay.com/api/?key=$apiKay&q=cars&image_type=photo&pretty=true'));

 return jsonDecode(response.body);

}
