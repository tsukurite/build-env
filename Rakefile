task(:default).clear
task :default => 'install'

desc 'install gems by Bundler'
task :install do
  sh 'bundle install --path bin/ruby/gem/'
end
