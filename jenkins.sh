export RBENV_VERSION="2.0.0"

bundle install --path "${HOME}/bundles/${JOB_NAME}"

bundle exec rake
bundle exec rake publish_gem
