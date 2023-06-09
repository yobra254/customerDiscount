import 'package:flutter/material.dart';
import 'package:customers/model/discount_helper.dart';

class DiscountList extends StatefulWidget {
  //const CustomerList({super.key});
  @override
  State<DiscountList> createState() => _DiscountListState();
}

class _DiscountListState extends State<DiscountList> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _addData() async {
    await SQLHelper.createData(
      _vehicleController.text,
      _numberController.text,
      _productController.text,
      _volumeController.text,
      _unitrateController.text,
      _totalController.text,
    );
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      _vehicleController.text,
      _numberController.text,
      _productController.text,
      _volumeController.text,
      _unitrateController.text,
      _totalController.text,
    );
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Data Deleted'),
      ),
    );
    _refreshData();
  }

  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _unitrateController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  void showBottomSheet(int? id) async {
    //if id is not null then it will update otherwise it will be added
    //when edit button is pressed id will be given to bottomsheet function and edited
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _vehicleController.text = existingData['vehicle'];
      _numberController.text = existingData['number'];
      _productController.text = existingData['product'];
      _volumeController.text = existingData['volume'];
      _unitrateController.text = existingData['unitrate'];
      _totalController.text = existingData['total'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 40.0,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _vehicleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Vehicle Number",
                isDense: true, // Added this
                //contentPadding: EdgeInsets.all(8),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _numberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Customer Phone Number",
                isDense: true, // Added this
                //contentPadding: EdgeInsets.all(8),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _productController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Product",
                isDense: true,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _volumeController,
              //maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Volume",
                isDense: true,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _unitrateController,
              //maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Unit Rate",
                isDense: true,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _totalController,
              //maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "TOTAL",
                isDense: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addData();
                  }
                  if (id != null) {
                    await _updateData(id);
                  }

                  _vehicleController.text = "";
                  _numberController.text = "";
                  _productController.text = "";
                  _volumeController.text = "";
                  _unitrateController.text = "";
                  _totalController.text = "";

//Hide Bottom Sheet
                  Navigator.of(context).pop();
                  print("Data Added");
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    id == null ? "Add Data" : "Update",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        title: Text(
          "Discounts",
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      _allData[index]['vehicle'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Text(_allData[index]['number']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showBottomSheet(_allData[index]['id']);
                        },
                        icon: Icon(
                          Icons.edit_square,
                          color: Colors.indigo,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteData(_allData[index]['id']);
                        },
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
