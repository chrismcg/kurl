$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'kurl'

TEST_SERVER_PORT = 13245
TEST_SERVER_BASE_URL = "http://localhost:#{TEST_SERVER_PORT}"
TEST_OUTPUT_DIR = File.expand_path('../../../tmp', __FILE__)

