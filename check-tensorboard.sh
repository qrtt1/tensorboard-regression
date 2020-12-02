tensorboard --logdir tf-logs \
--port 5001 --bind_all \
--path_prefix /foo/bar &

echo "Tensorboard Starting"

until printf "." && nc -z -w 2 127.0.0.1 5001; do
    sleep 1;
done;

echo 'Tensorboard Started ✓'

STATUS_CODE=$(curl -sL -w "%{http_code}" -I "http://127.0.0.1:5001/foo/bar/" -o /dev/null)

echo "STATUS_CODE is $STATUS_CODE"
if [ $STATUS_CODE != "200" ]; then
  echo "Failed to see the first page"
  exit 1
fi

node check-tensorboard.js http://127.0.0.1:5001/foo/bar/