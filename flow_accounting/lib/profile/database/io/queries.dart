/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/13/22, 11:19 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/profile/database/io/inputs.dart';
import 'package:flow_accounting/profile/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProfileDatabaseQueries {

  Future<List<ProfilesData>> getAllProfileAccounts() async {

    List<Map<String, dynamic>> maps = [];

    String databaseDirectory = await getDatabasesPath();

    String profileDatabasePath = "${databaseDirectory}/${ProfilesDatabaseInputs.profilesDatabase}";

    bool profilesDatabaseExist = await databaseExists(profileDatabasePath);

    if (profilesDatabaseExist) {
      final database = openDatabase(
        join(await getDatabasesPath(), ProfilesDatabaseInputs.profilesDatabase),
      );

      final databaseInstance = await database;

      var tableNameQuery = ProfilesDatabaseInputs.databaseTableName;

      maps = await databaseInstance.query(tableNameQuery);

    }

    return List.generate(maps.length, (i) {
      return ProfilesData(
        id: maps[i]['id'],

        userId: maps[i]['userId'].toString(),

        userFullName: maps[i]['userFullName'].toString(),
        userImage: maps[i]['userImage'].toString(),

        userEmailAddress: maps[i]['userEmailAddress'].toString(),
        userPhoneNumber: maps[i]['userPhoneNumber'].toString(),
        userInstagram: maps[i]['userInstagram'].toString(),

        userLocationAddress: maps[i]['userLocationAddress'].toString(),

        userSignedIn: maps[i]['userSignedIn'].toString(),
      );
    });

  }

  Future<ProfilesData?> querySignedInUser() async {

    ProfilesData? profilesData;

    String databaseDirectory = await getDatabasesPath();

    String profileDatabasePath = "${databaseDirectory}/${ProfilesDatabaseInputs.profilesDatabase}";

    bool profilesDatabaseExist = await databaseExists(profileDatabasePath);

    if (profilesDatabaseExist) {

      final database = openDatabase(
        join(await getDatabasesPath(), ProfilesDatabaseInputs.profilesDatabase),
      );

      final databaseInstance = await database;

      var tableNameQuery = ProfilesDatabaseInputs.databaseTableName;

      var databaseContents = await databaseInstance.query(
        tableNameQuery,
        where: 'userSignedIn = ?',
        whereArgs: [ProfilesData.Profile_Singed_In],
      );

      profilesData = ProfilesData(
        id: int.parse(databaseContents[0]['id'].toString()),

        userId: databaseContents[0]['userId'].toString(),

        userFullName: databaseContents[0]['userFullName'].toString(),
        userImage: databaseContents[0]['userImage'].toString(),

        userEmailAddress: databaseContents[0]['userEmailAddress'].toString(),
        userPhoneNumber: databaseContents[0]['userPhoneNumber'].toString(),
        userInstagram: databaseContents[0]['userInstagram'].toString(),

        userLocationAddress: databaseContents[0]['userLocationAddress'].toString(),

        userSignedIn: databaseContents[0]['userSignedIn'].toString(),
      );

    }

    return profilesData;
  }

}

class UserInformation {
  static String UserId = "Unknown";
}