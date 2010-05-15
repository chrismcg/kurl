Given /^A url "([^\"]*)" and a filename "([^\"]*)"$/ do |url, filename|
  @url = TEST_SERVER_BASE_URL + url
  @filename = File.join(TEST_OUTPUT_DIR, filename)
end

When /^I download the url$/ do
  Kurl.download(@url, @filename)
end

Then /^the contents of the url should be saved to the file identified by the filename$/ do
  contents = File.read(@filename)
  contents.should == "*" * 1024
end

