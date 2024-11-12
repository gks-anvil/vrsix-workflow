version 1.0

workflow vrsix_construct {
    meta {
        author: "GKS-AnVIL"
        description: "TODO insert description here"
        outputs: {
            updated_db_path: "description todo"
        }
    }

    parameter_meta {
        vcf_path: "describe"
        index_db_path: "describe"
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
        description: "todo describe"
        outputs: {
            updated_db_path: "describe todo"
        }
    }

    parameter_meta {
        vcf_path: "todo describe"
        index_db_path: "todo describe"
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
