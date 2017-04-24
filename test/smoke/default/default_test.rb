# # encoding: utf-8

# Inspec test for recipe lcd_basic::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

packages = []

%w(net-tools php-common).each do |item|
  packages << item
end

case os[:family]
when 'redhat'
  packages << 'httpd'
when 'debian'
  packages << 'apache2'
end

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

case os[:family]
when 'redhat'
  describe file('/usr/bin/php') do
    it { should exist }
    its('mode') { should cmp '00755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe service('httpd') do
    it { should be_running }
  end

when 'debian'
  describe file('/usr/bin/php7.0') do
    it { should exist }
    its('mode') { should cmp '00755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe service('apache2') do
    it { should be_running }
  end
end

describe group('developers') do
  it { should exist }
end

describe user('webadmin') do
  it { should exist }
  its('group') { should eq 'developers' }
end

describe port(80) do
  it { should be_listening }
end

describe command 'curl http://localhost' do
  its('stdout') { should match(/Greetings, Planet Earth!/) }
end
