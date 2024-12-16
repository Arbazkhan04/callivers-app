import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Provider/authen_provider.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:calliverse/Widgets/textfield.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:calliverse/Widgets/validations.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Provider/image_picker_provider.dart';
import '../../../Widgets/dialogBox.dart';
import '../../SubscriptionScreen/subscription_screen.dart';

class SignupProfileScreen extends StatefulWidget {
  const SignupProfileScreen({Key? key}) : super(key: key);

  @override
  State<SignupProfileScreen> createState() => _SignupProfileScreenState();
}

class _SignupProfileScreenState extends State<SignupProfileScreen> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Consumer2<ImagePickerProvider,AuthenProvider>(
      builder: (context,imagePickerProvider,authProvider,_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(title: 'Your Profile',leadOnTap: (){
            return logoutDialogBox(context: context);
          }),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // ProfileHeader(),
                    // SizedBox(height: 46),
                    sizeHeight20,
                    Stack(
                      children: [
                        cachedImage(imagePickerProvider.selectedImage != null?imagePickerProvider.selectedImage!.path : ic_placeholder, isFileBgCircleBool: true,isFileImageBool: imagePickerProvider.selectedImage != null? true : false,radius: 2340,height: 140, width: 140),
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
                    TextButton(onPressed: (){
                      print("${authProvider.otpReturnModelData?.userId}");
                    }, child: Text("Sdd")),
                    sizeHeight40,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: "First Name",
                            keyboardType: TextInputType.name,
                            controller: authProvider.firstNameController,
                            validator: AllValidation().firstNameValidator,
                          ),
                          sizeHeight10,
                          CustomTextField(
                            hintText: "Last Name",
                            keyboardType: TextInputType.name,
                            controller: authProvider.lastNameController,
                            validator: AllValidation().lastNameValidator,
                          ),
                          sizeHeight10,
                          CustomTextField(
                            hintText: "Bio (Optional)",
                            keyboardType: TextInputType.name,
                            controller: authProvider.bioController,
                            validator: AllValidation().bioValidator,
                          ),
                          sizeHeight10,
                          CustomTextField(hintText: "Website Link (Optional)",
                            keyboardType: TextInputType.name,
                            controller: authProvider.websiteController,
                            validator: AllValidation().websiteLinkValidator,
                          ),

                          const SizedBox(height: 66),
                          SizedBox(
                            width: double.infinity,
                            child: MyButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                //  if(imagePickerProvider.selectedImage == null || imagePickerProvider.selectedImage!.path.isEmpty){
                                //   AppToast.show("Please choose a image");
                                // }else{
                                  // Handle form submission
                                   authProvider.profileSetupFun();
                                   print("object ${authProvider.firstNameController.text} ->  ${authProvider.lastNameController.text} ->  ${authProvider.websiteController.text} ->  ${authProvider.bioController.text} ->  ${imagePickerProvider.selectedImage?.path} -> ");
                                  // SubscriptionScreen().launch(context);

                                 // }
                                }
                              },
                              text: 'Save',

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}