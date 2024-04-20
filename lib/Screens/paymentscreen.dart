import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> accomodationDetails;
  final Map<String, dynamic> selectedRoom;
  final String checkindate;
  final String checkoutdate;

  PaymentScreen({
    required this.accomodationDetails,
    required this.selectedRoom,
    required this.checkindate,
    required this.checkoutdate,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvcController = TextEditingController();
  var selectedmethod = 'Gcash';
  var paymentmessage = '';

  @override
  Widget build(BuildContext context) {
    int vat = (widget.selectedRoom['Price'] * 0.05).toInt();

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.accomodationDetails['data']['Name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.accomodationDetails['data']['Town'],
                        ),
                        SizedBox(height: 10),
                        Text('CHECK-IN DATE: ${widget.checkindate}'),
                        SizedBox(height: 5),
                        Text('CHECK-OUT DATE: ${widget.checkoutdate}'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PRICE INFORMATION',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Room Price: \$${widget.selectedRoom['Price']}'),
                        SizedBox(height: 5),
                        Text('VAT: \$${vat.toString()}'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          title: Text('Credit Card'),
                          leading: Radio<String>(
                            value: 'Credit Card',
                            groupValue: _selectedPaymentMethod,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedPaymentMethod = value;
                              });
                            },
                          ),
                        ),
                        if (_selectedPaymentMethod == 'Credit Card') ...[
                          SizedBox(height: 10),
                          Text(
                            'Credit Card Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _cardNumberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Credit Card Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _cardHolderNameController,
                            decoration: InputDecoration(
                              labelText: 'Cardholder Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _expiryDateController,
                                  decoration: InputDecoration(
                                    labelText: 'Expiry Date',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _cvcController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'CVC/CVV',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        ListTile(
                          title: Text('InstaPay'),
                          leading: Radio<String>(
                            value: 'InstaPay',
                            groupValue: _selectedPaymentMethod,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedPaymentMethod = value;
                              });
                            },
                          ),
                        ),
                        if (_selectedPaymentMethod == 'InstaPay') ...[
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownMenu(
                                width: 400,
                                onSelected: (s) {
                                  selectedmethod = s!;
                                },
                                dropdownMenuEntries: [
                                  DropdownMenuEntry(
                                      value: 'Gcash',
                                      label: 'Gcash',
                                      trailingIcon: Container(
                                          height: 10,
                                          width: 20,
                                          child:
                                              Image.asset('assets/gcash.png'))),
                                  DropdownMenuEntry(
                                      value: 'Paypal',
                                      label: 'Paypal',
                                      trailingIcon: Container(
                                          height: 10,
                                          width: 20,
                                          child: Image.asset(
                                              'assets/paypal.png'))),
                                  DropdownMenuEntry(
                                      value: 'Maya',
                                      label: 'Maya',
                                      trailingIcon: Container(
                                          height: 20,
                                          width: 50,
                                          child: Image.asset('maya.png'))),
                                ]),
                          ),
                          SizedBox(height: 10),
                          Text(paymentmessage),
                        ]
                      ],
                    ),
                  ),
                ),
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
                      'BOOK NOW',
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
          },
        ),
      ),
    );
  }
}
