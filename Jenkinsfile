node {
    def app

    stage('Clone Repo') {
        checkout scm
    }

    stage('Build') {
        app = docker.build("garage.chriswalker.dev:v" + currentBuild.number)
    }

    stage('Test') {
        app.inside {
            // TODO
        }
    }

    stage('Save Image to Archive') {
        sh "/usr/local/bin/save_image.sh garage.chriswalker.dev:v" + currentBuild.number
    }

    stage('Delete Local Previous Images') {
        sh "/usr/local/bin/clean_local_images.sh garage.chriswalker.dev"
    }

    stage('Delete Previous Archived Images') {
        sh "/usr/local/bin/delete_old.sh garage.chriswalker.dev"
    }

    stage('Delete Remote Existing Container') {
        sh "/usr/local/bin/stop_previous_image.sh garage.chriswalker.dev"
    }

    stage('Delete Remote Images') {
        sh "/usr/local/bin/clean_remote_images.sh garage.chriswalker.dev"
    }

    stage('Install New Image on Remote') {
        sh "/usr/local/bin/install_image.sh garage.chriswalker.dev:v" + currentBuild.number
    }

    stage('Deploy Image') {
        sh "/usr/local/bin/deploy.sh 8080:8080 v" +currentBuild.number + " garage.chriswalker.dev:v" + currentBuild.number
    }

    stage('Verify Image') {
        sleep(time: 10, unit:"SECONDS")
        sh "/usr/local/bin/verify_image.sh https://garage.chriswalker.dev/version v" + currentBuild.number
    }

}