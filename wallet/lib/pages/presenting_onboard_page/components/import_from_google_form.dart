import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:pylons_wallet/components/buttons/pylons_get_started_button.dart';
import 'package:pylons_wallet/components/loading.dart';
import 'package:pylons_wallet/components/pylons_rounded_button.dart';
import 'package:pylons_wallet/components/pylons_text_input_widget.dart';
import 'package:pylons_wallet/components/space_widgets.dart';
import 'package:pylons_wallet/gen/assets.gen.dart';
import 'package:pylons_wallet/services/repository/repository.dart';
import 'package:pylons_wallet/services/third_party_services/remote_notifications_service.dart';
import 'package:pylons_wallet/stores/wallet_store.dart';
import 'package:pylons_wallet/utils/constants.dart';
import 'package:pylons_wallet/utils/route_util.dart';

import '../../../generated/locale_keys.g.dart';

class ImportFromGoogleForm extends StatefulWidget {
  final WalletsStore walletStore;

  const ImportFromGoogleForm({super.key, required this.walletStore});

  @override
  ImportFromGoogleFormState createState() {
    return ImportFromGoogleFormState();
  }
}

class ImportFromGoogleFormState extends State<ImportFromGoogleForm> {
  final _formKey = GlobalKey<FormState>();

  final mnemonicController = TextEditingController();

  final isLoadingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          VerticalSpace(90.h),
          SvgPicture.asset(
            Assets.images.icons.pylonsLogoSvg,
            width: 60.w,
            fit: BoxFit.fill,
          ),
          VerticalSpace(50.h),
          const VerticalSpace(30),
          if (Platform.isAndroid)
            PylonsRoundedButton(
                glyph: svg.Svg(Assets.images.icons.googleDrive, size: const Size(30, 30)),
                text: LocaleKeys.import_from_google_cloud.tr(),
                textColor: Colors.white,
                onTap: () async {
                  _loginWithGoogleDrive();
                }),
          if (Platform.isIOS)
            PylonsRoundedButton(
                glyph: svg.Svg(Assets.images.icons.icloud, size: const Size(30, 30)),
                text: LocaleKeys.import_from_i_cloud.tr(),
                textColor: Colors.white,
                onTap: () async {
                  _loginWithICloudDrive();
                }),
          VerticalSpace(10.h),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.or.tr(),
                style: TextStyle(
                  color: AppColors.kBlack,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ]),
          VerticalSpace(5.h),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.enter_mnemonic.tr(),
                style: TextStyle(
                  color: AppColors.kBlack,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ]),
          PylonsTextInput(controller: mnemonicController, label: LocaleKeys.enter_mnemonic.tr()),
          VerticalSpace(140.h),
          Align(
            alignment: Alignment.bottomRight,
            child: PylonsGetStartedButton(
              onTap: () {
                if (mnemonicController.text.isEmpty ||
                    (mnemonicController.text.split(" ").length != 12 &&
                        mnemonicController.text.split(" ").length != 24)) {
                  LocaleKeys.invalid_mnemonic.tr().show();
                  return;
                }

                _loginExistingUser(mnemonic: mnemonicController.text);
              },
              text: "continue".tr(),
              loader: isLoadingNotifier,
              btnUnselectBGColor: AppColors.kGreyColorBtn.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  /// Create the new wallet and associate the chosen username with it.
  Future _loginExistingUser({required String mnemonic}) async {
    final remoteNotificationsProvider = context.read<RemoteNotificationsProvider>();
    isLoadingNotifier.value = true;

    final result = await widget.walletStore.importPylonsAccount(mnemonic: mnemonic);

    isLoadingNotifier.value = false;

    result.fold((failure) {
      failure.message.show();
    }, (walletInfo) {
      remoteNotificationsProvider.updateFCMToken(address: walletInfo.publicAddress);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home.name, (route) => true);
    });
  }

  /// Create the new wallet and associate the chosen username with it.
  Future _loginWithGoogleDrive() async {
    final remoteNotificationsProvider = context.read<RemoteNotificationsProvider>();
    final navigator = Navigator.of(context);
    final Loading loading = Loading()..showLoading();

    final response = await GetIt.I.get<Repository>().getGoogleDriveMnemonic();

    if (response.isLeft()) {
      loading.dismiss();
      navigator.pop();
      response.swap().toOption().toNullable()!.message.show();
      return;
    }

    final data = response.toOption().toNullable()!;

    final result = await widget.walletStore.importPylonsAccount(mnemonic: data.mnemonic);

    result.fold((failure) {
      loading.dismiss();
      navigator.pop();

      failure.message.show();
    }, (walletInfo) {
      remoteNotificationsProvider.updateFCMToken(address: walletInfo.publicAddress);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home.name, (route) => true);
    });
  }

  Future _loginWithICloudDrive() async {
    final remoteNotificationsProvider = context.read<RemoteNotificationsProvider>();

    final navigator = Navigator.of(context);
    final Loading loading = Loading()..showLoading();

    final response = await GetIt.I.get<Repository>().getICloudMnemonic();

    if (response.isLeft()) {
      loading.dismiss();
      navigator.pop();
      response.swap().toOption().toNullable()!.message.show();
      return;
    }

    final data = response.toOption().toNullable()!;

    final result = await widget.walletStore.importPylonsAccount(mnemonic: data.mnemonic);

    result.fold((failure) {
      loading.dismiss();
      navigator.pop();

      failure.message.show();
    }, (walletInfo) {
      remoteNotificationsProvider.updateFCMToken(address: walletInfo.publicAddress);

      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home.name, (route) => true);
    });
  }
}
