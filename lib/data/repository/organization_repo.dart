import 'package:euzzit/data/models/organized_model.dart';
import 'package:euzzit/utility/strings.dart';

class OrganizationRepo {
  List<OrganizerModel> getOrganizerList() {
    List<OrganizerModel> organizationList = [
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/electricity.png',
          name: Strings.ORGANIZATION1),
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/telephn.png',
          name: Strings.ORGANIZATION2),
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/education.png',
          name: Strings.ORGANIZATION3),
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/internet.png',
          name: Strings.ORGANIZATION4),
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/electricity.png',
          name: Strings.ORGANIZATION1),
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/telephn.png',
          name: Strings.ORGANIZATION2),
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/education.png',
          name: Strings.ORGANIZATION3),
      OrganizerModel(
          organizerImageUrl: 'assets/Icon/internet.png',
          name: Strings.ORGANIZATION4),
    ];
    return organizationList;
  }
}
