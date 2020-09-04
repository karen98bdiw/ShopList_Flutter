import 'package:flutter/material.dart';
import '../utils/transactions_db.dart';
import '../models/transaction.dart';

//this widget is statefull because in stl texinput works uncorrectly
class NewTransactionAddingForm extends StatefulWidget {
  final Function _dataChangeHandler;

  NewTransactionAddingForm(this._dataChangeHandler);

  @override
  _NewTransactionAddFormState createState() => _NewTransactionAddFormState();
}

class _NewTransactionAddFormState extends State<NewTransactionAddingForm> {
  final _titleController = TextEditingController();

  final _priceController = TextEditingController();

  DateTime _inputedDate;

  Map<String, Object> _validateForm() {
    final inputedTitle = _titleController.text;
    final inputedPrice = _priceController.text;
    //TODO:add regex;

    if (inputedTitle.isNotEmpty &&
        inputedPrice.isNotEmpty &&
        _inputedDate != null) {
      var transaction =
          Transaction(inputedTitle, double.parse(inputedPrice), _inputedDate);

      return {
        "result": true,
        "transaction": transaction,
      };
    } else {
      return {
        "result": false,
        "transaction": null,
      };
    }
  }

  void _addData() {
    var validateResult = _validateForm();
    if (validateResult["result"]) {
      TransactionsDB.instance.addData(validateResult["transaction"]);
      widget._dataChangeHandler();
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  void _getDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _inputedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Title",
            ),
            controller: _titleController,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Price",
            ),
            controller: _priceController,
          ),
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _inputedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${_inputedDate}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _getDate,
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: _addData,
            color: Theme.of(context).primaryColor,
            child: Text(
              "Add Transaction",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
