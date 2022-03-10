/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/10/22, 7:35 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/profile/database/io/inputs.dart';
import 'package:flow_accounting/profile/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProfileDatabaseQueries {

  Future<ProfilesData> querySignedInUser(String? tableName) async {

    final database = openDatabase(
      join(await getDatabasesPath(), ProfilesDatabaseInputs.profileDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : ProfilesDatabaseInputs.databaseTableName;
    tableNameQuery = "${tableNameQuery}";

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'userSignedIn = ?',
      whereArgs: [ProfilesData.Profile_Singed_In],
    );

    return ProfilesData(
        id: int.parse(databaseContents[0]['id'].toString()),

        userId: databaseContents[0]['userId'].toString(),

        userImage: databaseContents[0]['userImage'].toString(),
        userEmailAddress: databaseContents[0]['userEmailAddress'].toString(),
        userPhoneNumber: databaseContents[0]['userPhoneNumber'].toString(),
        userInstagram: databaseContents[0]['userInstagram'].toString(),

        userSignedIn: int.parse(databaseContents[0]['userSignedIn'].toString())
    );
  }

}

class UserInformation {
  static String UserId = "Unknown";
}