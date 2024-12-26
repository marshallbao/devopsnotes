pages

```
image:
  name: bianjie/ops-alpine:0830

stages:
  - deploy

pages:
  stage: deploy
  script:
  - echo 'Nothing to do...'
  - mv test public
  - cd public && tree -J > trees
  artifacts:
    paths:
    - public
  only:
  - dev
```

