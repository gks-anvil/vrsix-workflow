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
        vcf_file: "Path to VRS-annotated VCF."
        existing_index_db_file: "Path to existing index database file."
        new_index_db_path: "Path to write new index database."
    }

    input {
        File vcf_file
        File? existing_index_db_file
        String? new_index_db_path
    }

    call vrsix {
        input:
            vcf_file = vcf_file,
            existing_index_db_file = existing_index_db_file,
            new_index_db_path = new_index_db_path,
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
        vcf_file: "Path to VRS-annotated VCF."
        existing_index_db_file: "Path to existing index database file."
        new_index_db_path: "Path to write new index database."
    }

    input {
        File vcf_file
        File? existing_index_db_file
        String? new_index_db_path
    }

    Int disk_size = ceil(3*size(vcf_file, "GB") + 10)

    command <<<
        # check if file path was localized before creating index
        if [ "~{existing_index_db_file}" ]; then
            echo "using existing_index_db_file"
            vrsix load --db-location ~{existing_index_db_file} ~{vcf_file}
        elif  [ "~{new_index_db_path}" ]; then
            echo "using new_index_db_path"
            vrsix load --db-location ~{new_index_db_path} ~{vcf_file}
        else
            echo "Neither a new index path nor existing index file was specified. Please specify one." >&2
            exit 1
        fi

        
    >>>

    output {
        File updated_db_path = select_first([
            existing_index_db_file,
            new_index_db_path
        ])
    }

    runtime {
        docker: "quay.io/ohsu-comp-bio/vrsix:0.2.0" 
        disks: "local-disk " + disk_size + " SSD"
        bootDiskSizeGb: disk_size
        memory: "8G"
    }
}
