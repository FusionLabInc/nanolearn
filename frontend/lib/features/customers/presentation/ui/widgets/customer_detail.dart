import 'package:frontend/features/customers/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerDetailModal extends StatefulWidget {
  final Customer customer;

  const CustomerDetailModal({super.key, required this.customer});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerDetailModalState createState() => _CustomerDetailModalState();
}

class _CustomerDetailModalState extends State<CustomerDetailModal> {
  late Customer customer;

  @override
  void initState() {
    super.initState();
    customer = widget.customer;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppConstants.appSecondaryColor1.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Details',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppConstants.appBlack,
                    fontSize: 10.0.sp,
                  ),
            ),
            const SizedBox(height: 16),
            CustomerDetailSection(
              title: 'Basic Information',
              child: Column(
                children: [
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.firstName,
                    labelText: 'First Name',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.lastName,
                    labelText: 'Last Name',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.email,
                    labelText: 'Email',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.gender?.name,
                    labelText: 'Gender',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.dateOfBirth.toString().split(' ')[0],
                    labelText: 'Date of Birth',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.createdAt.toString().split(' ')[0],
                    labelText: 'Account Created At',
                    onChanged: (value) => {},
                  ),
                ],
              ),
            ),
            CustomerDetailSection(
              title: 'Address',
              child: Column(
                children: [
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.address?.street,
                    labelText: 'Street',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.address?.city,
                    labelText: 'City',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.address?.state,
                    labelText: 'State',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.address?.postalCode,
                    labelText: 'Zip Code',
                    onChanged: (value) => {},
                  ),
                ],
              ),
            ),
            CustomerDetailSection(
              title: 'Emergency Contact',
              child: Column(
                children: [
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.emergencyContact?.name,
                    labelText: 'Contact Name',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.emergencyContact?.phoneNumber,
                    labelText: 'Contact Phone Number',
                    onChanged: (value) => {},
                  ),
                  CustomerDetailTextFormFieldSection(
                    initialValue: customer.emergencyContact?.relationship,
                    labelText: 'Relationship',
                    onChanged: (value) => {},
                  ),
                ],
              ),
            ),
            CustomerDetailSection(
              title: 'Notification Preferences',
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: AppConstants.appPrimaryColor,
                    activeTrackColor:
                        AppConstants.appSecondaryColor1.withOpacity(0.3),
                    inactiveThumbColor:
                        AppConstants.appPrimaryColor.withOpacity(0.3),
                    inactiveTrackColor:
                        AppConstants.appSecondaryColor1.withOpacity(0.3),
                    title: Text(
                      'Email Notifications',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 6.0.sp,
                            color: AppConstants.appSecondaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    value: true,
                    onChanged: (value) => {},
                  ),
                  SwitchListTile(
                    activeColor: AppConstants.appPrimaryColor,
                    activeTrackColor:
                        AppConstants.appSecondaryColor1.withOpacity(0.3),
                    inactiveThumbColor:
                        AppConstants.appPrimaryColor.withOpacity(0.3),
                    inactiveTrackColor:
                        AppConstants.appSecondaryColor1.withOpacity(0.3),
                    title: Text(
                      'SMS Notifications',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 6.0.sp,
                            color: AppConstants.appSecondaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    value: true,
                    onChanged: (value) => {},
                  ),
                  SwitchListTile(
                    activeColor: AppConstants.appPrimaryColor,
                    activeTrackColor: AppConstants.appPrimaryColor,
                    inactiveThumbColor:
                        AppConstants.appPrimaryColor.withOpacity(0.3),
                    inactiveTrackColor:
                        AppConstants.appSecondaryColor1.withOpacity(0.3),
                    title: Text(
                      'Push Notifications',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppConstants.appBlack,
                            fontSize: 7.0.sp,
                          ),
                    ),
                    value: false,
                    onChanged: (value) => {},
                  ),
                ],
              ),
            ),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}

class CustomerDetailSection extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomerDetailSection(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppConstants.appBlack,
                    fontSize: 7.0.sp,
                  ),
            ),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}

class CustomerDetailTextFormFieldSection extends StatelessWidget {
  final String? initialValue;
  final String? labelText;
  final void Function(String)? onChanged;

  const CustomerDetailTextFormFieldSection(
      {super.key,
      required this.initialValue,
      required this.labelText,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppConstants.appPrimaryColor,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppConstants.appPrimaryColor,
              fontSize: 5.0.sp,
            ),
      ),
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            fontSize: 6.0.sp,
            color: AppConstants.appSecondaryColor,
            fontWeight: FontWeight.normal,
          ),
      onChanged: (value) => {},
    );
  }
}
