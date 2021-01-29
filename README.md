# Docker MySQL Kafka Maxwell

Docker compose setup to run MySQL Kafka and Maxwell (Change data capture)

This repo is based on [this github](https://github.com/githubcyc/docker-mysql-maxwell-kafka). 

It uses RabbitMQ
but it didn't work as expected and did not fulfill my objective, so I decided to create my own using Kafka

## Requirement 
Docker

## How to
1. Run docker compose (there is a bug with kafka that you need to use force-recreate, or it will produce an error)
```
docker-compose up --build --force-recreate
```
wait for all images downloaded and make sure containers ran OK

2. Connect to MySQL
```
host: localhost
user: root
pass: pass
db: test
port: 3306
```

Try to insert,update, delete data in "test" table. Maxwell will capture data changes and sent to Kafka (check from docker logs)

**Example Insert Data**

![Alt text](images/mysql_insert.png "Title")

**Example Maxwell Log**

![Alt text](images/maxwell_logs.png "Title")

3. Check Kafka using kafdrop. Open kafdrop url on your browser
```
localhost:9000
```

You should see kafka topic "example-cdc-test".
Topic name is dynamic based on the source table you changed the data from
```
example-cdc-<table_name>
```
Browse into the topic then you can see your change data from "test" table queued there

Kafdrop Homepage, click "example-cdc-test"
![Alt text](images/1_kafdrop_homepage.png "kafdrop homepage")

Click View Messages link
![Alt text](images/2_kafdrop_view_messages.png "kafdrop view message button")

Click View Messages button
![Alt text](images/3_kafdrop_view_messages_content.png "kafdrop view message content")

Messages content "id : 3, name: hello"
![Alt text](images/4_kafdrop_message_content.png "kafdrop message content")

4. If you have kafka consumer app, connect to kafka broker at **localhost:19092** and topic name = ""

Done. That's it CDC using MySQL, Kafka and Maxwell

Please message me if you have any issue and feel free to fork as well
