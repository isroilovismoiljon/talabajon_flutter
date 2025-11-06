import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatefulWidget {
  final String? initialPhoto;
  final Function(File) onPhotoChanged;

  const ProfileAvatar({super.key, this.initialPhoto, required this.onPhotoChanged});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      widget.onPhotoChanged(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 100.w,
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage!)
              : (widget.initialPhoto != null && widget.initialPhoto!.isNotEmpty
              ? NetworkImage(widget.initialPhoto!) as ImageProvider
              : null),
          backgroundColor: Colors.grey[200],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
