#!/bin/bash
docker build railgun --platform linux/amd64 -t gtary/railgun
docker push gtary/railgun