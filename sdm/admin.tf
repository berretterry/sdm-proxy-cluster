resource "sdm_role" "admins" {
  name = "${var.name}-admin-role"
  access_rules = jsonencode([
    { tags = { CreatedBy = "strongDM-Onboarding" } }
  ])
}
resource "sdm_account_attachment" "existing_users" {
  count      = length(var.grant_to_existing_users)
  account_id = element(data.sdm_account.existing_users[count.index].ids, 0)
  role_id    = sdm_role.admins.id
}
