import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:qverbo/Screens/paymentscreen.dart';
import 'package:qverbo/services/firestore.dart';

class CheckinScreen extends StatefulWidget {
  final List<Map<String, dynamic>> roomList;
  final Map<String, dynamic> accommodationDetails;

  CheckinScreen({required this.roomList, required this.accommodationDetails});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  late int? _selectedRadio;

  final config = CalendarDatePicker2WithActionButtonsConfig(
    calendarType: CalendarDatePicker2Type.range,
    disableModePicker: true,
  );

  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  List<DateTime?> _formattedDates = [];
  String _checkinString = '';
  String _checkoutString = '';
  int _numberOfDays = 0;
  Map<String, dynamic> selectedRoomData = {};
  FireStoreService fireStoreService = FireStoreService(); //

  @override
  void initState() {
    super.initState();
    _selectedRadio = 0;
    if (widget.roomList.isNotEmpty) {
      selectedRoomData = widget.roomList[0];
    }
    _onRoomCardSelected(_selectedRadio!);
    print('Selected Room : $selectedRoomData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'RESERVE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Container(
                        height: 400,
                        width: 300,
                        child: _buildDefaultRangeDatePickerWithValue(),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            _formattedDates = _getValueText(config.calendarType,
                                _rangeDatePickerValueWithDefaultValue);
                            if (_formattedDates.length >= 2) {
                              _checkinString = _formattedDates[0] != null
                                  ? '${_formattedDates[0]!.month}/${_formattedDates[0]!.day}/${_formattedDates[0]!.year}'
                                  : '';
                              _checkoutString = _formattedDates[1] != null
                                  ? '${_formattedDates[1]!.month}/${_formattedDates[1]!.day}/${_formattedDates[1]!.year}'
                                  : '';
                              _numberOfDays = _calculateNumberOfDays();
                            }
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Center(child: Text('Choose Dates')),
                ),
              ),
              SizedBox(height: 10),
              Text('Check in date: $_checkinString'),
              SizedBox(height: 10),
              Text('Check out date: $_checkoutString'),
              SizedBox(height: 10),
              Text('Number of Days: $_numberOfDays'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.roomList.length,
                itemBuilder: (BuildContext context, int index) {
                  return roomCard(index);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange),
                  width: 200,
                  height: 40,
                  child: const Center(
                    child: (Text(
                      'RESERVE',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    )),
                  )),
            ],
          ),
          onTap: () {
            // Check if both check-in and check-out dates are selected
            if (_checkinString.isNotEmpty && _checkoutString.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    accomodationDetails: widget.accommodationDetails,
                    selectedRoom: selectedRoomData,
                    checkindate: _checkinString,
                    checkoutdate: _checkoutString,
                  ),
                ),
              );
            } else {
              // Show a message or perform any action if both dates are not selected
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content:
                      Text('Please select both check-in and check-out dates.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Choose Dates'),
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        ),
        const SizedBox(height: 3),
      ],
    );
  }

  List<DateTime?> _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    final List<DateTime?> formattedDates = [];

    if (values.isEmpty) return formattedDates;

    formattedDates.addAll(values);

    return formattedDates;
  }

  int _calculateNumberOfDays() {
    if (_formattedDates.length == 2 &&
        _formattedDates[0] != null &&
        _formattedDates[1] != null) {
      // Calculate the difference in days
      int numberOfDays =
          _formattedDates[1]!.difference(_formattedDates[0]!).inDays;
      return numberOfDays;
    }
    return 0;
  }

  Map<String, dynamic> _onRoomCardSelected(int selectedIndex) {
    Map<String, dynamic> selectedRoom = widget.roomList[selectedIndex];
    return selectedRoom;
  }

  Widget roomCard(int index) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomList[index]['Name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${widget.roomList[index]['Price']} per night'),
            Text(widget.roomList[index]['Description']),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.roomList[index]['Amenities'].length,
              itemBuilder: (BuildContext context, int amenityIndex) {
                return ListTile(
                  title: Text(
                    widget.roomList[index]['Amenities'][amenityIndex],
                  ),
                );
              },
            ),
          ],
        ),
        trailing: Radio<int>(
          value: index, // Use the index as the value for the radio button
          groupValue: _selectedRadio, // Use a group value to maintain selection
          onChanged: (value) {
            setState(() {
              _selectedRadio = value;
              selectedRoomData = _onRoomCardSelected(value!);
            });
          },
        ),
      ),
    );
  }
}
