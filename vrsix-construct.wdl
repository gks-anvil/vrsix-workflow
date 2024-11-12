version 1.0

workflow vrsix_construct {
    meta {
        author: "GKS-AnVIL"
        description: "Extract VRS variation annotations from a VCF and load them into a vrsix index database."
        outputs: {
            updated_db_path: "Path to updated index database."
        }
    }

    parameter_meta {
        vcf_path: "Path to VRS-annotated VCF."
        index_db_path: "Path to existing index database file."
    }

    input {
        File vcf_path
        File index_db_path
    }

    call vrsix { input:
        vcf_path = vcf_path,
        index_db_path = index_db_path,
    }

    output {
        File updated_db_path = vrsix.updated_db_path
    }
}

task vrsix {
    meta {
        description: "Load VCF into index database."
        outputs: {
            updated_db_path: "Path to updated index database."
        }
    }

    parameter_meta {
        vcf_path: "Path to VRS-annotated VCF."
        index_db_path: "Path to index database file."
    }

    input {
        File vcf_path
        File index_db_path
    }

    Int disk_size = ceil(size(vcf_path, "GB") + 10)

    command <<<
        vrsix load --db-location ~{index_db_path} ~{vcf_path}
    >>>

    output {
        File updated_db_path = "~{index_db_path}"
    }

    runtime {
        docker: "ubuntu@sha256:foobar"
        disks: "local-disk" + disk_size + " SSD"
        bootDiskSizeGb: disk_size
        memory: "8G"
    }
}
