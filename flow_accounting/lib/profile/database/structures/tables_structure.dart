/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/12/22, 3:38 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

class ProfilesData {

  static const Profile_Not_Singed_In = "0";
  static const Profile_Singed_In = "1";

  final int id;

  final String userId;

  final String userImage;

  final String userEmailAddress;
  final String userPhoneNumber;
  final String userInstagram;

  final String userLocationAddress;

  String userSignedIn = Profile_Not_Singed_In;

  ProfilesData({
    required this.id,

    required this.userId,

    required this.userImage,

    required this.userEmailAddress,
    required this.userPhoneNumber,
    required this.userInstagram,

    required this.userLocationAddress,

    required this.userSignedIn
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'userId': userId,

      'userImage': userImage,

      'userEmailAddress': userEmailAddress,
      'userPhoneNumber': userPhoneNumber,
      'userInstagram': userInstagram,

      'userLocationAddress': userLocationAddress,

      'userSignedIn': userSignedIn,
    };
  }

  @override
  String toString() {
    return 'ProfilesData{'
      'id: $id, '

      'userId: $userId, '

      'userImage: $userImage, '

      'userEmailAddress: $userEmailAddress, '
      'userPhoneNumber: $userPhoneNumber, '
      'userInstagram: $userInstagram, '

      'userLocationAddress: $userLocationAddress, '

      'userSignedIn: $userSignedIn, '
    '}';
  }
}
