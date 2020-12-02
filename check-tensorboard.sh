PORT=5566

tensorboard --logdir tf-logs \
--port $PORT --bind_all \
--path_prefix /foo/bar &

echo "Tensorboard Starting"

until printf "." && nc -z -w 2 127.0.0.1 $PORT; do
    sleep 1;
done;

echo 'Tensorboard Started ✓'

STATUS_CODE=$(curl -sL -w "%{http_code}" -I "http://127.0.0.1:$PORT/foo/bar/" -o /dev/null)

echo "STATUS_CODE is $STATUS_CODE"

if [ $STATUS_CODE == "200" ]; then
  exit 0
else
  exit 1
fi