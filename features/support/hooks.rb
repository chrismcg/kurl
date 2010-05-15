Before do
  FileUtils.mkdir TEST_OUTPUT_DIR
end

After do
  FileUtils.rm_rf TEST_OUTPUT_DIR
end
