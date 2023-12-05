pipeline {
    agent any
    
    stages{
        stage ("Build Image"){
            steps {
                script {
                    dockerapp = docker.build("mesquita/app:v${env.BUILD_ID}", '-f Dockerfile .')
                }
            }
        }
    
        stage ("Push Image") {
            steps {
                script {
                    docker.withRegistry("https://registry.hub.docker.com",'dockerhub'){
                        //dockerapp.push("v${env.BUILD_ID}")
                        dockerapp.push("latest")
                    }
                }
            }
        }
        stage ("Deploy Kubernetes"){
            steps{
                withKubeConfig([credentialsId: 'kubeconfig']){
                    // sh "echo 'passou' "
                    sh "cd cd /var/jenkins_home/workspace/AvaliacaoCloudMinsait/k8s && kubectl apply -f app-service.yaml,app-deployment.yaml,avaliacao-network-networkpolicy.yaml,db-deployment.yaml,db-service.yaml"
                    // sh "kubectl set image deployment/web web=matheusmprado/sampletodoaula3:latest"
                }
            }
        }      
}        
}
