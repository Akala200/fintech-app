import 'package:flutter/material.dart';
import 'package:euzzit/data/models/organized_model.dart';
import 'package:euzzit/data/repository/organization_repo.dart';

class OrganizationProvider extends ChangeNotifier {
  final OrganizationRepo organizationRepo;
  OrganizationProvider({@required this.organizationRepo});

  List<OrganizerModel> getOrganizationList() {
    return organizationRepo.getOrganizerList();
  }
}