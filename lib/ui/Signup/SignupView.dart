import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/ui/Signup/SignupLogic.dart';

import '../../Routes/AppRoutes.dart';
import '../../Utils/Assets/Constants.dart';
import '../../generated/assets.dart';

class Signupview extends StatelessWidget {
   Signupview({super.key});
  final controller = Get.put(SignupLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child: Center(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50,bottom: 20),
          child: Image.asset(Assets.imagesLogo,height: 100,width: 100,),
        ),
        Text('Continue With',style: GoogleFonts.poppins(color: Colors.black,fontSize: 25),),
  Container(
    width: 240,
    height: 70,
    color: Colors.transparent,
    child: InkWell(
      onTap: () async {
        await controller.signInWithGoogle();
        Get.offAllNamed(AppRoutes.home);
      },
      child: Card(
        color: Color(0xFFCFF4D2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Set the card radius here
          ),
          child:Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(Assets.imagesGoogleicon,height: 50,),
            ),
            SizedBox(width: 30,),
            Text('Google',style: GoogleFonts.poppins(fontSize: 20),)
          ],)),
    ),
  ),
  SizedBox(height: 20,),
        Text('OR',style: GoogleFonts.poppins(fontSize: 25,color: Colors.grey,),),
  Text('Create Your Account',style: GoogleFonts.poppins(fontSize: 20,color: Colors.black),),
        SizedBox(height: 20,),
  
        Form(
          key: controller.formKey,
            child: Column(children: [
              GetBuilder<SignupLogic>(
                  id:'',
                  builder: (logic) {
                    return  Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          validator: (value){
                            controller.isNameValid(value!);
                          },
                          decoration: InputDecoration(
                            labelText: ' Enter Name',
                            labelStyle: TextStyle(color:Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    );
                  }),
              GetBuilder<SignupLogic>(
                  id:'',
                  builder: (logic) {
                    return  Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            controller.isEmailValid(value!);
                          },
                          decoration: InputDecoration(
                            labelText: ' Enter Email',
                            labelStyle: TextStyle(color:Colors.grey),
                            border: InputBorder.none,
                            // border: RoundedRectangleBorder(borderRadius: BorderRadi),
                          ),
                        ),
                      ),
                    );
                  }),

   GetBuilder<SignupLogic>(
   id: Constant.idPasswordInput,
   builder: (logic) {
   return  Card(
     child: Padding(
       padding: const EdgeInsets.only(left: 20),
       child: TextFormField(
       controller: controller.passwordController,
       keyboardType: TextInputType.name,
       validator: (value){
       controller.isPasswordValid(value!);
       },
       obscureText: logic.isShowPassword,

       decoration: InputDecoration(
       suffixIcon: GestureDetector(
       onTap: controller.toggleShowHidePassword, // Toggles password visibility
       child: Icon(
       logic.isShowPassword ? Icons.visibility_off : Icons.visibility, // Changes the icon based on password visibility
       color: Color(0xFF292D32),
       ),
       ),
       labelText: '  Password',
       labelStyle: TextStyle(color: Colors.grey),
       border: InputBorder.none,
       ),
       ),
     ),
   );
   }),

            ],)),
        InkWell(
          onTap: () async {
            await controller.signUp();

          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 60,
              width: 250,
              child: Card(
                  color: Color(0xFF215273),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Set the card radius here
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Center(child: Text('SignUp',style: GoogleFonts.poppins(color: Color(0xFFCFF4D2),fontSize: 15),)),

                  ],)),
            ),
          ),
        ),
        Center(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Center(child: Text('Already have an Account?',style: GoogleFonts.poppins(fontSize: 15,color: Colors.grey),)),

            InkWell(
                onTap: (){
                  controller.gotoLogin();
                },
                child: Text('Login',style: GoogleFonts.poppins(fontSize: 15,color: Color(0xFF215273))))
          ],),
        )
      ],
    ),
  ),
),

    );
  }
}
