tensorboard --logdir tf-logs \
--port 5001 --bind_all \
--path_prefix /foo/bar &

echo "Tensorboard Started"

ps aux