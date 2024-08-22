import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Partials/Button/BackButton.dart';
import '../Partials/Button/BaseButton.dart';
import '../Partials/Form/disableForm.dart';
import '../Provider/user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  String? name;
  String? jabatan;
  String? telepon;
  String? image = null;

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final XFile? imagea = await picker.pickImage(source: ImageSource.gallery);
    String userId = context.read<UserProvider>().userData!.uid;

    if (imagea != null) {
      image = await userProvider.uploadImage(userId, imagea);
      print(image);
      setState(() {});
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.updateUser(userProvider.userData!.uid, {
        "image": image ?? userProvider.userData!.image,
        "name": name ?? userProvider.userData!.name,
        "jabatan": jabatan ?? userProvider.userData!.jabatan,
        "telepon": telepon ?? userProvider.userData!.telepon,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil Update Data"),
          backgroundColor: Colors.green,
        ),
      );
      await userProvider.loadUserData();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    emailController.text = userProvider.userData?.email ?? "__";
    nameController.text = userProvider.userData?.name ?? "xxxxx";

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
                    padding: EdgeInsets.only(left: 20.w, right: 80.w),
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
                      backgroundImage: image != null && image!.isNotEmpty
                          ? CachedNetworkImageProvider(
                              image!,
                              cacheKey: image!,
                            )
                          : CachedNetworkImageProvider(
                              userProvider.userData?.image ?? "",
                              cacheKey: userProvider.userData?.image ?? "",
                            ),
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
                              name = value;
                            },
                          ),
                        )
                      : Flexible(
                          child: Text(
                            name != null ? name! : nameController.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 73, 124, 1),
                              fontFamily: "Lato",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
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
                      initialValue: userProvider.userData?.jabatan ?? "",
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

                      onSaved: (newValue) {
                        // Simpan nilai ke model atau provider
                        if (newValue != null) {
                          jabatan = newValue;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Nomer Telepon",
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
                      initialValue: userProvider.userData?.telepon ?? "",
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontSize: 14.sp),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Nomor Telepon",
                        disabledBorder: const OutlineInputBorder(
                            gapPadding: 0, borderRadius: BorderRadius.zero),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(3.dm)),
                      ),

                      onSaved: (newValue) {
                        // Simpan nilai ke model atau provider
                        if (newValue != null) {
                          telepon = newValue;
                          print(telepon ?? "");
                        }
                      },
                    ),
                  ),
                  // Text(telepon ?? "p"),
                  // Text(jabatan ?? "p"),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              /*
              tombol untuk update profile
              */
              userProvider.isLoading
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
