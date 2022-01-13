
# string
variable "name" {
    type = string
    description = "variable name"
    // default = "terraform"
    // validation = {
    //     condition = length(var.name) < 5
    //     error_msg = "Name is too short, give a name of length greater than 5"
    // }
    sensitive = true 
    // nullable = true /false --> null to the variable if      
}

# number
variable "port" {
    type = number
    description = "variable port"
    default = 123
}

#boolean
variable "create_service" {
    type = bool 
    description = "variable create_service"
    default = true
}

# arrays
variable "list_providers" {
    type = list(string)
    default = [ "aws", "azure", "gcp" ]
}

# key value pairs
variable "map_example" {
    type = map(string)
    default = {
        "name" = "aws"
        "service" = "s3"

    }
}

// var.name --> terraform
// var.port --> 123
// var.create_service --> true
// var.list_providers --> [ "aws", "azure", "gcp" ] (--> [0, 1, 2])
// var.list_providers[0] --> aws
// var.list_providers[1] --> azure
// var.list_providers[2] --> gcp

// var.map_example --> {
//         "name" = "aws"
//         "service" = "s3"
//     }

// var.map_example.name or var.map_example["name"]  --> aws 

output "name_out" {
    sensitive = true 
    value = var.name
}

output "port_out" {
    value = var.port
}