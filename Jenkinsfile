node {
    
    stage('Code checkout') { 
        git branch: 'main', url: 'https://github.com/ravisinghrajput95/spring-petclinic.git'
    }
    
    stage('Docker Build') { 
        app = docker.build("rajputmarch2020/spring-petclinic")

    }
    
    stage('Push image to Dockerhub') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker') {
        app.push("${env.BUILD_NUMBER}")
        
    }
    }
    
    stage('deploy to eks cluster') {
        script {
            sh 'aws eks update-kubeconfig --name pet-clinic --region us-east-1'
            sh "helm upgrade --install --set image.repository="rajputmarch2020:spring-petclinic" --set image.tag="${env.BUILD_NUMBER}" spring-petclinic spring-petclinic / "
        }
    }

}