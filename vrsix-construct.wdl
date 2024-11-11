version 1.0

workflow VrsixConstruct {
    input {
        File input_vcf_path
        File index_db_path
    }

    call annotate { input:
        input_vcf_path = input_vcf_path,
        index_db_path = index_db_path,
    }

    output {
        File output_db_path = vrsix.output_db_path
    }
}

task vrsix {
    input {
        File input_vcf_path
        File index_db_path
    }

    Int disk_size = ceil(size(input_vcf_path, "GB") + 10)

    command <<<
        vrsix load --db-location ~{index_db_path} ~{input_vcf_path}
    >>>

    output {
        File output_db_path = "~{index_db_path}"
    }

    runtime {
        docker: "todo:base"
        disks: "local-disk" + disk_size + " SSD"
        bootDiskSizeGb: disk_size
        memory: "8G"
    }
}
