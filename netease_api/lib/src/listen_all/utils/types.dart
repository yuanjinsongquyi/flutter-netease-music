import 'package:universal_io/io.dart' ;
import 'package:netease_api/src/listen_all/utils/answer.dart';

typedef Api = Future<Answer> Function(Map query, List<Cookie> cookie);
