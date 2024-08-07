import 'package:frontend/features/customers/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:frontend/utils/widgets/custom_om_side_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paged_datatable/paged_datatable.dart';

import '../widgets/customer_detail.dart';
import 'customer_repo..dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final tableController = PagedDataTableController<String, Customer>();

  @override
  void initState() {
    final bloc = BlocProvider.of<CustomersCubit>(context);
    CustomersRepository.generate(bloc);
    super.initState();
  }

  void _showDetailModal(Customer customer) {
    SideSheet.right(
      width: 130.w,
      body: CustomerDetailModal(customer: customer),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CustomersCubit>(context);
    return SizedBox(
      width: AppConstants.getWidth(context),
      height: AppConstants.getAppHeight(context),
      child: Expanded(
        child: PagedDataTableTheme(
          data: PagedDataTableThemeData(
            chipTheme: ChipThemeData(
              backgroundColor: AppConstants.appPrimaryColor,
              selectedColor: Colors.blue,
              disabledColor: Colors.grey,
              padding: const EdgeInsets.all(8),
              shape: const StadiumBorder(),
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14,
                  ),
              secondaryLabelStyle:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
            ),
            backgroundColor: Colors.grey[100]!,
            selectedRow: AppConstants.appPrimaryColor,
            // filterBarHeight: 50.h,
            headerTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 16,
                ),
            cellTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 14,
                ),
            footerTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 14,
                ),
          ),
          child: Theme(
            data: ThemeData(
              useMaterial3: true,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppConstants.appPrimaryColor),
            ),
            child: PagedDataTable<String, Customer>(
              controller: tableController,
              initialPageSize: 100,
              configuration: const PagedDataTableConfiguration(),
              pageSizes: const [10, 20, 50, 100],
              fetcher: (pageSize, sortModel, filterModel, pageToken) async {
                final data = await CustomersRepository.getCustomers(
                  pageSize: pageSize,
                  pageToken: pageToken,
                  sortBy: sortModel?.fieldName,
                  sortDescending: sortModel?.descending ?? false,
                  gender: filterModel["gender"],
                  searchQuery: filterModel["searchQuery"],
                  createdAtBetween: filterModel["createdAt"],
                  dateOfBirthBetween: filterModel["dateOfBirth"],
                  bloc: bloc,
                );

                return (data.items, data.nextPageToken);
              },
              footer: Row(
                children: [
                  const Spacer(),
                  const VerticalDivider(
                    color: Color(0xFFD6D6D6),
                    width: 3,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "Page 1",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const VerticalDivider(
                      color: Color(0xFFD6D6D6),
                      width: 3,
                      indent: 10,
                      endIndent: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.keyboard_arrow_left_rounded),
                        onPressed: (tableController.hasPreviousPage)
                            ? tableController.previousPage
                            : null,
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.keyboard_arrow_right_rounded),
                        onPressed: (tableController.hasNextPage)
                            ? tableController.nextPage
                            : null,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
              filters: [
                TextTableFilter(
                  id: "searchQuery",
                  chipFormatter: (value) =>
                      'Name, Email or Phone Number contains "$value"',
                  name: "Search by name, email or phone number",
                ),
                DropdownTableFilter<Gender>(
                  items: Gender.values
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text(e.toString().split('.').last)))
                      .toList(growable: false),
                  chipFormatter: (value) =>
                      'Gender is ${value.toString().split('.').last.toLowerCase()}',
                  id: "gender",
                  name: "Filter by Gender",
                ),
                DateRangePickerTableFilter(
                  id: "dateOfBirth",
                  name: "Filter by Date of Birth",
                  chipFormatter: (date) => "Date is $date",
                  initialValue: null,
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 365 * 100)),
                  lastDate: DateTime.now(),
                  formatter: (range) =>
                      "${DateFormat.yMMMEd().format(range.start)} - ${DateFormat.yMMMEd().format(range.end)}",
                ),
                DateRangePickerTableFilter(
                  id: "createdAt",
                  name: "Filter by Account created at",
                  chipFormatter: (date) => "Date is $date",
                  initialValue: null,
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 365 * 1)),
                  lastDate: DateTime.now(),
                  formatter: (range) =>
                      "${DateFormat.yMMMEd().format(range.start)} - ${DateFormat.yMMMEd().format(range.end)}",
                ),
              ],
              filterBarChild: Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: PopupMenuButton(
                  icon: const Icon(Icons.more_vert,
                      color: Color.fromARGB(255, 12, 12, 12),
                      size: 24), // Icon styling
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: const Text(
                        "Send Email notification",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54), // Text styling
                      ),
                      onTap: () {
                        debugPrint(tableController.selectedRows.toString());
                        debugPrint(tableController.selectedItems.toString());
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(
                        "Send SMS notification",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      onTap: () {
                        debugPrint(tableController.selectedRows.toString());
                        debugPrint(tableController.selectedItems.toString());
                      },
                    ),
                    // Add more menu items here
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  color: Colors.white, // Background color of the menu
                  elevation: 4, // Shadow elevation
                ),
              ),
              fixedColumnCount: 5,
              columns: [
                TableColumn(
                  title: const Text(" "),
                  size: const FixedColumnSize(50),
                  cellBuilder: (context, item, index) {
                    final selected =
                        tableController.selectedRows.contains(index);
                    return Checkbox(
                      value: selected,
                      onChanged: (value) {
                        if (value != null) {
                          if (value) {
                            tableController.selectRow(index);
                          } else {
                            tableController.unselectRow(index);
                          }
                        }
                      },
                      activeColor: Colors.green, // Checkbox color
                    );
                  },
                ),
                TableColumn(
                  title: const Text("First Name"),
                  cellBuilder: (context, item, index) => InkWell(
                    onTap: () => _showDetailModal(item),
                    child: Text(item.firstName ?? AppConstants.nA),
                  ),
                  sortable: false,
                  id: "firstName",
                  size: const FractionalColumnSize(.15),
                ),
                TableColumn(
                  title: const Text("Last Name"),
                  cellBuilder: (context, item, index) => InkWell(
                    onTap: () => _showDetailModal(item),
                    child: Text(item.lastName ?? AppConstants.nA),
                  ),
                  id: "lastName",
                  size: const FractionalColumnSize(.15),
                ),
                TableColumn(
                  title: const Text("Email"),
                  cellBuilder: (context, item, index) => InkWell(
                    onTap: () => _showDetailModal(item),
                    child: Text(item.email ?? AppConstants.nA),
                  ),
                  id: "email",
                  size: const FractionalColumnSize(.25),
                ),
                TableColumn(
                  title: const Text("Phone Number"),
                  cellBuilder: (context, item, index) => InkWell(
                    onTap: () => _showDetailModal(item),
                    child: Text(item.phoneNumber ?? AppConstants.nA),
                  ),
                  id: "phoneNumber",
                  size: const FractionalColumnSize(.20),
                ),
                TableColumn(
                  title: const Text("Date of Birth"),
                  cellBuilder: (context, item, index) => InkWell(
                    onTap: () => _showDetailModal(item),
                    child: Text(item.dateOfBirth.toString().split(' ')[0]),
                  ),
                  sortable: true,
                  id: "dateOfBirth",
                  size: const FractionalColumnSize(.125),
                ),
                TableColumn(
                  title: const Text("Account created at"),
                  cellBuilder: (context, item, index) => InkWell(
                    onTap: () => _showDetailModal(item),
                    child: Text(item.createdAt.toString().split(' ')[0]),
                  ),
                  sortable: true,
                  id: "createdAt",
                  size: const FractionalColumnSize(.125),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
