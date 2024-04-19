import 'package:flutter/material.dart';

class RoomList extends StatefulWidget {
   String name;
   String description;
   List<String> ammenities;
   String price;

  RoomList({
   required this.name,
   required this.description,
   required this.ammenities,
   required this.price
  });

  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {

  @override
  Widget build(BuildContext context) {
    return
     Column(
      children: [
          itemCount: ,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Column(
                  children: [
                    Text(widget.name, style:TextStyle(fontWeight: FontWeight.bold)),
                    Text('${widget.price}per night'),
                    Text(widget.description),
                    ListView.builder(itemBuilder: BuildContext context, int index  )
                  ],
                ),
                trailing: Checkbox(
                  value: _selected[index],
                  onChanged: (value) {
                    setState(() {
                      _selected[index] = value!;
                    });
                  },
                ),
              ),
            );
          },
        
        FloatingActionButton(
          onPressed: () {
            // Handle action for selected items
            List<int> selectedIndexes = [];
            for (int i = 0; i < _selected.length; i++) {
              if (_selected[i]) {
                selectedIndexes.add(i);
              }
            }
            print('Selected indexes: $selectedIndexes');
          },
          child: Icon(Icons.check),
        )
      ],
    );
  }
}
