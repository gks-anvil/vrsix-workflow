# VRSix Terra workflow

## Prerequisites
- VRS-Annotated VCF with (see [VRS Annotator](https://github.com/gks-anvil/vrs-annotator/) for more info!)

## Inputs
- `vcf_file` (File): path to the VCF file of interest
- `existing_index_db_file` (File, optional): path to an existing vrsix index which will be updated using the provided VCF. Must end in `.db`. If `existing_index_db_file` is specified, it is used over any `new_index_db_path`
- `new_index_db_path` (String, optional): path to write a new index_db_path. Must end in `.db`. If no `existing_index_db_file` is specified, `new_index_db_path` must be specified.

## Outputs
To write output file paths to directly to a Terra data table, specify the outputs in the Output tab on the workflow page, specifically:
- `output_vcf` (File): column in a Terra data table to write the VRS-annotated VCF to

For more info on how to write workflow ouputs to the data table, see the [Terra docs](https://support.terra.bio/hc/en-us/articles/4500420806299-Writing-workflow-outputs-to-the-data-table).

**Note:** If you encounter an error like "loading_module.VcfError: Expected Array variant" when running the workflow, make sure your VRSified VCF stores `VRS_Start` and `VRS_Stop` values in the INFO field! VCFs annotated only with `VRS_Allele_IDs` are not enough at the moment, we hope to make this clearer in future work addressed [here](https://github.com/gks-anvil/vrsix/issues/42).

