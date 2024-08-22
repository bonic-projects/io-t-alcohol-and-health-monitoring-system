import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';

import '../app/app.logger.dart';
import '../models/models.dart';

class DbService with ReactiveServiceMixin {
  final log = getLogger('RealTimeDB_Service');

  FirebaseDatabase _db = FirebaseDatabase.instance;

  DeviceData? _node;
  DeviceData? get node => _node;

  void setupNodeListening() {
    DatabaseReference starCountRef =
        _db.ref('/devices/Gz5VOr4v0Ae5QYK1V9AR8pCcl6A2/reading');
    starCountRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        _node = DeviceData.fromMap(event.snapshot.value as Map);
        // log.v(_node?.lastSeen); //data['time']
        notifyListeners();
      }
    });
  }
}
