/*
sudo apt install ghp-import
*/
node  ('linux') {
  stage ('Checkout') {
    checkout([
      $class: 'GitSCM',
      branches: scm.branches,
      doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
      extensions: scm.extensions + [
        [$class: 'CleanCheckout'],
        [$class: 'SubmoduleOption', disableSubmodules: false, recursiveSubmodules: true],
      ],
      userRemoteConfigs: scm.userRemoteConfigs
    ])
  }
  stage ('Build') {
    sh """#!/bin/bash -ex
./hugo.sh

# Generage gh-pages
git branch -fD gh-pages || true
git branch -rd origin/gh-pages || true
ghp-import -n public

# archive
pushd public
zip ../gh-pages.zip -r -q .
popd
"""
    archive "*.zip"
  }
  if (env.BRANCH_NAME != '') {
    stage ('Publish (branch)') {
      sshagent(credentials: ['0d1e35cd-a719-4ab9-afed-fb5d9c8ff9af']) {
        sh 'rsync -e "ssh -o StrictHostKeyChecking=no" -rlvzc --delete-after public/ deploy@bozaro.ru:tech-db-lectures/' + env.BRANCH_NAME + '/'
      }
    }
  }
  if (env.BRANCH_NAME == 'master') {
    stage ('Publish (master)') {
      withCredentials([usernamePassword(credentialsId: '88e000b8-d989-4f94-b919-1cc1352a5f96', passwordVariable: 'TOKEN', usernameVariable: 'LOGIN')]) {
        sh """
git push -qf https://\${TOKEN}@github.com/bozaro/tech-db-lectures.git gh-pages
"""
      }
    }
  }
}
