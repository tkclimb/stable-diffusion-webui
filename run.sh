CLI_ARGS=$1
CWD=`pwd`
python3 -u $CWD/launch.py --xformers --listen --port 7860 --ckpt-dir $CWD/models/Stable-diffusion ${CLI_ARGS}