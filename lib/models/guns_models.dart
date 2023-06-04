import 'package:flutter_application_kr/database/db_helper.dart';

class Guns {
  final String name;
  final int? id;
  double? inParts;
  double? inBrigade;
  double kig;
  Guns(
      {required this.name,
      this.id,
      this.inBrigade,
      this.inParts,
      required this.kig});
  Map<String, dynamic> toMap() {
    return {
      GunsDatabaseHelper.columnId: id,
      GunsDatabaseHelper.columnName: name,
      GunsDatabaseHelper.columnInParts: inParts,
      GunsDatabaseHelper.columnInBrigade: inBrigade,
    };
  }
}

class ConParts {
  final int? id;
  final String name;
  final Guns guns;
  ConParts({required this.guns, required this.name, this.id});
  Map<String, dynamic> toMap() {
    return {
      GunsDatabaseHelper.columnConPartsId: id,
      GunsDatabaseHelper.columnConPartsName: name,
      GunsDatabaseHelper.columnGunsId: guns.id,
    };
  }
}
