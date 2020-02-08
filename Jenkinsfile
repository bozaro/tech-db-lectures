pipeline {
    agent {
        dockerfile {
            dir '.jenkins'
            filename 'Dockerfile.build'
        }
    }

    environment {
        HOME = "$WORKSPACE"
    }

    stages {
        stage('Cleanup') {
            steps {
                sh "git clean -fdx"
            }
        }

        stage('Prepare repository') {
            steps {
                sh """
git lfs pull
git submodule update --init --recursive
"""
            }
        }

        stage ('Build') {
            steps {
                sh "./hugo.sh"
            }
        }

        stage ('Generate gh-pages') {
            steps {
                sh """
# Generage gh-pages
git branch -fD gh-pages || true
git branch -rd origin/gh-pages || true
ghp-import -n public
"""
                dir ("public") {
                    sh """
zip ../gh-pages.zip -r -q .
"""
                }
            }
        }

        stage ('Publish (master)') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'github_bozaro_user', passwordVariable: 'GITHUB_TOKEN', usernameVariable: 'GITHUB_LOGIN')]) {
                    sh """
git push -qf https://\${GITHUB_LOGIN}:\${GITHUB_TOKEN}@github.com/bozaro/tech-db-lectures.git gh-pages
"""
                }
            }
        }

        stage ('Publish (branch)') {
            when {
                expression { BRANCH_NAME ==~ /(master|20\d\d-[12])/ }
            }
            steps {
                sshagent(credentials: ['web-deploy']) {
                    sh 'rsync -e "ssh -o StrictHostKeyChecking=no" -rlvzc --no-owner --no-group --delete-after public/ deploy@ivy.bozaro.ru:tech-db-lectures/$BRANCH_NAME/'
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: "*.zip", fingerprint: false
        }
    }
}
