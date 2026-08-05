import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

DatabaseConnection openCardPilotDatabase() {
  return driftDatabase(name: 'cardpilot');
}
