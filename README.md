# Apigee Edge Microgateway for Docker

* Run your Apigee Edge Microgateway instances in Docker containers.

## Build the image

This step is optional.  You can pull this image directly from Docker Hub.

```
docker build -t apigee/edgemicro:2.1.0-beta .
```

## Configure edgemicro

### Step 1: Make a configuration directory on the host

This will hold config files for edgemicro.

```
$ mkdir config && export EDGEMICRO_DIR=$(pwd)/config
```

### Step 2: Set environment variables related to your deployment

```
export EDGEMICRO_ORG=ws-poc1
export EDGEMICRO_ENV=test
export EDGEMICRO_USER=kswiber@apigee.com
```

Optionally, set `EDGEMICRO_PASS` equal to your Apigee password.
If this variable isn't set, you'll be prompted for it in the next step.

### Step 3: Generate config files

This step will generate config files in the config directory 
and output additional variables you can set for the next step.

```
$ docker run -t -i --rm \
  -v $EDGEMICRO_DIR:/root/.edgemicro \
  -e "EDGEMICRO_ORG=$EDGEMICRO_ORG" \
  -e "EDGEMICRO_ENV=$EDGEMICRO_ENV" \
  -e "EDGEMICRO_USER=$EDGEMICRO_USER" \
  -e "EDGEMICRO_PASS=$EDGEMICRO_PASS" \
  apigee/edgemicro:2.1.0-beta \
  /usr/bin/local/configure.sh
```

### Step 4: Set edgemicro startup variables

Run the example output from Step 3:

```
# use these environment variables to start edgemicro
export EDGEMICRO_KEY=1b720ffdb6ddcfb40340ca6e9f0207b1c426756dc0d44a34f389015982677100
export EDGEMICRO_SECRET=226836b6d2f84f1f32a6db6115ce84dfd20541fb86b0f3e019c525e33e3f6ed5
export EDGEMICRO_ORG=ws-poc1
export EDGEMICRO_ENV=test
```

## Running edgemicro

```
$ docker run -d -p 8080:8000 \
  -v $EDGEMICRO_DIR:/root/.edgemicro \
  -e "EDGEMICRO_ORG=$EDGEMICRO_ORG" \
  -e "EDGEMICRO_ENV=$EDGEMICRO_ENV" \
  -e "EDGEMICRO_KEY=$EDGEMICRO_KEY" \
  -e "EDGEMICRO_SECRET=$EDGEMICRO_SECRET" \
  apigee/edgemicro:2.1.0-beta
```

## Testing it out

```
curl http://$(docker-machine ip):8080/basepath
```

## License

Apache License, Version 2.0
