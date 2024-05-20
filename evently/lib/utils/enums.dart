enum UploadStep { overView, detail, perks, price, none }

extension ToUploadStepPar on String {
  UploadStep toUploadStepEnum() {
    return UploadStep.values.firstWhere((e) {
      return e.toString().toLowerCase() == toLowerCase();
    }, orElse: () => UploadStep.none); //return null if not found
  }
}
