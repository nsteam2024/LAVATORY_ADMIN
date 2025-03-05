import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lavatory_admin/common_widget/custom_alert_dialog.dart';
import 'package:lavatory_admin/util/file_upload.dart';
import 'package:lavatory_admin/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddEditHubDialog extends StatefulWidget {
  final Map<String, dynamic>? hubData;

  AddEditHubDialog({this.hubData});

  @override
  _AddEditHubDialogState createState() => _AddEditHubDialogState();
}

class _AddEditHubDialogState extends State<AddEditHubDialog> {
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _image;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _capacityController;
  late TextEditingController _addressLineController;
  late TextEditingController _placeController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _pinController;
  late TextEditingController _mapsLinkController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.hubData?['name'] ?? '');
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
    _emailController.dispose();
    _passwordController.dispose();
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
    //pick image
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    setState(() {
      _image = result?.files.single;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      setState(() {});
      try {
        Map hubData = {
          'name': _nameController.text.trim(),
          'capacity': _capacityController.text.trim(),
          'address_line': _addressLineController.text.trim(),
          'place': _placeController.text.trim(),
          'district': _districtController.text.trim(),
          'state': _stateController.text.trim(),
          'pin': _pinController.text.trim(),
          'maps_link': _mapsLinkController.text.trim(),
        };

        if (widget.hubData != null) {
          if (_image != null) {
            hubData['image_url'] =
                await uploadFile('hubs', _image!.bytes!, _image!.name);
          }

          await Supabase.instance.client
              .from('hubs')
              .update(hubData)
              .eq('id', widget.hubData!['id']);

          Navigator.of(context).pop();
        } else {
          UserResponse userResponse = await Supabase.instance.client.auth.admin
              .createUser(AdminUserAttributes(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            emailConfirm: true,
          ));

          hubData['user_id'] = userResponse.user!.id;
          hubData['email'] = _emailController.text.trim();

          if (_image != null) {
            hubData['image_url'] =
                await uploadFile('hubs', _image!.bytes!, _image!.name);

            await Supabase.instance.client.from('hubs').insert(hubData);

            Navigator.of(context).pop();
          } else {
            showDialog(
              context: context,
              builder: (context) => const CustomAlertDialog(
                title: 'Image Required',
                description: 'Please select an image for the hub',
                primaryButton: 'OK',
              ),
            );
          }
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Failed',
            description: e.toString(),
            primaryButton: 'OK',
          ),
        );
      }
    }

    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.hubData != null ? 'Edit Laundry Hub' : 'Add Laundry Hub'),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: widget.hubData != null
                      ? Image.network(
                          widget.hubData!['image_url'],
                          height: 150,
                          width: 300,
                          fit: BoxFit.cover,
                        )
                      : _image == null
                          ? Container(
                              height: 150,
                              width: 300,
                              color: Colors.grey[200],
                              child: Icon(Icons.add_a_photo),
                            )
                          : Image.memory(
                              _image!.bytes!,
                              height: 150,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                ),
                if (widget.hubData == null) const SizedBox(height: 10),
                if (widget.hubData == null)
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: emailValidator,
                  ),
                if (widget.hubData == null) const SizedBox(height: 10),
                if (widget.hubData == null)
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: passwordValidator,
                  ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _capacityController,
                  decoration: InputDecoration(labelText: 'Capacity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the capacity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mapsLinkController,
                  decoration: InputDecoration(labelText: 'Google Maps Link'),
                  validator: urlValidator,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: _isLoading
          ? [LinearProgressIndicator()]
          : [
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
