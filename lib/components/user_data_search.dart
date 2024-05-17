import '../user_data.dart';

List<UserData> searchUserData(List<UserData> userDataList, String query) {
  // Convert the query to lowercase for case-insensitive search
  final String lowercaseQuery = query.toLowerCase();

  // Filter the userDataList based on the search query
  return userDataList.where((userData) {
    // Match the search query against various fields of UserData
    return userData.name.toLowerCase().contains(lowercaseQuery) ||
        userData.ip.toLowerCase().contains(lowercaseQuery) ||
        userData.macAdd.toLowerCase().contains(lowercaseQuery) ||
        userData.planName.toLowerCase().contains(lowercaseQuery) ||
        userData.subnetMask.toLowerCase().contains(lowercaseQuery) ||
        userData.nas.toLowerCase().contains(lowercaseQuery) ||
        userData.lastConnectionTimeString.toLowerCase().contains(lowercaseQuery) ||
        userData.createdAtString.toLowerCase().contains(lowercaseQuery);
  }).toList();
}
