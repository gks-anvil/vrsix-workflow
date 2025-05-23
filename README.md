# VRSix Terra workflow

## Description
The vrsix Terra workflow is a wrapper around the [vrsix](https://github.com/gks-anvil/vrsix) CLI tool. Using this workflow allows you to better interface with VCFs using VRS IDs, such as getting VCF rows by VRS ID or by fully-justified VRS coordinates!

## Usage
To get started, you will need a fully VRS-annotated VCF. Confirm that your VCF contains the following info fields:
- VRS_Allele_IDs
- VRS_Starts
- VRS_Stops

For example, confirm that chr1.vcf has the required fields.

```
bcftools view -h chr1.vcf | grep '^##INFO='
```

To annotate your VCFs on Terra, see the [VRS Annotator](https://github.com/gks-anvil/vrs-annotator/) workflow.

Import the workflow into your Terra Workspace using [Dockstore](https://dockstore.org/workflows/github.com/gks-anvil/vrsix-workflow/VrsixConstruct:main?tab=info). To learn more about how to run the workflow:


## Inputs

- `vcf_file` (File): path to the VRS VCF file of interest. Must contain VRS IDs as well as VRS coordinates (`VRS_Starta` and `VRS_Stops`) for each variant.
- `existing_index_db_file` (File, optional): Path to an existing vrsix index, which must end in `.db`. A new index will be created using the provided VCF. It is recommended to specify both `existing_index_db_file` and `new_index_db_path`. Without a `new_index_db_path`, the filename will be the entire path to the `existing_index_db_file` and becomes quite lengthy.
- `new_index_db_path` (String, optional): path to write a new index_db_path, which must end in `.db`. If no `existing_index_db_file` is specified, `new_index_db_path` must be specified.
   
To put things another way, there are three ways to specify the index db depending on your needs:
1. To create a new index from scratch, specify just a `new_index_db_path`. This is useful to get started creating indices
2. To create a new index using an existing index, specify both an `existing_index_db_file` and a `new_index_db_path`. The `new_index_db_path` will be the outputted file name of the combined index. This might be useful if you want to index multiple VCFs in a single file.
3. [not recommended] If you don't care about a long outputted index file name, specify only the `existing_index_db_file`.

Specifying neither of the two options will result in an error and no index will be created.

## Outputs
To write output file paths to directly to a Terra data table, specify the outputs in the Output tab on the workflow page, specifically:
- `output_vcf` (File): column in a Terra data table to write the VRS-annotated VCF to

For more info on how to write workflow ouputs to the data table, see the [Terra docs](https://support.terra.bio/hc/en-us/articles/4500420806299-Writing-workflow-outputs-to-the-data-table).

**Note:** If you encounter an error like "loading_module.VcfError: Expected Array variant" when running the workflow, make sure your VRSified VCF stores `VRS_Start` and `VRS_Stop` values in the INFO field! VCFs annotated only with `VRS_Allele_IDs` are not enough at the moment, we hope to make this clearer in future work addressed [here](https://github.com/gks-anvil/vrsix/issues/42).

