import 'package:flutter_dotenv/flutter_dotenv.dart';

class Envionment {
  static String movieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'NO HAY API KEY';
}