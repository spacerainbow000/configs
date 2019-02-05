#!/bin/bash
for f in $(\ls | grep -v deploy.sh | grep -v LICENSE);
do
    bash ${f}/deploy.sh
done

