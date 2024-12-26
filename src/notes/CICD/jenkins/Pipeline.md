### 概念

Pipeline，简而言之，就是一套运行于Jenkins上的工作流框架，将原本独立运行于单个或者多个节点的任务连接

起来，实现单个任务难以完成的复杂流程编排与可视化；

### 语法

Jenkins Pipeline 支持两种不同的语法：Declarative Pipeline 和 Scripted Pipeline。

Declarative Pipeline：Declarative Pipeline 提供了一种更结构化、可读性更强的声明式语法，通过声明式的方式

定义流水线的各个阶段和步骤。它使用 `pipeline` 块来定义整个流水线，而不需要像传统的 Jenkins Job 那样编

写复杂的 Groovy 脚本。Declarative Pipeline 还提供了一系列的内置步骤和指令，可以方便地定义流水线的逻辑

和控制流程。

Scripted Pipeline：Scripted Pipeline 允许你使用完整的 Groovy 脚本来编写流水线。它提供了更灵活、更自由的

编程能力，可以直接使用 Groovy 的语法和特性来编写复杂的流水线逻辑。Scripted Pipeline 通常适用于对自定

义逻辑和高级流程控制有更高需求的场景。

### Declarative Pipeline

关键字

```
pipeline

parameters

agent

stages

​	stage

​	step

​	script
post
	success
	always
	failure
triggers 
```



示例

```
pipeline {
    parameters {
        text(name: 'IMAGES', defaultValue: 'imageName1', description: '镜像')
    }
    agent {
        label 'gcp-deploy-01-125'
    }
    environment {
        DOCKER_SOURCE_REGISTRY = 'repository.bianjie.ai'
        DOCKER_SOURCE_CREDENTIALS = 'nexus'
    }
    stages {
        stage('Docker') {
            steps {
                script {
                    def images = env.IMAGES.split(',')
                        for (def image : images) {
                        	echo ${image}
                        }
                    }
                }
            }
        }

    post {
        success {
            script {
                def images = env.IMAGES.split(',')
                    for (def image : images) {
                        sh "docker rmi ${DOCKER_SOURCE_REGISTRY}/adb/${image}" 
                        sh "docker rmi ${DOCKER_TARGET_REGISTRY}/adb/${image}"
                    }
            }

        }
    }
}
```

注意点

```
1. pipeline 文件格式必须调整无误后 pipeline 才能进行调试，比如如何提供参数
```

