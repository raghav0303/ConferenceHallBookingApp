class BookingDetails {
  bool? status;
  String? message;
  List<BookingData>? data;

  BookingDetails({this.status, this.message, this.data});

  BookingDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookingData>[];
      json['data'].forEach((v) {
        data!.add(new BookingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingData {
  int? bookingId;
  String? bookingDate;
  String? bookingStartTime;
  String? bookingEndTime;
  String? bookingMeetingTitle;
  int? bookingLocationId;
  int? bookingConferenceId;
  String? bookingMeetingDescription;
  String? bookingOtherDetails;
  int? bookingStatus;
  int? userId;
  String? bookingCreatedAt;
  String? bookingUpdatedAt;
  int? bookingCreatedById;
  int? bookingUpdatedById;

  BookingData(
      {this.bookingId,
      this.bookingDate,
      this.bookingStartTime,
      this.bookingEndTime,
      this.bookingMeetingTitle,
      this.bookingLocationId,
      this.bookingConferenceId,
      this.bookingMeetingDescription,
      this.bookingOtherDetails,
      this.bookingStatus,
      this.userId,
      this.bookingCreatedAt,
      this.bookingUpdatedAt,
      this.bookingCreatedById,
      this.bookingUpdatedById});

  BookingData.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingDate = json['booking_date'];
    bookingStartTime = json['booking_start_time'];
    bookingEndTime = json['booking_end_time'];
    bookingMeetingTitle = json['booking_meeting_title'];
    bookingLocationId = json['booking_location_id'];
    bookingConferenceId = json['booking_conference_id'];
    bookingMeetingDescription = json['booking_meeting_description'];
    bookingOtherDetails = json['booking_other_details'];
    bookingStatus = json['booking_status'];
    userId = json['user_id'];
    bookingCreatedAt = json['booking_created_at'];
    bookingUpdatedAt = json['booking_updated_at'];
    bookingCreatedById = json['booking_created_by_id'];
    bookingUpdatedById = json['booking_updated_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_date'] = this.bookingDate;
    data['booking_start_time'] = this.bookingStartTime;
    data['booking_end_time'] = this.bookingEndTime;
    data['booking_meeting_title'] = this.bookingMeetingTitle;
    data['booking_location_id'] = this.bookingLocationId;
    data['booking_conference_id'] = this.bookingConferenceId;
    data['booking_meeting_description'] = this.bookingMeetingDescription;
    data['booking_other_details'] = this.bookingOtherDetails;
    data['booking_status'] = this.bookingStatus;
    data['user_id'] = this.userId;
    data['booking_created_at'] = this.bookingCreatedAt;
    data['booking_updated_at'] = this.bookingUpdatedAt;
    data['booking_created_by_id'] = this.bookingCreatedById;
    data['booking_updated_by_id'] = this.bookingUpdatedById;
    return data;
  }
}
