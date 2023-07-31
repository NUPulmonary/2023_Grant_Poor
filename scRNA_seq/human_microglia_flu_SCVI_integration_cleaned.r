source("/home/XXXXX/utils/R/run_scvi_integration.R")

run_SCVI_integration(object = "/projects/b1038/Pulmonary/rgrant/microglia_aging_flu/scRNAseq/analysis/230118_human_microglia_penultimate.rds", 
                     python_path = "/projects/b1038/Pulmonary/rgrant/microglia_aging_flu/scRNAseq/human_microglia_venv/bin/python3",
                     random_seed = 12345,
                     batch_col = "sample",
                     project_path = "/home/XXXXX/aging_microglia_flu/",
                     RDS_path = "/projects/b1038/Pulmonary/rgrant/microglia_aging_flu/scRNAseq/analysis/230118_human_microglia_SCVI_integrated_final_v2.rds",
                     use_GPU = TRUE,
                     hvgs = 1000,
                     n_layers = 2,
                     n_epochs = 400,
                     early_stopping = T,
                     dropout_rate = 0.2)