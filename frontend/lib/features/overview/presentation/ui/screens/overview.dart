import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/features/base/presentation/ui/widgets/app_bar.dart';
import 'package:frontend/features/core/data/index.dart';
import 'package:frontend/features/core/index.dart';
import 'package:frontend/features/overview/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final GlobalKey<ScaffoldState> appBaseScaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      compressionQuality: 30,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print(status),
      type: FileType.custom,
      allowedExtensions: ['mp4', 'pdf', 'mp3'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print(result.files.length);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final coreBloc = BlocProvider.of<CoreCubit>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppConstants.appPrimaryColor.withOpacity(0.4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          80.0,
        ),
        child: CustomAppBar(
          appBaseScaffoldKey: appBaseScaffoldKey,
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: coreBloc.getUserDetailsLogic(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (coreBloc.contents != null) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: coreBloc.contents!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  index -= 1;

                  if (index == coreBloc.contents!.length - 1) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 250.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            color: AppConstants.appWhite,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 6),
                                  color:
                                      const Color(0xFFA4A6B3).withOpacity(.1),
                                  blurRadius: 12)
                            ],
                          ),
                          child: InkWell(
                            onTap: () async => _pickFiles(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppConstants.appBlack,
                                  size: 70.0,
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Text(
                                  AppConstants.nanoANewContentText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppConstants.appBlack,
                                        fontSize: 5.0.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final Content contentData = coreBloc.contents![index + 1];

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 250.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          color: AppConstants.appWhite,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 6),
                                color: const Color(0xFFA4A6B3).withOpacity(.1),
                                blurRadius: 12)
                          ],
                        ),
                        child: InkWell(
                          onTap: () async => _pickFiles(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.book,
                                color: AppConstants.appBlack,
                                size: 70.0,
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                contentData.fileName ?? AppConstants.nA,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppConstants.appBlack,
                                      fontSize: 5.0.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: coreBloc.contents!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  index -= 1;

                  if (index == coreBloc.contents!.length - 1) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 250.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            color: AppConstants.appWhite,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 6),
                                  color:
                                      const Color(0xFFA4A6B3).withOpacity(.1),
                                  blurRadius: 12)
                            ],
                          ),
                          child: InkWell(
                            onTap: () async => _pickFiles(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppConstants.appBlack,
                                  size: 70.0,
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Text(
                                  AppConstants.nanoANewContentText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppConstants.appBlack,
                                        fontSize: 5.0.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final Content contentData = coreBloc.contents![index + 1];

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 250.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          color: AppConstants.appWhite,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 6),
                                color: const Color(0xFFA4A6B3).withOpacity(.1),
                                blurRadius: 12)
                          ],
                        ),
                        child: InkWell(
                          onTap: () async => _pickFiles(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.book,
                                color: AppConstants.appBlack,
                                size: 70.0,
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                contentData.fileName ?? AppConstants.nA,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppConstants.appBlack,
                                      fontSize: 5.0.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Shimmer.fromColors(
              baseColor: AppConstants.appShimmerBaseColor,
              highlightColor: AppConstants.appShimmerHighlightColor,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 250.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          color: AppConstants.appWhite,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 6),
                                color: const Color(0xFFA4A6B3).withOpacity(.1),
                                blurRadius: 12)
                          ],
                        ),
                        child: InkWell(
                          onTap: () async => _pickFiles(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppConstants.appBlack,
                                size: 70.0,
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                AppConstants.nanoANewContentText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppConstants.appBlack,
                                      fontSize: 5.0.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
