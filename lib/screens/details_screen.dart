import 'package:conference_hall_booking/models/booking_departments_model.dart';
import 'package:conference_hall_booking/source/constants.dart';
import 'package:conference_hall_booking/source/exported_packages_for_easy_imports.dart';

class DetailsScreen extends StatefulWidget {
  final BookingData currentBookingData;
  final String currentConferenceRoomName;
  final String currentLocationName;
  final String currentConferenceHallImageName;
  const DetailsScreen(
      {Key? key,
      required this.currentBookingData,
      required this.currentConferenceRoomName,
      required this.currentLocationName,
      required this.currentConferenceHallImageName})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class MultiSelectDepartmentsForEditing extends StatefulWidget {
  final List<String> departments;
  const MultiSelectDepartmentsForEditing({Key? key, required this.departments})
      : super(key: key);

  @override
  State<MultiSelectDepartmentsForEditing> createState() =>
      _MultiSelectDepartmentsForEditingState();
}

class _MultiSelectDepartmentsForEditingState
    extends State<MultiSelectDepartmentsForEditing> {
  // this variable holds the selected departments
  final List<String> _selectedDepartments = [];

  // This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedDepartments.add(itemValue);
      } else {
        _selectedDepartments.remove(itemValue);
      }
    });
  }

  // This function is called when the cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

  // this function is called when the submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedDepartments);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Departments'),
      content: SingleChildScrollView(
          child: ListBody(
        children: widget.departments
            .map((department) => CheckboxListTile(
                  value: _selectedDepartments.contains(department),
                  title: Text(department),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) => _itemChange(department, isChecked!),
                ))
            .toList(),
      )),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        )
      ],
    );
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _snackChecked = false;
  bool _biscuitChecked = false;
  bool _coffeeChecked = false;
  bool _teaChecked = false;
  int _snackQuantity = 0;
  int _biscuitQuantity = 0;
  int _coffeeQuantity = 0;
  int _teaQuantity = 0;
  get onPressed => null;
  bool isEditable = false;
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
  DateTime? currentBookingDate;
  BookingData toBeWithdrawnBookingNeededData = new BookingData();
  late Future<BookingDepartmentsResponse> bookingDepartmentsByBookingIdResponse;
  List<BookingDepartmentsData> listOfBookingDepartmentsByBookingId = [];

  Future<void> _fetchBookingDepartmentsByBookingIdDetails() async {
    try {
      final BookingDepartmentsResponse data =
          await bookingDepartmentsByBookingIdResponse;
      print('${data} casjkas');
      setState(() {
        if (data.data != null) {
          // accessing the 'data' of the api response and storing the value in global
          // variable listOfConferenceHall(defined in constants.dart file) after convering
          // it in list format. .toList() function is used to convert the data in list
          // format.
          listOfBookingDepartmentsByBookingId = data.data!.map((item) {
            return BookingDepartmentsData.fromJson(item.toJson());
          }).toList();
          print('${listOfBookingDepartmentsByBookingId} adbjnkxzx');
          _selectedDepartments = getListOfBookingDepartmentNames(
              listOfBookingDepartmentsByBookingId);
        }
      });
    } catch (error) {
      print('Error fetching booking departments by booking id data: $error');
    }
  }

  String? selectedLocation;
  callBackLocationName(varSelectedLocation) {
    setState(() {
      selectedLocation = varSelectedLocation;

      conferenceRoomChoosed = null;
      selectedConferenceHall = null;
    });
  }

  String? selectedConferenceHall;
  callBackConferenceHallName(varSelectedConferenceHall) {
    setState(() {
      selectedConferenceHall = varSelectedConferenceHall;
    });
  }

  Future<DateTime?> _selectedDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now()
            .add(Duration(days: 30)), // Restrict to one month from today
      );

  // Future<TimeOfDay?> _selectedTime(BuildContext context) {
  //   final now = DateTime.now();
  //   return showTimePicker(
  //       initialEntryMode: TimePickerEntryMode.dialOnly,
  //       context: context,
  //       initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
  // }

  Future<TimeOfDay?> _selectedTime(BuildContext context) async {
    final now = DateTime.now();
    final selectedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );

    if (selectedTime != null) {
      // Check if the selected minute is in the allowed list
      final allowedMinutes = [0, 30];
      if (!allowedMinutes.contains(selectedTime.minute)) {
        // Show an error message or select the nearest allowed minute here.
        // You can adjust the selected time as needed.
        // For example, round the minute to the nearest allowed minute.
        final nearestAllowedMinute = allowedMinutes.reduce((a, b) =>
            (a - selectedTime.minute).abs() < (b - selectedTime.minute).abs()
                ? a
                : b);
        return TimeOfDay(hour: selectedTime.hour, minute: nearestAllowedMinute);
      }
    }

    return selectedTime;
  }

  List<String> _selectedDepartments = [];

  void _showMultiSelectDepartments() async {
    List<String> departments = getDepartmentNames();

    final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelectDepartmentsForEditing(departments: departments);
        });

    if (results != null) {
      setState(() {
        _selectedDepartments = results;
      });
    }
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String reason = ""; // Store the input reason

        return AlertDialog(
          title: Text("Reason for Withdrawing the meeting"),
          content: TextField(
            onChanged: (text) {
              reason = text;
            },
            decoration: InputDecoration(
              hintText: "Enter your reason here",
            ),
            maxLines: null,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                print("Reason: $reason");

                // You can use the 'reason' variable for further processing
                print("${widget.currentBookingData.bookingId} fkjfjakdalsdka");

                toBeWithdrawnBookingNeededData.bookingId =
                    widget.currentBookingData.bookingId;

                toBeWithdrawnBookingNeededData.bookingStatus = 0;

                toBeWithdrawnBookingNeededData.bookingWithdrawById =
                    currentUserData!.id;

                toBeWithdrawnBookingNeededData.bookingWithdrawCreatedAt =
                    DateTime.now().toString();

                toBeWithdrawnBookingNeededData.bookingWithdrawReason = reason;

                // var response = await addReschedulingRequest(
                //     toBeAddedReschedulingRequestData);

                // if (response.status == 'success') {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text("Requested successfully!"),
                //   ));
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text("Failed to make a request!"),
                //   ));
                // }
                var response =
                    await withdrawBooking(toBeWithdrawnBookingNeededData);
                if (response.status == 'success') {
                  print('Saved Changes');
                  final snackBar = SnackBar(
                    content: Text('Withdrawn Successfully'),
                    backgroundColor: Colors.green,
                    duration:
                        Duration(seconds: 3), // Adjust the duration as needed
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    content: Text('Failed to withdraw booking'),
                    backgroundColor: Colors.red,
                    duration:
                        Duration(seconds: 3), // Adjust the duration as needed
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                // print("Reason: $reason");
                Navigator.of(context).pop();
              },
              child: Text("Withdraw"),
            ),
          ],
        );
      },
    );
  }

  void _showEditBookingConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Edit Booking'),
          content: Text('Are you sure you want to edit this booking?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  toBeUpdatedBookingData.bookingId =
                      widget.currentBookingData.bookingId;
                  toBeUpdatedBookingData.bookingMeetingTitle =
                      _meetingTitleController.text;
                  toBeUpdatedBookingData.bookingMeetingDescription =
                      _meetingDescriptionController.text;
                  toBeUpdatedBookingData.bookingOtherDetails =
                      _otherDetailsController.text;
                  toBeUpdatedBookingData.bookingUpdatedAt =
                      DateTime.now().toString();
                  toBeUpdatedBookingData.bookingReportedBy =
                      _meetingReportedByController.text;
                });

                var response = await updateBooking(toBeUpdatedBookingData);

                var deleteBookingDepartmentsResponse =
                    await deleteBookingDepartmentsByBookingId(
                        widget.currentBookingData.bookingId!);

                var bookingDepartmentsResponse = await addBookingDepartments(
                    _selectedDepartments, widget.currentBookingData.bookingId!);

                Navigator.of(dialogContext).pop(); // Close the dialog

                if (response.status == 'success' &&
                    deleteBookingDepartmentsResponse.status == 'success' &&
                    bookingDepartmentsResponse.status == 'success') {
                  setState(() {
                    isEditable = false;
                  });
                  await Future.delayed(
                      Duration(milliseconds: 300)); // Add a delay if needed
                  Navigator.of(context).popUntil((route) =>
                      route.isFirst); // Navigate after the dialog is closed
                  // Navigator.of(dialogContext).pushReplacement(MaterialPageRoute(
                  //   builder: (context) => const SyncfusionCalendar(),
                  // ));
                  // dialogContext
                  //     .read<BottomNavBarCubit>()
                  //     .updateSelectedItem(BottomNavBarItem.home);
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //   builder: (context) => const HomeScreen(),
                  // ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[300],
                      content: Text("Booking updated successfully!"),
                    ),
                  );
                } else if (response.message == 'Validation failed') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("${response.data}"),
                    ),
                  );
                } else if (response.message ==
                    'The requested time slot is not available.') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("${response.message}"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Failed to update booking"),
                    ),
                  );
                }

                // Navigator.of(dialogContext).pop(); // Close the dialog first
                // await Future.delayed(
                //     Duration(milliseconds: 300)); // Add a delay if needed
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  List<String> initialbookingDepartments = [];
  List<String> getListOfBookingDepartmentNames(
      List<BookingDepartmentsData> list) {
    print("${list} dhkdjkdasdas");
    for (var bookingDepartment in list) {
      print('${bookingDepartment.departmentId} njxsxxZXZ');
      initialbookingDepartments
          .add(getDepartmentNameById(bookingDepartment.departmentId!));
    }
    return initialbookingDepartments;
  }

  @override
  void initState() {
    _meetingTitleController = TextEditingController(
        text: widget.currentBookingData.bookingMeetingTitle);

    _meetingDescriptionController = TextEditingController(
        text: widget.currentBookingData.bookingMeetingDescription);
    _otherDetailsController = TextEditingController(
        text: widget.currentBookingData.bookingOtherDetails);
    _meetingReportedByController = TextEditingController(
        text: widget.currentBookingData.bookingReportedBy);
    currentBookingDate =
        DateTime.tryParse(widget.currentBookingData.bookingDate!);
    selectedLocation =
        getLocationName(widget.currentBookingData.bookingLocationId!);
    toBeUpdatedBookingData.bookingLocationId =
        getLocationId(widget.currentLocationName);
    toBeUpdatedBookingData.bookingConferenceId =
        getConferenceHallId(widget.currentConferenceRoomName);
    toBeUpdatedBookingData.bookingDate =
        widget.currentBookingData.bookingDate.toString();
    toBeUpdatedBookingData.bookingStartTime =
        widget.currentBookingData.bookingStartTime;
    toBeUpdatedBookingData.bookingEndTime =
        widget.currentBookingData.bookingEndTime;
    toBeUpdatedBookingData.bookingReportedBy =
        widget.currentBookingData.bookingReportedBy;

    bookingDepartmentsByBookingIdResponse =
        getBookingDepartmentsByBookingId(widget.currentBookingData.bookingId!);
    _fetchBookingDepartmentsByBookingIdDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('${_selectedDepartments} ddjknncxz');
    print('${currentBookingDate} chgjvhjbkhj');
    print('${widget.currentBookingData.bookingStartTime} chgjvhjbkhj');
    print('${widget.currentBookingData.bookingEndTime} chgjvhjbkhj');
    print(
        '${widget.currentBookingData.bookingMeetingDescription} nfcdcdzlkvmz');
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'Meeting Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: 0.16,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.03,
                ),
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.21, -0.98),
                    end: Alignment(-0.21, 0.98),
                    colors: [Colors.white, Color(0x00DBCC95)],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),

                    // SizedBox(
                    //   height: screenHeight * 0.02,
                    // ),
                    Container(
                        padding: EdgeInsets.all(15),
                        width: 352,
                        // height: 641,
                        decoration: BoxDecoration(
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
                          children: <Widget>[
                            if (isEditable == false)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (currentUserData!.id ==
                                              widget
                                                  .currentBookingData.userId &&
                                          currentBookingDate!
                                              .isAfter(DateTime.now()) ||
                                      ((currentUserData!.id ==
                                              widget
                                                  .currentBookingData.userId) &&
                                          (currentBookingDate!.day ==
                                                  DateTime.now().day &&
                                              currentBookingDate!.month ==
                                                  DateTime.now().month &&
                                              currentBookingDate!.year ==
                                                  DateTime.now().year &&
                                              (hourPartOfStringTime(widget
                                                          .currentBookingData
                                                          .bookingEndTime!) >=
                                                      DateTime.now().hour &&
                                                  minutePartOfStringTime(widget
                                                          .currentBookingData
                                                          .bookingEndTime!) <
                                                      DateTime.now().minute))))
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditable = true;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape:
                                                CircleBorder(), // Use CircleBorder to make the button circular
                                            backgroundColor: Colors
                                                .blue, // Change the button color to your preference
                                            padding: EdgeInsets.all(
                                                16.0), // Adjust the padding as needed
                                          ),
                                          child: Icon(
                                            Icons
                                                .edit, // You can use your preferred edit icon here
                                            color: Colors
                                                .white, // Change the icon color to your preference
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _showWithdrawDialog(context);
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
                                                .delete, // You can use your preferred edit icon here
                                            color: Colors
                                                .white, // Change the icon color to your preference
                                          ),
                                        ),
                                      ],
                                    ),
                                  Container(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.01,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/images/conference_hall_images/${widget.currentConferenceHallImageName}",
                                            width: screenWidth * 0.24,
                                            height: screenHeight * 0.15,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Text(
                                    '${widget.currentBookingData.bookingMeetingTitle}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      fontWeight: FontWeight.w700,
                                      // fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    color: Color(
                                        0xFFC2C0C0), // Set the color of the divider line
                                    thickness:
                                        1, // Set the thickness of the divider line
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.currentConferenceRoomName,
                                      style: TextStyle(
                                        color: Color(0xFFB88D05),
                                        fontSize: 16,
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .calendar_month, // Replace with the icon you want
                                        color: Color(
                                            0xFF696767), // Set the color of the icon
                                        size: 20, // Set the size of the icon
                                      ),
                                      // SizedBox(
                                      //     width:
                                      //         8), // Add some spacing between the icon and text
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5,
                                              ),
                                              child: Text(
                                                '${convertStringDateIntoDesiredFormat(widget.currentBookingData.bookingDate!)}',
                                                style: TextStyle(
                                                  color: Color(0xFF696767),
                                                  fontSize: 12,
                                                  fontFamily: 'Noto Sans',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ))),
                                      SizedBox(
                                        width: screenWidth * 0.05,
                                      ),
                                      Icon(
                                        Icons
                                            .av_timer, // Replace with the icon you want
                                        color: Color(
                                            0xFF696767), // Set the color of the icon
                                        size: 20, // Set the size of the icon
                                      ),
                                      // SizedBox(
                                      //     width:
                                      //         8), // Add some spacing between the icon and text
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5,
                                              ),
                                              child: Text(
                                                '${convertStringTimeIntoDesiredFormat(widget.currentBookingData.bookingStartTime!)} to ${convertStringTimeIntoDesiredFormat(widget.currentBookingData.bookingEndTime!)}',
                                                style: TextStyle(
                                                  color: Color(0xFF696767),
                                                  fontSize: 12,
                                                  fontFamily: 'Noto Sans',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )))
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .pin_drop_outlined, // Replace with the icon you want
                                        color: Color(0xFF696767),
                                        size: 20, // Set the size of the icon
                                      ),
                                      // SizedBox(
                                      //     width:
                                      //         8), // Add some spacing between the icon and text
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5,
                                              ),
                                              child: Text(
                                                widget.currentLocationName,
                                                style: TextStyle(
                                                  color: Color(0xFF696767),
                                                  fontSize: 14,
                                                  fontFamily: 'Noto Sans',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )))
                                    ],
                                  ),
                                  // Text(
                                  //   'Location',
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //     fontSize: 14,
                                  //     fontFamily: 'Noto Sans',
                                  //     fontWeight: FontWeight.w700,
                                  //   ),
                                  // ),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  //),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),

                                  Text(
                                    '${widget.currentBookingData.bookingMeetingDescription}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                    'About Room',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    color: Color(
                                        0xFFC2C0C0), // Set the color of the divider line
                                    thickness:
                                        1, // Set the thickness of the divider line
                                  ),
                                  Text(
                                    getConferenceHallDescription(widget
                                        .currentBookingData
                                        .bookingConferenceId!),
                                    style: TextStyle(
                                      color: Colors.grey[850],
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      // fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Text(
                                    'Additional Requirements',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    color: Color(
                                        0xFFC2C0C0), // Set the color of the divider line
                                    thickness:
                                        1, // Set the thickness of the divider line
                                  ),
                                  Text(
                                    '${widget.currentBookingData.bookingOtherDetails}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      // fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Text(
                                    'Meeting Reported By',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    color: Color(
                                        0xFFC2C0C0), // Set the color of the divider line
                                    thickness:
                                        1, // Set the thickness of the divider line
                                  ),
                                  Text(
                                    '${widget.currentBookingData.bookingReportedBy}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Noto Sans',
                                      // fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: MeetingUpdateButtons(
                                      bookingUserId:
                                          widget.currentBookingData.userId!,
                                      bookingId:
                                          widget.currentBookingData.bookingId!,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.01,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/images/conference_hall_images/${widget.currentConferenceHallImageName}",
                                            width: screenWidth * 0.24,
                                            height: screenHeight * 0.15,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
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
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
                                  SizedBox(height: screenHeight * 0.01),
                                  SizedBox(
                                    width: 300,
                                    // height: 25,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical:
                                              1), // Adjust the padding as needed
                                      decoration: BoxDecoration(
                                        color: Colors.grey[
                                            200], // Use a light gray color
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
                                  Align(
                                    alignment: Alignment.centerLeft,
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
                                  SizedBox(height: screenHeight * 0.01),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
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
                                  LocationsDropdown(
                                      callBackFunction: callBackLocationName,
                                      initialSelectedLocation:
                                          widget.currentLocationName),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
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
                                  SizedBox(height: screenHeight * 0.01),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
                                  // Text(
                                  //   widget.currentConferenceRoomName,
                                  //   style: TextStyle(
                                  //     color: Color(0xFFB88D05),
                                  //     fontSize: 16,
                                  //     fontFamily: 'Noto Sans',
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                  ConferenceHallDropdown(
                                      callBackFunction:
                                          callBackConferenceHallName,
                                      locationName: selectedLocation!,
                                      initialSelectedConferenceHall:
                                          widget.currentConferenceRoomName),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Align(
                                    alignment: Alignment.centerLeft,
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
                                  SizedBox(height: screenHeight * 0.01),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
                                  SizedBox(
                                    width: 300,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final date =
                                            await _selectedDate(context);
                                        if (date == null) return;
                                        setState(() {
                                          dateTime = date;
                                          selectedDate = date;
                                          toBeUpdatedBookingData.bookingDate =
                                              selectedDate.toString();
                                        });
                                        print(date);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(300,
                                            50), // Adjust the width and height as needed
                                        backgroundColor: Colors.grey[
                                            200], // Set the background color to light gray
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Adjust the value as needed
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .calendar_month, // Replace with the icon you want
                                            color: Color(
                                                0xFF696767), // Set the color of the icon
                                            size:
                                                24, // Set the size of the icon
                                          ),
                                          SizedBox(
                                              width:
                                                  8), // Add some spacing between the icon and text
                                          Text(
                                            selectedDate != null
                                                // ? '${dateTime.year}-${dateTime.month}-${dateTime.day}'
                                                ? '${convertDateTimeDateIntoDesiredFormat(dateTime)}'
                                                :
                                                // controller: _meetingTitleController,
                                                // '${widget.currentBookingData.bookingDate}',
                                                '${convertStringDateIntoDesiredFormat(widget.currentBookingData.bookingDate!)}',
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
                                  Align(
                                    alignment: Alignment.centerLeft,
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
                                  SizedBox(height: screenHeight * 0.01),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          // width: 100,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              // Handle button tap here
                                              print('Button tapped');
                                              final time =
                                                  await _selectedTime(context);
                                              if (time == null) return;
                                              print(selectedStartTime);
                                              setState(() {
                                                printedStartTime = time;
                                                selectedStartTime = time;
                                                toBeUpdatedBookingData
                                                        .bookingStartTime =
                                                    '${selectedStartTime!.hour.toString().padLeft(2, '0')}:${selectedStartTime!.minute.toString().padLeft(2, '0')}';
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(100,
                                                  50), // Adjust the width and height as needed
                                              backgroundColor: Colors.grey[
                                                  200], // Set the background color to light gray
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10.0), // Adjust the value as needed
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .av_timer, // Replace with the icon you want
                                                  color: Color(
                                                      0xFF696767), // Set the color of the icon
                                                  size:
                                                      24, // Set the size of the icon
                                                ),
                                                SizedBox(
                                                    width:
                                                        8), // Add some spacing between the icon and text
                                                Text(
                                                  // controller: _meetingTitleController,
                                                  selectedStartTime != null
                                                      // ? '${printedStartTime.hour.toString().padLeft(2, '0')}:${printedStartTime.minute.toString().padLeft(2, '0')}'
                                                      ? '${convertTimeOfDayTimeIntoDesiredFormat(printedStartTime)}'
                                                      : '${convertStringTimeIntoDesiredFormat(widget.currentBookingData.bookingStartTime!)}',
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
                                      ),
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
                                      Expanded(
                                        child: SizedBox(
                                          // width: 100,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              // Handle button tap here
                                              print('Button tapped');
                                              final time =
                                                  await _selectedTime(context);
                                              if (time == null) return;
                                              print(selectedEndTime);
                                              setState(() {
                                                printedEndTime = time;
                                                selectedEndTime = time;
                                                toBeUpdatedBookingData
                                                        .bookingEndTime =
                                                    '${selectedEndTime!.hour.toString().padLeft(2, '0')}:${selectedEndTime!.minute.toString().padLeft(2, '0')}';
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(100,
                                                  50), // Adjust the width and height as needed
                                              backgroundColor: Colors.grey[
                                                  200], // Set the background color to light gray
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10.0), // Adjust the value as needed
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .av_timer, // Replace with the icon you want
                                                  color: Color(
                                                      0xFF696767), // Set the color of the icon
                                                  size:
                                                      24, // Set the size of the icon
                                                ),
                                                SizedBox(
                                                    width:
                                                        8), // Add some spacing between the icon and text
                                                Text(
                                                  // controller: _meetingTitleController,
                                                  selectedEndTime != null
                                                      // ? '${printedEndTime.hour.toString().padLeft(2, '0')}:${printedEndTime.minute.toString().padLeft(2, '0')}'
                                                      ? '${convertTimeOfDayTimeIntoDesiredFormat(printedEndTime)}'
                                                      : '${convertStringTimeIntoDesiredFormat(widget.currentBookingData.bookingEndTime!)}',
                                                  // : '${widget.currentBookingData.bookingEndTime}',
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
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
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
                                  SizedBox(height: screenHeight * 0.01),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
                                  SizedBox(
                                    width: 300,
                                    // height: 25,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical:
                                              1), // Adjust the padding as needed
                                      decoration: BoxDecoration(
                                        color: Colors.grey[
                                            200], // Use a light gray color
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the value as needed
                                      ),
                                      child: TextField(
                                        controller:
                                            _meetingDescriptionController,
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Additional Requirements',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
                                  SizedBox(
                                    width: 300,
                                    // height: 25,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical:
                                              1), // Adjust the padding as needed
                                      decoration: BoxDecoration(
                                        color: Colors.grey[
                                            200], // Use a light gray color
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

                                  Align(
                                    alignment: Alignment.centerLeft,
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
                                  SizedBox(height: screenHeight * 0.01),
                                  // Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness:
                                  //       1, // Set the thickness of the divider line
                                  // ),
                                  SizedBox(
                                    width: 300,
                                    // height: 25,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical:
                                              1), // Adjust the padding as needed
                                      decoration: BoxDecoration(
                                        color: Colors.grey[
                                            200], // Use a light gray color
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the value as needed
                                      ),
                                      child: TextField(
                                        controller:
                                            _meetingReportedByController,
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

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: screenWidth *
                                          0.5, // Set the desired width
                                      child: ElevatedButton(
                                        onPressed: _showMultiSelectDepartments,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber[100],
                                          foregroundColor: Colors.black,
                                          padding: EdgeInsets.all(10),
                                          textStyle: TextStyle(fontSize: 18),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text('Select Department'),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.only(left: 15.0),
                                  //     child: Text(
                                  //       'Select Departments',
                                  //       style: TextStyle(
                                  //         color: Colors.black,
                                  //         fontSize: 14,
                                  //         fontFamily: 'Noto Sans',
                                  //         fontWeight: FontWeight.w700,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  // const Divider(
                                  //   color: Color(
                                  //       0xFFC2C0C0), // Set the color of the divider line
                                  //   thickness: 1,
                                  // ),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      children: _selectedDepartments
                                          .map((e) => Chip(
                                                label: Text(e),
                                              ))
                                          .toList(),
                                    ),
                                  ),

                                  // ElevatedButton(
                                  //   onPressed: _showMultiSelectDepartments,
                                  //   style: ElevatedButton.styleFrom(
                                  //     shape:
                                  //         CircleBorder(), // Use CircleBorder to make the button circular
                                  //     backgroundColor: Colors.grey[
                                  //         200], // Change the button color to your preference
                                  //     padding: EdgeInsets.all(
                                  //         11.0), // Adjust the padding as needed
                                  //   ),
                                  //   child: Icon(
                                  //     Icons
                                  //         .add, // You can use your preferred edit icon here
                                  //     color: Colors
                                  //         .black, // Change the icon color to your preference
                                  //   ),
                                  // ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     'Facilities',
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 14,
                                  //       fontFamily: 'Noto Sans',
                                  //       fontWeight: FontWeight.w700,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // SizedBox(
                                  //   width: 300,
                                  //   height: 210,
                                  //   // height: 25,
                                  //   child: Container(
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: 15.0,
                                  //         vertical:
                                  //             1), // Adjust the padding as needed
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey[
                                  //           200], // Use a light gray color
                                  //       borderRadius: BorderRadius.circular(
                                  //           10.0), // Adjust the value as needed
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: MeetingUpdateButtons(
                                  //     bookingId:
                                  //         widget.currentBookingData.bookingId!,
                                  //     bookingUserId:
                                  //         widget.currentBookingData.userId!,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // if(currentUserData!.id == widget.currentBookingData)
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isEditable = false;
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
                                        onPressed: () {
                                          _showEditBookingConfirmationDialog(
                                              context);
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
                  ],
                ))));
  }

  Widget _buildCheckboxRow(String label, bool checked, int quantity) {
    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: (value) {
            setState(() {
              if (label == 'Snack') {
                _snackChecked = value!;
              } else if (label == 'Biscuit') {
                _biscuitChecked = value!;
              } else if (label == 'Coffee') {
                _coffeeChecked = value!;
              } else if (label == 'Tea') {
                _teaChecked = value!;
              }
            });
          },
        ),
        Text(label),
        if (checked)
          GestureDetector(
            onTap: () {
              _showQuantityDialog(label);
            },
            child: Text(' ($quantity)'),
          ),
      ],
    );
  }

  void _showQuantityDialog(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int quantity;
        if (item == 'Snack') {
          quantity = _snackQuantity;
        } else if (item == 'Biscuit') {
          quantity = _biscuitQuantity;
        } else if (item == 'Coffee') {
          quantity = _coffeeQuantity;
        } else if (item == 'Tea') {
          quantity = _teaQuantity;
        } else {
          // Provide a default value for the 'quantity' variable
          quantity = 0;
        }

        return AlertDialog(
          title: Text('Select Quantity for $item'),
          content: Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    quantity = (quantity - 1).clamp(0, 99);
                  });
                },
              ),
              Text('$quantity'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    quantity = (quantity + 1).clamp(0, 99);
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  if (item == 'Snack') {
                    _snackQuantity = quantity;
                  } else if (item == 'Biscuit') {
                    _biscuitQuantity = quantity;
                  } else if (item == 'Coffee') {
                    _coffeeQuantity = quantity;
                  } else if (item == 'Tea') {
                    _teaQuantity = quantity;
                  }
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
