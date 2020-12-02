tensorboard --logdir tf-logs \
--port 5001 --bind_all \
--path_prefix /foo/bar &

echo "Tensorboard Started"

STATUS_CODE=$(curl -sL -w "%{http_code}" -I "http://127.0.0.1/foo/bar/" -o /dev/null)

echo "STATUS_CODE is $STATUS_CODE"

if [ $STATUS_CODE == "200" ]; then
  exit 0
else
  exit 1
fi