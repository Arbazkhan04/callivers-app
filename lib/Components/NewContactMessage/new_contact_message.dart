import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  const ContactListItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(contact.imageUrl),
        ),
        sizeWidth15,
        Expanded(
          child: Text(
            contact.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: txtStyle14AndBold,
          ),
        ),
      ],
    );
  }
}

class Contact {
  final String name;
  final String imageUrl;

  const Contact({
    required this.name,
    required this.imageUrl,
  });
}

final List<Contact> contacts = [
  Contact(name: 'Marcus Septimus sas as as as  as s  sasas as  as s  sas', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/6617270363cc78d99a5d801824f1937e4171917adba2355d862f2431c34d23c0?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Lindsey Dorwart', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/12d6ab45c347c6affab84de6ba81f9d104f0d4d8372f8b38c2f9e54263049933?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Aspen Geidt', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d74b03095360c29422497d61198d454bab4dbc6f21bd4f00dd79dfd95a2a91d5?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Alfonso Aminoff', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/493a333f6076441db7a5809f1074fdc4fa835e1e7339eb5da80782a34f921013?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Angel Carder', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/1604b5343978cc85c80ff11584bde73445ffea577dc1142ec565f4ff83e66ed7?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Miracle Dorwart', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/95bc77b8aa5528cfd73d6445a9d2ddc63912855403fe6b51c6b7476347e9e943?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Mira Press', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/0dc9d0b81c6610f76bb960b51c5d35086f3ebeb3c630d11029949ac90785e383?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Jakob Herwitz', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/544ef2e568383ac93ea4ea8b865dc22f40f3fb832f27b69efbc2e2ddfaceb543?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Marcus Septimus', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/6617270363cc78d99a5d801824f1937e4171917adba2355d862f2431c34d23c0?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Lindsey Dorwart', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/12d6ab45c347c6affab84de6ba81f9d104f0d4d8372f8b38c2f9e54263049933?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Aspen Geidt', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d74b03095360c29422497d61198d454bab4dbc6f21bd4f00dd79dfd95a2a91d5?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Alfonso Aminoff', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/493a333f6076441db7a5809f1074fdc4fa835e1e7339eb5da80782a34f921013?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Angel Carder', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/1604b5343978cc85c80ff11584bde73445ffea577dc1142ec565f4ff83e66ed7?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Miracle Dorwart', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/95bc77b8aa5528cfd73d6445a9d2ddc63912855403fe6b51c6b7476347e9e943?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Mira Press', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/0dc9d0b81c6610f76bb960b51c5d35086f3ebeb3c630d11029949ac90785e383?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),
  Contact(name: 'Jakob Herwitz', imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/544ef2e568383ac93ea4ea8b865dc22f40f3fb832f27b69efbc2e2ddfaceb543?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561'),


];