#!/bin/bash
docker system prune -af
docker volume prune -f
docker network prune -f
echo "Docker cleanup completed."