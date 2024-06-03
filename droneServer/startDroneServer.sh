#!/bin/bash

docker run -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD='yes' mysql:8 &
