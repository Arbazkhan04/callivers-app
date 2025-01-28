import 'package:calliverse/Provider/authen_provider.dart';
import 'package:calliverse/Provider/image_picker_provider.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Components/common.dart';
import '../../Constants/DB_keys.dart';
import '../../Constants/color.dart';
import '../../Constants/paths.dart';
import '../../Constants/sizedbox.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/textfield.dart';
import '../../utils/app_common.dart';
import '../AuthScreen/Phone/phone_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e){
    mInit();
    });
  }

  mInit(){
    final provider = Provider.of<AuthenProvider>(context,listen: false);
    provider.editProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthenProvider,ImagePickerProvider>(
      builder: (context,authProvider,imagePickerProvider,_) {
        return Scaffold(
          appBar: appBar(title: "Edit Profile"),
          resizeToAvoidBottomInset: false,
          backgroundColor: whiteColor,
          body: SafeArea(
              child: Padding(
                padding: kDefaultPaddingHorizontal,
                child: Column(
                  children: [
                    sizeHeight20,
                    // Stack(
                    //   children: [
                    //     cachedImage("",radius: 120,width: 120),
                    //     Positioned(
                    //       right: 6,
                    //       bottom: 15,
                    //       child: CircleAvatar(
                    //         radius: 13,
                    //         backgroundColor: textColor,
                    //         child: Icon(CupertinoIcons.add,size: 18,color: whiteColor,),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Stack(
                      children: [
                        cachedImage(
                            imagePickerProvider.selectedImage != null?imagePickerProvider.selectedImage!.path
                            :
                            authProvider.userInfoData != null && authProvider.userInfoData?.profileImage != null && authProvider.userInfoData?.profileImage?.imageUrl != null?
                            authProvider.userInfoData?.profileImage?.imageUrl
                            :
                            ic_placeholder,
                            isFileBgCircleBool: true,
                            isFileImageBool: imagePickerProvider.selectedImage != null? true : false,
                            radius: 2340,
                            height: 140,
                            width: 140
                        ),
                        Positioned(
                          right: 6,
                          bottom: 15,
                          child: GestureDetector(
                            onTap: (){
                              imagePickerProvider.pickAndCropImage(source: ImageSource.gallery);
                            },
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: textColor,
                              child: Icon(CupertinoIcons.add,size: 18,color: whiteColor,),
                            ),
                          ),
                        )
                      ],
                    ),

                    sizeHeight40,
                    CustomTextField(
                      controller: authProvider.firstNameController,
                      hintText: 'First Name (Required)',
                    ),
                    sizeHeight20,
                    CustomTextField(
                      controller: authProvider.lastNameController,
                      hintText: 'Last Name',
                    ),
                    sizeHeight20,
                    PhoneNumberField(),
                    sizeHeight60,
                    MyButton(
                        text: "Save",
                        onPressed: (){
                          // showMyWaitingModal(context: context);
                          authProvider.profileSetupFun(
                            req: {
                              DBkeys.firstName : authProvider.firstNameController.text,
                              DBkeys.lastName : authProvider.lastNameController.text,
                            },isProfileEditBool: true
                          );
                        })
                  ],
                ),
              )),
        );
      }
    );
  }
}
