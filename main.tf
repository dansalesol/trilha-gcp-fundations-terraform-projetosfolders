provider "google" {
    project = "sb-devops-iac"
    region  = "us-central1"
    zone    = "us-central1-c"
    credentials = "${file("serviceaccount.yaml")}"  
}

resource "google_folder" "Financeiro" {
    display_name = "Financeiro"
    parent       = "organizations/971749664186"
}

resource "google_folder" "SalesForce" {
    display_name = "SalesForce"
    parent       = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento" {
    display_name = "Desenvolvimento"
    parent       = google_folder.SalesForce.name    
}

resource "google_folder" "Producao" {
    display_name = "Producao"
    parent       = google_folder.SalesForce.name    
}

resource "google_project" "sb2-financeiro-salesforce-dev" {
    name = "SalesForce-Dev"
    project_id = "sb2-financeiro-salesforce-dev"
    folder_id = google_folder.Desenvolvimento.name
    auto_create_network=false
    billing_account = "01C67C-DEE2AB-1DC5F3"
}
resource "google_project" "sb2-financeiro-salesforce-prod" {
    name = "SalesForce-Prod"
    project_id = "sb2-financeiro-salesforce-prod"
    folder_id = google_folder.Producao.name
    auto_create_network=false
    billing_account = "01C67C-DEE2AB-1DC5F3"
}
