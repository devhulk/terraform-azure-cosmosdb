variable "team_name" {
    description = "Name of Product Team"
}

variable "region" {
    description = "Name of Product Team"
    default = "East US"
}

variable "db" {
    description = "Specify mongo or sql"
}

variable "failover_location" {
    description = "Replication Region"
    default = "West US"
}
