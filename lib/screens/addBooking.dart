import 'package:conference_hall_booking/source/exported_packages_for_easy_imports.dart';
import 'package:conference_hall_booking/source/constants.dart';
import 'package:intl/intl.dart';

class AddBooking extends StatefulWidget {
  final DateTime selectedStartTime;
  final DateTime selectedEndTime;
  final String selectedLocation;
  final String selectedConferenceHall;
  const AddBooking(
      {Key? key,
      required this.selectedStartTime,
      required this.selectedEndTime,
      required this.selectedLocation,
      required this.selectedConferenceHall})
      : super(key: key);

  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  TextEditingController _meetingTitleController = TextEditingController();
  TextEditingController _meetingDescriptionController = TextEditingController();
  TextEditingController _otherDetailsController = TextEditingController();
  TextEditingController _meetingReportedByController = TextEditingController();

  DateTime? selectedDate;
  DateTime dateTime = DateTime(2022, 12, 24);
  TimeOfDay? selectedStartTime;
  TimeOfDay printedStartTime = TimeOfDay(hour: 4, minute: 24);
  TimeOfDay? selectedEndTime;
  TimeOfDay printedEndTime = TimeOfDay(hour: 4, minute: 24);

  String? selectedLocation;
  callBack(varSelectedLocation) {
    setState(() {
      selectedLocation = varSelectedLocation;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   conferenceHallDetailsResponse = getConferenceHallDetails();
  //   _fetchConferenceHallData();
  // }

  // Future<void> _addBooking() async {
  //   // Create a BookingDetails object with the data you want to add
  //   BookingDetails newBooking = BookingDetails(
  //     data: [BookingData.fromJson({/* ... */})], // Add the data as needed
  //   );

  //   try {
  //     // Call the addBookingDetails function to add the booking
  //     BookingDetails addedBooking = await addBookingDetails(newBooking);
  //     // Handle the response as needed
  //     print('Booking added: ${addedBooking.toJson()}');
  //   } catch (e) {
  //     // Handle any errors that occur during the HTTP request
  //     print('Error adding booking: $e');
  //   }
  // }

  Future<TimeOfDay?> _selectedTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
  }

  Future<DateTime?> _selectedDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

  @override
  Widget build(BuildContext context) {
    print('${selectedLocation} sddddscddcdscsdcdscs');
    final conferenceHallImageName = getConferenceHallImageName(
        getConferenceHallId(widget.selectedConferenceHall));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15),
            // width: 352,
            // height: 641,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/conference_hall_images/${conferenceHallImageName}",
                              width: screenWidth * 0.24,
                              height: screenHeight * 0.15,
                            ),
                          )
                        ],
                      ),
                    ),
                    // Text('Start Time: ${widget.selectedStartTime}'),
                    // Text('End Time: ${widget.selectedEndTime}'),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),
                    // SizedBox(
                    //   width: 300,
                    //   child: ElevatedButton(
                    //     onPressed: () async {
                    //       final date = await _selectedDate(context);
                    //       if (date == null) return;
                    //       setState(() {
                    //         dateTime = date;
                    //         selectedDate = date;
                    //         toBeAddedBookingData.bookingDate =
                    //             selectedDate.toString();
                    //       });
                    //       print('${date} date date date date date');
                    //       print(
                    //           '${selectedDate.toString()} date date date date date');
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       minimumSize: Size(
                    //           300, 50), // Adjust the width and height as needed
                    //       primary: Colors.grey[
                    //           200], // Set the background color to light gray
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(
                    //             10.0), // Adjust the value as needed
                    //       ),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Icon(
                    //           Icons
                    //               .calendar_month, // Replace with the icon you want
                    //           color: Color(
                    //               0xFF696767), // Set the color of the icon
                    //           size: 24, // Set the size of the icon
                    //         ),
                    //         SizedBox(
                    //             width:
                    //                 8), // Add some spacing between the icon and text
                    //         Text(
                    //           selectedDate != null
                    //               ? '${dateTime.year}-${dateTime.month}-${dateTime.day}'
                    //               :
                    //               // controller: _meetingTitleController,
                    //               'Select Date',
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 14,
                    //             fontFamily: 'Noto Sans',
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      child: Container(
                        width: screenWidth * 0.9, // Adjust the width as needed
                        height: 50, // Adjust the height as needed
                        decoration: BoxDecoration(
                          color: Colors.grey[
                              200], // Set the background color to light gray
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Icon(
                                Icons
                                    .calendar_month, // Replace with the icon you want
                                color: Color(
                                    0xFF696767), // Set the color of the icon
                                size: 24, // Set the size of the icon
                              ),
                            ),
                            SizedBox(
                                width:
                                    8), // Add some spacing between the icon and text
                            Text(
                              '${widget.selectedStartTime.day}-${widget.selectedStartTime.month}-${widget.selectedStartTime.year}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Noto Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Timing',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons
                        //       .av_timer, // Replace with the icon you want
                        //   color: Color(
                        //       0xFF696767), // Set the color of the icon
                        //   size: 24, // Set the size of the icon
                        // ),
                        // SizedBox(
                        //     width:
                        //         8), // Add some spacing between the icon and text

                        // SizedBox(
                        //   width: 140,
                        //   child: ElevatedButton(
                        //     onPressed: () async {
                        //       // Handle button tap here
                        //       print('Button tapped');
                        //       final time = await _selectedTime(context);
                        //       if (time == null) return;
                        //       print(selectedStartTime);
                        //       setState(() {
                        //         printedStartTime = time;
                        //         selectedStartTime = time;
                        //         toBeAddedBookingData.strTime =
                        //             '${selectedStartTime!.hour.toString().padLeft(2, '0')}:${selectedStartTime!.minute.toString().padLeft(2, '0')}';
                        //       });
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       minimumSize: Size(100,
                        //           50), // Adjust the width and height as needed
                        //       primary: Colors.grey[
                        //           200], // Set the background color to light gray
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(
                        //             10.0), // Adjust the value as needed
                        //       ),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           Icons
                        //               .av_timer, // Replace with the icon you want
                        //           color: Color(
                        //               0xFF696767), // Set the color of the icon
                        //           size: 24, // Set the size of the icon
                        //         ),
                        //         SizedBox(
                        //             width:
                        //                 8), // Add some spacing between the icon and text
                        //         Text(
                        //           // controller: _meetingTitleController,
                        //           selectedStartTime != null
                        //               ? '${printedStartTime.hour.toString().padLeft(2, '0')}:${printedStartTime.minute.toString().padLeft(2, '0')}'
                        //               : 'Start Time',
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //             fontSize: 14,
                        //             fontFamily: 'Noto Sans',
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                            width: 130,
                            child: Container(
                              width: 140,
                              child: Card(
                                color: Colors.grey[
                                    200], // Set the background color to light gray
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust the value as needed
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons
                                            .av_timer, // Replace with the icon you want
                                        color: Color(
                                            0xFF696767), // Set the color of the icon
                                        size: 24, // Set the size of the icon
                                      ),
                                      SizedBox(
                                          width:
                                              8), // Add some spacing between the icon and text

                                      Text(
                                        //   '${widget.selectedStartTime.hour.toString().padLeft(2, '0')}:${widget.selectedStartTime.minute.toString().padLeft(2, '0')}',
                                        '${convertDateTimeTimeIntoDesiredFormat(widget.selectedStartTime)}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Noto Sans',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Text(
                            'to ',
                            style: TextStyle(
                              color: Color(0xFF696767),
                              fontSize: 12,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // SizedBox(
                        //   width: 140,
                        //   child: ElevatedButton(
                        //     onPressed: () async {
                        //       // Handle button tap here
                        //       print('Button tapped');
                        //       final time = await _selectedTime(context);
                        //       if (time == null) return;
                        //       print(selectedEndTime);
                        //       setState(() {
                        //         printedEndTime = time;
                        //         selectedEndTime = time;
                        //         toBeAddedBookingData.endTime =
                        //             '${selectedEndTime!.hour.toString().padLeft(2, '0')}:${selectedEndTime!.minute.toString().padLeft(2, '0')}';
                        //       });
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       minimumSize: Size(100,
                        //           50), // Adjust the width and height as needed
                        //       primary: Colors.grey[
                        //           200], // Set the background color to light gray
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(
                        //             10.0), // Adjust the value as needed
                        //       ),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           Icons
                        //               .av_timer, // Replace with the icon you want
                        //           color: Color(
                        //               0xFF696767), // Set the color of the icon
                        //           size: 24, // Set the size of the icon
                        //         ),
                        //         SizedBox(
                        //             width:
                        //                 8), // Add some spacing between the icon and text
                        //         Text(
                        //           // controller: _meetingTitleController,
                        //           selectedEndTime != null
                        //               ? '${printedEndTime.hour.toString().padLeft(2, '0')}:${printedEndTime.minute.toString().padLeft(2, '0')}'
                        //               : 'End Time',
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //             fontSize: 14,
                        //             fontFamily: 'Noto Sans',
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                            width: 130,
                            child: Container(
                              width: 140,
                              child: Card(
                                color: Colors.grey[
                                    200], // Set the background color to light gray
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust the value as needed
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons
                                            .av_timer, // Replace with the icon you want
                                        color: Color(
                                            0xFF696767), // Set the color of the icon
                                        size: 24, // Set the size of the icon
                                      ),
                                      SizedBox(
                                          width:
                                              8), // Add some spacing between the icon and text
                                      Text(
                                        // '${widget.selectedEndTime.hour.toString().padLeft(2, '0')}:${widget.selectedEndTime.minute.toString().padLeft(2, '0')}',
                                        '${convertDateTimeTimeIntoDesiredFormat(widget.selectedEndTime)}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Noto Sans',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Meeting Title',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),
                    SizedBox(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 1), // Adjust the padding as needed
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Use a light gray color
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        child: TextField(
                          controller: _meetingTitleController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Noto Sans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // Remove the default TextField border
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons
                    //           .pin_drop_outlined, // Replace with the icon you want
                    //       color: Colors
                    //           .yellow, // Set the color of the icon
                    //       size: 24, // Set the size of the icon
                    //     ),
                    //     // SizedBox(
                    //     //     width:
                    //     //         8), // Add some spacing between the icon and text

                    //   ],
                    // ),

                    // LocationsDropdown(callBackFunction: callBack),

                    SizedBox(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 50,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 1), // Adjust the padding as needed
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Use a light gray color
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        child: Text(
                          '${widget.selectedLocation}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Noto Sans',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Conference Room Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),
                    // Text(
                    //   widget.currentConferenceRoomName,
                    //   style: TextStyle(
                    //     color: Color(0xFFB88D05),
                    //     fontSize: 16,
                    //     fontFamily: 'Noto Sans',
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // ConferenceHallDropdown(),

                    SizedBox(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 50,
                        alignment: Alignment.center,
                        // width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors
                                  .transparent), // Set border color to transparent
                        ),
                        child: Text(
                          '${widget.selectedConferenceHall}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Noto Sans',
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Meeting Description',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),
                    SizedBox(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 1), // Adjust the padding as needed
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Use a light gray color
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        child: TextField(
                          controller: _meetingDescriptionController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Noto Sans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // Remove the default TextField border
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Other Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),

                    SizedBox(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 1), // Adjust the padding as needed
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Use a light gray color
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        child: TextField(
                          controller: _otherDetailsController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Noto Sans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // Remove the default TextField border
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Meeting Reported By',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(
                          0xFFC2C0C0), // Set the color of the divider line
                      thickness: 1, // Set the thickness of the divider line
                    ),
                    SizedBox(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 1), // Adjust the padding as needed
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Use a light gray color
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        child: TextField(
                          controller: _meetingReportedByController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Noto Sans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // Remove the default TextField border
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // if(currentUserData!.id == widget.currentBookingData)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SyncfusionCalendar()));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape:
                                CircleBorder(), // Use CircleBorder to make the button circular
                            backgroundColor: Colors
                                .red, // Change the button color to your preference
                            padding: EdgeInsets.all(
                                16.0), // Adjust the padding as needed
                          ),
                          child: Icon(
                            Icons
                                .cancel, // You can use your preferred edit icon here
                            color: Colors
                                .white, // Change the icon color to your preference
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              // toBeUpdatedBookingData.bookingId =
                              //     widget.currentBookingData
                              //         .bookingId;
                              toBeAddedBookingData.bookingMeetingTitle =
                                  _meetingTitleController.text;
                              toBeAddedBookingData.bookingMeetingDescription =
                                  _meetingDescriptionController.text;
                              toBeAddedBookingData.bookingOtherDetails =
                                  _otherDetailsController.text;
                              toBeAddedBookingData.bookingCreatedAt =
                                  DateTime.now().toString();
                              toBeAddedBookingData.bookingStatus = 1;
                              toBeAddedBookingData.userId = currentUserData!.id;
                              toBeAddedBookingData.bookingDate =
                                  widget.selectedStartTime.toString();
                              toBeAddedBookingData.bookingStartTime =
                                  '${widget.selectedStartTime.hour.toString().padLeft(2, '0')}:${widget.selectedStartTime.minute.toString().padLeft(2, '0')}';
                              toBeAddedBookingData.bookingEndTime =
                                  '${widget.selectedEndTime.hour.toString().padLeft(2, '0')}:${widget.selectedEndTime.minute.toString().padLeft(2, '0')}';
                              toBeAddedBookingData.bookingReportedBy =
                                  _meetingReportedByController.text;
                            });

                            var response =
                                await addBooking(toBeAddedBookingData);

                            if (response.status == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Booking added successfully!"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Failed to add booking"),
                                ),
                              );
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SyncfusionCalendar()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape:
                                CircleBorder(), // Use CircleBorder to make the button circular
                            backgroundColor: Colors
                                .green, // Change the button color to your preference
                            padding: EdgeInsets.all(
                                16.0), // Adjust the padding as needed
                          ),
                          child: Icon(
                            Icons
                                .check, // You can use your preferred edit icon here
                            color: Colors
                                .white, // Change the icon color to your preference
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
