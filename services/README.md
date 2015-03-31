# Example service configuration

This is example configuration to run in boot2docker.

## Usage

Build everything from the root of this repository:

```
./buildall.sh
```

Run hdfs node:

```
docker run -d -p 9000:9000 --name hdfs sequenceiq/hadoop-docker:2.4.1
```

Then spin up cluster with kafka and mysql:

```
docker-compose up
```

### Example events

Events to push in kafka topic `example-druid` should look like this:

```json
{"timestamp":"2015-03-31T20:52:08Z","zone_id":2,"requests":23,"bytes_client":1500,"bytes_origin":400}
```

### Example query

```
curl -X POST -H "Content-type: application/json" "http://192.168.59.103:8031/druid/v2/?pretty" -d @test.query.json
```
