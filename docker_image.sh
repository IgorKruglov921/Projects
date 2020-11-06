# !/bin/bash
no_delete=no_delete.txt
date
DATA=$(date +"%Y-%m-%d" -d "-150 days");
IFS=$'\n'
echo $DATA;
echo
for image in $(docker images --format "table{{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}" | awk '{print $3}'); do
	if grep $image $no_delete;
	then
		echo "NO_DELETE_IMAGE" $image

	else
		DATA1=$(docker inspect -f "{{.Created}}" $image)
		DATA2="${DATA1:0:10}"
		echo
		echo $DATA2;
		if [[ $DATA2 > $DATA ]]; then
			echo "NO_DELETE_IMAGE" $image
			echo
		else
			echo "DELETE_IMAGE" $image
#			(docker rmi $image --force)
			echo
		fi

	fi
done
