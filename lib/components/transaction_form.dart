import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptative_button.dart';
import './adaptative_textfield.dart';
import './adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) saveTransaction;

  TransactionForm(this.saveTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.saveTransaction(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AdaptativeTextfield(
              controller: _titleController,
              onSubmited: (_) => _submitForm(),
              label: 'Titulo',
            ),
            AdaptativeTextfield(
              controller: _valueController,
              onSubmited: (_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              label: 'Valor (R\$ )',
            ),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AdaptativeButton(
                  onPressed: _submitForm,
                  label: 'Salvar',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
