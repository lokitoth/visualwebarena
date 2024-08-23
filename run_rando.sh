run_name=$1
# if there is no run name, then use the current <date>_<time> as the run name
if [ -z "$run_name" ]; then
  run_name=$(date +"%Y%m%d_%H%M%S")
fi

taskset=$2
# if there is no taskset, default to shopping
if [ -z "$taskset" ]; then
  taskset=shopping
fi

start_idx=$3
end_idx=$4

# set up the test range in the following way:
#   if there is a start index, include --test_start_idx $start_idx
#   if there is an end index, include --test_end_idx $end_idx
test_range_flags=""
if [ ! -z "$start_idx" ]; then
  test_range_flags="--test_start_idx $start_idx"
fi
if [ ! -z "$end_idx" ]; then
  test_range_flags="$test_range_flags --test_end_idx $end_idx"
fi

echo "Running visualwebarena random policy."
echo "Run name: $run_name"
echo "Taskset: $taskset"
echo "Runnning tasks $start_idx to $end_idx"

agent_type=rando

command="python run.py \
  --instruction_path agent/prompts/jsons/p_som_cot_id_actree_3s.json \
  --result_dir ~/expresult/vewba/$run_name \
  --test_config_base_dir=config_files/vwa/test_shopping \
  --model gpt-4o --agent_type $agent_type \
  --action_set_tag som  --observation_type image_som \
  $test_range_flags"

echo
echo "-----------------------------------------------------------------"
echo

echo "Running command:"
echo $command

echo
echo "-----------------------------------------------------------------"
echo

$command
