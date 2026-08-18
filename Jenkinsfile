pipeline {
    agent any
    environment {
        NAMESPACE = "keycloak"
        KC_IMAGE = "keycloak-custom:${BUILD_NUMBER}"
        MAPPER_IMAGE = "oauth2-mapper:${BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Build Images') {
            steps {
                sh """
                    docker build -t ${KC_IMAGE} .
                    docker build -t ${MAPPER_IMAGE} -f Dockerfile.mapper .
                """
            }
        }
        stage('Deploy') {
            steps {
                sh """
                    docker save ${KC_IMAGE} -o /tmp/kc.tar
                    sudo ctr -n k8s.io images import /tmp/kc.tar

                    docker save ${MAPPER_IMAGE} -o /tmp/mapper.tar
                    sudo ctr -n k8s.io images import /tmp/mapper.tar

                    kubectl set image deployment/keycloak keycloak=${KC_IMAGE} -n ${NAMESPACE}
                    kubectl set image deployment/oauth2-mapper oauth2-mapper=${MAPPER_IMAGE} -n ${NAMESPACE}

                    kubectl rollout restart deployment/keycloak -n ${NAMESPACE}
                    kubectl rollout restart deployment/oauth2-mapper -n ${NAMESPACE}
                """
            }
        }
    }
}
