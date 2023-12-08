aws ecs run-task \
    --cluster test-falcon \
    --task-definition Falco:3 \
    --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[subnet-00d4c482e624ec84b],securityGroups=[sg-050957bdf4a9868ff],assignPublicIp=ENABLED}" \
    --overrides '{ "taskRoleArn": "arn:aws:iam::177078417298:role/ecsTaskExecutionRole"}' \
    --enable-execute-command
