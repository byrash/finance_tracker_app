import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;

  NewTransaction(this.onAddTransaction) {
    print("NewTransaction Constructor");
  }

  @override
  State<NewTransaction> createState() {
    print("NewTransaction Create State");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  _NewTransactionState() {
    print("_NewTransactionState Constructor");
  }

  @override
  void initState() {
    super.initState();
    print("_NewTransactionState init state");
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_NewTransactionState did update widget ");
  }

  @override
  void dispose() {
    super.dispose();
    print("_NewTransactionState dispose");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (val) {
                  _onSubmit();
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text("Selected Date: " +
                            DateFormat.yMMMd().format(_selectedDate))),
                    ElevatedButton(
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date'),
                    )
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _onSubmit,
                      child: Text("Add Transaction"))
                  : ElevatedButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(TextStyle(
                              color: Theme.of(context).primaryColorLight))),
                      onPressed: _onSubmit,
                      child: Text("Add Transaction")),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    var enteredAmt = double.parse(_amountController.text);
    var enertedTitle = _titleController.text;
    if (enteredAmt <= 0 || enertedTitle.trim().isEmpty) {
      return;
    }
    widget.onAddTransaction(enertedTitle, enteredAmt, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }
}
