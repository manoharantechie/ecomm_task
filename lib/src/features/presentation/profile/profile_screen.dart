import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.of(context).primaryColorDark,


      body: Container(
        height: ConstantValues.height(context),
        width: ConstantValues.width(context),
        color: CustomTheme.of(context).scaffoldBackgroundColor,child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
       
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/icons/logo.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text('Mano', style: CustomWidget(context: context)
                        .CustomSizedTextStyle(
                        16.0,
                        Theme.of(context).focusColor,
                        FontWeight.w600,
                        'FontRegular'),),
                    Text('mano@example.com', style: CustomWidget(context: context)
                        .CustomSizedTextStyle(
                        14.0,
                        Theme.of(context).shadowColor,
                        FontWeight.w400,
                        'FontRegular')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                StatCard(label: 'Orders', value: '0'),
                StatCard(label: 'Wishlist', value: '0'),
                StatCard(label: 'Cart', value: '0'),
              ],
            ),
            const SizedBox(height: 24),


            SectionCard(
              title: 'Saved Addresses',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AddressTile(
                    name: 'Home',
                    address: '12A, Thaen Street, Pudūr, Tamil Nadu',
                  ),
                  Divider(),
                  AddressTile(
                    name: 'Office',
                    address: 'Tech Park, Coimbatore',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {},
              icon:  Icon(Icons.logout,color: Theme.of(context).canvasColor,),
              label:  Text('Log Out',style:  CustomWidget(context: context)
                  .CustomSizedTextStyle(
                  14.0,
                  Theme.of(context).canvasColor,
                  FontWeight.w400,
                  'FontRegular')),
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).hoverColor),
            ),
          ],
        ),
      ))
    );
  }
}


class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style:  CustomWidget(context: context)
            .CustomSizedTextStyle(
            16.0,
            Theme.of(context).primaryColor,
            FontWeight.w400,
            'FontRegular')),
        const SizedBox(height: 4),
        Text(label, style:  CustomWidget(context: context)
            .CustomSizedTextStyle(
            14.0,
            Theme.of(context).shadowColor,
            FontWeight.w400,
            'FontRegular')),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style:  CustomWidget(context: context)
                .CustomSizedTextStyle(
                16.0,
                Theme.of(context).shadowColor,
                FontWeight.w500,
                'FontRegular')),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final String name;
  final String address;

  const AddressTile({super.key, required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Colors.deepOrange),
      title: Text(name,style:  CustomWidget(context: context)
          .CustomSizedTextStyle(
          14.0,
          Theme.of(context).primaryColor,
          FontWeight.w500,
          'FontRegular'),),
      subtitle: Text(address,style:  CustomWidget(context: context)
          .CustomSizedTextStyle(
          12.0,
          Theme.of(context).primaryColorLight,
          FontWeight.w400,
          'FontRegular'),),
    );
  }
}
