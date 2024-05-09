// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:evently/evently_provider.dart' as _i4;
import 'package:evently/repository/repository.dart' as _i8;
import 'package:evently/utils/file_utils_helper.dart' as _i5;
import 'package:evently/viewmodels/create_event_viewmodel.dart' as _i3;
import 'package:file_picker/file_picker.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_cropper/image_cropper.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.CreateEventViewModel>(
        () => _i3.CreateEventViewModel());
    gh.lazySingleton<_i4.EventlyProvider>(() => _i4.EventlyProvider());
    gh.lazySingleton<_i5.FileUtilsHelper>(() => _i5.FileUtilsHelperImpl(
          imageCropper: gh<_i6.ImageCropper>(),
          filePicker: gh<_i7.FilePicker>(),
        ));
    gh.lazySingleton<_i8.Repository>(
        () => _i8.RepositoryImp(fileUtilsHelper: gh<_i5.FileUtilsHelper>()));
    return this;
  }
}
