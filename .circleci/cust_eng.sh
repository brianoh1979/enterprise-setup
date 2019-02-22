#!/bin/bash

set -e

function add_tags_to_services {
    sed -i.bak '/Name = "${var.prefix}_services"/a\
    \ \ \ \ ce_email = "${var.ce_email}"\
    \ \ \ \ ce_purpose = "${var.ce_purpose}"\
    \ \ \ \ customer = "${var.customer}"\
    \ \ \ \ ce_schedule = "${var.ce_schedule}"\
    \ \ \ \ ce_duration = "${var.ce_duration}"\
    ' ./circleci.tf
}

function add_tags_to_nomad_lc {
    sed -i.bak '/user_data = "${module.cloudinit.rendered}"/a\
    \
    \ \ tag {\
    \ \ \ \ ce_email = "${var.ce_email}"\
    \ \ \ \ ce_purpose = "${var.ce_purpose}"\
    \ \ \ \ customer = "${var.customer}"\
    \ \ \ \ ce_schedule = "${var.ce_schedule}"\
    \ \ \ \ ce_duration = "${var.ce_duration}"\
    \ \ }\
    ' ./modules/nomad/main.tf
}

function add_tags_variable_to_services {

}

function add_tags_variable_to_nomad_lc {
    
}

function add_tagging_stanza() {
    (cat <<EOF


#####################################
# 4. Customer Engineering Tagging
#####################################

# REQUIRED Your e-mail address
ce_email = "yourname@circleci.com"

# Short note on use
ce_purpose = ""

# SF account name
customer = ""

# Schedule you want this to be run: ["core_hours", "always"]
ce_schedule = "core_hours"

# Intended duration of usage ["day", "week", "month", "persistent"]
ce_duration = "day"
EOF
) >> ./terraform.tfvars
}

# add_tagging_stanza
# add_tags_to_services
add_tags_to_nomad_lc