# VRSix Terra workflow

### Inputs
- `vcf_file` (File): path to the VCF file of interest
- `existing_index_db_file` (File, optional): path to an existing vrsix index which will be updated using the provided VCF. If `existing_index_db_file` is specified, it is used over any `new_index_db_path`
- `new_index_db_path` (String, optional): path to write a new index_db_path. If no `existing_index_db_file` is specified, `new_index_db_path` must be specified.

## Outputs
To write output file paths to directly to a Terra data table, specify the outputs in the Output tab on the workflow page, specifically:
- `output_vcf` (File): column in a Terra data table to write the VRS-annotated VCF to

For more info on how to write workflow ouputs to the data table, see the [Terra docs](https://support.terra.bio/hc/en-us/articles/4500420806299-Writing-workflow-outputs-to-the-data-table)

