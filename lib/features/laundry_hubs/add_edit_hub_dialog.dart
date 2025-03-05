import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditHubDialog extends StatefulWidget {
  final Map<String, dynamic>? hubData;

  AddEditHubDialog({this.hubData});

  @override
  _AddEditHubDialogState createState() => _AddEditHubDialogState();
}

class _AddEditHubDialogState extends State<AddEditHubDialog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  late TextEditingController _nameController;
  late TextEditingController _capacityController;
  late TextEditingController _addressLineController;
  late TextEditingController _placeController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _pinController;
  late TextEditingController _mapsLinkController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.hubData?['name'] ?? '');
    _capacityController = TextEditingController(
        text: widget.hubData?['capacity']?.toString() ?? '');
    _addressLineController =
        TextEditingController(text: widget.hubData?['address_line'] ?? '');
    _placeController =
        TextEditingController(text: widget.hubData?['place'] ?? '');
    _districtController =
        TextEditingController(text: widget.hubData?['district'] ?? '');
    _stateController =
        TextEditingController(text: widget.hubData?['state'] ?? '');
    _pinController = TextEditingController(text: widget.hubData?['pin'] ?? '');
    _mapsLinkController =
        TextEditingController(text: widget.hubData?['maps_link'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    _addressLineController.dispose();
    _placeController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    _mapsLinkController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.hubData != null ? 'Edit Laundry Hub' : 'Add Laundry Hub'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _image == null
                    ? Image.asset('assets/placeholder.png',
                        height: 100, width: 100)
                    : Image.file(File(_image!.path), height: 100, width: 100),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Hub Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the hub name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _capacityController,
                decoration: InputDecoration(labelText: 'Capacity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the capacity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressLineController,
                decoration: InputDecoration(labelText: 'Address Line'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the address line';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _placeController,
                decoration: InputDecoration(labelText: 'Place'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the place';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _districtController,
                decoration: InputDecoration(labelText: 'District'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the district';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the state';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pinController,
                decoration: InputDecoration(labelText: 'PIN'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the PIN';
                  }
                  if (value.length != 6) {
                    return 'Please enter a valid 6-digit PIN';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mapsLinkController,
                decoration: InputDecoration(labelText: 'Google Maps Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Google Maps link';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text(widget.hubData != null ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
