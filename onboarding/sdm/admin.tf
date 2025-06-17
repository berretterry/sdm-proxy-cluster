resource "sdm_role" "admins" {
  name = "${var.name}-admin-role"
  access_rules = jsonencode([
    { tags = { CreatedBy = "strongDM-Onboarding" } }
  ])
}
resource "sdm_account_attachment" "existing_users" {
  count      = length(var.existing_users)
  account_id = element(var.existing_users[count.index].ids, 0)
  role_id    = sdm_role.admins.id
}
resource "sdm_workflow" "this" {
    name = "auto grant access for ${var.name}"
    auto_grant = true
    enabled = true
    access_rules = jsonencode([
    {
      "type" : "any",
      "tags" : var.tags
    }
  ])
}
resource "sdm_workflow_role" "this" {
    workflow_id = sdm_workflow.this.id
    role_id = sdm_role.admins.id
}
