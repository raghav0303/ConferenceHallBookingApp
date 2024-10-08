import 'package:conference_hall_booking/source/exported_packages_for_easy_imports.dart';
import 'package:conference_hall_booking/source/constants.dart';
import 'package:http/http.dart' as http;

// Future<BookingDetails> getBookingDetails() async {
//   String url = liveUrl + "booking_details";
//   Uri urlUri = Uri.parse(url);
//   // Map<String, String> requestBody = {
//   //   'mobile1': mobile,
//   //   'password': password,
//   // };
//   final response = await http.get(urlUri);
//   print(response.body);
//   // if (response

//   return BookingDetails.fromJson(json.decode(response.body));
//   // } else {
//   //   throw Exception('Failed to load Data');
//   // }
// }

Future<BookingDetails> getBookingDetails() async {
  try {
    String url = "${liveUrl}booking_details";
    Uri urlUri = Uri.parse(url);
    final response = await http.get(urlUri);

    if (response.statusCode == 200) {
      return BookingDetails.fromJson(json.decode(response.body));
    } else {
      // print('Error: ${response.statusCode}');
      // print('Body: ${response.body}');
      throw Exception('Failed to load data');
    }
  } catch (e) {
    // print('Exception: $e');
    throw Exception('Failed to load data');
  }
}

Future<BookingDetails> addBookingDetails(BookingDetails bookingDetails) async {
  String url = "${liveUrl}booking_details"; // Replace with your server URL
  Uri urlUri = Uri.parse(url);

  final response = await http.post(
    urlUri,
    headers: {"Content-Type": "application/json"},
    body: json.encode(
        bookingDetails.toJson()), // Convert BookingDetails object to JSON
  );

  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return BookingDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to add booking details');
  }
}

Future<UpdateBooking> updateBooking(BookingData value) async {
  String url = "${liveUrl}update_booking";
  Uri urlUri = Uri.parse(url);
  var requestBody = {
    "booking_id": toBeUpdatedBookingData.bookingId.toString(),
    "booking_number_id": toBeUpdatedBookingData.bookingNumberId.toString(),
    "booking_meeting_title": toBeUpdatedBookingData.bookingMeetingTitle,
    "booking_location_id": toBeUpdatedBookingData.bookingLocationId.toString(),
    "booking_conference_id":
        toBeUpdatedBookingData.bookingConferenceId.toString(),
    "booking_meeting_description":
        toBeUpdatedBookingData.bookingMeetingDescription,
    "booking_requirement_details":
        toBeUpdatedBookingData.bookingRequirementDetails,
    "booking_date": toBeUpdatedBookingData.bookingDate,
    "booking_start_time": toBeUpdatedBookingData.bookingStartTime,
    "booking_end_time": toBeUpdatedBookingData.bookingEndTime,
    "booking_updated_at": toBeUpdatedBookingData.bookingUpdatedAt,
    "booking_reported_by": toBeUpdatedBookingData.bookingReportedBy,
    "booking_number_of_attendees":
        toBeUpdatedBookingData.bookingNumberOfAttendees.toString(),
  };

  var response = await http.post(urlUri,
      // headers: {"Content-Type": "application/json"},
      body: requestBody);
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return UpdateBooking.fromJson(json.decode(response.body));
  } else if (response.statusCode == 442) {
    // print('Validation error');
    return UpdateBooking.fromJson(json.decode(response.body));
  } else if (response.statusCode == 422) {
    // print('No slot available error');
    return UpdateBooking.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update booking details');
  }
}

Future<BookingDepartmentsResponse> getBookingDepartmentsByBookingId(
    int bookingId) async {
  String url = "${liveUrl}get_booking_departments/$bookingId";
  // print('${url} nknjjxczx');
  Uri urlUri = Uri.parse(url);
  // Map<String, String> requestBody = {
  //   'mobile1': mobile,
  //   'password': password,
  // };
  final response = await http.get(urlUri);
  // print("${response.body} nksdkjad");
  // if (response

  return BookingDepartmentsResponse.fromJson(json.decode(response.body));
  // } else {
  //   throw Exception('Failed to load Data');
  // }
}

Future<BookingRefreshmentDetails> getBookingRefreshmentsByBookingId(
    int bookingId) async {
  String url = "${liveUrl}get_booking_refreshments/$bookingId";
  // print('${url} nknjjxczx');
  Uri urlUri = Uri.parse(url);
  // Map<String, String> requestBody = {
  //   'mobile1': mobile,
  //   'password': password,
  // };
  final response = await http.get(urlUri);
  // print("${response.body} nksdkjad");
  // if (response

  return BookingRefreshmentDetails.fromJson(json.decode(response.body));
  // } else {
  //   throw Exception('Failed to load Data');
  // }
}

Future<BookingAssetRequirementDetails> getBookingAssetRequirementsByBookingId(
    int bookingId) async {
  String url = "${liveUrl}get_booking_asset_requirements/$bookingId";
  // print('${url} nknjjxczx');
  Uri urlUri = Uri.parse(url);
  // Map<String, String> requestBody = {
  //   'mobile1': mobile,
  //   'password': password,
  // };
  final response = await http.get(urlUri);
  // print("${response.body} nksdkjad");
  // if (response

  return BookingAssetRequirementDetails.fromJson(json.decode(response.body));
  // } else {
  //   throw Exception('Failed to load Data');
  // }
}

Future<AddBookingData> addBooking(BookingData value) async {
  String url = "${liveUrl}add_booking";
  Uri urlUri = Uri.parse(url);
  // var requestBody = {
  //   "booking_date": toBeAddedBookingData.bookingDate,
  //   "str_time": toBeAddedBookingData.strTime,
  //   "end_time": toBeAddedBookingData.endTime,
  //   "meeting_title": toBeAddedBookingData.meetingTitle,
  //   "location_id": toBeAddedBookingData.locationName.toString(),
  //   "conference_id": toBeAddedBookingData.conferenceName.toString(),
  //   "meeting_description": toBeAddedBookingData.meetingDes,
  //   "requirement_details": toBeAddedBookingData.requirementDetails,
  //   "booking_status": toBeAddedBookingData.bookingStatus,
  //   "user_id": toBeAddedBookingData.userId.toString(),
  //   "created_at": toBeUpdatedBookingData.createdAt,
  // };

  var requestBody = {
    "booking_date": toBeAddedBookingData?.bookingDate ?? '',
    "booking_start_time": toBeAddedBookingData?.bookingStartTime ?? '',
    "booking_end_time": toBeAddedBookingData?.bookingEndTime ?? '',
    "booking_meeting_title": toBeAddedBookingData?.bookingMeetingTitle ?? '',
    "booking_location_id":
        toBeAddedBookingData?.bookingLocationId?.toString() ?? '',
    "booking_conference_id":
        toBeAddedBookingData?.bookingConferenceId?.toString() ?? '',
    "booking_meeting_description":
        toBeAddedBookingData?.bookingMeetingDescription ?? '',
    "booking_requirement_details":
        toBeAddedBookingData?.bookingRequirementDetails ?? '',
    "booking_status": toBeAddedBookingData?.bookingStatus.toString() ?? '',
    "user_id": toBeAddedBookingData?.userId?.toString() ?? '',
    "booking_created_at": toBeAddedBookingData?.bookingCreatedAt ?? '',
    "booking_reported_by": toBeAddedBookingData?.bookingReportedBy ?? '',
    "booking_number_of_attendees":
        toBeAddedBookingData?.bookingNumberOfAttendees.toString(),
  };

  var response = await http.post(urlUri,
      // headers: {"Content-Type": "application/json"},
      body: requestBody);
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return AddBookingData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to add booking details');
  }
}

Future<BookingDepartmentsResponse> addBookingDepartments(
    List<String> departmentsToBeAdded, int bookingId) async {
  String url = "${liveUrl}add_booking_departments";
  Uri urlUri = Uri.parse(url);

  // Create a list to store the JSON objects
  List<Map<String, dynamic>> requestBodyList = [];

  // Iterate through the department names and create JSON objects
  for (String departmentName in departmentsToBeAdded) {
    var returnValue = getDepartmentIdByName(departmentName);
    if (returnValue == 0) {
      // print(
      //     "please check department name as it doesnot exists in the database");
    } else {
      var requestBody = {
        "booking_id": bookingId.toString(),
        "department_id": returnValue
            .toString(), // Assuming departmentName can be used as department_id
        "created_at": DateTime.now().toString(),
      };
      requestBodyList.add(requestBody);
    }
  }

  var response = await http.post(urlUri,
      // headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBodyList));
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return BookingDepartmentsResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to add booking departments');
  }
}

Future<WithdrawBooking> withdrawBooking(BookingData value) async {
  String url = "${liveUrl}withdraw_booking";
  Uri urlUri = Uri.parse(url);
  var requestBody = {
    "booking_id": value.bookingId.toString(),
    "booking_status": value.bookingStatus.toString(),
    "booking_withdraw_by_id": value.bookingWithdrawById.toString(),
    "booking_withdraw_created_at": value.bookingWithdrawCreatedAt,
    "booking_withdraw_reason": value.bookingWithdrawReason,
  };

  var response = await http.post(urlUri,
      // headers: {"Content-Type": "application/json"},
      body: requestBody);
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return WithdrawBooking.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to withdraw booking');
  }
}

Future<DeleteBookingDepartmentDetails> deleteBookingDepartmentsByBookingId(
    int bookingId) async {
  String url = "${liveUrl}delete_booking_departments/$bookingId";
  Uri urlUri = Uri.parse(url);

  var response = await http.delete(
    urlUri,
    // headers: {"Content-Type": "application/json"},
  );
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return DeleteBookingDepartmentDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to delete booking departments');
  }
}

Future<DeleteBookingRefreshmentDetails> deleteBookingRefreshmentsByBookingId(
    int bookingId) async {
  String url = "${liveUrl}delete_booking_refreshments/$bookingId";
  Uri urlUri = Uri.parse(url);

  var response = await http.delete(
    urlUri,
    // headers: {"Content-Type": "application/json"},
  );
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return DeleteBookingRefreshmentDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to delete booking refreshments');
  }
}

Future<DeleteBookingAssetRequirementDetails>
    deleteBookingAssetRequirementsByBookingId(int bookingId) async {
  String url = "${liveUrl}delete_booking_asset_requirements/$bookingId";
  Uri urlUri = Uri.parse(url);

  var response = await http.delete(
    urlUri,
    // headers: {"Content-Type": "application/json"},
  );
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return DeleteBookingAssetRequirementDetails.fromJson(
        json.decode(response.body));
  } else {
    throw Exception('Failed to delete booking asset requirements');
  }
}

Future<BookingRefreshmentDetails> addBookingRefreshments(
    List<String> refreshmentsToBeAdded, int bookingId) async {
  String url = "${liveUrl}add_booking_refreshments";
  Uri urlUri = Uri.parse(url);

  // Create a list to store the JSON objects
  List<Map<String, dynamic>> requestBodyList = [];

  // Iterate through the department names and create JSON objects
  for (String refreshmentName in refreshmentsToBeAdded) {
    var returnValue = getRefreshmentIdByName(refreshmentName);
    if (returnValue == 0) {
      // print(
      //     "please check refreshment name as it doesnot exists in the database");
    } else {
      var requestBody = {
        "booking_id": bookingId.toString(),
        "refreshment_id": returnValue
            .toString(), // Assuming departmentName can be used as department_id
        "created_at": DateTime.now().toString(),
      };
      requestBodyList.add(requestBody);
    }
  }

  var response = await http.post(urlUri,
      // headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBodyList));
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return BookingRefreshmentDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to add booking refreshments');
  }
}

Future<BookingStationaryDetails> addBookingStationaries(
    List<String> stationariesToBeAdded, int bookingId) async {
  String url = "${liveUrl}add_booking_stationaries";
  Uri urlUri = Uri.parse(url);

  // Create a list to store the JSON objects
  List<Map<String, dynamic>> requestBodyList = [];

  // Iterate through the department names and create JSON objects
  for (String stationaryName in stationariesToBeAdded) {
    var returnValue = getStationaryIdByName(stationaryName);
    if (returnValue == 0) {
      // print(
      //     "please check refreshment name as it doesnot exists in the database");
    } else {
      var requestBody = {
        "booking_id": bookingId.toString(),
        "stationary_id": returnValue
            .toString(), // Assuming departmentName can be used as department_id
        "booking_stationary_created_at": DateTime.now().toString(),
      };
      requestBodyList.add(requestBody);
    }
  }

  var response = await http.post(urlUri,
      // headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBodyList));
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return BookingStationaryDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to add booking stationaries');
  }
}

Future<BookingStationaryDetails> getBookingStationariesByBookingId(
    int bookingId) async {
  String url = "${liveUrl}get_booking_stationaries/$bookingId";
  // print('${url} nknjjxczx');
  Uri urlUri = Uri.parse(url);
  // Map<String, String> requestBody = {
  //   'mobile1': mobile,
  //   'password': password,
  // };
  final response = await http.get(urlUri);
  // print("${response.body} nksdkjad");
  // if (response

  return BookingStationaryDetails.fromJson(json.decode(response.body));
  // } else {
  //   throw Exception('Failed to load Data');
  // }
}

Future<DeleteBookingStationariesDetails> deleteBookingStationariesByBookingId(
    int bookingId) async {
  String url = "${liveUrl}delete_booking_stationaries/$bookingId";
  Uri urlUri = Uri.parse(url);

  var response = await http.delete(
    urlUri,
    // headers: {"Content-Type": "application/json"},
  );
  // print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return DeleteBookingStationariesDetails.fromJson(
        json.decode(response.body));
  } else {
    throw Exception('Failed to delete booking stationaries');
  }
}

Future<BookingAssetRequirementDetails> addBookingAssetRequirement(
    List<String> assetRequirementsToBeAdded, int bookingId) async {
  String url = "${liveUrl}add_booking_asset_requirements";
  Uri urlUri = Uri.parse(url);

  // Create a list to store the JSON objects
  List<Map<String, dynamic>> requestBodyList = [];

  // Iterate through the department names and create JSON objects
  for (String assetName in assetRequirementsToBeAdded) {
    var returnValue = getAssetIdByName(assetName);
    if (returnValue == 0) {
      // print(
      //     "please check asset requirement name as it doesnot exists in the database");
    } else {
      var requestBody = {
        "booking_id": bookingId.toString(),
        "asset_requirement_id": returnValue
            .toString(), // Assuming departmentName can be used as department_id
        "created_at": DateTime.now().toString(),
      };
      requestBodyList.add(requestBody);
    }
  }

  var response = await http.post(urlUri,
      // headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBodyList));
  //print(response.body);
  if (response.statusCode == 200) {
    // Assuming the server returns the updated booking details in the response
    return BookingAssetRequirementDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to add booking asset requirement');
  }
}
