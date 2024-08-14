import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Partials/Button/BaseButton.dart';
import '../Partials/Form/disableForm.dart';
import '../Provider/user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEditing = false;

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String userId = context.read<UserProvider>().userData!.uid;
      final _userProvider = Provider.of<UserProvider>(context, listen: false);
      await _userProvider.uploadAndSetUserImage(userId, image);
    }
  }

  void loadUser() {
    final _userProvider = Provider.of<UserProvider>(context, listen: false);
    String uid = _userProvider.userData!.uid;
    _userProvider.loadUserData(uid);
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.updateUser(userProvider.userData!.uid, {
        "image": userProvider.userData?.image ?? "",
        "name": userProvider.userData!.name,
        "jabatan": userProvider.userData?.jabatan
      });

      await userProvider.loadUserData(userProvider.userData!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    emailController.text = _userProvider.userData?.email ?? "__";
    nameController.text = _userProvider.userData?.name ?? "__";

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 100.w),
                    child: KembaliButton(context, onTap: () {
                      Navigator.pop(context);
                    }),
                  ),
                  Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(0, 73, 124, 1)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  _pickImage(context);
                },
                child: Consumer(
                  builder: (context, value, child) {
                    return CircleAvatar(
                      radius: 70.dm,
                      backgroundColor: Colors.white,
                      backgroundImage: _userProvider.userData?.image != null
                          ? NetworkImage(_userProvider.userData!.image!)
                          : null,
                      child: _userProvider.userData?.image == null
                          ? Icon(Icons.person, size: 50.dm, color: Colors.grey)
                          : null,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isEditing
                      ? Flexible(
                          child: TextFormField(
                            controller: nameController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 73, 124, 1),
                              fontFamily: "Lato",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            autofocus: true,
                            onChanged: (value) {
                              _userProvider.setName(value);
                            },
                          ),
                        )
                      : Flexible(
                          child: Consumer(
                            builder: (context, value, child) {
                              return Text(
                                nameController.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color.fromRGBO(0, 73, 124, 1),
                                  fontFamily: "Lato",
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                  IconButton(
                    icon: Icon(isEditing ? Icons.check : Icons.edit),
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              // field email
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EMAIL",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Lato",
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  disableForm(context,
                      controller: emailController, label: "EMAIL"),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              // field jabatan
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "JABATAN",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Lato",
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(10.dm)),
                    child: TextFormField(
                      // controller: jabatanController,
                      initialValue: _userProvider.userData?.jabatan ?? "",
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontSize: 14.sp),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "jabatan",
                        disabledBorder: const OutlineInputBorder(
                            gapPadding: 0, borderRadius: BorderRadius.zero),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(3.dm)),
                      ),
                      validator: (String? sr) {
                        if (sr == null || sr.isEmpty) {
                          return "Field jabatan tidak boleh kosong!";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        // Simpan nilai ke model atau provider
                        if (newValue != null) {
                          context.read<UserProvider>().userData?.jabatan =
                              newValue;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              /*
              tombol untuk update profile
              */
              _userProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : BaseButton(
                      context,
                      height: 40.h,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: const Color.fromRGBO(2, 138, 234, 1),
                      fontColor: Colors.white,
                      label: "Simpan",
                      borderRadius: 10.dm,
                      onTap: _submitForm,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
