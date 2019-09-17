# # encoding: utf-8

describe http('http://localhost') do
  its('status') { should eq 200 }
end
