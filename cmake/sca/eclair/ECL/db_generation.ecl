# eclair_report

# NEEDED: set the variable for the binary output directory from the environment
# variable.
setq(data_dir,getenv("ECLAIR_DATA_DIR"))

# NEEDED: set the variable for the ECLAIR project database from the environment
# variable.
setq(ecd_file,getenv("ECLAIR_PROJECT_ECD"))

# NEEDED: set the variable for the output directory from the environment
# variable.
setq(output_dir,getenv("ECLAIR_OUTPUT_DIR"))

if(file_exists(ecd_file),
   db(ecd_file),
 create_db(ecd_file))

setq(loaded_dir,join_paths(data_dir,"loaded"))
make_dirs(loaded_dir)

# NEEDED: generate the ecd from frame files
strings_map("load_ecb",500,"",".+\\.ecb",0,setq(ecb,join_paths(data_dir,$0)),load(ecb),rename(ecb,join_paths(loaded_dir,$0)))
strings_map("load_ecb",500,"",".*",0)

loading()
map_strings("load_ecb", dir_entries(data_dir))
loaded()
