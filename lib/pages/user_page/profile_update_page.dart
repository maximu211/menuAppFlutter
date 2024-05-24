import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/dtos/dtos.dart';
import 'package:menuapp/http/user_requests/user_requests.dart';
import 'package:menuapp/pages/common_components/image_picker/image_picker.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key, required this.userId});

  final String userId;

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  Uint8List? _image;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserImage();
  }

  Future<void> _loadUserImage() async {
    try {
      UserImageDto userImageDto = await UserRequest.getProfileImage();
      if (userImageDto.userImage != null &&
          userImageDto.userImage!.isNotEmpty) {
        _image = userImageDto.userImage!;
      } else {
        _image = null;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading user image: $e';
      });
    }
  }

  void _updateImage(Uint8List? image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ColorVariables.backgroundColor,
        ),
        backgroundColor: ColorVariables.primaryColor,
        title: Text(
          "Update profile",
          style: TextStyle(color: ColorVariables.backgroundColor),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            UserRequest.setProfileImage(
                _image != null ? base64Encode(_image!) : null);
            Navigator.pop(context, _image);
          },
          child: Text(
            "Submit",
            style: TextStyle(
              color: ColorVariables.backgroundColor,
              fontSize: FontSizeVariables.h2Size,
            ),
          ),
        )
      ],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      children: [
                        ImagePickerContainer(
                          image: _image,
                          onImageChanged: _updateImage,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
