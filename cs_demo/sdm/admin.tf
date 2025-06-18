resource "sdm_role" "admins" {
  name         = "${var.name}-admin-role"
  # access_rules = jsonencode([
  #   { tags = { CreatedBy = "strongDM-Onboarding" } }
  # ])
}

resource "sdm_account_attachment" "existing_users" {
  count      = length(var.grant_to_existing_users)
  account_id = element(data.sdm_account.existing_users[count.index].ids, 0)
  role_id    = sdm_role.admins.id
}

resource "sdm_workflow" "this" {
    name         = "${var.name} automatic workflow"
    auto_grant   = true
    enabled      = true
    approval_flow_id = data.sdm_approval_workflow.this.id
    description  = "${var.name} automatic workflow"
    access_rules = jsonencode([
    {
      "type" : "rdp",
      "tags" : {
        "workflow" : "${var.name}-workflow"
      }
    }
  ])
}

data "sdm_approval_workflow" "this" {
    name = "${var.name} auto approval workflow"
}

resource "sdm_workflow_role" "this" {
    workflow_id = sdm_workflow.this.id
    role_id     = sdm_role.admins.id
}
